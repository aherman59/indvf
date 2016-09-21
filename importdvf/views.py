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
from collections import namedtuple
from django.shortcuts import render
from django.contrib import messages
from django.http import HttpResponse

from main.configuration import BASE_DIR

from importdvf.forms import ConfigForm

from .creation_dvf import etapes
from .gestion_import import *

# Ressources
repertoire_ressources = os.path.join(BASE_DIR, 'importdvf/creation_dvf/ressources') 
fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                    os.path.join(repertoire_ressources,'natcult.csv'),
                    os.path.join(repertoire_ressources,'natcultspe.csv'))

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
    if request.is_ajax():
    # Etapes intermédiaires - renvoie des données JSON traitées par le script jQuery du template etapes_import.html
        reconstituer_etapes(request)
        if etape == '1':
            etape_courante = renvoyer_etape(request, int(etape))
            reussite, fichiers_ordonnes, departements, erreurs = executer_etape(request, etape_courante)
            if reussite:
                request.session['departements'] = departements
                constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes)            
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant)}
                if erreurs:
                    data['warning'] = erreurs[0]
                data['message'] = 'Vérification des fichiers terminée. Intégration des fichiers suivants : ' + ', '.join(fichiers_ordonnes)
            else:
                request.session['erreur'] = erreurs[0]
                data = {'erreur':True}               
            return HttpResponse(json.dumps(data), content_type='application/json')
        elif etape == '9999':
            return HttpResponse(json.dumps(None), content_type='application/json')
        else:
            etape_courante = renvoyer_etape(request, int(etape))
            reussite, message = executer_etape(request, etape_courante)            
            if reussite:
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant),
                        'message': message,}
                return HttpResponse(json.dumps(data), content_type='application/json')
            else:
                request.session['erreur'] = str(message)
                data = {'erreur':True}
            return HttpResponse(json.dumps(data), content_type='application/json')
    # Etape initiale - Constitution des premières étapes et enregistrement des données dans la session    
    context = None
    formulaire  = ConfigForm(request.POST)
    if formulaire.is_valid():
        constituer_etapes(request)
        # enregistrement des données formulaire dans la session
        request.session['dossier'] = formulaire.cleaned_data['chemin_dossier']
        request.session['parametres_connexion'] = formulaire.recuperer_donnees_connexion()
        request.session['effacer_schemas_existants'] = formulaire.cleaned_data['effacer_schemas_existants']
        request.session['geolocaliser'] = formulaire.cleaned_data['geolocaliser']
        request.session['proxy'] = formulaire.cleaned_data['proxy']
        request.session['communes_a_geolocaliser'] = None
        return render(request, 'etapes_import.html', context)
    else:
        return _afficher_formulaire(request, formulaire)

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
    constituer_etapes(request)    
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

