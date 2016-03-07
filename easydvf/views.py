from django.shortcuts import render
import json
from django.http import HttpResponse
from .recherche.requetes import Requeteur
from main import configuration, controle_bdd
from indicateur.models import Departement, Epci, Commune, Territoire

# Create your views here.

def recherche(request, tri = 'id'):
    
    departements = Departement.objects.all()
    # initialiation des variables de session
    if request.method != 'POST':        
        # verification qu'une configuration a bien été definie 
        config_active = configuration.configuration_active()
        if config_active and controle_bdd.verification_configuration(config_active):
            request.session['params'] = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)
        else:
            return redirect('main:configuration_bdd')
        request.session['departement'] = int(departements[0].pk)
        request.session['ecpi'] = int(Epci.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['commune'] = int(Commune.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['mutations'] = []
    # changement de département
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
    epcis = Epci.objects.filter(departement=request.session['departement'])
    communes = Commune.objects.filter(departement = request.session['departement'])
    if 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = request.session['epci'])]       
    if 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        codes_insee = [str(Commune.objects.get(pk = request.session['commune']).code),]
    if ('voir_commune' in request.POST) or ('voir_epci' in request.POST):   
        requeteur = Requeteur(*(request.session['params']), script = 'sorties/requeteur_recherche.sql')            
        mutations = requeteur.mutations(codes_insee, tri = tri)
        request.session['mutations'] = mutations
    else:
        mutations = Requeteur.transformer_mutations_en_namedtuple(request.session['mutations'], tri = tri)
    context = {'departements' : departements, 'epcis' : epcis, 'communes' : communes, 'mutations': mutations}
    return render(request, 'recherche.html', context)

def recherche_detaillee(request, id):
    data = {'test':True}
    return HttpResponse(json.dumps(data), content_type='application/json')

