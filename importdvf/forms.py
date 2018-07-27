'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

from django import forms
from django.core.validators import URLValidator
import os
from outils import controle_bdd
from .creation_dvf.cadastre import Cadastre
from main.models import ProxyUser

class ConfigForm(forms.Form):
    hote = forms.CharField(label='Hôte', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"localhost"}))
    bdd = forms.CharField(label='Base de données', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"dvf"}))
    utilisateur = forms.CharField(label='Utilisateur', max_length = 255, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"postgres"}))
    mdp = forms.CharField(label='Mot de Passe', max_length = 255, widget = forms.PasswordInput(attrs={'class':"form-control", 'placeholder':""}))
    port = forms.CharField(label='Port', max_length = 8, widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':"5432"}))
    chemin_dossier = forms.CharField(label='Dossier données DVF', widget = forms.TextInput(attrs={'class':"form-control", 'placeholder':os.getcwd()}))
    geolocaliser = forms.BooleanField(required = False, label='Géométries (1)', widget = forms.CheckboxInput(attrs={'class':"checkbox",}))
    effacer_schemas_existants = forms.BooleanField(required = False, label='Effacer schemas (2)', widget = forms.CheckboxInput(attrs={'class':"checkbox"}))

    def __init__(self, *args, **kwargs):
        # Définit un self.request pour pouvoir récupérer le proxy du User dans la méthode clean()
        self.request = kwargs.pop('request', None)
        super(ConfigForm, self).__init__(*args, **kwargs)

    def clean(self):
        cleaned_data = super(ConfigForm, self).clean()
        hote = cleaned_data.get('hote') or ''
        bdd = cleaned_data.get('bdd') or ''
        utilisateur = cleaned_data.get('utilisateur') or ''
        mdp = cleaned_data.get('mdp') or ''
        port = cleaned_data.get('port') or ''
        chemin_dossier = cleaned_data.get('chemin_dossier') or ''
        geolocaliser = cleaned_data.get('geolocaliser') or False 
        
        # test acces à la bdd
        test_connexion, msg_erreur = controle_bdd.tentative_connexion(hote, bdd, utilisateur, mdp, port)
        if not test_connexion:
            self.add_error('__all__', msg_erreur)
        
        # test acces aux données cadastre si demande d'intégration des géométries
        if geolocaliser:
            cada = Cadastre(hote, bdd, port, utilisateur, mdp)
            reussite, donnees = cada.recuperer_donnees_json_commune('59001', proxy = ProxyUser.objects.recuperer_proxy(self.request.user))
            if not reussite:
                msg_erreur = "Le test de récupération des données géométriques a échoué. Pensez à configurer le proxy"
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
