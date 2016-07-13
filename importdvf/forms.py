from django import forms
import os
from outils import controle_bdd

class ConfigForm(forms.Form):
    hote = forms.CharField(label='Hôte', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}))
    bdd = forms.CharField(label='Base de données', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"dvf"}))
    utilisateur = forms.CharField(label='Utilisateur', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"postgres"}))
    mdp = forms.CharField(label='Mot de Passe', max_length = 255, widget = forms.PasswordInput(attrs={'class':"form-control", 'placeholder':""}))
    port = forms.CharField(label='Port', max_length = 8, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"5432"}))
    chemin_dossier = forms.CharField(label='Dossier données DVF', widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':os.getcwd()}))
    geolocaliser = forms.BooleanField(required = False, label='Importer géométries depuis cadastre.api.gouv.fr', widget = forms.CheckboxInput(attrs={'class':"checkbox"}))
    proxy = forms.CharField(label='Proxy', required=False, max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"http://proxy.example.fr - laisser vide en l'absence de proxy"}))
    effacer_schemas_existants = forms.BooleanField(required = False, label='Effacer schemas DVF+ existants', widget = forms.CheckboxInput(attrs={'class':"checkbox"}))

    def clean(self):
        cleaned_data = super(ConfigForm, self).clean()
        hote = cleaned_data.get('hote') or ''
        bdd = cleaned_data.get('bdd') or ''
        utilisateur = cleaned_data.get('utilisateur') or ''
        mdp = cleaned_data.get('mdp') or ''
        port = cleaned_data.get('port') or ''
        chemin_dossier = cleaned_data.get('chemin_dossier') or '' 
        proxy = cleaned_data.get('proxy') or ''

        test_connexion, msg_erreur = controle_bdd.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
            
        #if hote not in ['localhost']:
        #    msg_erreur = "Saisie incorrecte du champ hôte"
        #    self.add_error('hote', msg_erreur)

        if ' ' in bdd:
            msg_erreur = "Saisie incorrecte du nom de la base"
            self.add_error('bdd', msg_erreur)

        if not os.path.isdir(chemin_dossier):
            msg_erreur = "Le chemin spécifié pour le répertoire n'est pas valide."
            self.add_error('chemin_dossier', msg_erreur)
            
        return cleaned_data
        
    def recuperer_donnees_connexion(self):
    # recuperation des données de connexion
        hote = self.cleaned_data['hote']
        bdd = self.cleaned_data['bdd']
        port = self.cleaned_data['port']
        utilisateur = self.cleaned_data['utilisateur']
        mdp = self.cleaned_data['mdp']
        return (hote, bdd, port, utilisateur, mdp)    
