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
    
