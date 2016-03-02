from django import forms
from main.models import ConfigurationBDD
from main.controle_bdd import tentative_connexion, ControleBDD


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
        type_bdd = cleaned_data.get('type_bdd') or ''

        test_connexion, msg_erreur = tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
        else:
            ctrlbdd = ControleBDD(hote, bdd, port, utilisateur, mdp)
            if type_bdd == 'DVF+':
                test = ctrlbdd.est_une_base_DVF_plus()
                if not test:
                    self.add_error('__all__', "La base spécifiée n'est pas une base DVF+ valide")
          

        return cleaned_data
        
class SelectConfigBDDForm(forms.Form):
    selection = forms.ModelChoiceField(label = 'Selection', queryset = ConfigurationBDD.objects.all(), widget = forms.Select(attrs={'class':"form-control"}))
    
