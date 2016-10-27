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

from django.test import TestCase
from django.core.urlresolvers import reverse

from .description_tables import lister_tables
from .models import Variable, DescriptionVariable, GroupementVariable, ValeurVariable

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
                description_simplifiee = 'variable de test 1 pour la table mutation',
                description = None
            )
        v1.save()
        
        v2 = Variable(
                position = 2, 
                nom = 'var2',
                code_modele = 3,
                table_associee = 'mutation',
                depuis_version = 'beta',
                jusque_version = None,
                type = 'varchar[]',
                contrainte = 'U',
                table_pour_creation = '',
                description_simplifiee = 'variable de test 2 pour la table mutation',
                description = None
            )
        v2.save()
        
        d1 = DescriptionVariable(
                nom = 'v1_desc',
                description = 'Ceci est la description détaillée de la variable 1',
                observation = 'Ceci est une observation',
                construction = 'Mais comment est construit cette variable ?',
                limites_precautions = 'Soyez prudent!!',
                fiabilite = 'OUI',
                amelioration = 'Un jour, peut être',
            )
        d1.save()
        v1.description = d1
        v1.save() 
    
    '''
        PAGE ACCUEIL
    '''
        
    def test_charge_la_page_accueil_doc(self):
        url = reverse('docdv3f:accueil_doc')
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
        
    def test_la_page_accueil_contient_la_liste_des_tables(self):
        url = reverse('docdv3f:accueil_doc')
        reponse = self.client.get(url)
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
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
        self.assertContains(reponse, 'table mutation')
    
    def test_charge_la_page_disposition_parcelle(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'disposition_parcelle'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
    
    def test_renvoie_un_404_si_la_table_nexiste_pas(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'table_inexistante'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 404)
    
    def test_affichage_position_variable(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<th>N°</th>', html=True)
        self.assertContains(reponse, '<td>1</td>', html=True)
    
    def test_affichage_nom_variable(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<th>Nom</th>', html=True)
        self.assertContains(reponse, 'variable_test')
        
    def test_affichage_description_variable(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<td>variable de test 1 pour la table mutation</td>', html=True)
    
    def test_affichage_type_serial_variable(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<td>Entier auto-incrémenté</td>', html=True)
    
    def test_affichage_type_tableau_variable(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<td>Caractère[]</td>', html=True)
        
    def test_affichage_contrainte_clef_primaire(self):
        url = reverse('docdv3f:doc_table', kwargs={'table': 'mutation'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '<td class="text-center">PK</td>', html=True)
        
    '''        
        PAGE DOC VARIABLES
    '''
        
    def test_charge_la_page_variable(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
        self.assertContains(reponse, 'variable_test')
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'var2'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 200)
    
    def test_renvoie_un_404_si_la_table_nexiste_pas(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_inexistante'})
        reponse = self.client.get(url)
        self.assertEqual(reponse.status_code, 404)
    
    def test_affiche_modele(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'DVF+ et DV3F')
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'var2'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'DV3F')
    
    def test_affiche_type_variable_fr_en(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Entier auto-incrémenté')
        self.assertContains(reponse, 'serial')
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'var2'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Caractère[]')
        self.assertContains(reponse, 'varchar[]')
    
    def test_affiche_contrainte(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Clef primaire')
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'var2'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'unicité')
    
    def test_affiche_existence(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'La variable existe depuis la version beta.')
    
    def test_affiche_description_simplifiee(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'variable de test 1 pour la table mutation')
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'var2'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'variable de test 2 pour la table mutation')
    
    def test_affichage_description_detaillee(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Description détaillée')
        self.assertContains(reponse, 'Ceci est la description détaillée de la variable 1')
    
    def test_affichage_observation(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Observation')
        self.assertContains(reponse, 'Ceci est une observation')
        
    def test_affichage_fiabilite(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, 'Remplissage et Fiabilité de la variable')
        self.assertContains(reponse, 'OUI')
        
    def test_affichage_usage(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '''Conseils ou Précautions d'usage''')
        self.assertContains(reponse, 'Soyez prudent!!')
        
    def test_affichage_amelioration(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '''Pistes d'amélioration''')
        self.assertContains(reponse, 'Un jour, peut être')
    
    def test_affichage_construction(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '''Méthode de construction''')
        self.assertContains(reponse, 'Mais comment est construit cette variable ?')
    
    def test_affichage_modalites_si_valeurs(self):    
        val = ValeurVariable(
            valeur = 'valeur_test',
            depuis_version = 'beta',
            jusque_version = None,
            detail = 'Valeur de test',
            description = DescriptionVariable.objects.get(nom = 'v1_desc'),
            )
        val.save()
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '''Modalités''')
        self.assertContains(reponse, '''valeur_test''')
    
    def test_non_affichage_modalites_si_pas_valeurs(self):    
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertNotContains(reponse, '''Modalités''')
    
    def test_affichage_variables_associees_si_groupement(self):
        v1 = Variable.objects.get(position = 1, table_associee = 'mutation')
        v2 = Variable.objects.get(position = 2, table_associee = 'mutation')        
        grp = GroupementVariable(nom = 'groupe_test')
        grp.save()
        grp.variables_associees.add(v1)
        grp.variables_associees.add(v2)
        grp.save()
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertContains(reponse, '''Variables associées''')
        self.assertContains(reponse, '''var2''')
        
    def test_non_affichage_variables_associees_si_pas_de_groupement(self):
        url = reverse('docdv3f:doc_variable', kwargs={'table':'mutation', 'variable': 'variable_test'})
        reponse = self.client.get(url)
        self.assertNotContains(reponse, '''Variables associées''')