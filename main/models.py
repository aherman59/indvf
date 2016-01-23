from django.db import models

# Create your models here.

class ConfigurationBDD(models.Model):
    CHOIX_TYPE_BDD = (('DVF+', 'Base de type DVF+'), ('DV3F','Base de type DV3F'))
    nom_config = models.CharField(max_length=100, unique = True)
    hote = models.CharField(max_length=255)
    bdd = models.CharField(max_length=255)
    utilisateur = models.CharField(max_length=255)
    mdp = models.CharField(max_length=255)
    port = models.CharField(max_length=10)
    type_bdd = models.CharField(max_length=4, choices=CHOIX_TYPE_BDD)
    active = models.BooleanField()
    date_creation = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.nom_config
