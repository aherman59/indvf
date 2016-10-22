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

from django.db import models

class IndicateurManager(models.Manager):
    '''
    Manager du modèle Indicateur
    '''
    
    def indicateurs_actifs_tries(self):
        return self.filter(actif=True).order_by('-code_typo', 'annee_debut', 'type_indic', 
                                                'periode', 'unite', 'variable', 'nom')
    
    def supprimer(self, id_indicateur):
        indicateur_choisi = self.get(pk = id_indicateur)
        indicateur_choisi.delete()
        
    
class Indicateur(models.Model):
    
    TYPOLOGIE = (('999','Tout type de mutation'),
                 ('8','Adjudication'),
                 ('9','Expropriation'),
                 ('7','Echange'),
                 ('4','Volume'),
                 ('31', 'Vefa - Industriel et Commercial'),
                 ('32', 'Vefa - Appart'),
                 ('33', 'Vefa - Maison'),
                 ('34', 'Vefa - Non déterminé'),
                 ('211','Non Bati - Terrain naturels'),
                 ('212','Non Bati - Terrains forestiers'),
                 ('213','Non Bati - Terrains agricoles'),
                 ('221','Non Bati - Terrains artificialisés'),
                 ('241','Non Bati - Terrains non déterminés'),
                 ('231','Non Bati - Terrains mixtes'),
                 ('25', 'Non Bati - Terrain à bâtir'),
                 ('111','Bati - Logement/industriel et commercial'),
                 ('112','Bati - Industriel et Commercial'),
                 ('121','Bati - Appartements'),
                 ('122','Bati - Appartement'),
                 ('131','Bati - Maisons'),
                 ('132','Bati - Maison'),
                 ('141','Bati - Bien agricole'),
                 ('142', 'Bati - Dépendance Logement'),
                 ('143', 'Bati - Logement mixte'),
                 ('144', 'Bati - Non déterminé'),
                 ('145', 'Bati - Bien forestier'),)
        
    nom = models.CharField(max_length = 255)
    type_indic = models.CharField(max_length = 30, choices =(('somme', 'Somme'),
                                                             ('compte', 'Décompte'),
                                                             ('mediane_10', 'Médiane')))
    unite = models.CharField(max_length = 30, null = True)
    periode = models.CharField(max_length = 2, choices = (('a','annuel'),
                                                          ('ma','multi-annuel')))
    variable = models.CharField(max_length = 50)
    annee_debut = models.IntegerField()
    annee_fin = models.IntegerField()
    code_typo = models.CharField(max_length = 5, choices = TYPOLOGIE)
    type_graphe = models.CharField(max_length = 20, choices = (('bar', 'diagramme à barre'),
                                                               ('line-dotted', 'diagramme point-ligne')))
    actif = models.BooleanField(default = True)
    
    objects = IndicateurManager()

    def __str__(self):
        return self.nom


class ResultatIndicateurManager(models.Manager):
    
    def resultat_as_tuple(self, id_indicateur, id_territoire, type_territoire):
        resultats = self.filter(id_indicateur = id_indicateur).filter(id_territoire = id_territoire).filter(type_territoire=type_territoire)
        if len(resultats) == 0:
            return None
        indicateur = Indicateur.objects.get(pk=id_indicateur)
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        if indicateur.periode == 'ma':
            return ((str(annee_debut) + ' - ' + str(annee_fin), resultats[0].resultat),)
        elif indicateur.periode == 'a':
            r = [(str(result.annee), result.resultat) for result in resultats]
            return tuple(sorted(r, key = lambda x : int(x[0])))
    
    def supprimer_resultats(self, id_indicateur):
        self.filter(id_indicateur = id_indicateur).delete()             

        
class ResultatIndicateur(models.Model):
    id_territoire = models.IntegerField()
    type_territoire = models.CharField(max_length = 50)
    id_indicateur = models.IntegerField()
    annee = models.IntegerField(null = True)
    resultat = models.IntegerField()
    
    objects = ResultatIndicateurManager()
