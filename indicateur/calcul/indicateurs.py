from .pg import *
from indicateur.models import Departement, Epci, Commune, Territoire

class IndicateurDVF():

    def __init__(self, indicateur, territoires, calculateur):
        self.donnees = []
        self.calculateur = calculateur
        self.territoires = territoires
        self.type_indic = indicateur.type_indic
        self.periode = indicateur.periode
        self.variable = indicateur.variable
        self.annee_debut = indicateur.annee_debut
        self.annee_fin = indicateur.annee_fin
        self.code_typo = indicateur.code_typo
    
    def code_insee(self, territoire):
        if isinstance(territoire, Commune):
            return [territoire.code]
        elif isinstance(territoire, Epci):
            communes = Commune.objects.filter(epci = territoire)
            return [c.code for c in communes]
        elif isinstance(territoire, Departement):
            communes = Commune.objects.filter(departement = territoire)
            return [c.code for c in communes]

    def graphique(self):
        if len(self.donnees) > 0:
            graph = {}
            graph["xScale"] =  "ordinal"
            graph["yScale"] = "linear"
            graph["main"] = []
            for i, d in enumerate(self.donnees):
                donnees_formatees = [{"x": x, "y": y} for (x, y) in d]
                graph["main"].append({"className" : ".graph" + str(i), "data" : donnees_formatees})
            return graph
        else:
            self.calcul()
            return self.graphique()

    def tableau(self):
        pass

    def calcul(self):
        if (self.type_indic == 'somme' and self.periode == 'a'):
            for t in self.territoires:
                self.donnees.append(self.formatter(self.calculateur.calculer_somme_par_annee(self.variable, self.code_insee(t))))
        elif (self.type_indic == 'somme' and self.periode == 'ma'):
            for t in self.territoires:
                self.donnees.append(self.formatter(self.calculateur.calculer_somme_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin)))
        elif (self.type_indic == 'compte' and self.periode == 'a'):
            for t in self.territoires:
                self.donnees.append(self.formatter(self.calculateur.compter_par_annee(self.variable, self.code_insee(t))))
         elif (self.type_indic == 'compte' and self.periode == 'ma'):
            for t in self.territoires:
                self.donnees.append(self.formatter(self.calculateur.compter_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin)))


    def formatter(self, donnees):
        if self.periode == 'a':
            return tuple((annee, int(resultat)) for annee, resultat in donnees if (int(annee) >= self.annee_debut and int(annee) <= self.annee_fin))
        elif self.periode == 'ma':
            return ((str(self.annee_debut) + ' - ' + str(self.annee_fin), int(donnees[0][0])),)
       

class CalculIndicateur(PgOutils):

    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
    
    @select_sql_avec_modification_args
    def calculer_somme_par_annee(self, variable, codes_insee):
        return variable, "'" + "', '".join(codes_insee) + "'"

    @select_sql_avec_modification_args
    def calculer_somme_multi_annee(self, variable, codes_insee, annee_debut, annee_fin):
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin

    @select_sql_avec_modification_args
    def compter_par_annee(self, variable, codes_insee):
        return variable, "'" + "', '".join(codes_insee) + "'"

    @select_sql_avec_modification_args
    def compter_multi_annee(self, variable, codes_insee, annee_debut, annee_fin):
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin
    
    
