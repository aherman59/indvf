import os

from django.test import TestCase
from django.core.urlresolvers import reverse

from .forms import ConfigForm

hote = 'localhost'
bdd = 'test_appdvf'
utilisateur = 'postgres'
mdp = 'cerema59'
port = '5432'
chemin_dossier = './importdvf/creation_dvf/ressources'

class TestImportDVF(TestCase):
    
    @classmethod
    def setUpClass(cls):
        os.system('''
    psql -h {0} -p {1} -U {2} -c "CREATE DATABASE {3};"
                '''.format(hote, port, utilisateur, bdd))
        os.system('''
    psql -h {0} -p {1} -U {2} -d {3} -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;"
                 '''.format(hote, port, utilisateur, bdd))
        
    
    @classmethod
    def tearDownClass(cls):
        os.system('''psql -h localhost -p 5432 -U postgres -c "DROP DATABASE test_appdvf;"''')
        
    '''
    TEST PAGE ACCUEIL IMPORT
    '''
    
    def test_charge_la_page_accueil_import(self):
        url = reverse('import:formulaire_configuration')
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)

    def test_la_page_accueil_import_contient_un_formulaire(self):
        url = reverse('import:formulaire_configuration')
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Paramètrage de la base de données')
        self.assertContains(reponse, '<form')
    
    '''
    TEST FORMULAIRE
    '''
    
    def test_validation_formulaire_configuration(self):
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertTrue(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_hote_incorrect(self):
        donnees_formulaire = {'hote':'blabla', 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_bdd_incorrecte(self):
        donnees_formulaire = {'hote':hote, 
                              'bdd':'base_non_existante', 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_utilisateur_incorrect(self):
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':'blabla', 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_port_incorrect(self):
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':'80', 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    def test_formulaire_non_valide_si_chemin_dossier_incorrect(self):
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':'./trucmuche/',
                              'proxy':None}
        formulaire = ConfigForm(data = donnees_formulaire)
        self.assertFalse(formulaire.is_valid())
    
    '''
    TEST LANCEMENT IMPORT
    ''' 
    
    def test_retour_page_formulaire_avec_alerte_si_formulaire_invalide(self):
        
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':'80', 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        url = reverse('import:etape_import', kwargs={'etape':'0'})
        reponse = self.client.post(url, data=donnees_formulaire)
        self.assertContains(reponse, '<form')
        self.assertContains(reponse, 'alert')
    
    def test_lancement_page_import_si_formulaire_valide(self):
        
        donnees_formulaire = {'hote':hote, 
                              'bdd':bdd, 
                              'utilisateur':utilisateur, 
                              'mdp':mdp, 
                              'port':port, 
                              'chemin_dossier':chemin_dossier,
                              'proxy':None}
        url = reverse('import:etape_import', kwargs={'etape':'0'})
        reponse = self.client.post(url, data=donnees_formulaire)
        self.assertContains(reponse, 'Création de la base de données DVF+')
    
    def test_lancement_etape_1(self):
        
        session = self.client.session
        session['dossier'] = chemin_dossier 
        session['parametre_connexion'] = (hote, bdd, port, utilisateur, mdp) 
        session['effacer_schemas_existants']=True
        session['geolocaliser']=False 
        session['communes_a_geolocaliser']=None 
        session['proxy']=None
        session.save()

        url = reverse('import:etape_import', kwargs={'etape':'1'})
        reponse = self.client.post(url, HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertContains(reponse, 'Vérification des fichiers terminée')
    
        
    
