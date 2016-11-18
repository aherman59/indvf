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
from outils import controle_bdd


class ConfigBDDForm(forms.ModelForm):
    class Meta:
        model = ConfigurationBDD
        fields = ['nom_config', 'hote', 'bdd', 'utilisateur', 'mdp', 'port', 'type_bdd']
        labels = {
            'nom_config' : 'Nom de la configuration',
            'hote': 'Hôte',
            'bdd' : 'Base de données',
            'utilisateur' : 'Utilisateur',
            'mdp' : 'Mot de Passe',
            'port' : 'Port',
            'type_bdd' : 'Type',
        }
        widgets = {
            'nom_config' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"Config_1"}),
            'hote' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}),
            'bdd' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"base_dvf"}),
            'utilisateur' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"postgres"}),
            'mdp' : forms.PasswordInput(attrs={'class':"form-control", 'placeholder':""}, render_value=True),
            'port' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"5432"}),
            'type_bdd': forms.Select(attrs={'class':"form-control"}),
        }
    
    def clean(self):
        cleaned_data = super(ConfigBDDForm, self).clean()
        hote = cleaned_data.get('hote') or ''
        bdd = cleaned_data.get('bdd') or ''
        utilisateur = cleaned_data.get('utilisateur') or ''
        mdp = cleaned_data.get('mdp') or ''
        port = cleaned_data.get('port') or ''
        type_bdd = cleaned_data.get('type_bdd') or ''

        test_connexion, msg_erreur = controle_bdd.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
        else:
            ctrlbdd = controle_bdd.ControleBDD(hote, bdd, port, utilisateur, mdp)
            if type_bdd == 'DVF+':
                test = ctrlbdd.est_une_base_DVF_plus()
                if not test:
                    self.add_error('__all__', "La base spécifiée n'est pas une base DVF+ valide.")
            elif type_bdd == 'DV3F':
                test = ctrlbdd.est_une_base_DV3F()
                if not test:
                    self.add_error('__all__', "La base spécifiée n'est pas une base DV3F valide.")
            else:
                self.add_error('__all__', "Le type de la base de données n'est pas valide")

        return cleaned_data
        
class SelectConfigBDDForm(forms.Form):
    selection = forms.ModelChoiceField(label = 'Selection', queryset = ConfigurationBDD.objects.all(), widget = forms.Select(attrs={'class':"form-control"}))
    
