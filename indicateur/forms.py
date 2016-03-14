from django import forms
from indicateur.models import Indicateur

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
            'annee_debut' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"2010"}),
            'annee_fin' : forms.TextInput(attrs={'class':"form-control", 'placeholder':"2013"}),
            'code_typo' : forms.Select(attrs={'class':"form-control"}),
            'type_graphe': forms.Select(attrs={'class':"form-control"}),
            'actif': forms.CheckboxInput(attrs={'class':"form-control"}),
        }

    def clean(self):
        cleaned_data = super(IndicateurForm, self).clean()
        
        annee_debut = cleaned_data.get('annee_debut')
        annee_fin = cleaned_data.get('annee_fin')
        
        if int(annee_debut) >= int(annee_fin):
            self.add_error('__all__', "L'année de début est supérieure ou égale à l'année de fin.")
        
        return cleaned_data
        
class SelectIndicateurForm(forms.Form):
    selection = forms.ModelChoiceField(label = 'Selection', queryset = Indicateur.objects.all(), widget = forms.Select(attrs={'class':"form-control"}))
    