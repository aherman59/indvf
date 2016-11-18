'''

#    Copyright (C) 2016  Cerema
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

'''

from main.models import Departement, Epci, Commune, Territoire
from indicateur.models import Indicateur, ResultatIndicateur

from pg.pgbasics import *

def indicateurs_actifs_format_xcharts(territoires, config_active):
        indicateurs_actifs = Indicateur.objects.indicateurs_actifs_tries()
        indicateursDVF = []
        for num, indicateur in enumerate(indicateurs_actifs):
            indic_dvf = IndicateurDVF(indicateur, territoires, config_active)
            i = {'idgraph': 'graph' + str(num),
                 'type_graph' : indicateur.type_graphe,
                 'graph'  : indic_dvf.graphique,
                 'tableau': indic_dvf.tableau,
                 'nom'    : indic_dvf.titre}            
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
    
    @property    
    def titre(self):
        unite = ' (' + self.prefixe + self.indicateur.unite + ')' if self.indicateur.unite else ''
        return self.indicateur.nom + unite
    
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
        unite = ' (en ' + self.indicateur.unite + ')' if self.indicateur.unite else ''
        tableau = '<table class="table table-condensed table-striped">'
        for i, d in enumerate(self.donnees):
            if i == 0:
                tableau += '<tr><th class="text-center">' + unite + '</th>' + ''.join(['<th class="text-right">' + str(x) + '</th>' for (x, y) in d]) + '</tr>'
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
    