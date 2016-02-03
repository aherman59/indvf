from django.shortcuts import render, redirect
from main import configuration
from .calcul.pg import *
from .territoire import integration 
from indicateur.models import Departement, Epci, Commune
 

def indicateurs(request):
    # integration des territoires si nécessaire
    if len(Departement.objects.all()) == 0:
        integration.integrer_departements('indicateur/territoire/doc_insee/departement.csv')
    if len(Epci.objects.all()) == 0:
        integration.integrer_epcis('indicateur/territoire/doc_insee/epci2015.csv')
    
    # verification qu'une configuration a bien été definie
    config_active = configuration.configuration_active()
    if config_active:
        pgoutils = PgOutils(config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp, script = 'sorties/script_indvf.sql')   
    else:
        return redirect('main:configuration_bdd')

    # chargement des territoires
    departements = Departement.objects.all()
    if request.method != 'POST':
        request.session['departement'] = int(departements[0].pk)
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
    print(request.session['departement'])
    epcis = Epci.objects.filter(departement=request.session['departement'])
    
    context = {'departements' : departements, 'epcis' : epcis}
    return render(request, 'indicateurs.html', context)
