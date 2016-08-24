from django.shortcuts import render, redirect
import json
from datetime import datetime
from django.http import HttpResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from outils.interrogation_bdd import Requeteur
from main.territoire import integration
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
        verif = ConfigurationBDD.objects.verifier_configuration_active()
        if not verif.validation:
             return redirect('main:configuration_bdd')
        request.session['id_config'] = verif.id         
    else:
        init = False    
    
    config_active = ConfigurationBDD.objects.get(pk = request.session['id_config'])
    request.session['type_bdd'] = config_active.type_bdd
    request.session['params'] = config_active.parametres_bdd() 
     
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
        reinitialisation_parametres_filtre_valeur_fonciere_min_max(request)
        calculer_modalites_filtre(request)
    
    reinitialisation_parametres_filtre(request)
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes,
               'charger_tableau': charger_tableau,}
    # une requete ajax sera lancée dès la fin du chargement de la page pour mettre à jour le tableau des mutations
    # fonction : maj_tableau (page = 1)
    return render(request, 'recherche.html', context)

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
    requeteur = Requeteur(*(request.session['params']), type_base = request.session['type_bdd'], script = 'sorties/requeteur_recherche.sql')            
    mutations = requeteur.mutations(codes_insee)
    return titre, mutations 

def reinitialisation_parametres_filtre(request):    
    request.session['typologie'] = 0
    request.session['annee_min'] = 0
    request.session['annee_max'] = 0
    reinitialisation_parametres_filtre_valeur_fonciere_min_max(request)
    
def reinitialisation_parametres_filtre_valeur_fonciere_min_max(request):
    request.session['valeur_min'] = 0
    request.session['valeur_max'] = 10000000000

def calculer_modalites_filtre(request):
    request.session['typologies'] = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) 
                                                for mutation in request.session['mutations']] + [(0, 'Tous')]), 
                                           key = lambda x : x[1])    
    request.session['annees'] = sorted(set([int(mutation.anneemut) 
                                            for mutation in request.session['mutations']]))
    request.session['valeur_min_existante'] = min([float(mutation.valeurfonc) 
                                                   for mutation in request.session['mutations']])
    request.session['valeur_max_existante'] = max([float(mutation.valeurfonc) 
                                                   for mutation in request.session['mutations']])

'''

REQUETE AJAX ACTUALISATION TABLEAU

'''
    
def maj_tableau(request, page, tri):    
    mutations = Requeteur.transformer_mutations_en_namedtuple(request.session['mutations'])
    modification_filtre(request)
    correction_valeurs_filtre_incorrectes(request)
    mutations = Requeteur.filtrer_mutations(mutations, 
                                            typologie = request.session['typologie'],
                                            annee_min = request.session['annee_min'],
                                            annee_max = request.session['annee_max'],
                                            valeur_min = request.session['valeur_min'],
                                            valeur_max = request.session['valeur_max'],)
    mutations = Requeteur.trier_mutations(mutations, tri)  
    mutations = mutations_de_la_page(page, mutations, 50)    
    
    context = {'mutations': mutations, 
               'tri' : tri,
               'typologies' : request.session['typologies'],
               'annees' : request.session['annees'],}
    return render(request, 'tableau_mutations.html', context)

def modification_filtre(request):
    fonctions_filtres = {'typologie': modification_filtre_typologie,
                         'annee_min': modification_filtre_annee,
                         'annee_max': modification_filtre_annee,
                         'valeur_min': modification_filtre_valeur_fonciere,
                         'valeur_max': modification_filtre_valeur_fonciere,
                         }
    for key, value in request.POST.items():
        if key in fonctions_filtres.keys():
            fonctions_filtres[key](request, key)

def correction_valeurs_filtre_incorrectes(request):
    fonctions_corrections = {'typologie': correction_filtre_typologie,
                             'annee_min': correction_filtre_annee,
                             'annee_max': correction_filtre_annee,
                             'valeur_min': correction_filtre_valeur_fonciere,
                             'valeur_max': correction_filtre_valeur_fonciere,
                             }
    for key, value in fonctions_corrections.items():
        fonctions_corrections[key](request, key)

def modification_filtre_typologie(request, clef_session):    
    request.session[clef_session] = int(request.POST[clef_session])

def correction_filtre_typologie(request, clef_session):
    typologies_existantes = request.session['typologies']
    if request.session['typologie'] not in [code for code, lib in typologies_existantes]:
        request.session['typologie'] = 0

def modification_filtre_annee(request, clef_session):    
    request.session[clef_session] = int(request.POST[clef_session])

def correction_filtre_annee(request, clef_session):
    annees_existantes = request.session['annees']
    if request.session[clef_session] not in annees_existantes or (request.session[clef_session]==0):
        annee = min(annees_existantes) if clef_session =='annee_min' else max(annees_existantes)
        request.session[clef_session] = annee    

def modification_filtre_valeur_fonciere(request, clef_session):
    valeur_borne = request.session['valeur_min_existante'] 
    if clef_session == 'valeur_max':
        valeur_borne = request.session['valeur_max_existante']
    try:
        request.session[clef_session] = int(request.POST[clef_session])
    except Exception as e:
        request.session[clef_session] = valeur_borne

def correction_filtre_valeur_fonciere(request, clef_session):
    valeur_min = request.session['valeur_min_existante']
    valeur_max = request.session['valeur_max_existante']
    if request.session[clef_session] > valeur_max:
        request.session[clef_session] = valeur_max
    if request.session[clef_session] < valeur_min:
        request.session[clef_session] = valeur_min

def mutations_de_la_page(page, mutations, nb_par_page):
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
    requeteur = Requeteur(*(request.session['params']), type_base = request.session['type_bdd'], script = 'sorties/requeteur_recherche.sql')
    mutation = requeteur.mutation_detaillee(id) or []
    locaux = requeteur.locaux_detailles(id) or []
    parcelles = requeteur.parcelles_detaillees(id) or []
    adresses = requeteur.adresses_associees(id) or []
    return render(request, 'detail_mutation.html', {'mutation':mutation, 
                                                    'locaux': locaux,
                                                    'parcelles': parcelles, 
                                                    'adresses': ', '.join(adresses)})


