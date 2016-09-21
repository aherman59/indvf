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
from outils.interrogation_bdd import Requeteur

def calcul_indicateurs_actifs_format_xcharts(territoires, config_active):
        indicateurs_actifs = Indicateur.objects.indicateurs_actifs_tries()
        requeteur = Requeteur(*(config_active.parametres_bdd()), 
                                type_base = config_active.type_bdd, 
                                script = 'sorties/script_indvf.sql')
        indicateursDVF = []
        for num, indicateur in enumerate(indicateurs_actifs):
            indic_dvf = IndicateurDVF(indicateur, territoires, requeteur)
            i = {}            
            i['graph'] = indic_dvf.graphique()
            i['idgraph'] = 'graph' + str(num) 
            i['type_graph'] = indicateur.type_graphe
            i['tableau'] = indic_dvf.tableau()
            i['nom'] = indic_dvf.titre()
            indicateursDVF.append(i)
        requeteur.deconnecter()
        return indicateursDVF 

class IndicateurDVF():

    def __init__(self, indicateur, territoires, requeteur):
        '''
        indicateur est une entree du modele Indicateur
        territoires est une liste d'entrée pouvant être issue des modèles Département, Epci, Commune
        requeteur est une instance de la classe outils.interrogation_bdd.Requeteur
        '''
        self.donnees = []
        self.calculateur = requeteur
        self.territoires = territoires
        self.id_indicateur = indicateur.id
        self.nom_indicateur = indicateur.nom
        self.type_indic = indicateur.type_indic
        self.unite = indicateur.unite
        self.periode = indicateur.periode
        self.variable = indicateur.variable
        self.annee_debut = indicateur.annee_debut
        self.annee_fin = indicateur.annee_fin
        self.code_typo = indicateur.code_typo
        self.facteur_unite = 1
    
    def code_insee(self, territoire):
        if isinstance(territoire, Commune):
            return [territoire.code]
        elif isinstance(territoire, Epci):
            communes = Commune.objects.filter(epci = territoire)
            return [c.code for c in communes]
        elif isinstance(territoire, Departement):
            communes = Commune.objects.filter(departement = territoire)
            return [c.code for c in communes]        
    
    def titre(self):
        self.evaluer_facteur_unite()
        if self.facteur_unite == 1000000:
            prefixe = 'M'
        elif self.facteur_unite == 1000 :
            prefixe = 'k'
        elif self.facteur_unite == 1 :
            prefixe = ''
        unite = ' (' + prefixe + self.unite + ')' if self.unite else ''
        return self.nom_indicateur + unite

    def graphique(self):
        if len(self.donnees) > 0:
            self.evaluer_facteur_unite()
            mini, maxi = self.min_max_echelle()
            graph = {}
            graph["xScale"] =  "ordinal"
            graph["yScale"] = "linear"
            graph["yMin"] = round(0.3 * mini/self.facteur_unite)
            graph["yMax"] = round(1.12 * maxi/self.facteur_unite)
            graph["main"] = []
            for i, d in enumerate(self.donnees):
                donnees_formatees = [{"x": x, "y": round(y/self.facteur_unite)} for (x, y) in d]
                graph["main"].append({"className" : ".graph" + str(i), "data" : donnees_formatees})
            return graph
        else:
            self.calcul()
            return self.graphique()
    
    def min_max_echelle(self):        
        if len(self.donnees) > 0:
            mini, maxi = 99999999999999999, 1
            for d in self.donnees:
                min_d = min(d, key = lambda x : x[1])
                max_d = max(d, key = lambda x : x[1])
                if min_d[1] < mini:
                    mini = min_d[1]
                if max_d[1] > maxi:
                    maxi = max_d[1]
            return mini, maxi
        else :
            self.calcul()
            self.min_max_echelle()           

    def tableau(self):
        if len(self.donnees) > 0:
            unite = ' (en ' + self.unite + ')' if self.unite else ''
            tableau = '<table class="table table-condensed table-striped">'
            for i, d in enumerate(self.donnees):
                if i == 0:
                    tableau += '<tr><th class="text-center">' + unite + '</th>' + ''.join(['<th class="text-right">' + str(x) + '</th>' for (x, y) in d]) + '</tr>'
                tableau += '<tr><th class="text-left"><span class="color' + str(i) + '-indvf">' + self.territoires[i].nom + '</th>' + ''.join(['<td class="text-right text-nowrap">' + self._separateur_millier(str(y)) + '</td>' for (x, y) in d]) + '</tr>' 
            tableau += '</table>'
            return tableau
        else:
            self.calcul()
            return self.tableau()

    def calcul(self):
        for t in self.territoires:
            calculs_disponibles = ResultatIndicateur.objects.filter(id_indicateur = self.id_indicateur).filter(id_territoire = t.id).filter(type_territoire = t.type())
            if len(calculs_disponibles) > 0 :
                calcul = self.reconstituer(calculs_disponibles)
            else:
                self.calculateur.creer_fonctions_utiles()
                if (self.type_indic == 'somme' and self.periode == 'a'):
                    calcul  = self.calculateur.calculer_somme_par_annee(self.variable, self.code_insee(t), self.code_typo)                         
                elif (self.type_indic == 'somme' and self.periode == 'ma'):
                    calcul = self.calculateur.calculer_somme_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo)
                elif (self.type_indic == 'compte' and self.periode == 'a'):
                    calcul = self.calculateur.compter_par_annee(self.variable, self.code_insee(t), self.code_typo)
                elif (self.type_indic == 'compte' and self.periode == 'ma'):
                    calcul = self.calculateur.compter_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo)
                elif (self.type_indic == 'mediane_10' and self.periode == 'a'):
                    calcul = self.calculateur.calculer_mediane_10_par_annee(self.variable, self.code_insee(t), self.code_typo)
                elif (self.type_indic == 'mediane_10' and self.periode == 'ma'):
                    calcul = self.calculateur.calculer_mediane_10_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo)
                calcul = self.formatter_et_sauvegarder(calcul, t)
            self.donnees.append(calcul)
    
    def evaluer_facteur_unite(self):
        if len(self.donnees) > 0 :
            for d in self.donnees:
                for x, y in d:
                    if y >= 1000000000:
                        self.facteur_unite = 1000000
                        return
                    elif y >= 1000000:
                        self.facteur_unite = 1000
        else :
            self.calcul()
            self.evaluer_facteur_unite()

    def formatter_et_sauvegarder(self, donnees, t):
        if self.periode == 'a':
            resultats = [(annee, int(resultat)) for annee, resultat in donnees if (int(annee) >= self.annee_debut and int(annee) <= self.annee_fin)]
            for an in range(self.annee_debut, self.annee_fin + 1):
                if an not in [annee for annee, resultat in resultats]:
                    resultats.append((str(an), 0))
                    r = ResultatIndicateur(id_territoire = t.id, type_territoire = t.type(), id_indicateur = self.id_indicateur, annee = an, resultat = 0)
                    r.save()
                else :
                    valeur = [resultat for annee, resultat in resultats if an == annee][0]
                    r = ResultatIndicateur(id_territoire = t.id, type_territoire = t.type(), id_indicateur = self.id_indicateur, annee = an, resultat = valeur)
                    r.save()
            return tuple(sorted(resultats, key = lambda x : int(x[0])))
        elif self.periode == 'ma':
            valeur = int(donnees[0][0]) or 0
            r = ResultatIndicateur(id_territoire = t.id, type_territoire = t.type(), id_indicateur = self.id_indicateur, annee = None, resultat = valeur)
            r.save()
            return ((str(self.annee_debut) + ' - ' + str(self.annee_fin), valeur),)
    
    def reconstituer(self, calculs_disponibles):
        if self.periode == 'a':
            resultats = []
            for an in range(self.annee_debut, self.annee_fin + 1):
                if an in [calcul_disponible.annee for calcul_disponible in calculs_disponibles]:
                    valeur = [calcul_disponible.resultat for calcul_disponible in calculs_disponibles if an == calcul_disponible.annee][0]
                    resultats.append((str(an), valeur))
            return tuple(sorted(resultats, key = lambda x : int(x[0])))
        elif self.periode == 'ma':
            valeur = calculs_disponibles[0].resultat        
            return ((str(self.annee_debut) + ' - ' + str(self.annee_fin), valeur),)
                    
    def _separateur_millier(self, nombre, sep = ' '):
        if nombre:
            if len(nombre) <= 3:
                return nombre
            else:
                return self._separateur_millier(nombre[:-3], sep) + sep + nombre[-3:]