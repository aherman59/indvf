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
from indicateur_v2.models import Indicateur

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
    