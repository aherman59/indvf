from django.db import models

class Indicateur(models.Model):
    nom = models.CharField(max_length = 255)
    type_indic = models.CharField(max_length = 30, choices =(('somme', 'Somme'),('decompte', 'Décompte'),('mediane', 'Médiane')))
    unite = models.CharField(max_length = 30, null = True)
    periode = models.CharField(max_length = 2, choices = (('a','annuel'),('ma','multi-annuel')))
    variable = models.CharField(max_length = 50)
    annee_debut = models.IntegerField(null = True)
    annee_fin = models.IntegerField(null = True)
    code_typo = models.CharField(max_length = 5)
    type_graphe = models.CharField(max_length = 20, choices = (('bar', 'diagramme à barre'),('line-dotted', 'diagramme point-ligne')))
    actif = models.BooleanField(default = True)

    def __str__(self):
        return self.nom


