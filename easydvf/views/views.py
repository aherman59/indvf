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

import json
from datetime import datetime

from django.shortcuts import render, redirect
from django.http import HttpResponse

from main.territoire import integration
from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire

from .filtre import ContexteFiltre
from .mutation import Mutations

'''

PAGE RECHERCHE

'''

def recherche(request):
    '''
    Permet de générer la page de résultat des mutations
    
    Une requete ajax sera lancée dès la fin du chargement de la page 
    pour mettre à jour le tableau des mutations (si la variable charger_tableau est True).
    La requete ajax correspond à la réponse de la fonction maj_tableau
    
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    'params' : paramètres de configuration de la bdd active (sert à instancier un objet Requeteur)
    'type_bdd' : type de la base de données DVF+ ou DV3F (sert à instancier un objet Requeteur)
    'titre' : titre pour le territoire affiché
    'mutations' : conserve l'ensemble des mutations du territoire actif
    'typologies' : conserve la liste des typologies disponibles (tuple (code, libelle)) pour le territoire actif
    'annees' : conserve la liste des années de mutation disponibles pour le territoire actif 
    'valeur_min_existante' : conserve la valeur fonciere minimale existante dans la liste des mutations
    'valeur_max_existante' : conserve la valeur fonciere maximale existante dans la liste des mutations
    'typologie' : typologie définie pour le filtre de mutations
    'annee_min' : annee minimale définie pour le filtre de mutations
    'annee_max' : annee maximale définie pour le filtre de mutations
    'valeur_min' : valeur foncière minimale définie pour le filtre de mutations
    'valeur max' : valeur foncière maximale définie pour le filtre de mutations
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    contexte = ContexteRecherche(request)
    if not contexte.success:
        return redirect('main:configuration_bdd')
    
    request.session = contexte.request.session      
    context = {'departements' : contexte.departements, 
               'epcis' : contexte.epcis, 
               'communes' : contexte.communes,
               'charger_tableau': contexte.charger_tableau,}
    return render(request, 'recherche.html', context)
    
    
class ContexteRecherche():
    
    def __init__(self, request):
        self.request = request
        self.success = True
        self.filtre = ContexteFiltre(self.request)
        self.charger_tableau = False
        self.main()
    
    def main(self):
        if self.request.method != 'POST' and self.request.get_full_path() == '/recherche/': # page démarrage
            self.configuration_initiale()
        elif 'departement' in self.request.POST: # changement de département
            self.selection_departement()
        elif 'voir_epci' in self.request.POST: # choix d'un epci
            self.selection_epci()
            self.charger_tableau = True
        elif 'voir_commune' in self.request.POST: # choix d'une commune
            self.selection_commune()
            self.charger_tableau = True
        self.request.session['parametres_filtre'] = self.filtre.parametres
    
    @property
    def config_active(self):
        if self.request.session['id_config']:
            return ConfigurationBDD.objects.get(pk = self.request.session['id_config'])
        return None
            
    @property    
    def departements(self):
        if self.config_active:
            return self.config_active.departements_disponibles()
        return None
    
    @property
    def code_departement(self):
        return Departement.objects.get(pk=self.request.session['departement']).code
    
    @property     
    def epcis(self):
        if self.config_active:
            return self.config_active.epcis_disponibles(self.code_departement)
        return None
    
    @property     
    def communes(self):
        if self.config_active:
            return self.config_active.communes_disponibles(self.code_departement)
        return None
    
    def configuration_initiale(self):
        verification = ConfigurationBDD.objects.verifier_configuration_active()
        if verification.validation:
            self.request.session['id_config'] = verification.id
            self.request.session['type_bdd'] = self.config_active.type_bdd
            self.request.session['params'] = self.config_active.parametres_bdd()
            self.initialisation()
        else:
            self.success = False
    
    def selection_departement(self):
        self.request.session['departement'] = int(self.request.POST['departement'])
        self.initialisation()
    
    def selection_epci(self):
        self.request.session['epci'] = int(self.request.POST['epci'])
        self.request.session['titre'] = Epci.objects.get(pk = self.request.session['epci']).nom
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = self.request.session['epci'])]
        self.request.session['mutations'] = self.calcul_mutations(codes_insee)
        self.filtre.definir_modalites(Mutations(self.request.session).as_objet())
    
    def selection_commune(self):
        self.request.session['commune'] = int(self.request.POST['commune'])
        self.request.session['titre'] = Commune.objects.get(pk = self.request.session['commune']).nom
        codes_insee = [str(Commune.objects.get(pk = self.request.session['commune']).code),]
        self.request.session['mutations'] = self.calcul_mutations(codes_insee)
        self.filtre.definir_modalites(Mutations(self.request.session).as_objet())
    
    def initialisation(self):
        self.request.session['titre'] = ''
        self.request.session['mutations'] = []
        self.filtre.initialiser_valeurs()
    
    def calcul_mutations(self, codes_insee):
        return Mutations(self.request.session, codes_insee).as_list()
    
    



    
     