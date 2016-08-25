import json

from django.shortcuts import render, redirect
from pg.pgbasics import *

from main.territoire import integration 
from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire
from indicateur.models import Indicateur, ResultatIndicateur
from indicateur.forms import IndicateurForm, SelectIndicateurForm

from .indicateurs import calcul_indicateurs_actifs_format_xcharts


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
    
    if request.method != 'POST' and request.get_full_path() == '/indicateur/':
        # page de démarrage 
        init = True   
        verif = ConfigurationBDD.objects.verifier_configuration_active()
        if not verif.validation:
             return redirect('main:configuration_bdd')
        request.session['id_config'] = verif.id  
    else:
        init = False
        
    config_active = ConfigurationBDD.objects.get(pk = request.session['id_config'])
        
    departements = config_active.departements_disponibles()
    enregistrement_departement_selectionne_dans_session(request, departements, init)    
    code_departement_selectionne = recuperation_code_departement_selectionne(request)
    
    epcis, communes = recuperation_epcis_communes(request, config_active, code_departement_selectionne)
    enregistrement_epci_ou_commune_selectionne_dans_session(request, epcis, communes, init)
         
    if not init:  
        territoires = generer_territoire_etude(request)        
        titre = creer_titre_format_html(territoires)
        indicateursDVF = calcul_indicateurs_actifs_format_xcharts(territoires, config_active)     
    else:
        titre = ''
        indicateursDVF = []
       
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes, 
               'indicateursDVF' : indicateursDVF,
               'titre': titre}
    return render(request, 'indicateurs.html', context)

def enregistrement_departement_selectionne_dans_session(request, departements, init):
    if init:    
        request.session['departement'] = int(departements[0].pk)
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])

def recuperation_code_departement_selectionne(request):            
    return Departement.objects.get(pk=request.session['departement']).code

def recuperation_epcis_communes(request, config_active, code_departement):
    epcis = config_active.epcis_disponibles(code_departement)
    communes = config_active.communes_disponibles(code_departement)    
    return epcis, communes

def enregistrement_epci_ou_commune_selectionne_dans_session(request, epcis, communes, init):
    if init:
        request.session['epci'] = int(epcis[0].pk)    
        request.session['commune'] = int(communes[0].pk)
    if ('voir_epci' in request.POST) or ('ajout_epci' in request.POST):
        request.session['epci'] = int(request.POST['epci'])
    elif ('voir_commune' in request.POST) or ('ajout_commune' in request.POST):
        request.session['commune'] = int(request.POST['commune'])

def generer_territoire_etude(request):
    if 'voir_departement' in request.POST:
        t = Territoire.objects.territoire_comparaison_reinitialise()
        t.ajouter_departement(request.session['departement'])        
    elif 'voir_epci' in request.POST:
        t = Territoire.objects.territoire_comparaison_reinitialise()
        t.ajouter_epci(request.session['epci'])        
    elif 'voir_commune' in request.POST:
        t = Territoire.objects.territoire_comparaison_reinitialise()
        t.ajouter_commune(request.session['commune'])        
    elif 'ajout_departement' in request.POST:
        t = Territoire.objects.territoire_comparaison()
        t.ajouter_departement(request.session['departement'])
    elif 'ajout_epci' in request.POST:
        t = Territoire.objects.territoire_comparaison()
        t.ajouter_epci(request.session['epci'])
    elif 'ajout_commune' in request.POST:
        t = Territoire.objects.territoire_comparaison()
        t.ajouter_commune(request.session['commune'])
    else:
        t = Territoire.objects.territoire_comparaison()
    territoires = t.lister_entites_administratives()
    return territoires

def creer_titre_format_html(territoires):
    return ', '.join(['<span class="color'+ str(i) + '-indvf">' 
                      + territoire.nom 
                      + '</span>' for i, territoire in enumerate(territoires)])
    
        
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
    # suppression
    elif 'suppression' in request.POST:
        id_indicateur = int(request.POST['selection_indicateur'])
        indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
        indicateur_choisi.delete()
        ResultatIndicateur.objects.filter(id_indicateur = id_indicateur).delete()
        
        return _charger_formulaire(request, IndicateurForm())
    # modification de la selection
    elif 'selection' in request.POST:
        return _modification_selection(request)
    # activation de la nouvelle configuration
    if 'creation' in request.POST:
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

def _modification_selection(request):
    id_indicateur = int(request.POST['selection'])
    indicateur = Indicateur.objects.get(pk = id_indicateur)
    formulaire = IndicateurForm(instance = indicateur)
    formulaire_selection = SelectIndicateurForm(initial = {'selection' : id_indicateur })
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_indicateur' : id_indicateur,                }
    return render(request, 'configuration_indicateur.html', context)
