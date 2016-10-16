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

from django.shortcuts import render, redirect
from pg.pgbasics import *

from main.territoire import integration 
from indicateur.models import Indicateur, ResultatIndicateur
from indicateur.forms import IndicateurForm, SelectIndicateurForm

from .contexte import ContexteIndicateur

'''
PAGE AFFICHAGE INDICATEURS
''' 

def indicateurs(request):
    '''
    Permet de générer la page des indicateurs
     
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    contexte_indicateur = ContexteIndicateur(request)
    if not contexte_indicateur.success:
        return redirect('main:configuration_bdd')    
    
    request.session = contexte_indicateur.request.session
           
    context = {'departements' : contexte_indicateur.departements, 
               'epcis' : contexte_indicateur.epcis, 
               'communes' : contexte_indicateur.communes, 
               'indicateursDVF' : contexte_indicateur.indicateurs,
               'titre': contexte_indicateur.titre,
               'charger_indicateur': contexte_indicateur.charger_indicateur}
    return render(request, 'indicateurs.html', context)
    
        
'''

PAGE CONFIGURATION

'''

def configuration_indicateur(request):
    # premier chargement de la page
    if request.method != 'POST' or ('selection' in request.POST and request.POST['selection'] == ''):
        return _charger_formulaire(request, IndicateurForm())
    # annulation 
    elif 'annulation' in request.POST:
        return redirect('indicateur:indicateurs')
    # suppression de la selection
    elif 'suppression' in request.POST:
        id_indicateur = int(request.POST['selection_indicateur'])
        Indicateur.objects.supprimer_indicateur_et_resultats_lies(id_indicateur)        
        return _charger_formulaire(request, IndicateurForm())
    # modification de la selection
    elif 'selection' in request.POST:
        id_indicateur = int(request.POST['selection'])
        return _modification_selection(request, id_indicateur)
    # creation de l'indicateur
    elif 'creation' in request.POST:
        id_indicateur = int(request.POST['selection_indicateur'])
        if id_indicateur == 0: # nouvelle entree
            indicateurform = IndicateurForm(request.POST)            
        else: # mise à jour
            indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
            indicateurform = IndicateurForm(request.POST, instance = indicateur_choisi)
        if indicateurform.is_valid():       
            indicateurform.save()
            ResultatIndicateur.objects.filter(id_indicateur = id_indicateur).delete()        
            return _charger_formulaire(request, IndicateurForm())
        else:
            return _charger_formulaire(request, indicateurform, id_indicateur = id_indicateur)

def _charger_formulaire(request, indicateurform, id_indicateur = 0):
    formulaire = indicateurform
    formulaire_selection = SelectIndicateurForm()    
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_indicateur' : id_indicateur, }
    return render(request, 'configuration_indicateur.html', context)

def _modification_selection(request, id_indicateur):
    indicateur = Indicateur.objects.get(pk = id_indicateur)
    formulaire = IndicateurForm(instance = indicateur)
    formulaire_selection = SelectIndicateurForm(initial = {'selection' : id_indicateur })
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_indicateur' : id_indicateur,                }
    return render(request, 'configuration_indicateur.html', context)
