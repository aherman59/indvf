import os

import unittest
from django.test import TestCase
from django.core.urlresolvers import reverse

from .forms import ConfigForm
from main.configuration import BASE_DIR
from .creation_dvf.cadastre import Cadastre

hote = 'localhost'
bdd = 'test_appdvf'
utilisateur = 'postgres'
mdp = 'postgres'
port = '5432'
chemin_dossier = './importdvf/creation_dvf/ressources'

repertoire_ressources = os.path.join(BASE_DIR, 'importdvf/creation_dvf/ressources') 
fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                        os.path.join(repertoire_ressources,'natcult.csv'),
                        os.path.join(repertoire_ressources,'natcultspe.csv'))

class TestCadastre(unittest.TestCase):
    
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
    
    def setUp(self):
        self.cada = Cadastre(hote, bdd, port, utilisateur, mdp)
        
    def tearDown(self):
        self.cada.deconnecter()
    
    '''
    test sur récuperation données et parcelles
    '''
    
    def test_une_requete_communale_avec_un_code_INSEE_correct_renvoie_True_et_un_dictionnaire(self):
        reussite, entites = self.cada.recuperer_donnees_json_commune('59001')
        self.assertTrue(reussite)
        self.assertFalse(entites is None)
        self.assertEqual(type(entites), type(dict()))
    
    def test_une_requete_communale_avec_un_code_INSEE_incorrect_renvoie_False_et_None(self):
        reussite, entites = self.cada.recuperer_donnees_json_commune('00001')
        self.assertFalse(reussite)
        self.assertTrue(entites is None)
    
    def test_une_requete_communale_avec_un_code_INSEE_a_6_caracteres_renvoie_False_et_None(self):
        reussite, entites = self.cada.recuperer_donnees_json_commune('590100')
        self.assertFalse(reussite)
        self.assertTrue(entites is None)
    
    def test_une_requete_communale_qui_echoue_renvoie_False_et_None(self):
        self.cada.url_commune = 'https://cadastre.erreur_api_volontaire.gouv.fr/commune/{0}'
        reussite, entites = self.cada.recuperer_donnees_json_commune('59001')
        self.assertFalse(reussite)
        self.assertTrue(entites is None)
    
    def test_une_requete_avec_donnee_parcelle_correcte_renvoie_un_dictionnaire(self):
        reussite, entites = self.cada.recuperer_donnees_json_parcelle('59001', '0U', '0369')
        self.assertTrue(reussite)
        self.assertFalse(entites is None)
        self.assertEqual(type(entites), type(dict()))
    
    def test_une_requete_avec_donnee_parcelle_dont_codeINSEE_incorrect_renvoie_False_et_None(self):
        reussite, entites = self.cada.recuperer_donnees_json_parcelle('00001', 'ZZ', '0000')
        self.assertFalse(reussite)
        self.assertTrue(entites is None)
    
    def test_une_requete_avec_donnee_parcelle_inexistante_mais_codeINSEE_correct_renvoie_True_et_un_dictionnaire(self):
        reussite, entites = self.cada.recuperer_donnees_json_parcelle('59001', 'ZZ', '0000')
        self.assertTrue(reussite)
        self.assertEqual(type(entites), type(dict()))
    
    def test_une_requete_avec_donnee_parcelle_qui_echoue_renvoie_False_et_none(self):
        self.cada.url_parcelle = 'https://cadastre.erreur_api_volontaire.gouv.fr/commune/{0}?{1}'
        reussite, entites = self.cada.recuperer_donnees_json_parcelle('59001', '0U', '0369')
        self.assertFalse(reussite)
        self.assertTrue(entites is None)
    
    def test_la_recuperation_des_parcelles_pour_code_INSEE_valable_renvoie_True_et_une_liste_non_vide(self):
        reussite, parcelles = self.cada.recuperer_parcelles('59001')
        self.assertTrue(len(parcelles) > 0)
        self.assertTrue(reussite)
    
    def test_la_recuperation_des_parcelles_pour_code_INSEE_non_valable_renvoie_False_et_une_liste_vide(self):
        reussite, parcelles = self.cada.recuperer_parcelles('00001')
        self.assertTrue(len(parcelles) == 0)
        self.assertFalse(reussite)
    
    def test_la_recuperation_des_parcelles_si_requete_echoue_renvoie_False_et_une_liste_vide(self):
        self.cada.url_commune = 'https://cadastre.erreur_api_volontaire.gouv.fr/commune/{0}'
        reussite, parcelles = self.cada.recuperer_parcelles('59001')
        self.assertTrue(len(parcelles) == 0)
        self.assertFalse(reussite)
    
    def test_les_parcelles_recuperees_ont_des_idpar_qui_commencent_bien_par_le_code_insee(self):
        code_insee = '59001'
        reussite, parcelles = self.cada.recuperer_parcelles(code_insee)
        for parcelle in parcelles:
            self.assertEqual(parcelle.idpar[:5], code_insee)
    
    def test_les_parcelles_recuperees_ont_des_coordonnees_qui_renvoient_bien_un_liste_non_vide(self):
        code_insee = '59001'
        reussite, parcelles = self.cada.recuperer_parcelles(code_insee)
        for parcelle in parcelles:
            self.assertEqual(type(parcelle.coordonnees), type(list()))
            self.assertTrue(len(parcelle.coordonnees) > 0)      
         
    def test_la_recuperation_dune_parcelle_pour_donnees_valables_renvoie_True_et_une_parcelle_bien_constituee(self):
        reussite, parcelle = self.cada.recuperer_parcelle('59001', '0U', '0369')
        self.assertTrue(reussite)
        self.assertEqual(parcelle.idpar[:5], '59001')
        self.assertEqual(type(parcelle.coordonnees), type(list()))
        self.assertTrue(len(parcelle.coordonnees) > 0)
    
    def test_la_recuperation_dune_parcelle_pour_donnees_non_valables_mais_Code_INSEE_correct_renvoie_True_et_None(self):
        reussite, parcelle = self.cada.recuperer_parcelle('59001', 'ZZ', '0369')
        self.assertTrue(reussite)
        self.assertEqual(parcelle, None)        
        reussite, parcelle = self.cada.recuperer_parcelle('59001', '0U', '0000')
        self.assertTrue(reussite)
        self.assertEqual(parcelle, None)
    
    def test_la_recuperation_dune_parcelle_avec_code_INSEE_incorrect_renvoie_False_et_None(self):
        reussite, parcelle = self.cada.recuperer_parcelle('00001', '0U', '0369')
        self.assertFalse(reussite)
        self.assertEqual(parcelle, None)
        
    def test_la_recuperation_dune_parcelle_si_la_requete_echoue_renvoie_False_et_None(self):
        self.cada.url_parcelle = 'https://cadastre.erreur_api_volontaire.gouv.fr/commune/{0}?{1}'
        reussite, parcelle = self.cada.recuperer_parcelle('59001', '0U', '0369')        
        self.assertFalse(reussite)
        self.assertEqual(parcelle, None)
        
    '''
     test sur bdd
    '''
        
    def test_la_table_est_creee_si_inexistante(self):
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire0')
        self.assertTrue(reussite)
        schemas = self.cada.lister_schemas()
        self.assertTrue('cadastre' in schemas)
        tables = self.cada.lister_tables('cadastre')
        self.assertTrue('parcellaire0' in tables)
    
    def test_la_table_nest_pas_recreee_si_existante(self):
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire1')
        self.cada.execution('''INSERT INTO cadastre.parcellaire1 VALUES('62', '62001000ZZ0123', 25.1, NULL, NULL, 'source_inconnue', 'V')''')
        nb_lignes = self.cada.compter('cadastre', 'parcellaire1')
        self.assertEqual(nb_lignes, 1)
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire1')
        self.assertTrue(reussite)
        nb_lignes = self.cada.compter('cadastre', 'parcellaire1')
        self.assertEqual(nb_lignes, 1)
    
    def test_la_parcelle_recuperee_est_bien_inseree(self):
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire2')
        self.cada.inserer_parcelle('59001', '0U', '0369', 'cadastre', 'parcellaire2')
        lignes = self.cada.execution_et_recuperation('''SELECT * FROM cadastre.parcellaire2''')
        self.assertEqual(len(lignes), 1)
        self.assertEqual(lignes[0][0], '59')
        self.assertEqual(lignes[0][1], '590010000U0369')
    
    def test_les_parcelles_recuperees_pour_la_commune_sont_bien_inserees(self):
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire3')
        self.cada.inserer_parcelles_communales('59009', 'cadastre', 'parcellaire3')
        lignes = self.cada.execution_et_recuperation('''SELECT * FROM cadastre.parcellaire3''')
        self.assertTrue(len(lignes) > 0)
        for ligne in lignes:
            self.assertEqual(ligne[0], '59')
            self.assertEqual(ligne[1][:5], '59009')
            
    def test_aucune_parcelle_inseree_si_code_INSEE_incorrect_et_renvoi_message_erreur(self):
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire4')
        reussite, msg = self.cada.inserer_parcelles_communales('00001', 'cadastre', 'parcellaire4')
        compte = self.cada.compter('cadastre', 'parcellaire4')
        self.assertFalse(reussite)
        self.assertEqual(compte, 0)
        self.assertEqual(msg, 'Problème requêtage ou code INSEE incorrect')
    
    def test_aucune_parcelle_inseree_si_erreur_requete_et_renvoi_message_erreur(self):
        self.cada.url_commune = 'https://cadastre.erreur_api_volontaire.gouv.fr/commune/{0}'
        reussite, nb = self.cada.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire5')
        reussite, msg = self.cada.inserer_parcelles_communales('59001', 'cadastre', 'parcellaire5')
        compte = self.cada.compter('cadastre', 'parcellaire5')
        self.assertFalse(reussite)
        self.assertEqual(compte, 0)
        self.assertEqual(msg, 'Problème requêtage ou code INSEE incorrect')
        
        
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
        '''
        Un fichier de test est correct
        L'autre est incorrect
        '''
        session = self.client.session
        session['dossier'] = chemin_dossier 
        session['parametres_connexion'] = (hote, bdd, port, utilisateur, mdp) 
        session['effacer_schemas_existants']=True
        session['geolocaliser']=False 
        session['communes_a_geolocaliser']=None 
        session['proxy']=None
        session['etapes'] = [
                            (0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                            (1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF'),
                            ]
        session.save()
        url = reverse('import:etape_import', kwargs={'etape':'1'})
        reponse = self.client.post(url, HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        print(reponse.content)
        self.assertIn('"etape_suivante": "2"', str(reponse.content, encoding='utf-8'))
        self.assertIn('"warning": "La ligne 2 du fichier', str(reponse.content, encoding='utf-8'))
    
    def test_lancement_etape_1_sur_repertoire_sans_fichiers_txt(self):       
        session = self.client.session
        session['dossier'] = os.path.dirname(chemin_dossier) # pas de fichiers txt 
        session['parametres_connexion'] = (hote, bdd, port, utilisateur, mdp) 
        session['effacer_schemas_existants']=True
        session['geolocaliser']=False 
        session['communes_a_geolocaliser']=None 
        session['proxy']=None
        session['etapes'] = [
                            (0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                            (1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF'),
                            ]
        session.save()
        url = reverse('import:etape_import', kwargs={'etape':'1'})
        reponse = self.client.post(url, HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        print(reponse.content)
        self.assertIn('{"erreur": true}', str(reponse.content, encoding='utf-8'))
            
    def test_lancement_etape_2(self):       
        
        session = self.client.session
        session['dossier'] = chemin_dossier 
        session['parametres_connexion'] = (hote, bdd, port, utilisateur, mdp) 
        session['effacer_schemas_existants']=True
        session['geolocaliser']=False 
        session['communes_a_geolocaliser']=None 
        session['proxy']=None
        session['departements']=['62', '59']
        session['etapes'] = [
                            (0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                            (1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF'),
                            (2, 300, '15', 'creation', ('DVF', fichier_gestion_csv, fichiers_annexes, session['effacer_schemas_existants'],), 'Import des données sources DVF - Fichier X')
                            ]
        session.save()

        url = reverse('import:etape_import', kwargs={'etape':'2'})
        reponse = self.client.post(url, HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertIn('"etape_suivante": "300"', str(reponse.content, encoding='UTF-8'))
    
        
    
