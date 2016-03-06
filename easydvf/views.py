from django.shortcuts import render
import json
from django.http import HttpResponse
from .recherche.requetes import Requeteur
from main import configuration, controle_bdd

# Create your views here.

def recherche(request):    
    # verification qu'une configuration a bien été definie
    config_active = configuration.configuration_active()
    if config_active and controle_bdd.verification_configuration(config_active):
        params = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)
        requeteur = Requeteur(*params, script = 'sorties/requeteur_recherche.sql')
        mutations = requeteur.mutations()
    context = {'mutations': mutations}
    return render(request, 'recherche.html', context)

def recherche_detaillee(request, id):
    data = {'test':True}
    return HttpResponse(json.dumps(data), content_type='application/json')