from django.db import models

class Departement(models.Model):
    nom = models.CharField(max_length=100)
    code = models.CharField(max_length=3, unique = True)

    def __str__(self):
        return self.nom
    
class Epci(models.Model):
    nom = models.CharField(max_length=255)
    code = models.CharField(max_length=15, unique = True)
    departement = models.ForeignKey(Departement, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom
        
class Commune(models.Model):
    nom = models.CharField(max_length=100)
    code = models.CharField(max_length=5)
    departement = models.ForeignKey(Departement, on_delete=models.CASCADE)
    epci = models.ForeignKey(Epci, on_delete=models.CASCADE)
    code_actualite = models.CharField(max_length=2, null = True)
    commune_absorbante = models.CharField(max_length=5, null = True)
    commune_emancipee = models.CharField(max_length=5, null = True)
    date_absorbtion = models.DateField(null = True)
    date_separation = models.DateField(null = True)

    def __str__(self):
        return self.nom

class Territoire(models.Model):
    nom = models.CharField(max_length = 100, unique = True)
    departements = models.ManyToManyField(Departement)
    epcis = models.ManyToManyField(Epci)
    communes = models.ManyToManyField(Commune)
    
    def __str__(self):
        return self.nom

    def ajouter_departement(self, pk):
        self.departements.add(pk)
        self.save()

    def ajouter_epci(self, pk):
        self.epcis.add(pk)
        self.save()

    def ajouter_commune(self, pk):
        self.communes.add(pk)
        self.save()

class Indicateur(models.Model):
    nom = models.CharField(max_length = 255)
    type_indic = models.CharField(max_length = 100)
    periode = models.CharField(max_length = 2, choices = (('a','annuel'),('ma','multi-annuel')))
    variable = models.CharField(max_length = 50)
    annee_debut = models.IntegerField(null = True)
    annee_fin = models.IntegerField(null = True)
    code_typo = models.CharField(max_length = 5)
    type_graphe = models.CharField(max_length = 20, choices = (('bar', 'diagramme à barre'),('line-dotted', 'diagramme point-ligne')))
    actif = models.BooleanField(default = True)

    def __str__(self):
        return self.nom


