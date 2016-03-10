from django.shortcuts import render, redirect
import json
from django.http import HttpResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .recherche.requetes import Requeteur
from main.territoire import integration
from main import configuration, controle_bdd
from main.models import Departement, Epci, Commune, Territoire

# Create your views here.

def recherche(request, page = 1, tri = 'id'):
    
    # integration des territoires si nécessaire
    integration.integrer_territoires()    
    
    init = False
    # si page de démarrage
    if request.method != 'POST' and request.get_full_path() == '/recherche/':    
        # verification qu'une configuration a bien été definie 
        config_active = configuration.configuration_active()
        if config_active and controle_bdd.verification_configuration(config_active):
            init = True
        else:
            return redirect('main:configuration_bdd')
        
    departements = Departement.objects.filter(code__in=controle_bdd.departements_disponibles(configuration.configuration_active()))
    
    if init:
        request.session['params'] = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)        
        request.session['departement'] = int(departements[0].pk)
        request.session['ecpi'] = int(Epci.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['commune'] = int(Commune.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['mutations'] = []
        request.session['titre'] = ''
        request.session['typologie'] = 0
        
    # changement de département
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
    # changement de typologie
    if 'typologie' in request.POST:
        request.session['typologie'] = int(request.POST['typologie'])
        
    epcis = Epci.objects.filter(departement=request.session['departement'])
    communes = Commune.objects.filter(departement = request.session['departement'])
    
    if 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        request.session['titre'] = Epci.objects.get(pk = request.session['epci']).nom
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = request.session['epci'])]       
    if 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        request.session['titre'] = Commune.objects.get(pk = request.session['commune']).nom
        codes_insee = [str(Commune.objects.get(pk = request.session['commune']).code),]
        
    if ('voir_commune' in request.POST) or ('voir_epci' in request.POST):   
        requeteur = Requeteur(*(request.session['params']), script = 'sorties/requeteur_recherche.sql')            
        mutations = requeteur.mutations(codes_insee)
        request.session['mutations'] = mutations        
    else:
        mutations = Requeteur.transformer_mutations_en_namedtuple(request.session['mutations'])
    
    typologies = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) for mutation in mutations] + [(0, 'Tous')]), key = lambda x : x[1])
    if request.session['typologie'] not in [code for code, lib in typologies]:
        request.session['typologie'] = 0
    
    mutations = Requeteur.filtrer_mutations(mutations, typologie = request.session['typologie'])
    mutations = Requeteur.trier_mutations(mutations, tri)
        
    paginator = Paginator(mutations, 100)
    try:
        mutations = paginator.page(page)
    except PageNotAnInteger:
        mutations = paginator.page(1)
    except EmptyPage:
        mutations = paginator.page(paginator.num_pages)
    
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes, 
               'typologies' : typologies, 
               'mutations': mutations, 
               'tri' : tri}
    return render(request, 'recherche.html', context)


def recherche_detaillee(request, id):
    requeteur = Requeteur(*(request.session['params']), script = 'sorties/requeteur_recherche.sql')
    mutation = requeteur.mutation_detaillee(id)
    data = {'Type de bien vendu': mutation.libtypbien.capitalize(),
            'Nombre de locaux vendus': mutation.nblocmut, 
            'Nombre de parcelles vendues': mutation.nbparmut}
    return HttpResponse(json.dumps(data), content_type='application/json')


