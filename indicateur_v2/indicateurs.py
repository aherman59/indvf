'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

from collections import namedtuple

from main.models import Departement, Epci, Commune, Territoire
from indicateur_v2.models import ResultatIndicateur

from pg.pgbasics import *
from indicateur_v2.filtres_perso import PersoManager

TYPES_INDICATEUR = {'Quantitatif': [('nbtrans', 'Nombre de transactions', 'mutations', '1'),
                                     ('total', 'Montant total', '€', '2'),],
                    'Prix' : [('med', 'Prix médian', '€', '3'),
                              ('pq', 'Premier quartile de prix', '€', '4'),
                              ('dq', 'Dernier quartile de prix', '€', '5'),
                              ('moy', 'Prix moyen', '€', '9')],
                    'Prix_m2_bati' : [('med_m2_bati', 'Prix médian au m2 de surface bâtie', '€/m2 bati', '8'),
                                      ('moy_m2_bati', 'Prix moyen au m2 de surface bâtie', '€/m2 bati', '10'),],
                    'Prix_m2_terr' : [('med_m2_terr', 'Prix médian au m2 de terrain', '€/m2 terrain', '11'),
                                      ('moy_m2_terr', 'Prix moyen au m2 de terrain', '€/m2 terrain', '12'),],
                    'Surface' : [('surfmed_bati', 'Surface médiane de bâti', 'm2', '6'),
                                 ('surftot_bati', 'Surface totale de bâti', 'm2', '7'),
                                 ('surfmed_terr', 'Surface médiane de terrain', 'm2', '13'),
                                 ('surftot_terr', 'Surface totale de terrain', 'm2', '14'),],
                    }

FILTRES = [('0', 'Mutation sans spécificité'),
           ('A', 'Adjudication'),
           ('B', 'Appartement avec terrain'),
           ('D', 'Mutation dont un bien est vendu 2 fois le même jour'),
           ('E', 'Echange'),
           ('H', 'Vente à 0 ou 1 euro'),
           ('L', 'Bien exceptionnel'),
           ('M', 'Multi-site (1km)'),
           ('S', 'Logement social'),
           ('T', 'Transfert entre opérateur social'),
           ('X', 'Expropriation'),
           ('1', 'Terrain bati >1ha/local'),
           ('5', 'Terrain bati >5ha/local'),
           ]

DEVENIRS = [('S', 'Inchangé'),
            ('CD', 'Construction avec démolition'),
            ('C', 'Construction'),
            ('A', 'Aménagement'),
            ('M', 'Transformation potentielle')]

TYPOLOGIE_DV3F = {'Niv0' : [('999', 'Tout type de mutation')],
             'Niv1' : [('1', 'Bâti'), ('2', 'Non bâti')],
             'Niv2' : [('11', 'Maison'), ('12', 'Appartement'), ('13', 'Dépendance'),
                       ('14', 'Activité'), ('15', 'Bâti mixte'), ('10', 'Bâti-indéterminé'),
                       ('21', 'Terrain type TAB'), ('22', 'Terrain artificialisé'),
                       ('23', 'Terrain naturel'), ('20', 'Terrain non bâti indéterminé')],
             'Niv3' : [('111', "Une maison"),
                       ('112', "Des maisons"),
                       ('110', "Maison indéterminee"),                       
                       ('121', "Un appartement"),
                       ('122', "Deux appartements"),
                       ('123', "Des appartements dans le meme immeuble"),
                       ('120', "Appartement indétermine"),                       
                       ('131', "Une dependance"),
                       ('132', "Des dependances"),
                       ('141', "Activite primaire"),
                       ('142', "Activite secondaire"),
                       ('143', "Activite tertiaire"),
                       ('149', "Activite mixte"),
                       ('140', "Activite indeterminee"),
                       ('151', "Bâti mixte - logements"),
                       ('152', "Bâti mixte - logement/activite"),
                       ('101', "Bâti - indéterminé : vefa sans descriptif"),
                       ('102', "Bâti - indéterminé: vente avec volume(s)"),
                       ('221', "Terrain d'agrement"),
                       ('222', "Terrain d'extraction"),
                       ('223', "Terrain de type reseau"),
                       ('229', "Terrain artificialise mixte"),
                       ('231', "Terrain agricole"),
                       ('232', "Terrain forestier"),('233', "Terrain landes et eaux"),
                       ('239', "Terrain naturel mixte")],
             'Niv4' : [('1111', 'Une maison vefa ou neuve'), 
                       ('1112', 'Une maison récente'), 
                       ('1113', 'Une maison ancienne'), 
                       ('1114', 'Une maison à usage professionnel'), 
                       ('1110', 'Une maison age indéterminé'), 
                       ('1211', 'Un appartement vefa ou neuf'), 
                       ('1212', 'Un appartement récent'), 
                       ('1213', 'Un appartement ancien'), 
                       ('1214', 'Un appartement à usage professionnel'),
                       ('1210', 'Un appartement âge indéterminé'),  
                       ('1221', 'Deux appartements vefa ou neufs'), 
                       ('1222', 'Deux appartements recents'), 
                       ('1223', 'Deux appartements anciens'), 
                       ('1224', 'Deux appartements à usage professionnel'), 
                       ('1229', 'Deux appartements à usage mixte'), 
                       ('1220', 'Deux appartements indéterminés'), 
                       ('1311', 'Un garage'), 
                       ('1312', 'Une dépendance autre'), 
                       ('2311', 'Terrain viticole'), 
                       ('2312', 'Terrain verger'), 
                       ('2313', 'Terrain de type terre et pré'), 
                       ('2319', 'Terrain agricole mixte')],
             'Niv5' : [('12111', 'Un appartement vefa ou neuf T1'), 
                       ('12112', 'Un appartement vefa ou neuf T2'), 
                       ('12113', 'Un appartement vefa ou neuf T3'), 
                       ('12114', 'Un appartement vefa ou neuf T4'), 
                       ('12115', 'Un appartement vefa ou neuf T5 ou +'),
                       ('12110', 'Un appartement vefa ou neuf nombre de pièces indéterminé'),  
                       ('12121', 'Un appartement recent T1'), 
                       ('12122', 'Un appartement recent T2'), 
                       ('12123', 'Un appartement recent T3'), 
                       ('12124', 'Un appartement recent T4'), 
                       ('12125', 'Un appartement recent T5 ou +'), 
                       ('12120', 'Un appartement récent nombre de pièces indéterminé'), 
                       ('12131', 'Un appartement ancien T1'), 
                       ('12132', 'Un appartement ancien T2'), 
                       ('12133', 'Un appartement ancien T3'), 
                       ('12134', 'Un appartement ancien T4'), 
                       ('12135', 'Un appartement ancien T5 ou +'),
                       ('12130', 'Un appartement ancien nombre de pièces indéterminé'), ]
             }

TYPOLOGIE_DVF_PLUS = {'Niv0' : [('999', 'Tout type de mutation')],
             'Niv1' : [('1', 'Bâti'), ('2', 'Non bâti')],
             'Niv2' : [('11', 'Maison'), ('12', 'Appartement'), ('13', 'Dépendance'),
                       ('14', 'Activité'), ('15', 'Bâti mixte'), ('10', 'Bâti-indéterminé'),
                       ('21', 'Terrain type TAB'), ('22', 'Terrain artificialisé'),
                       ('23', 'Terrain naturel'), ('20', 'Terrain non bâti indéterminé')],
             'Niv3' : [('111', "Une maison"),
                       ('112', "Des maisons"),
                       ('110', "Maison indéterminee"),                       
                       ('121', "Un appartement"),
                       ('122', "Deux appartements"),
                       ('120', "Appartement indétermine"),                       
                       ('131', "Une dependance"),
                       ('132', "Des dependances"),                      
                       ('151', "Bâti mixte - logements"),
                       ('152', "Bâti mixte - logement/activite"),
                       ('101', "Bâti - indéterminé : vefa sans descriptif"),
                       ('102', "Bâti - indéterminé: vente avec volume(s)"),
                       ('221', "Terrain d'agrement"),
                       ('222', "Terrain d'extraction"),
                       ('223', "Terrain de type reseau"),
                       ('229', "Terrain artificialise mixte"),
                       ('231', "Terrain agricole"),
                       ('232', "Terrain forestier"),
                       ('233', "Terrain landes et eaux"),
                       ('239', "Terrain naturel mixte")],
             'Niv4' : [('2311', 'Terrain viticole'), 
                       ('2312', 'Terrain verger'), 
                       ('2313', 'Terrain de type terre et pré'), 
                       ('2319', 'Terrain agricole mixte')],
             'Niv5' : []
             }

PERSOMANAGER = PersoManager()


def indicateurs_format_xcharts(territoires, gestionnaire, config_active):
        indicateurs_actifs = gestionnaire.indicateurs_actifs()
        indicateursDVF = []
        for num, indicateur in enumerate(indicateurs_actifs):
            indic_dvf = IndicateurDVF(indicateur, territoires, config_active)
            i = {'idgraph'    : 'graph' + str(num),
                 'type_graph' : indicateur.type_graphe,
                 'graph'      : indic_dvf.graphique,
                 'tableau'    : indic_dvf.tableau,
                 'nom'        : indic_dvf.titre + indic_dvf.unite(prefixe=True),}            
            indicateursDVF.append(i)
        return indicateursDVF

def indicateurs_actifs_format_csv(territoires, gestionnaire, config_active):
        indicateurs_actifs = gestionnaire.indicateurs_actifs()
        indicateursDVF = []
        for num, indicateur in enumerate(indicateurs_actifs):
            indic_dvf = IndicateurDVF(indicateur, territoires, config_active)
            i = {'unite'  : indic_dvf.unite(prefixe=False),
                 'donnees': indic_dvf.donnees,
                 'territoires' : [t.nom for t in indic_dvf.territoires],
                 'nom'    : indic_dvf.titre,}            
            indicateursDVF.append(i)
        return indicateursDVF 


class GestionnaireIndicateurs:
        
    def __init__(self, typologies, filtres, types_indicateur, devenirs, periodicite, an_min_max, conditions_perso):
        self.typologies = typologies
        self.filtres = filtres
        self.types_indicateur = types_indicateur
        self.devenirs = devenirs
        self.periodicite = periodicite
        self.an_min_max = an_min_max
        self.conditions_perso = conditions_perso
    
    def indicateurs_actifs(self):
        indicateurs = []
        for type_indicateur in self.types_indicateur:
            for typologie in self.typologies:
                indicateurs.append(Indicateur.from_filtre_standard(type_indicateur, typologie, self.filtres, self.devenirs, self.periodicite, self.an_min_max))
            for condition_perso in self.conditions_perso:
                indicateurs.append(Indicateur.from_filtre_perso(type_indicateur, condition_perso, self.periodicite, self.an_min_max))
        return indicateurs
    
class Indicateur:
    
    def __init__(self, type, typologie, filtres, devenirs, periodicite, an_min_max, condition_perso):
        self.type = type
        self.typologie = typologie
        self.filtres = filtres
        self.devenirs = devenirs
        self.periodicite = periodicite
        self.an_min_max = an_min_max
        self.condition_perso = condition_perso
        self.indicateur_standard = False if condition_perso is not None else True
    
    @classmethod
    def from_filtre_standard(cls, type, typologie, filtres, devenirs, periodicite, an_min_max):
        return cls(type, typologie, filtres, devenirs, periodicite, an_min_max, None)
    
    @classmethod
    def from_filtre_perso(cls, type, condition_perso, periodicite, an_min_max):
        return cls(type, None, None, None, periodicite, an_min_max, condition_perso)
        
    @property
    def id(self):
        if self.indicateur_standard:
            id_type = self.get_type_indicateur('id').ljust(2, '0')
            id_periode = '1' if self.periodicite == 'a' else '0'
            id_annee_min = str(self.annee_debut - 2000)
            id_annee_max = str(self.annee_fin - 2000)
            id_typologie = self.typologie.rjust(5, '0')
            id_fltr = self.id_filtre()
            id_dev = self.id_devenir()            
            return int(id_type + id_typologie + id_fltr + id_dev + id_periode + id_annee_min + id_annee_max)
        return 1 # on affecte l'id 1 pour les indicateurs non standards
    
    @property
    def code_typo(self):
        if self.indicateur_standard:
            return self.typologie
        return None
    
    @property
    def nom(self):
        if self.indicateur_standard:
            return self.type_libelle + ' pour la catégorie ' + self.code_typo +  ' - ' + self.typologie_libelle
        else:
            return self.type_libelle + ' pour ' + PERSOMANAGER.get_condition_by_id(self.condition_perso).nom 

    @property
    def variable(self):
        if self.type == 'nbtrans':
            return 'idmutation'
        elif self.type in ('total', 'med', 'moy', 'pq', 'dq'):
            return 'valeurfonc'
        elif self.type in ('med_m2_bati', 'moy_m2_bati'):
            return 'valeurfonc/sbati'
        elif self.type in ('med_m2_terr', 'moy_m2_terr'):
            return 'valeurfonc/sterr'
        elif self.type in ('surfmed_terr', 'surftot_terr'):
            return 'sterr'
        elif self.type in ('surfmed_bati', 'surftot_bati'):
            return 'sbati'
    
    @property
    def unite(self):
        return self.get_type_indicateur('unite')
    
    @property
    def type_libelle(self):
        return self.get_type_indicateur('libelle')
    
    @property
    def periode(self):
        return self.periodicite
    
    @property
    def annee_debut(self):
        return self.an_min_max[0]
    
    @property
    def annee_fin(self):
        return self.an_min_max[1]
          
    @property
    def type_indic(self):
        if self.type in ('total', 'surftot_terr', 'surftot_bati'):
            return 'somme'
        elif self.type in ('nbtrans'):
            return 'compte'
        elif self.type in ('med', 'surfmed_terr', 'surfmed_bati', 'med_m2_bati', 'med_m2_terr'):
            return 'mediane'
        elif self.type in ('moy', 'moy_m2_bati', 'moy_m2_terr'):
            return 'moyenne'
        elif self.type in ('pq'):
            return 'pq'
        elif self.type in ('dq'):
            return 'dq'
    
    @property
    def typologie_libelle(self):
        for niv, typ in TYPOLOGIE_DV3F.items():
            for t in typ:
                if t[0] == self.code_typo:
                    return t[1]
        return None
     
    @property
    def type_graphe(self):
        if self.type in ('nbtrans', 'total', 'surftot_terr', 'surftot_bati'):
            return 'bar'
        elif self.type in ('med', 'moy', 'pq', 'dq', 'surfmed_terr', 'surfmed_bati', 'med_m2_terr', 'med_m2_bati', 'moy_m2_terr', 'moy_m2_bati'):
            return 'line-dotted'
        else:
            return 'bar'
    
    def get_type_indicateur(self, champ):
        for _, types in TYPES_INDICATEUR.items():
            for (abbr, libelle, unite, id) in types:
                if abbr == self.type:
                    if champ == 'unite':
                        return unite
                    elif champ == 'id':
                        return id
                    elif champ == 'libelle':
                        return libelle
        return None
    
    def id_filtre(self):
        id = ''
        for (abbr, libelle) in FILTRES:
            if abbr in self.filtres:
                id += '1'
            else:
                id += '0'
        return str(int(id, 2))
    
    def id_devenir(self):
        id = ''
        for (abbr, libelle) in DEVENIRS:
            if abbr in self.devenirs:
                id += '1'
            else:
                id += '0'
        return str(int(id, 2))
    



class IndicateurDVF():

    def __init__(self, indicateur, territoires, config_active):
        '''
        indicateur est une entree du modele Indicateur
        territoires est une liste d'entrée pouvant être issue des modèles Département, Epci, Commune
        '''
        self.config_active = config_active
        self.territoires = territoires
        self.indicateur = indicateur
        # calcul des valeurs
        self.donnees = self.calcul()
        self.facteur, self.prefixe = self.evaluer_prefixe_unite()
    
    def calcul(self):
        resultats = []
        resultat_indicateur = Resultat(self.indicateur)
        for t in self.territoires:
            resultat = resultat_indicateur.resultat_en_base(t, self.config_active)
            if resultat is None:
                return None
            resultats.append(resultat)
        return resultats
    
    def evaluer_prefixe_unite(self):
        facteur_unite, prefixe = 1, '' 
        if self.donnees is not None:       
            for d in self.donnees:
                for x, y in d:
                    if y >= 1000000000:
                        facteur_unite, prefixe = 1000000, 'M'
                        return facteur_unite, prefixe
                    elif y >= 1000000:
                        facteur_unite, prefixe = 1000, 'k'
        return facteur_unite, prefixe
    
    def unite(self, prefixe=True):
        if not self.indicateur.unite:
            return ''
        if prefixe : 
            return ' (' + self.prefixe + self.indicateur.unite + ')'
        return ' (' + self.indicateur.unite + ')'
    
    @property    
    def titre(self):
        return self.indicateur.nom
    
    @property
    def graphique(self):
        if self.donnees is None:
            return None
        mini, maxi = self.min_max_echelle()
        graph = {"xScale": "ordinal",
                 "yScale": "linear",
                 "yMin"  : round(0.3 * mini/self.facteur),
                 "yMax"  : round(1.12 * maxi/self.facteur)}
        graph["main"] = []
        for i, d in enumerate(self.donnees):
            donnees_formatees = [{"x": x, "y": round(y/self.facteur)} for (x, y) in d]
            graph["main"].append({"className" : ".graph" + str(i), "data" : donnees_formatees})
        return graph
    
    def min_max_echelle(self):        
        mini, maxi = 99999999999999999, 1
        for d in self.donnees:
            min_d = min(d, key = lambda x : x[1])
            max_d = max(d, key = lambda x : x[1])
            if min_d[1] < mini:
                mini = min_d[1]
            if max_d[1] > maxi:
                maxi = max_d[1]
        return mini, maxi          

    @property
    def tableau(self):
        if self.donnees is None:
            return None
        tableau = '<table class="table table-condensed table-striped">'
        for i, d in enumerate(self.donnees):
            if i == 0:
                tableau += '<tr><th class="text-center">' + self.unite(prefixe=False) + '</th>' + ''.join(['<th class="text-right">' + str(x) + '</th>' for (x, y) in d]) + '</tr>'
            tableau += '<tr><th class="text-left"><span class="color' + str(i) + '-indvf">' + self.territoires[i].nom + '</th>' + ''.join(['<td class="text-right text-nowrap">' + self._separateur_millier(str(y)) + '</td>' for (x, y) in d]) + '</tr>' 
        tableau += '</table>'
        return tableau        
                    
    def _separateur_millier(self, nombre, sep = ' '):
        if nombre:
            if len(nombre) <= 3:
                return nombre
            else:
                return self._separateur_millier(nombre[:-3], sep) + sep + nombre[-3:]

class Resultat():
    
    def __init__(self, indicateur):
        self.indicateur = indicateur
    
    def resultat_en_base(self, territoire, config_active):
        id_indicateur = self.indicateur.id 
        if not self.indicateur.indicateur_standard: # on supprime les résultats temporaires stockés si indicateur perso
            ResultatIndicateur.objects.supprimer_resultats(id_indicateur)
        if not ResultatIndicateur.objects.resultat_as_tuple(self.indicateur, territoire.id, territoire.type()):
            resultat = self.calcul(territoire, config_active)
            if resultat is None:
                return None
            self.sauvegarde(resultat, territoire)
        return ResultatIndicateur.objects.resultat_as_tuple(self.indicateur, territoire.id, territoire.type())
            
    
    def calcul(self, territoire, config_active):
        codes_insee = territoire.codes_insee
        c = RequeteurInDVF(config_active, script = 'sorties/script_indvf.sql')
        #c.creer_aggregat_mediane_10()
        resultat = c.calcul(self.indicateur, codes_insee)
        c.deconnecter()
        return resultat
    
    def sauvegarde(self, resultat, territoire):
        id_indicateur = self.indicateur.id
        id_territoire = territoire.id
        type_territoire = territoire.type()
        if self.indicateur.periode == 'ma':
            valeur = int(resultat[0][0]) or 0
            r = ResultatIndicateur(id_territoire=id_territoire, 
                                   type_territoire=type_territoire, 
                                   id_indicateur=id_indicateur, 
                                   annee=None, 
                                   resultat=valeur)
            r.save()
        elif self.indicateur.periode == 'a':
            annee_debut = self.indicateur.annee_debut
            annee_fin = self.indicateur.annee_fin
            for an in range(annee_debut, annee_fin + 1):
                if an not in [annee for annee, val in resultat]:
                    valeur = 0
                else:
                    valeur = [val for annee, val in resultat if an == annee][0]
                r = ResultatIndicateur(id_territoire=id_territoire, 
                                       type_territoire=type_territoire, 
                                       id_indicateur=id_indicateur, 
                                       annee=an, 
                                       resultat=valeur)
                r.save()                    
    
class RequeteurInDVF(PgOutils):
    
    def __init__(self, config_active, script = None):
        super().__init__(*(config_active.parametres_bdd()), script=script)
        self.config_active = config_active
    
    def calcul(self, indicateur, codes_insee):
        FONCTIONS_CALCUL = {('somme', 'ma')    : self.calculer_somme_multi_annee,
                            ('somme', 'a')     : self.calculer_somme_par_annee,
                            ('compte', 'ma')   : self.compter_multi_annee,
                            ('compte', 'a')    : self.compter_par_annee,
                            ('mediane','ma'): self.calculer_mediane_multi_annee,
                            ('mediane','a') : self.calculer_mediane_par_annee,
                            ('moyenne','ma'): self.calculer_moyenne_multi_annee,
                            ('moyenne','a') : self.calculer_moyenne_par_annee,
                            ('pq','ma'): self.calculer_pq_multi_annee,
                            ('pq','a') : self.calculer_pq_par_annee,
                            ('dq','ma'): self.calculer_dq_multi_annee,
                            ('dq','a') : self.calculer_dq_par_annee,
                            }
        parametres_indicateur = (indicateur.type_indic, indicateur.periode)
        return FONCTIONS_CALCUL[parametres_indicateur](indicateur, codes_insee)
    
    @property
    def variables_typobien(self):
        if self.config_active.type_bdd == 'DVF+' and not self.config_active.a_les_champs_typologie():
            codtypbien = self.requete_sql['_CODTYPBIEN']
            libtypbien = self.requete_sql['_LIBTYPBIEN']
            return ', ' + codtypbien + ', ' + libtypbien
        return ''
    
    @requete_sql    
    def creer_aggregat_mediane_10(self):
        pass
    
    @select_sql_avec_modification_args
    def calculer_somme_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien

    @select_sql_avec_modification_args
    def calculer_somme_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien

    @select_sql_avec_modification_args
    def compter_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien

    @select_sql_avec_modification_args
    def compter_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien

    @select_sql_avec_modification_args
    def calculer_mediane_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_mediane_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_moyenne_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_moyenne_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_pq_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_pq_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_dq_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_dq_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien
    
    def condition(self, indicateur):
        if indicateur.indicateur_standard:
            condition = ''
            if indicateur.code_typo != '999':
                condition += "WHERE codtypbien LIKE '{0}%'".format(indicateur.code_typo)
            else:
                condition += 'WHERE codtypbien IS NOT NULL'
            if self.config_active.type_bdd == 'DV3F':
                condition += " AND (" + " OR ".join(["filtre LIKE '%{0}%'".format(f) for f in indicateur.filtres]) + ")"
                condition += " AND (" + " OR ".join(["devenir LIKE '{0}%'".format(f) for f in indicateur.devenirs]) + ")"        
            try:
                denominateur = indicateur.variable.split('/')[1]
                condition_denominateur = ' {0} != 0'.format(denominateur)
                return condition + 'AND' + condition_denominateur
            except IndexError as e:
                return condition
        else:
            condition = PERSOMANAGER.get_condition_by_id(indicateur.condition_perso).condition
            return condition