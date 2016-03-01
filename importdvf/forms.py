from django import forms
import os
from main import controle_bdd

class ConfigForm(forms.Form):
    hote = forms.CharField(label='Hôte', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}))
    bdd = forms.CharField(label='Base de données', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"dvf"}))
    utilisateur = forms.CharField(label='Utilisateur', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"postgres"}))
    mdp = forms.CharField(label='Mot de Passe', max_length = 255, widget = forms.PasswordInput(attrs={'class':"form-control", 'placeholder':""}))
    port = forms.CharField(label='Port', max_length = 8, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"5432"}))
    chemin_dossier = forms.CharField(label='Dossier données DVF', widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':os.getcwd()}))

    def clean(self):
        cleaned_data = super(ConfigForm, self).clean()
        hote = cleaned_data.get('hote') or ''
        bdd = cleaned_data.get('bdd') or ''
        utilisateur = cleaned_data.get('utilisateur') or ''
        mdp = cleaned_data.get('mdp') or ''
        port = cleaned_data.get('port') or ''
        chemin_dossier = cleaned_data.get('chemin_dossier') or '' 

        test_connexion, msg_erreur = controle_bdd.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
            
        if hote not in ['localhost']:
            msg_erreur = "Saisie incorrecte du champ hôte"
            self.add_error('hote', msg_erreur)

        if bdd not in ['dvf', 'postgres']:
            msg_erreur = "Saisie incorrecte du nom de la base"
            self.add_error('bdd', msg_erreur)

        if not os.path.isdir(chemin_dossier):
            msg_erreur = "Le chemin spécifié pour le répertoire n'est pas valide."
            self.add_error('chemin_dossier', msg_erreur)
            
        return cleaned_data
        
        
