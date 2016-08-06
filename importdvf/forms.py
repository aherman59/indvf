from django import forms
from django.core.validators import URLValidator
import os
from outils import controle_bdd
from .creation_dvf.cadastre import Cadastre

class ConfigForm(forms.Form):
    hote = forms.CharField(label='Hôte', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}))
    bdd = forms.CharField(label='Base de données', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"dvf"}))
    utilisateur = forms.CharField(label='Utilisateur', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"postgres"}))
    mdp = forms.CharField(label='Mot de Passe', max_length = 255, widget = forms.PasswordInput(attrs={'class':"form-control", 'placeholder':""}))
    port = forms.CharField(label='Port', max_length = 8, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"5432"}))
    chemin_dossier = forms.CharField(label='Dossier données DVF', widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':os.getcwd()}))
    geolocaliser = forms.BooleanField(required = False, label='Géométries (1)', widget = forms.CheckboxInput(attrs={'class':"checkbox"}))
    proxy = forms.CharField(label='Proxy (1)', validators=[URLValidator], required=False, max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"http://proxy.example.fr - laisser vide dans un premier temps"}))
    effacer_schemas_existants = forms.BooleanField(required = False, label='Effacer schemas (2)', widget = forms.CheckboxInput(attrs={'class':"checkbox"}))

    def clean(self):
        cleaned_data = super(ConfigForm, self).clean()
        hote = cleaned_data.get('hote') or ''
        bdd = cleaned_data.get('bdd') or ''
        utilisateur = cleaned_data.get('utilisateur') or ''
        mdp = cleaned_data.get('mdp') or ''
        port = cleaned_data.get('port') or ''
        chemin_dossier = cleaned_data.get('chemin_dossier') or ''
        geolocaliser = cleaned_data.get('geolocaliser') or False 
        proxy = cleaned_data.get('proxy') or None
        
        # test acces à la bdd
        test_connexion, msg_erreur = controle_bdd.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
        
        # test acces aux données cadastre si demande d'intégration des géométries
        if geolocaliser:
            cada = Cadastre(hote, bdd, port, utilisateur, mdp)
            reussite, donnees = cada.recuperer_donnees_json_commune('59001', proxy = proxy)
            if not reussite:
                msg_erreur = "Le test de récupération des données géométriques a échoué."
                self.add_error('__all__', msg_erreur)      

        if ' ' in bdd:
            msg_erreur = "Saisie incorrecte du nom de la base"
            self.add_error('bdd', msg_erreur)

        # test répertoire valide
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
