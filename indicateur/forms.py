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

from django import forms
from main.models import ConfigurationBDD
from indicateur.models import Indicateur

class IndicateurForm(forms.ModelForm):
    class Meta:
        model = Indicateur
        fields = ['nom', 'type_indic', 'unite', 'variable', 'periode', 'annee_debut', 'annee_fin', 'code_typo', 'type_graphe', 'actif']
        labels = {
            'nom' : 'Nom de l\'indicateur',
            'type_indic': 'Type d\'indicateur',
            'unite' : 'Unité',
            'variable' : 'Variable observée',
            'periode' : 'Echelle temporelle',
            'annee_debut' : 'Année de début',
            'annee_fin' : 'Année de fin',
            'code_typo' : 'Code de typologie',
            'type_graphe' : 'Type de graphique',
            'actif' : 'Rendre actif',            
        }
        widgets = {
            'nom' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"Indicateur_1"}),
            'type_indic' : forms.Select(attrs={'class':"form-control"}),
            'unite' : forms.TextInput(attrs={'class':"form-control", 'placeholder':""}),
            'variable' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"valeurfonc"}),
            'periode' : forms.Select(attrs={'class':"form-control"}),
            'annee_debut' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"2011"}),
            'annee_fin' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"2015"}),
            'code_typo' : forms.Select(attrs={'class':"form-control"}),
            'type_graphe': forms.Select(attrs={'class':"form-control"}),
            'actif': forms.CheckboxInput(attrs={'class':"form-control"}),
        }

    def clean(self):
        cleaned_data = super(IndicateurForm, self).clean()
        
        # controle années
        annee_debut = cleaned_data.get('annee_debut') or 0
        annee_fin = cleaned_data.get('annee_fin') or 0
        if int(annee_debut) >= int(annee_fin):
            self.add_error('__all__', "L'année de début est supérieure ou égale à l'année de fin.")
        
        # controle validité variable
        variable = cleaned_data.get('variable') or ''   
        config_active = ConfigurationBDD.objects.configuration_active()
        success = config_active.controleur_bdd().tester_variable_mutation(variable)
        if not success:
            self.add_error('__all__', 'Variable mal définie')        
        
        return cleaned_data
        
class SelectIndicateurForm(forms.Form):
    selection = forms.ModelChoiceField(label = 'Selection', queryset = Indicateur.objects.all(), widget = forms.Select(attrs={'class':"form-control"}))
    