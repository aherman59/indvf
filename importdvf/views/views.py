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
import os

from django.shortcuts import render
from django.contrib import messages
from django.http import HttpResponse

from importdvf.forms import ConfigForm

from .contexte import ContexteImportAjax
from .contexte import ContexteImport

def formulaire_configuration(request):
    '''
    Permet de générer la page formulaire servant à renseigner 
    les paramètres de connexion à la base de données
    '''
    formulaire = ConfigForm()
    return _afficher_formulaire(request, formulaire)

def etape_import(request, etape):
    '''
    Permet d'afficher la page avec la barre de progression liées aux étapes d'importation des données dans la base
    et les notifications liées.
    
    request.session :
    --------------- 
    'departements' : conservent la liste des départements identifiés dans les fichiers de données bruts DVF
    'dossier' : chemin du dossier contenant les fichiers de données bruts DVF à importer dans la base de données
    'parametres_connexion' : données de connexions à la base de données (sous forme de tuple)
    'effacer_schemas_existants' : booleen précisant si les schemas existants doivent être effacés avant import
    'geolocaliser' : boolean précisant si  il faut récupérer les parcelles sur cadastre.api.gouv.fr
    'commune_a_geolocaliser' : liste des codes insee des communes dont il faut récupérer la géolocalisation
    'proxy' : proxy renseigné par l'utilisateur
    '''       
    
    # Etape initiale - Enregistrement des données dans la session       
    if not request.is_ajax():
        contexte_import = ContexteImport(request)
        if contexte_import.success:
            request.session = contexte_import.session
            return render(request, 'etapes_import.html', None)
        else:
            return _afficher_formulaire(request, contexte_import.formulaire)
    # Etapes intermédiaires - renvoie des données JSON traitées par le script jQuery du template etapes_import.html
    else:
        contexte_import = ContexteImportAjax(request, etape)
        if contexte_import.success:
            if etape == '9999':
                data = {}
            else:
                request.session = contexte_import.session
                data = {'pourcentage':contexte_import.pourcentage_etape_suivante,
                        'description':contexte_import.description_etape_suivante,                     
                        'etape_suivante':str(contexte_import.numero_etape_suivante),
                        'message': contexte_import.message,}
        else:
            request.session['erreur'] = contexte_import.erreur
            data = {'erreur':True}               
        return HttpResponse(json.dumps(data), content_type='application/json')
                

def erreur(request):
    '''
    Permet d'afficher une page d'erreur
    '''
    if 'erreur' in request.session:
        return _afficher_msg(request, request.session['erreur'], err=True)
    return _afficher_formulaire(request, ConfigForm())

def fin_import(request):
    '''
    Permet d'afficher la page de fin d'importation
    '''
    return _afficher_msg(request, "L'import des données DVF dans la base DVF+ est achevé.", err=False)

def _afficher_formulaire(request, formulaire):   
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

