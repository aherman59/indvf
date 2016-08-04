import json
from pg.pgbasics import *
from django.shortcuts import render
from django.http import JsonResponse
from outils.interrogation_bdd import Requeteur
from main import configuration

def carto(request):
    '''
    permet de générer la page avec la cartographie
    
    La clef 'params' de request.session conserve les paramètres de configuration de la bdd.
    '''
    config_active = configuration.configuration_active()
    verif = verification_geoconfiguration(request, config_active)
    if not verif:
        return redirect('main:configuration_bdd')
    request.session['params'] = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)
    
    context = None
    return render(request, 'carto.html', context)

def verification_geoconfiguration(request, config_active):
    if config_active:
        if config_active.verification_configuration() and config_active.est_une_geobase():
            return True                
        else:
            return False
    else:
        return False

'''

REQUETES AJAX pour envoi des informations géométriques 

'''

def requete_geom(request, geom, xmin, ymin, xmax, ymax):
    geomutations = Requeteur(*(request.session['params'])).mutations_en_geojson(geom, xmin, ymin, xmax, ymax)
    return JsonResponse(geomutations)

'''

REQUETE AJAX AFFICHAGE DETAIL MUTATION

'''

def requete_detail_mutation(request, id):
    requeteur = Requeteur(*(request.session['params']))
    mutation = requeteur.mutation_detaillee(id)
    return render(request, 'detail_mutation.html', {'mutation':mutation, 'identifiant' : id})

# eof