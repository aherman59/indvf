import unittest
from collections import namedtuple
from pg.pgio import *

from outils.interrogation_bdd import Requeteur 

hote = 'localhost'
base = 'test_appdvf'
utilisateur = 'postgres'
mdp = 'postgres'
port = '5432'
fichier_base_test = './data_test/base_dvf_plus_test.sql'

class TestRequeteur(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.effacer_base()
        
    def setUp(self):
        unittest.TestCase.setUp(self)
        self.requeteur_dvf_plus = Requeteur(hote, base, port, utilisateur, mdp, type_base = 'DVF+')
    
    def tearDown(self):
        unittest.TestCase.tearDown(self)
        self.requeteur_dvf_plus.deconnecter()
    
    def test_recuperer_mutation_dvf_plus_renvoie_une_liste_de_mutations_avec_10_champs(self):
        resultat = self.requeteur_dvf_plus.recuperer_mutations_dvf_plus(['59350'])
        for mutation in resultat:
            self.assertEqual(len(mutation), 10)
            self.assertTrue(int(mutation[0]) > 0) # idmutation
            self.assertTrue(int(mutation[2]) > 2000) # anneemut
            self.assertTrue(float(mutation[3]) >= 0) # valeurfonc
    
    def test_la_fonction_mutations_renvoie_une_liste_de_namedtuple(self):
        mutations = self.requeteur_dvf_plus.mutations(['59350'])
        self.assertTrue(isinstance(mutations, list))
        for mutation in mutations:
            self.assertEqual(len(mutation), 10)
            self.assertTrue(mutation.id > 0)
            self.assertTrue(mutation.anneemut > 2000)
    
        