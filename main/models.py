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

from collections import namedtuple
from django.db import models

from outils import controle_bdd

class ConfigurationManager(models.Manager):
    '''
    Manager du modèle ConfigurationBDD
    '''
    def configuration_active(self):
        try: 
            return self.get(active=True)
        except Exception as e:
            return None
    
    def parametres_bdd_active(self):
        config_active = self.configuration_active()
        if not config_active:
            return None
        return config_active.parametres_bdd()
    
    def type_bdd_active(self):
        config_active = self.configuration_active()
        if not config_active:
            return None
        return config_active.type_bdd
        
    def desactiver_configurations(self):
        for config in self.all():
            config.active = False
            config.save()
    
    def verifier_configuration_active(self):
        '''
        Renvoie un tuple nommé
        le premier element renvoie l'id de la configuration
        le premier boolean renvoie True si la base active est bien de type DVF+ ou DV3F
        le deuxième boolean renvoie True si la base active est bien une geobase 
        '''
        VerifConfiguration = namedtuple('VerifConfiguration', ['id', 'validation', 'geobase'])
        config_active = self.configuration_active()
        if config_active:
            if config_active.verification_configuration():
                id = int(config_active.pk)
                if config_active.est_une_geobase():
                    return VerifConfiguration(id, True, True)
                else:
                    return VerifConfiguration(id, True, False)                 
            else:
                return VerifConfiguration(-1, False, False)
        else:
            return VerifConfiguration(-1, False, False)

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
    
    objects = ConfigurationManager()

    def __str__(self):
        return self.nom_config
    
    def parametres_bdd(self):
        return (self.hote, 
                self.bdd, 
                self.port, 
                self.utilisateur, 
                self.mdp)
    
    def activer(self):
        self.active = True
        self.save()
    
    def controleur_bdd(self):
        return controle_bdd.ControleBDD(self.hote, 
                                        self.bdd, 
                                        self.port, 
                                        self.utilisateur, 
                                        self.mdp)
    
    def verification_configuration(self):
        '''
        Verifie que la configuration correspond bien au type de bdd spécifié (DVF+ ou DV3F)
        '''
        test, msg = controle_bdd.tentative_connexion(self.hote, 
                                                     self.bdd,
                                                     self.utilisateur,
                                                     self.mdp,  
                                                     self.port)
        if not test or self.type_bdd not in ['DVF+', 'DV3F']:
            return False
        if self.type_bdd == 'DVF+':
            return self.controleur_bdd().est_une_base_DVF_plus()
        if self.type_bdd == 'DV3F':
            return self.controleur_bdd().est_une_base_DV3F()
    
    def est_une_geobase(self):
        try:
            reussite = self.controleur_bdd().a_les_champs_geometriques()
            return reussite
        except Exception as e:
            print(e)
            return False

    def departements_disponibles(self):
        controleurbdd = self.controleur_bdd()
        departements = [dep[5:] for dep in controleurbdd.schemas_departementaux()]
        return Departement.objects.filter(code__in=departements)
    
    def communes_disponibles(self, departement):
        controleurbdd = self.controleur_bdd()
        communes = controleurbdd.lister_codes_insee_commune(departement)
        return Commune.objects.filter(code__in=communes)
        
    def epcis_disponibles(self, departement):
        controleurbdd = self.controleur_bdd()
        communes = controleurbdd.lister_codes_insee_commune(departement)
        epcis = Commune.objects.filter(code__in=communes).values_list('epci', flat=True)
        return Epci.objects.filter(pk__in = epcis)

class Departement(models.Model):
    nom = models.CharField(max_length=100)
    code = models.CharField(max_length=3, unique = True)

    def __str__(self):
        return self.nom
    
    def type(self):
        return 'departement'
    
class Epci(models.Model):
    nom = models.CharField(max_length=255)
    code = models.CharField(max_length=15, unique = True)
    departement = models.ForeignKey(Departement, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom
    
    def type(self):
        return 'epci'
        
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
    
    def type(self):
        return 'commune'

class TerritoireManager(models.Manager):
    
    def territoire_comparaison(self):
        return self.get(nom = 'comparaison')
    
    def territoire_comparaison_reinitialise(self):
        if len(self.filter(nom = 'comparaison')):
            self.get(nom = 'comparaison').delete()
        return self.create(nom = 'comparaison')
    

class Territoire(models.Model):
    nom = models.CharField(max_length = 100, unique = True)
    departements = models.ManyToManyField(Departement)
    epcis = models.ManyToManyField(Epci)
    communes = models.ManyToManyField(Commune)
    
    objects = TerritoireManager()
    
    def __str__(self):
        return self.nom
    
    def type(self):
        return 'territoire'

    def ajouter_departement(self, pk):
        self.departements.add(pk)
        self.save()

    def ajouter_epci(self, pk):
        self.epcis.add(pk)
        self.save()

    def ajouter_commune(self, pk):
        self.communes.add(pk)
        self.save()

    def lister_entites_administratives(self):
        return (
                list(self.departements.all()) 
                + list(self.epcis.all()) 
                + list(self.communes.all())
                   )
