'''

#    Copyright (C) 2016  Cerema
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

'''

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