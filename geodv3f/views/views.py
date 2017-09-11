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

import json
from pg.pgbasics import *
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

from .contexte import ContexteCarto
from .geomutation import Centre
from .geomutation import GeoMutations
from .geomutation import DetailMutation

from geodv3f.api_adresse import RechercheAdresse

@login_required
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


def requete_adresse(request):
    '''
    requete ajax pour le traitement de l'adresse
    '''
    adresse = request.GET['adresse']
    if not adresse:
        reponse = {'erreur': True}
    else:
        recherche = RechercheAdresse()
        recherche.texte(adresse)
        resultat = recherche.meilleure_adresse
        if resultat:
            reponse = {'x':resultat.x, 'y':resultat.y, 'erreur': False}
        else:
            reponse = {'erreur': True}
    return JsonResponse(reponse)

# eof