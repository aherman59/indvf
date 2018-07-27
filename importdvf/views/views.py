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
import os

from django.shortcuts import render
from django.contrib import messages
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required

from importdvf.forms import ConfigForm

from .contexte import ContexteImportAjax
from .contexte import ContexteImport

@login_required
def formulaire_configuration(request):
    '''
    Permet de générer la page formulaire servant à renseigner 
    les paramètres de connexion à la base de données
    '''
    formulaire = ConfigForm(request=request)
    return _afficher_formulaire(request, formulaire)

@login_required
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
                
@login_required
def erreur(request):
    '''
    Permet d'afficher une page d'erreur
    '''
    if 'erreur' in request.session:
        return _afficher_msg(request, request.session['erreur'], err=True)
    return _afficher_formulaire(request, ConfigForm())

@login_required
def fin_import(request):
    '''
    Permet d'afficher la page de fin d'importation
    '''
    return _afficher_msg(request, "L'import des données DVF dans la base DVF+ est achevé.", err=False)

@login_required
def _afficher_formulaire(request, formulaire):   
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

@login_required
def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

