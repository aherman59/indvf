from django.shortcuts import render, redirect
import json
from datetime import datetime
from django.http import HttpResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .recherche.requetes import Requeteur
from main.territoire import integration
from main import configuration
from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire

'''

PAGE RECHERCHE

'''

def recherche(request):
    '''
     permet de générer la page de résultat des mutations
     
    Les clefs 'departement', 'epci', 'commune' de request.session permettent d'enregistrer la
    selection en cours des entités du menu territoire.
    
    La clef 'config' de request.session enregistre l'id de la configuration active pour la base de données
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    if request.method != 'POST' and request.get_full_path() == '/recherche/':
        # page de démarrage 
        init = True   
        config_active = configuration.configuration_active()
        verification_et_enregistrement_configuration_dans_session(request, config_active) 
    else:
        init = False
        config_active = ConfigurationBDD.objects.get(pk = request.session['config'])
    request.session['params'] = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)
        
    departements = config_active.departements_disponibles()
    code_departement_actif = recuperation_code_departement_actif(request, departements, init)
    epcis, communes = recuperation_epcis_communes(request, config_active, code_departement_actif, init)
    
    if init or ('departement' in request.POST):
        charger_tableau = False
        request.session['titre'] = ''
        request.session['mutations'] = []       
    else:
        charger_tableau =  True
        request.session['titre'], request.session['mutations'] = recuperation_mutations_dans_session(request)
        request.session['valeur_min'] = 0
        request.session['valeur_max'] = 10000000000
        calculer_possibilites_filtre(request)
    
    reinitialisation_parametres_filtre(request)
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes,
               'charger_tableau': charger_tableau,}
    return render(request, 'recherche.html', context)

def verification_et_enregistrement_configuration_dans_session(request, config_active):
    if config_active:
        if config_active.verification_configuration():
            request.session['config'] = int(config_active.pk)                
        else:
            return redirect('main:configuration_bdd')
    else:
        return redirect('main:configuration_bdd')

def recuperation_code_departement_actif(request, departements, init):            
    if init:    
        request.session['departement'] = int(departements[0].pk)
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
    return Departement.objects.get(pk=request.session['departement']).code

def recuperation_epcis_communes(request, config_active, code_departement, init):
    epcis = config_active.epcis_disponibles(code_departement)
    communes = config_active.communes_disponibles(code_departement)
    if init:
        request.session['epci'] = int(epcis[0].pk)    
        request.session['commune'] = int(communes[0].pk)
    return epcis, communes

def reinitialisation_parametres_filtre(request):    
    request.session['typologie'] = 0
    request.session['annee_min'] = 0
    request.session['annee_max'] = 0
    request.session['valeur_min'] = 0
    request.session['valeur_max'] = 10000000000

def recuperation_mutations_dans_session(request):
    titre = ''
    codes_insee = []
    if 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        titre = Epci.objects.get(pk = request.session['epci']).nom
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = request.session['epci'])]       
    if 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        titre = Commune.objects.get(pk = request.session['commune']).nom
        codes_insee = [str(Commune.objects.get(pk = request.session['commune']).code),]        
    requeteur = Requeteur(*(request.session['params']), script = 'sorties/requeteur_recherche.sql')            
    mutations = requeteur.mutations(codes_insee)
    return titre, mutations 

def calculer_possibilites_filtre(request):
    request.session['typologies'] = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) for mutation in request.session['mutations']] + [(0, 'Tous')]), key = lambda x : x[1])    
    request.session['annees'] = sorted(set([int(mutation.anneemut) for mutation in request.session['mutations']]))
    request.session['valeur_min_existante'] = min([int(mutation.valeurfonc.replace(' ', '')) for mutation in request.session['mutations']])
    request.session['valeur_max_existante'] = max([int(mutation.valeurfonc.replace(' ', '')) for mutation in request.session['mutations']])


'''

REQUETE AJAX ACTUALISATION TABLEAU

'''
    
def maj_tableau(request, page, tri):    
    mutations = Requeteur.transformer_mutations_en_namedtuple(request.session['mutations'])
    modification_filtre(request)
    mutations = Requeteur.filtrer_mutations(mutations, 
                                            typologie = request.session['typologie'],
                                            annee_min = request.session['annee_min'],
                                            annee_max = request.session['annee_max'],
                                            valeur_min = request.session['valeur_min'],
                                            valeur_max = request.session['valeur_max'],)
    mutations = Requeteur.trier_mutations(mutations, tri)  
    mutations = mutations_ds_page(page, mutations, 50)    
    context = {'mutations': mutations, 
               'tri' : tri,
               'typologies' : request.session['typologies'],
               'annees' : request.session['annees'],}
    return render(request, 'tableau_mutations.html', context)

def modification_filtre(request):
    typologies_existantes = request.session['typologies']
    annees_existantes = request.session['annees']
    valeur_min_existante = request.session['valeur_min_existante']
    valeur_max_existante = request.session['valeur_max_existante']
    # changement de typologie
    if 'typologie' in request.POST:
        request.session['typologie'] = int(request.POST['typologie'])    
    if request.session['typologie'] not in [code for code, lib in typologies_existantes]:
        request.session['typologie'] = 0
    # changement annee mini
    if 'annee_min' in request.POST:
        request.session['annee_min'] = int(request.POST['annee_min'])
    if request.session['annee_min'] not in annees_existantes or (request.session['annee_min']==0):
        request.session['annee_min'] = min(annees_existantes)
    # changement annee maxi
    if 'annee_max' in request.POST:
        request.session['annee_max'] = int(request.POST['annee_max'])
    if request.session['annee_max'] not in annees_existantes or (request.session['annee_max']==0):
        request.session['annee_max'] = max(annees_existantes)
    # changement valeur mini
    if 'valeur_min' in request.POST:
        try:
            request.session['valeur_min'] = int(request.POST['valeur_min'])
        except Exception as e:
            request.session['valeur_min'] = valeur_min_existante
    if request.session['valeur_min'] < valeur_min_existante:
        request.session['valeur_min'] = valeur_min_existante
    if request.session['valeur_min'] > valeur_max_existante:
        request.session['valeur_min'] = valeur_max_existante
    # changement valeur mini
    if 'valeur_max' in request.POST:
        try:
            request.session['valeur_max'] = int(request.POST['valeur_max'])
        except Exception as e:
            request.session['valeur_max'] = valeur_max_existante
    if request.session['valeur_max'] > valeur_max_existante:
        request.session['valeur_max'] = valeur_max_existante
    if request.session['valeur_max'] < valeur_min_existante:
        request.session['valeur_max'] = valeur_min_existante

def mutations_ds_page(page, mutations, nb_par_page):
    paginator = Paginator(mutations, nb_par_page)
    try:
        mutations = paginator.page(page)
    except PageNotAnInteger:
        mutations = paginator.page(1)
    except EmptyPage:
        mutations = paginator.page(paginator.num_pages)
    return mutations

'''

REQUETE AJAX AFFICHAGE DETAIL MUTATION

'''

def recherche_detaillee(request, id):
    requeteur = Requeteur(*(request.session['params']), script = 'sorties/requeteur_recherche.sql')
    mutation = requeteur.mutation_detaillee(id)
    return render(request, 'detail_mutation.html', {'mutation':mutation, 'identifiant' : id})


