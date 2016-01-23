from django import forms
from main.models import ConfigurationBDD
from main import configuration

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
            'mdp' : forms.TextInput(attrs={'class':"form-control"}),
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

        test_connexion, msg_erreur = configuration.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)

        return cleaned_data
        
class SelectConfigBDDForm(forms.Form):
    selection = forms.ModelChoiceField(label = 'Selection', queryset = ConfigurationBDD.objects.all(), widget = forms.Select(attrs={'class':"form-control"}))
    
