from django.test import TestCase

from .description_tables import lister_tables
from .models import Variable

class TestDocDV3F(TestCase):
    
    @classmethod
    def setUpTestData(cls):
        super(TestDocDV3F, cls).setUpTestData()        
        v1 = Variable(
                        position = 1, 
                        nom = 'variable_test',
                        code_modele = 1,
                        table_associee = 'mutation',
                        depuis_version = 'beta',
                        jusque_version = None,
                        type = 'serial',
                        contrainte = 'PK',
                        table_pour_creation = '',
                        description_simplifiee = 'identifiant de clef primaire de la table mutation',
                        description = None
                    )
        v1.save()
    
    '''
        PAGE ACCUEIL
    '''
        
    def test_charge_la_page_accueil_doc(self):
        reponse = self.client.get('/doc/')
        self.assertEqual(reponse.status_code, 200)
        
    def test_la_page_accueil_contient_la_liste_des_tables(self):
        reponse = self.client.get('/doc/')
        self.assertContains(reponse, 'DocDV3F')
        self.assertContains(reponse, 'Tables principales')
        self.assertContains(reponse, 'Tables secondaires')
        self.assertContains(reponse, 'Tables annexes')
        for table in lister_tables():
            self.assertContains(reponse, table)
    
    '''        
        PAGE DOC TABLES
    '''
            
    def test_charge_la_page_mutation(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertEqual(reponse.status_code, 200)
        self.assertContains(reponse, 'table mutation')
    
    def test_charge_la_page_disposition_parcelle(self):
        reponse = self.client.get('/doc/table/disposition_parcelle')
        self.assertEqual(reponse.status_code, 200)
    
    def test_renvoie_un_404_si_la_table_nexiste_pas(self):
        reponse = self.client.get('/doc/table/table_inexistante')
        self.assertEqual(reponse.status_code, 404)
    
    def test_affichage_position_variable(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertContains(reponse, '<th>N°</th>', html=True)
        self.assertContains(reponse, '<td>1</td>', html=True)
    
    def test_affichage_nom_variable(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertContains(reponse, '<th>Nom</th>', html=True)
        self.assertContains(reponse, 'variable_test')
        
    def test_affichage_description_variable(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertContains(reponse, '<td>identifiant de clef primaire de la table mutation</td>', html=True)
    
    def test_affichage_type_serial_variable(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertContains(reponse, '<td>Entier auto-incrémenté</td>', html=True)
        
    def test_affichage_contrainte_clef_primaire(self):
        reponse = self.client.get('/doc/table/mutation')
        self.assertContains(reponse, '<td>PK</td>', html=True)
        
    '''        
        PAGE DOC VARIABLES
    '''
        
    def test_charge_la_page_variable(self):
        reponse = self.client.get('/doc/variable/mutation/variable_test')
        self.assertEqual(reponse.status_code, 200)
        self.assertContains(reponse, 'variable_test')
    
    def test_renvoie_un_404_si_la_table_nexiste_pas(self):
        reponse = self.client.get('/doc/variable/mutation/variable_inexistante')
        self.assertEqual(reponse.status_code, 404)