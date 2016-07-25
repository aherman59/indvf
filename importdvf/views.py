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
    formulaire = ConfigForm()
    return _afficher_formulaire(request, formulaire)

def _afficher_formulaire(request, formulaire):
    constituer_etapes(request)    
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

def etape_import(request, etape):
    # Etapes intermédiaires - renvoie des données JSON traitées par le script jQuery du template etapes_import.html
    if request.is_ajax():
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
    if 'erreur' in request.session:
        return _afficher_msg(request, request.session['erreur'], err=True)
    return _afficher_formulaire(request, ConfigForm())

def fin_import(request):
    return _afficher_msg(request, "L'import des données DVF dans la base DVF+ est achevé.", err=False)

def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

