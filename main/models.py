from django.db import models


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


