'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

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
        pgload = PgLoad(hote, base, utilisateur, mdp)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur, mdp)
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
        pgload = PgLoad(hote, base, utilisateur, mdp)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur, mdp)
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
    
    def test_la_page_precise_la_base_active_si_elle_est_specifiee(self):
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
        url = reverse('main:configuration_bdd')
        reponse = self.client.get(url)
        self.assertContains(reponse, 'La configuration actuellement sélectionnée est Test_conf.')
        
    def test_la_page_affiche_aucune_configuration_active_si_cest_le_cas(self):
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
        url = reverse('main:configuration_bdd')
        reponse = self.client.get(url)
        self.assertContains(reponse, "Aucune configuration n'est selectionnée")
    
    def test_la_page_affiche_un_message_si_la_configuration_ne_repond_pas_aux_criteres(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DV3F',
                                        active = True)
        url = reverse('main:configuration_bdd')
        reponse = self.client.get(url)
        self.assertContains(reponse, "ne répond pas aux critères de définition d'une base de ce type")    
        
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

    def test_annulation_formulaire_renvoie_vers_la_page_accueil(self):
        donnees_post = {'annulation':''}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)        
        self.assertEqual(reponse.status_code, 302)
        self.assertEqual(reponse.url, reverse('main:applications'))
        
    def test_un_changement_de_selection_inscrit_les_donnees_correspondantes_dans_les_differents_champs(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = 'host2',
                                        bdd = 'base2',
                                        utilisateur = 'user2',
                                        mdp = 'mdp2',
                                        port = 'port2',
                                        type_bdd = 'DV3F',
                                        active = False)
        donnees_post = {'selection':'2'}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertContains(reponse, '<input type = "hidden" name="selection_config" value="2"/>', html=True) 
        self.assertContains(reponse, 'Test_conf2')
        self.assertContains(reponse, 'host2')
        self.assertContains(reponse, 'base2')
        self.assertContains(reponse, 'user2')
        self.assertContains(reponse, 'mdp2')
        self.assertContains(reponse, 'port2')
        donnees_post = {'selection':'1'}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertContains(reponse, '<input type = "hidden" name="selection_config" value="1"/>', html=True)
        self.assertContains(reponse, hote)
        self.assertContains(reponse, base)
        self.assertContains(reponse, port)
        self.assertContains(reponse, utilisateur)
        donnees_post = {'selection':''}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertNotIn('Test_conf', reponse)
        self.assertNotIn('Test_conf2', reponse)
        
    def test_le_bouton_supprimer_apparait_quand_la_configuration_existe_deja(self):
        ConfigurationBDD.objects.create(nom_config = 'Test_conf',
                                        hote = hote,
                                        bdd = base,
                                        utilisateur = utilisateur,
                                        mdp = mdp,
                                        port = port,
                                        type_bdd = 'DVF+',
                                        active = False)
        ConfigurationBDD.objects.create(nom_config = 'Test_conf2',
                                        hote = 'host2',
                                        bdd = 'base2',
                                        utilisateur = 'user2',
                                        mdp = 'mdp2',
                                        port = 'port2',
                                        type_bdd = 'DV3F',
                                        active = False)
        donnees_post = {'selection':'2'}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertContains(reponse, 'Supprimer cette configuration')
        donnees_post = {'selection':'1'}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertContains(reponse, 'Supprimer cette configuration')
        donnees_post = {'selection':''}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertNotIn('Supprimer cette configuration', reponse)
        
    def test_la_suppression_dune_configuration_existante_fonctionne_et_renvoie_un_formulaire_vierge(self):
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
        donnees_post = {'suppression':'', 'selection_config':'1'}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertEquals(len(ConfigurationBDD.objects.all()), 1)
        self.assertEquals((ConfigurationBDD.objects.all())[0].nom_config, 'Test_conf2')
        self.assertNotIn('Test_conf', reponse)
        self.assertNotIn('Test_conf2', reponse)
        
    def test_lactivation_echoue_si_hote_non_valide(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': 'hote_non_valide', 
                        'bdd':base, 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertTemplateUsed(reponse, 'configuration_bdd.html')
        #self.assertContains(reponse, 'Name or service not known')
        self.assertEqual(len(ConfigurationBDD.objects.all()), 0)
    
    def test_lactivation_echoue_si_bdd_non_valide(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':'base_non_valide', 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertTemplateUsed(reponse, 'configuration_bdd.html')
        self.assertEqual(len(ConfigurationBDD.objects.all()), 0)
    
    def test_lactivation_echoue_si_utilisateur_non_valide(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':base, 
                        'utilisateur': 'user_non_valide', 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertTemplateUsed(reponse, 'configuration_bdd.html')
        self.assertEqual(len(ConfigurationBDD.objects.all()), 0)
    
    def test_lactivation_echoue_si_port_non_valide(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':base, 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port': '', 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertTemplateUsed(reponse, 'configuration_bdd.html')
        self.assertEqual(len(ConfigurationBDD.objects.all()), 0)
    
    def test_lactivation_echoue_si_le_type_base_est_non_valide(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':base, 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DV3F',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)
        self.assertTemplateUsed(reponse, 'configuration_bdd.html')
        self.assertContains(reponse, "pas une base DV3F valide")
    
    def test_lactivation_reussit_si_la_configuration_est_correcte_et_retourne_vers_accueil(self):
        donnees_post = {'activation':'',
                        'selection_config':'0', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':base, 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)        
        self.assertEqual(reponse.status_code, 302)
        self.assertEqual(reponse.url, reverse('main:applications'))
        self.assertEqual(len(ConfigurationBDD.objects.all()), 1)
        self.assertEqual((ConfigurationBDD.objects.all())[0].nom_config, 'Test_conf')
        self.assertTrue((ConfigurationBDD.objects.all())[0].active)
    
    def test_lactivation_reussit_si_la_configuration_existante_choisie_est_correcte_et_retourne_vers_accueil(self):
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
                                        active = True)
        donnees_post = {'activation':'',
                        'selection_config':'1', 
                        'nom_config':'Test_conf',
                        'hote': hote, 
                        'bdd':base, 
                        'utilisateur':utilisateur, 
                        'mdp':mdp, 
                        'port':port, 
                        'type_bdd':'DVF+',}
        url = reverse('main:configuration_bdd')
        reponse = self.client.post(url, data = donnees_post)        
        self.assertEqual(reponse.status_code, 302)
        self.assertEqual(reponse.url, reverse('main:applications'))
        self.assertEqual(len(ConfigurationBDD.objects.all()), 2)
        self.assertTrue(ConfigurationBDD.objects.get(nom_config='Test_conf').active)
        self.assertFalse(ConfigurationBDD.objects.get(nom_config='Test_conf2').active)
        
            