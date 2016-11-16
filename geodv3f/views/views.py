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

from .contexte import ContexteCarto
from .geomutation import Centre
from .geomutation import GeoMutations
from .geomutation import DetailMutation

def carto(request):
    '''
    permet de générer la page avec la cartographie
    
    La clef 'params' de request.session conserve les paramètres de configuration de la bdd.
    '''
    
    contexte_carto = ContexteCarto(request)
    if not contexte_carto.success:
        return redirect('main:configuration_bdd')
    
    request.session = contexte_carto.request.session
    context = {'localisant' : Centre(request.session).as_text()}
    return render(request, 'carto.html', context)
    

def requete_geom(request, nom_geometrie, xmin, ymin, xmax, ymax):
    '''
    requete ajax pour envoi des informations géométriques
    
    La clef 'geomutations' de request.session conserve les mutations dans l'emprise.'     
    '''
    emprise = [xmin, ymin, xmax, ymax]
    geomutations = GeoMutations(request.session, nom_geometrie, emprise)
    if nom_geometrie == 'geompar':
        request.session['geomutations'] = geomutations.as_list()
    return JsonResponse(geomutations.as_geojson())
    '''
    geomutations = Requeteur(*(request.session['params']), type_base=request.session['type_bdd']).mutations_en_geojson(geom, xmin, ymin, xmax, ymax)
    return JsonResponse(geomutations)
    '''

def requete_detail_mutation(request, id):
    '''
    requete ajax pour l'affichage du détail de la mutation   
    '''
    detail = DetailMutation(id, request.session)
    reponse = {'mutation': detail.mutation, 
               'locaux': detail.locaux, 
               'parcelles': detail.parcelles, 
               'adresses':detail.adresses}
    return render(request, 'detail_mutation.html', reponse)

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