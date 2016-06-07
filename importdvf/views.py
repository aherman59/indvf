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

# Create your views here.

def formulaire_configuration(request):
    formulaire = ConfigForm()
    return _afficher_formulaire(request, formulaire)

def _afficher_formulaire(request, formulaire):
    constituer_etapes(request)    
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

def etape_import(request, etape):
    # Ressources
    repertoire_ressources = os.path.join(BASE_DIR, 'importdvf/creation_dvf/ressources') 
    fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
    fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                        os.path.join(repertoire_ressources,'natcult.csv'),
                        os.path.join(repertoire_ressources,'natcultspe.csv'))

    if request.is_ajax():
        reconstituer_etapes(request)
        if etape == '1':
            print(request.session['etapes'])
            etape_courante = etapes.context_etape(request.session['etapes'], int(etape))
            reussite, fichiers_ordonnes, departements, erreurs = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(request.session['dossier'])
            if reussite:
                request.session['departements'] = departements
                constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes)            
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant)}
                if erreurs:
                    data['warning'] = erreurs[0]
            else:
                request.session['erreur'] = str(erreur)
                data = {'erreur':True}               
            return HttpResponse(json.dumps(data), content_type='application/json')
        elif (etape == '8' and not request.session['geolocaliser']) or etape == '9':
            return HttpResponse(json.dumps(None), content_type='application/json')
        else:
            etape_courante = etapes.context_etape(request.session['etapes'], int(etape))
            dvf = dvf_objet(request, etape_courante)
            reussite, erreur = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(dvf, *(etape_courante.params[1:]))
            dvf.pgconn.deconnection_postgres()
            if reussite:
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant)}
                return HttpResponse(json.dumps(data), content_type='application/json')
            else:
                request.session['erreur'] = str(erreur)
                data = {'erreur':True}
            return HttpResponse(json.dumps(data), content_type='application/json')
        
    context = None
    formulaire  = ConfigForm(request.POST)
    if formulaire.is_valid():
        constituer_etapes(request)
        # enregistrement des données formulaire dans la session
        request.session['dossier'] = formulaire.cleaned_data['chemin_dossier']
        request.session['parametres_connexion'] = recuperer_donnees_connexion(formulaire)
        request.session['effacer_schemas_existants'] = formulaire.cleaned_data['effacer_schemas_existants']
        request.session['geolocaliser'] = formulaire.cleaned_data['geolocaliser']
        request.session['communes_a_geolocaliser'] = None
        return render(request, 'etapes_import.html', context)
    else:
        return _afficher_formulaire(request, formulaire)

def erreur(request):
    if 'erreur' in request.session:
        return _afficher_msg(request, request.session['erreur'], True)
    return _afficher_formulaire(request, ConfigForm())

def fin_import(request):
    return _afficher_msg(request, "L'import des données DVF dans la base DVF+ est achevé.", False)

def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

