import unittest
from pg.pgio import *

from outils.controle_bdd import tentative_connexion, ControleBDD

hote = 'localhost'
base = 'test_appdvf'
utilisateur = 'postgres'
mdp = 'postgres'
port = '5432'
fichier_base_test = './data_test/base_dvf_plus_test.sql'

class TestControleBDD(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.charger_fichier_sql_dans_nouvelle_base(fichier_base_test)        
    
    @classmethod
    def tearDownClass(cls):
        pgload = PgLoad(hote, base, utilisateur)
        pgload.effacer_base()
        
    def test_tentative_connexion_renvoie_True_OK_si_fonctionne(self):
        reussite, msg = tentative_connexion(hote, base, utilisateur, mdp, port)
        self.assertTrue(reussite)
        self.assertEqual(msg, 'OK')
    
    def test_tentative_connexion_renvoie_False_msg_erreur_si_parametre_incorrect(self):
        reussite, msg = tentative_connexion('hote_incorrect', base, utilisateur, mdp, port)
        self.assertFalse(reussite)
        reussite, msg = tentative_connexion(hote, 'base_incorrecte', utilisateur, mdp, port)
        self.assertFalse(reussite)
        reussite, msg = tentative_connexion(hote, base, 'user_incorrect', mdp, port)
        self.assertFalse(reussite)
        reussite, msg = tentative_connexion(hote, base, utilisateur, mdp, 'port_incorrect')
        self.assertFalse(reussite)
        
    def test_le_renvoi_des_schemas_principaux_echoue_si_parametres_connexion_incorrects(self):
        ctrl = ControleBDD('hote_incorrect', base, port, utilisateur, mdp)
        self.assertRaises(Exception, ctrl.a_schemas_principaux)
 
    def test_renvoie_True_si_les_schemas_principaux_existent(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        self.assertTrue(ctrl.a_schemas_principaux())
    
    def test_renvoie_False_si_un_des_schemas_principaux_n_existent_pas(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.execution('''ALTER SCHEMA dvf_annexe RENAME TO dvf_annexe_bis;''')
        self.assertFalse(ctrl.a_schemas_principaux())
        ctrl.execution('''ALTER SCHEMA dvf_annexe_bis RENAME TO dvf_annexe;''')
    
    def test_lister_schemas_departementaux_fonctionne(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        self.assertListEqual(ctrl.schemas_departementaux(), ['dvf_d59'])
    
    def test_renvoie_True_si_a_au_moins_schema_departemental(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        self.assertTrue(ctrl.a_au_moins_un_schema_departemental())
    
    def test_renvoie_False_si_les_schemas_departementaux_n_existent_pas(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.execution('''ALTER SCHEMA dvf_d59 RENAME TO dvf_59;''')
        self.assertFalse(ctrl.a_au_moins_un_schema_departemental())
        ctrl.execution('''ALTER SCHEMA dvf_59 RENAME TO dvf_d59;''')
    
    def test_renvoie_True_si_la_base_possede_les_tables_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        self.assertTrue(ctrl.a_les_tables_dvf_plus())
    
    def test_renvoie_False_si_la_base_ne_possede_pas_toutes_les_tables_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.renommer_table('dvf_d59', 'mutation', 'mutation_bis')
        self.assertFalse(ctrl.a_les_tables_dvf_plus())
        ctrl.renommer_table('dvf_d59', 'mutation_bis', 'mutation')
    
    def test_renvoie_True_si_les_tables_principales_contiennent_les_champs_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        self.assertTrue(ctrl.a_les_champs_dvf_plus())
    
    def test_renvoie_False_si_la_table_local_ne_contiennent_pas_tous_les_champs_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.execution('''ALTER TABLE dvf.local RENAME COLUMN idloc TO idloc_bis;''')
        self.assertFalse(ctrl.a_les_champs_dvf_plus())
        ctrl.execution('''ALTER TABLE dvf.local RENAME COLUMN idloc_bis TO idloc;''')
            
    def test_renvoie_False_si_la_table_disposition_parcelle_ne_contiennent_pas_tous_les_champs_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.execution('''ALTER TABLE dvf.disposition_parcelle RENAME COLUMN idpar TO idpar_bis;''')
        self.assertFalse(ctrl.a_les_champs_dvf_plus())
        ctrl.execution('''ALTER TABLE dvf.disposition_parcelle RENAME COLUMN idpar_bis TO idpar;''')
    
    def test_renvoie_False_si_la_table_mutation_ne_contiennent_pas_tous_les_champs_dvf_plus(self):
        ctrl = ControleBDD(hote, base, port, utilisateur, mdp)
        ctrl.execution('''ALTER TABLE dvf.mutation RENAME COLUMN idmutation TO idmutation_bis;''')
        self.assertFalse(ctrl.a_les_champs_dvf_plus())
        ctrl.execution('''ALTER TABLE dvf.mutation RENAME COLUMN idmutation_bis TO idmutation;''')
    
    
    
    
        