from django.shortcuts import render
from docdv3f.models import DescriptionVariable, Variable, ValeurVariable, integration_donnees_variables

# Create your views here.


def accueil_doc(request):
    integration_donnees_variables()
    context = None
    return render(request, 'accueil.html', context)