import json
from datetime import datetime

from django.shortcuts import render, redirect
from django.http import HttpResponse

from outils.interrogation_bdd import Requeteur

from main.territoire import integration
from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire

from .filtre import reinitialisation_parametres_filtre_dans_session
from .filtre import reinitialisation_parametres_filtre_valeur_fonciere_min_max_dans_session
from .filtre import calcul_et_enregistrement_modalites_filtre_dans_session

'''

PAGE RECHERCHE

'''

def recherche(request):
    '''
    Permet de générer la page de résultat des mutations
    
    Une requete ajax sera lancée dès la fin du chargement de la page 
    pour mettre à jour le tableau des mutations (si la variable charger_tableau est True).
    La requete ajax correspond à la réponse de la fonction maj_tableau
    
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    'params' : paramètres de configuration de la bdd active (sert à instancier un objet Requeteur)
    'type_bdd' : type de la base de données DVF+ ou DV3F (sert à instancier un objet Requeteur)
    'titre' : titre pour le territoire affiché
    'mutations' : conserve l'ensemble des mutations du territoire actif
    'typologies' : conserve la liste des typologies disponibles (tuple (code, libelle)) pour le territoire actif
    'annees' : conserve la liste des années de mutation disponibles pour le territoire actif 
    'valeur_min_existante' : conserve la valeur fonciere minimale existante dans la liste des mutations
    'valeur_max_existante' : conserve la valeur fonciere maximale existante dans la liste des mutations
    'typologie' : typologie définie pour le filtre de mutations
    'annee_min' : annee minimale définie pour le filtre de mutations
    'annee_max' : annee maximale définie pour le filtre de mutations
    'valeur_min' : valeur foncière minimale définie pour le filtre de mutations
    'valeur max' : valeur foncière maximale définie pour le filtre de mutations
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    if request.method != 'POST' and request.get_full_path() == '/recherche/':
        # page de démarrage 
        init = True   
        verif = ConfigurationBDD.objects.verifier_configuration_active()
        if not verif.validation:
             return redirect('main:configuration_bdd')
        request.session['id_config'] = verif.id         
    else:
        init = False    
    
    config_active = enregistrement_configuration_dans_session(request) 
     
    departements = config_active.departements_disponibles()
    enregistrement_departement_selectionne_dans_session(request, departements, init)    
    code_departement_selectionne = recuperation_code_departement_selectionne(request)
    
    epcis, communes = recuperation_epcis_communes(request, config_active, code_departement_selectionne)
    enregistrement_epci_ou_commune_selectionne_dans_session(request, epcis, communes, init)
    
    enregistrement_titre_et_mutations_dans_session(request, init)
    
    if init or ('departement' in request.POST):        
        reinitialisation_parametres_filtre_dans_session(request)
        charger_tableau = False       
    else:        
        reinitialisation_parametres_filtre_valeur_fonciere_min_max_dans_session(request)
        calcul_et_enregistrement_modalites_filtre_dans_session(request)
        charger_tableau =  True
    
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes,
               'charger_tableau': charger_tableau,}
    return render(request, 'recherche.html', context)

def enregistrement_configuration_dans_session(request):
    config_active = ConfigurationBDD.objects.get(pk = request.session['id_config'])
    request.session['type_bdd'] = config_active.type_bdd
    request.session['params'] = config_active.parametres_bdd()
    return config_active

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
    if 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
    if 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])

def enregistrement_titre_et_mutations_dans_session(request, init):    
    if init or ('departement' in request.POST):
        titre = ''
        codes_insee = []
    if 'voir_epci' in request.POST:
        titre = Epci.objects.get(pk = request.session['epci']).nom
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = request.session['epci'])]       
    elif 'voir_commune' in request.POST:
        titre = Commune.objects.get(pk = request.session['commune']).nom
        codes_insee = [str(Commune.objects.get(pk = request.session['commune']).code),]        
    
    requeteur = Requeteur(*(request.session['params']), 
                          type_base = request.session['type_bdd'], 
                          script = 'sorties/requeteur_recherche.sql')            
    request.session['titre'] = titre
    request.session['mutations'] = requeteur.mutations(codes_insee) 
