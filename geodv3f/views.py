import json
from pg.pgbasics import *
from django.shortcuts import render, redirect
from django.http import JsonResponse
from outils.interrogation_bdd import Requeteur
from main.models import ConfigurationBDD

def carto(request):
    '''
    permet de générer la page avec la cartographie
    
    La clef 'params' de request.session conserve les paramètres de configuration de la bdd.
    '''
    
    ## à retravailler sur modèle easydvf
    verif = ConfigurationBDD.objects.verifier_configuration_active()
    if not (verif.validation and verif.geobase):
        return redirect('main:configuration_bdd')
    request.session['type_bdd'] = ConfigurationBDD.objects.type_bdd_active()
    request.session['params'] = ConfigurationBDD.objects.parametres_bdd_active()
    
    [x, y] = Requeteur(*(request.session['params']), type_base=request.session['type_bdd']).localisant_moyen(10000) 
    context = {'localisant' : '[' + str(x) + ', ' + str(y) + ']'}
    return render(request, 'carto.html', context)


'''

REQUETES AJAX pour envoi des informations géométriques 

'''

def requete_geom(request, geom, xmin, ymin, xmax, ymax):
    geomutations = Requeteur(*(request.session['params']), type_base=request.session['type_bdd']).mutations_en_geojson(geom, xmin, ymin, xmax, ymax)
    return JsonResponse(geomutations)

'''

REQUETE AJAX AFFICHAGE DETAIL MUTATION

'''

def requete_detail_mutation(request, id):
    requeteur = Requeteur(*(request.session['params']), type_base=request.session['type_bdd'])
    mutation = requeteur.mutation_detaillee(id) or []
    locaux = requeteur.locaux_detailles(id) or []
    parcelles = requeteur.parcelles_detaillees(id) or []
    adresses = requeteur.adresses_associees(id) or []
    return render(request, 'detail_mutation.html', {'mutation':mutation, 
                                                    'locaux': locaux,
                                                    'parcelles' : parcelles, 
                                                    'adresses': ', '.join(adresses)})


# eof