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
    
    def desactiver_configurations(self):
        for config in self.all():
            config.active = False
            config.save()

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
                                                     self.port                                                    
                                                     )
        if not test or self.type_bdd not in ['DVF+', 'DV3F']:
            return False
        if self.type_bdd == 'DVF+' and not self.controleur_bdd().est_une_base_DVF_plus():
                return False
        if self.type_bdd == 'DV3F' and not self.controleur_bdd().est_une_base_DV3F():
                return False
        return True
    
    def est_une_geobase(self):
        if self.controleur_bdd().a_les_champs_geometriques():
            return True
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
