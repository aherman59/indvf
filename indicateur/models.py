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
    code = models.CharField(max_length=5, unique = True)
    departement = models.ForeignKey(Departement, on_delete=models.CASCADE)
    epci = models.ForeignKey(Epci, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom
    
