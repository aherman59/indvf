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

TYPES_INDICATEUR = {'Quantitatif': [('nbtrans', 'Nombre de transactions'),
                                     ('total', 'Montant total'),],
                    'Prix' : [('med', 'Prix médian'),
                              ('pq', 'Premier quartile de prix'),
                              ('dq', 'Dernier quartile de prix'),],
                    'Surface' : [('surfmed', 'Surface médiane'),
                                 ('surftot', 'Surface totale'),],
                    }

FILTRES = [('A', 'Adjudication'),
           ('E', 'Echange'),
           ('T', 'Transfert'),
           ]

def indicateurs_actifs_format_xcharts(territoires, gestionnaire, config_active):
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


class GestionnaireIndicateurs:
        
    def _init_(self, typologies, filtres, types_indicateur):
        self.typologies = typologies
        self.filtres = filtres
        self.types_indicateur = types_indicateur
    
    def indicateurs_actifs(self):
        indicateurs = []
        for type_indicateur in self.types_indicateur:
            for typologie in self.typologies:
                for filtre in self.filtres:
                    indicateurs.append(Indicateur(type_indicateur, typologie, filtre))
        return indicateurs
    
class Indicateur:
    
    def __init__(self, type, typologie, filtre):
        self.type = type
        self.typologie = typologie
        self.filtre = filtre
    
    @property
    def nom(self):
        pass
        

def indicateurs_actifs_format_csv(territoires, config_active):
        indicateurs_actifs = Indicateur.objects.indicateurs_actifs_tries()
        indicateursDVF = []
        for num, indicateur in enumerate(indicateurs_actifs):
            indic_dvf = IndicateurDVF(indicateur, territoires, config_active)
            i = {'unite'  : indic_dvf.unite(prefixe=False),
                 'donnees': indic_dvf.donnees,
                 'territoires' : [t.nom for t in indic_dvf.territoires],
                 'nom'    : indic_dvf.titre,}            
            indicateursDVF.append(i)
        return indicateursDVF 

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
        if not ResultatIndicateur.objects.resultat_as_tuple(id_indicateur, territoire.id, territoire.type()):
            resultat = self.calcul(territoire, config_active)
            if resultat is None:
                return None
            self.sauvegarde(resultat, territoire)
        return ResultatIndicateur.objects.resultat_as_tuple(id_indicateur, territoire.id, territoire.type())
    
    def calcul(self, territoire, config_active):
        codes_insee = territoire.codes_insee
        c = RequeteurInDVF(*(config_active.parametres_bdd()), type_base=config_active.type_bdd, script = 'sorties/script_indvf.sql')
        c.creer_aggregat_mediane_10()
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
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, type_base = None, script = None):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.type_base = type_base
    
    def calcul(self, indicateur, codes_insee):
        FONCTIONS_CALCUL = {('somme', 'ma')    : self.calculer_somme_multi_annee,
                            ('somme', 'a')     : self.calculer_somme_par_annee,
                            ('compte', 'ma')   : self.compter_multi_annee,
                            ('compte', 'a')    : self.compter_par_annee,
                            ('mediane_10','ma'): self.calculer_mediane_10_multi_annee,
                            ('mediane_10','a') : self.calculer_mediane_10_par_annee,
                            }
        parametres_indicateur = (indicateur.type_indic, indicateur.periode)
        return FONCTIONS_CALCUL[parametres_indicateur](indicateur, codes_insee)
    
    @property
    def variables_typobien(self):
        if self.type_base == 'DV3F':
            return ''
        elif self.type_base == 'DVF+':
            codtypbien = self.requete_sql['_CODTYPBIEN']
            libtypbien = self.requete_sql['_LIBTYPBIEN']
            return ', ' + codtypbien + ', ' + libtypbien
    
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
    def calculer_mediane_10_par_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, self.variables_typobien
    
    @select_sql_avec_modification_args
    def calculer_mediane_10_multi_annee(self, indicateur, codes_insee):
        variable = indicateur.variable
        code_typo = self.condition(indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, self.variables_typobien
    
    def condition(self, indicateur):
        condition = '' if indicateur.code_typo == '999' else " WHERE codtypbien='{0}' ".format(indicateur.code_typo)
        try:
            denominateur = indicateur.variable.split('/')[1]
            condition_denominateur = ' {0} != 0 '.format(denominateur)
            return 'WHERE ' + condition_denominateur if not condition else condition + 'AND' + condition_denominateur
        except IndexError as e:
            return condition
    