from django import forms
from main.models import ConfigurationBDD

class ConfigBDDForm(forms.ModelForm):
    class Meta:
        model = ConfigurationBDD
        fields = ['hote', 'bdd', 'utilisateur', 'mdp', 'port', 'type_bdd', 'active']
        labels = {
            'hote': 'Hôte',
            'bdd' : 'Base de données',
        }
        widgets = {
            'hote' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}),
        }
        
