from django.db import models

class IndicateurManager(models.Manager):
    '''
    Manager du modèle Indicateur
    '''
    
    def indicateurs_actifs_tries(self):
        return self.filter(actif=True).order_by('-code_typo', 'annee_debut', 'type_indic', 
                                                'periode', 'unite', 'variable', 'nom')
    
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
    
class ResultatIndicateur(models.Model):
    id_territoire = models.IntegerField()
    type_territoire = models.CharField(max_length = 50)
    id_indicateur = models.IntegerField()
    annee = models.IntegerField(null = True)
    resultat = models.IntegerField()
