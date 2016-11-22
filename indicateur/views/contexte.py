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

from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire
from indicateur.models import Indicateur, ResultatIndicateur
from indicateur.forms import IndicateurForm, SelectIndicateurForm
from indicateur.indicateurs import indicateurs_actifs_format_xcharts
from indicateur.indicateurs import indicateurs_actifs_format_csv

class ContexteIndicateur():
    
    def __init__(self, request):
        self.request = request
        self.success = True
        self.charger_indicateur = True
        self.main()
    
    def main(self):
        if self.request.method != 'POST' and self.request.get_full_path() == '/indicateur/': # page démarrage
            self.configuration_initiale()
            self.charger_indicateur = False
        elif 'voir_departement' in self.request.POST: # choix d'un nouveau département
            print(self.request.POST)
            self.selection_departement(ajout=False)
        elif 'voir_epci' in self.request.POST: # choix d'un nouvel epci
            self.selection_epci(ajout=False)
        elif 'voir_commune' in self.request.POST: # choix d'une nouvelle commune
            self.selection_commune(ajout=False)
        elif 'ajout_departement' in self.request.POST: # ajout d'un nouveau département
            self.selection_departement(ajout=True)
        elif 'ajout_epci' in self.request.POST: # ajout d'un nouvel epci
            self.selection_epci(ajout=True)
        elif 'ajout_commune' in self.request.POST: # ajout d'une nouvelle commune
            self.selection_commune(ajout=True)
        elif 'departement' in self.request.POST: # changement de département
            self.changement_departement()
            self.charger_indicateur = False
    
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
        if 'departement' in self.request.session:
            return Departement.objects.get(pk=self.request.session['departement']).code
        return self.config_active.departements_disponibles()[0].code
    
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

    def territoire(self, mise_a_zero = False):
        if mise_a_zero:
            return Territoire.objects.territoire_comparaison_reinitialise()
        return Territoire.objects.territoire_comparaison()
    
    @property
    def indicateurs(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires) and self.charger_indicateur:
            return indicateurs_actifs_format_xcharts(territoires, self.config_active)
        return []
    
    @property
    def indicateurs_csv(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires) and self.charger_indicateur:
            return indicateurs_actifs_format_csv(territoires, self.config_active)
        return []
    
    @property
    def titre(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires):
            return ', '.join(['<span class="color'+ str(i) + '-indvf">' 
                          + territoire.nom 
                          + '</span>' for i, territoire in enumerate(territoires)])
        return ''
    
    def configuration_initiale(self):
        verification = ConfigurationBDD.objects.verifier_configuration_active()
        if verification.validation:
            self.request.session['id_config'] = verification.id
            self.request.session['type_bdd'] = self.config_active.type_bdd
            self.request.session['params'] = self.config_active.parametres_bdd()
            self.initialisation()
        else:
            self.success = False
    
    def changement_departement(self):
        self.initialisation()
        self.request.session['departement'] = int(self.request.POST['departement'])        
    
    def selection_departement(self, ajout):
        self.request.session['departement'] = int(self.request.POST['departement'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_departement(self.request.session['departement'])
    
    def selection_epci(self, ajout):
        self.request.session['epci'] = int(self.request.POST['epci'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_epci(self.request.session['epci'])
    
    def selection_commune(self, ajout):
        self.request.session['commune'] = int(self.request.POST['commune'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_commune(self.request.session['commune']) 
    
    def initialisation(self):
        self.request.session.pop('departement', None)
        self.request.session['epci'] = 0
        self.request.session['commune'] = 0


class ContexteConfigIndicateur():
    
    def __init__(self, request):
        self.request = request
        self.formulaire = IndicateurForm()
        self.formulaire_selection = SelectIndicateurForm()
        self.id_indicateur = 0
        self.annulation = False
        self.main()
    
    def main(self):
        if 'selection' in self.request.POST: # modification de la selection
            if self.request.POST['selection'] != '':
                id_indicateur = int(self.request.POST['selection'])
                self.modification_selection(id_indicateur)
        elif 'annulation' in self.request.POST: # annulation
            self.annulation = True
        elif 'suppression' in self.request.POST: # suppression de la selection
            id_indicateur = int(self.request.POST['selection_indicateur'])
            self.suppression(id_indicateur)
        elif 'creation' in self.request.POST: # creation ou modification de l'indicateur
            id_indicateur = int(self.request.POST['selection_indicateur'])
            if id_indicateur == 0:
                self.creation()
            else:
                self.modification(id_indicateur)
    
    def modification_selection(self, id_indicateur):
        self.id_indicateur = id_indicateur
        indicateur = Indicateur.objects.get(pk = self.id_indicateur)
        self.formulaire = IndicateurForm(instance = indicateur)
        self.formulaire_selection = SelectIndicateurForm(initial = {'selection' : self.id_indicateur })

    def suppression(self, id_indicateur):
        Indicateur.objects.supprimer(id_indicateur)
        ResultatIndicateur.objects.supprimer_resultats(id_indicateur)
    
    def creation(self):
        indicateurform = IndicateurForm(self.request.POST)
        if indicateurform.is_valid():
            indicateurform.save()
        else:
            self.formulaire = indicateurform
    
    def modification(self, id_indicateur):
        indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
        indicateurform = IndicateurForm(self.request.POST, instance = indicateur_choisi)
        if indicateurform.is_valid():       
            indicateurform.save()
            ResultatIndicateur.objects.supprimer_resultats(id_indicateur)
        else:
            self.id_indicateur = id_indicateur
            self.formulaire = indicateurform        
