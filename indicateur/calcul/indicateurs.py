from pg.pgbasics import *
from main.models import Departement, Epci, Commune, Territoire
from main.controle_bdd import ControleBDD 

class IndicateurDVF():

    def __init__(self, indicateur, territoires, calculateur):
        self.donnees = []
        self.calculateur = calculateur
        self.territoires = territoires
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
            graph = {}
            graph["xScale"] =  "ordinal"
            graph["yScale"] = "linear"
            graph["main"] = []
            for i, d in enumerate(self.donnees):
                donnees_formatees = [{"x": x, "y": round(y/self.facteur_unite)} for (x, y) in d]
                graph["main"].append({"className" : ".graph" + str(i), "data" : donnees_formatees})
            return graph
        else:
            self.calcul()
            return self.graphique()

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
        calculs = []
        if (self.type_indic == 'somme' and self.periode == 'a'):
            for t in self.territoires:
                calculs.append(self.calculateur.calculer_somme_par_annee(self.variable, self.code_insee(t), self.code_typo))                          
        elif (self.type_indic == 'somme' and self.periode == 'ma'):
            for t in self.territoires:
                calculs.append(self.calculateur.calculer_somme_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo))
        elif (self.type_indic == 'compte' and self.periode == 'a'):
            for t in self.territoires:
                calculs.append(self.calculateur.compter_par_annee(self.variable, self.code_insee(t), self.code_typo))
        elif (self.type_indic == 'compte' and self.periode == 'ma'):
            for t in self.territoires:
                calculs.append(self.calculateur.compter_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo))
        elif (self.type_indic == 'mediane_10' and self.periode == 'a'):
            for t in self.territoires:
                calculs.append(self.calculateur.calculer_mediane_10_par_annee(self.variable, self.code_insee(t), self.code_typo))
        elif (self.type_indic == 'mediane_10' and self.periode == 'ma'):
            for t in self.territoires:
                calculs.append(self.calculateur.calculer_mediane_10_multi_annee(self.variable, self.code_insee(t), self.annee_debut, self.annee_fin, self.code_typo))
        for t in self.territoires:
            self.donnees = [self.formatter(calcul) for calcul in calculs]
    
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

    def formatter(self, donnees):
        if self.periode == 'a':
            resultats = [(annee, int(resultat)) for annee, resultat in donnees if (int(annee) >= self.annee_debut and int(annee) <= self.annee_fin)]
            for an in range(self.annee_debut, self.annee_fin + 1):
                if an not in [annee for annee, resultat in resultats]:
                    resultats.append((str(an), 0))
            return tuple(sorted(resultats, key = lambda x : int(x[0])))
        elif self.periode == 'ma':
            return ((str(self.annee_debut) + ' - ' + str(self.annee_fin), int(donnees[0][0])),)
        
    def _separateur_millier(self, nombre, sep = ' '):
        if nombre:
            if len(nombre) <= 3:
                return nombre
            else:
                return self._separateur_millier(nombre[:-3], sep) + sep + nombre[-3:]
       

class CalculIndicateur(PgOutils):

    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.base = 'DV3F' if ControleBDD(hote, base, port, utilisateur, motdepasse).est_une_base_DV3F() else 'DVF+'
        self.creer_aggregat_mediane_10()
    
    @requete_sql    
    def creer_aggregat_mediane_10(self):
        pass
    
    @select_sql_avec_modification_args
    def calculer_somme_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def calculer_somme_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def compter_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def compter_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, variables_typologie_dvf_plus
    
    @select_sql_avec_modification_args
    def calculer_mediane_10_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus
    
    @select_sql_avec_modification_args
    def calculer_mediane_10_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus
    
    def condition_code_typo(self, code_typo):
        return '' if code_typo == '999' else " WHERE codtypbien='{0}' ".format(code_typo)
    
    def ajout_variables_typologies(self):
        return '' if self.base == 'DV3F' else self.requete_sql['SOUS_REQUETE_TYPOLOGIE']
    
    
