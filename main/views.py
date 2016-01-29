from django.shortcuts import render, redirect
from main import configuration
from collections import namedtuple
from main.forms import ConfigBDDForm, SelectConfigBDDForm
from main.models import ConfigurationBDD

# Create your views here.

def applications(request):
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])

    applis = [appli_nt(nom='ImportDVF+', description='Application permettant d\'importer des données sources DVF dans une base de données PostgreSQL 9.x', 
                       version='2.0', classe_fa='fa fa-database', image = 'img/import.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='InDVF-Indicateurs', description='Application permettant de produire, à partir de DVF+ ou DV3F, des indicateurs agrégés pour différentes échelles géographiques', version='1.0', classe_fa='fa fa-bar-chart', image = 'img/indicateur.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='GeoDVF', description='Application permettant de faciliter la production de cartographies à partir de DVF (projet QGis, export shp, etc)', 
                       version='1.0', classe_fa='fa fa-map', image = 'img/geo.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='DocDV3F', description='Application donnant accès aux documentations DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-book', image = 'img/documentation.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='UseDV3F', description='Application pour mieux comprendre et travailler avec les bases de données DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-info-circle', image = 'img/usedvf.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='TutoDVF', description='Application tutorielle pour démarrer avec DVF et les bases de données DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-graduation-cap', image = 'img/tutoriel.jpg', url='import:formulaire_configuration'),]
    
    context = {'applis':applis}
    return render(request, 'applications.html', context)

def configuration_bdd(request):
    # premier chargement de la page
    if request.method != 'POST' or ('selection' in request.POST and request.POST['selection'] == ''):
        formulaire = ConfigBDDForm()
        formulaire_selection = SelectConfigBDDForm()
        context = {'formulaire':formulaire, 'formulaire_selection' : formulaire_selection, 'id_config' : 0}
        return render(request, 'configuration_bdd.html', context)
    # annulation 
    elif 'annulation' in request.POST:
        return redirect('main:applications')  
    # modification de la selection
    elif 'selection' in request.POST:
        id_config = int(request.POST['selection'])
        config = ConfigurationBDD.objects.get(pk = id_config)
        formulaire = ConfigBDDForm(instance = config)
        formulaire_selection = SelectConfigBDDForm(initial = {'selection' : id_config })
        context = {'formulaire':formulaire, 'formulaire_selection' : formulaire_selection, 'id_config' : id_config}
        return render(request, 'configuration_bdd.html', context)
    # activation de la nouvelle configuration
    if 'activation' in request.POST:
        id_config = int(request.POST['selection_config'])
        if id_config == 0: # nouvelle entree
            configform = ConfigBDDForm(request.POST)
            if configform.is_valid():
                configuration.desactiver_connexions()
                nvelle_config = configform.save(commit=False)
                nvelle_config.active = True
                nvelle_config.save()
            else:
                formulaire = configform
                formulaire_selection = SelectConfigBDDForm()
                context = {'formulaire':formulaire, 'formulaire_selection' : formulaire_selection, 'id_config' : 0}
                return render(request, 'configuration_bdd.html', context)
        else: # mise à jour
            config_choisie = ConfigurationBDD.objects.get(pk = id_config)
            configform = ConfigBDDForm(request.POST, instance = config_choisie)
            if configform.is_valid():
                configuration.desactiver_connexions()
                configform.save()
                config_choisie.active = True
                config_choisie.save()
            else:
                formulaire = configform
                formulaire_selection = SelectConfigBDDForm()
                context = {'formulaire':formulaire, 'formulaire_selection' : formulaire_selection, 'id_config' : 0}
                return render(request, 'configuration_bdd.html', context)
        return redirect('main:applications') 












