from django.test import TestCase
from django.core.urlresolvers import reverse
from pg.pgio import *

from .forms import ConfigBDDForm
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
    
    def test_la_configuration_active_est_renvoyee_si_elle_existe(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = True)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.configuration_active()
        self.assertEqual(config.nom_config, 'Test_conf')
        
    def test_configuration_active_renvoie_None_si_elle_n_existe_pas(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.configuration_active()
        self.assertEqual(config, None)
    
    def test_configuration_active_renvoie_None_si_plusieurs_configurations_sont_actives(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = True)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = True)
        config = ConfigurationBDD.objects.configuration_active()
        self.assertEqual(config, None)
        
    def test_la_configuration_est_rendue_active_par_la_fonction_activer(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config = 'Test_conf')
        config.activer()
        self.assertTrue(config.active)

    def test_la_desactivation_des_configurations_bdd_fonctionne(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = True)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        ConfigurationBDD.objects.desactiver_configurations()
        configs = ConfigurationBDD.objects.all()
        for config in configs:
            self.assertFalse(config.active)
    
    def la_verification_de_la_bdd_type_DVF_plus_renvoie_True_si_la_configuration_est_correcte(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertTrue(config.verification_configuration())
    
    def la_verification_de_la_bdd_type_DVF_plus_renvoie_False_si_le_type_bdd_est_incorrect(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DV3F',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertFalse(config.verification_configuration())
    
    def la_verification_de_la_bdd_type_DVF_plus_renvoie_False_si_lhote_est_incorrect(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = 'blabla',
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertFalse(config.verification_configuration())
        
    def la_verification_de_la_bdd_type_DVF_plus_renvoie_False_si_lhote_est_incorrect(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = 'blabla',
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertFalse(config.verification_configuration())
    
    def la_verification_de_la_geobase_renvoie_True_si_la_configuration_est_correcte(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertTrue(config.est_une_geobase())
    
    def la_verification_de_la_geobase_renvoie_False_si_la_configuration_est_incorrecte(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = 'blabla',
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        config = ConfigurationBDD.objects.get(nom_config='Test_conf')
        self.assertFalse(config.est_une_geobase())

class TestMain(TestCase):

    @classmethod
    def setUpClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.effacer_base()
    
    '''
    TEST PAGE CONFIGURATION BDD
    '''
    
    def test_charge_la_page_configuration_bdd(self):
        url = reverse('main:configuration_bdd')
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
    
    def test_la_page_configuration_bdd_charge_un_formulaire(self):
        url = reverse('main:configuration_bdd')
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Paramètrage de la base de données')
        self.assertContains(reponse, '<form')
        
    '''
    TEST FORMULAIRE
    '''
    
    def test_validation_formulaire_configuration_bdd(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':hote, 
                              'bdd':base, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'type_bdd':'DVF+',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertTrue(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_hote_incorrect(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':'blabla', 
                              'bdd':base, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'type_bdd':'DVF+',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_bdd_incorrecte(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':hote, 
                              'bdd':'blabla', 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'type_bdd':'DVF+',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_utilisateur_incorrect(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':hote, 
                              'bdd':base, 
                              'utilisateur':'fkefzeav', 
                              'mdp':mdp, 
                              'port':port, 
                              'type_bdd':'DVF+',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_port_incorrect(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':hote, 
                              'bdd':base, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':'80', 
                              'type_bdd':'DVF+',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_bdd_incorrect(self):
        donnees_formulaire = {'nom_config':'Test_conf',
                              'hote':hote, 
                              'bdd':base, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'type_bdd':'blabla',}
        formulaire = ConfigBDDForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    '''
    
    TEST REQUETE POST SUR PAGE CONFIGURATION BDD
    
    '''

    def test_annulation_formulaire_renvoie(self):
        donnees_post = {'annulation':''}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)        
        self.assertEqual(reponse.status_code, 302)
        self.assertEqual(reponse.url, reverse('main:applications'))