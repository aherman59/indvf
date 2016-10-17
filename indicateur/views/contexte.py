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

from indicateur.indicateurs import calcul_indicateurs_actifs_format_xcharts

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
        elif 'departement' in self.request.POST: # changement de département
            self.changement_departement()
            self.charger_indicateur = False
        elif 'voir_departement' in self.request.POST: # choix d'un nouveau département
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

    def territoire(self, mise_a_zero = False):
        if mise_a_zero:
            return Territoire.objects.territoire_comparaison_reinitialise()
        return Territoire.objects.territoire_comparaison()
    
    @property
    def indicateurs(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires):
            return calcul_indicateurs_actifs_format_xcharts(territoires, self.config_active)
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
        self.request.session['departement'] = int(self.request.POST['departement'])
        self.initialisation()
    
    def selection_departement(self, ajout):
        self.territoire(mise_a_zero=(not ajout)).ajouter_departement(self.request.session['departement'])
    
    def selection_epci(self, ajout):
        self.request.session['epci'] = int(self.request.POST['epci'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_epci(self.request.session['epci'])
    
    def selection_commune(self, ajout):
        self.request.session['commune'] = int(self.request.POST['commune'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_commune(self.request.session['commune']) 
    
    def initialisation(self):
        self.request.session['epci'] = 0
        self.request.session['commune'] = 0
           
        