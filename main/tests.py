from django.test import TestCase
from pg.pgio import *

from .models import ConfigurationBDD

hote = 'localhost'
base = 'test_appdvf'
utilisateur = 'postgres'
mdp = 'postgres'
port = '5432'
fichier_base_test = './data_test/base_dvf_plus_test.sql'

class TestModelConfigurationBDD(TestCase):
    
    @classmethod
    def setUpClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.effacer_base()
        
    def test_configuration_bdd_est_bien_cree_si_toutes_les_valeurs_sont_renseignees(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        configs = ConfigurationBDD.objects.all()
        self.assertEqual(len(configs), 1)
    
    def test_configuration_bdd_nest_pas_cree_si_valeur_non_renseignee(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'Blabla',
                                        active = False)
        configs = ConfigurationBDD.objects.all()
        self.assertEqual(len(configs), 0)
    
    def test_configuration_bdd_nest_pas_cree_si_nom_config_deja_existant(self):
        try:
            ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        
            ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DV3F',
                                        active = False)
        except Exception as e:
            pass
        configs = ConfigurationBDD.objects.all()
        self.assertEqual(len(configs), 1)
    
