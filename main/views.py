from django.shortcuts import render, redirect
from main import configuration
from collections import namedtuple
from main.forms import ConfigBDDForm, SelectConfigBDDForm
from main.models import ConfigurationBDD

def applications(request):
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])
    
    applis = configuration.recuperer_metadonnees_applications_disponibles()

    # Pour mémoire, applications à créer mais pas encore de modules et donc métadonnées disponibles.
    applis += [appli_nt(nom='ExportDVF',
                       description='Application permettant des exports de données DVF+ ou DV3F sous différents formats (shp, ods, xls, pdf)', 
                       version='1.0', 
                       classe_fa='fa fa-map', 
                       image = 'img/export.jpg', 
                       url='import:formulaire_configuration'),
              appli_nt(nom='GeoDV3F', 
                       description='Application permettant des visualisations cartographiques à partir de DV3F.', 
                       version='1.0', 
                       classe_fa='fa fa-map', 
                       image = 'img/geo.jpg', 
                       url='import:formulaire_configuration')]
    
    context = {'applis':applis}
    return render(request, 'applications.html', context)

def credits(request):
    return render(request, 'credits.html')

def configuration_bdd(request):
    # premier chargement de la page
    if request.method != 'POST' or ('selection' in request.POST and request.POST['selection'] == ''):
        return _charger_formulaire(request, ConfigBDDForm())
    # annulation 
    elif 'annulation' in request.POST:
        return redirect('main:applications')
    # suppression
    elif 'suppression' in request.POST:
        id_config = int(request.POST['selection_config'])
        config_choisie = ConfigurationBDD.objects.get(pk = id_config)
        config_choisie.delete()
        return _charger_formulaire(request, ConfigBDDForm())
    # modification de la selection
    elif 'selection' in request.POST:
        return _modification_selection(request)
    # activation de la nouvelle configuration
    if 'activation' in request.POST:
        id_config = int(request.POST['selection_config'])
        if id_config == 0: # nouvelle entree
            actif, configform = configuration.creer_et_activer_nouvelle_configuration(request.POST)
            if not actif:
                return _charger_formulaire(request, configform)
        else: # mise à jour
            config_choisie = ConfigurationBDD.objects.get(pk = id_config)
            actif, configform = configuration.maj_et_activer_configuration(request.POST, config_choisie)
            if not actif:
                return _charger_formulaire(request, configform)
        return redirect('main:applications') 

def _charger_formulaire(request, configform):
    formulaire = configform
    formulaire_selection = SelectConfigBDDForm()
    config_active = configuration.configuration_active()
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_config' : 0, 
               'config_active': config_active,
               'verif_config': config_active.verification_configuration()}
    return render(request, 'configuration_bdd.html', context)

def _modification_selection(request):
    id_config = int(request.POST['selection'])
    config = ConfigurationBDD.objects.get(pk = id_config)
    formulaire = ConfigBDDForm(instance = config)
    formulaire_selection = SelectConfigBDDForm(initial = {'selection' : id_config })
    config_active = configuration.configuration_active()
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_config' : id_config, 
               'config_active': config_active,
               'verif_config': config_active.verification_configuration()}
    return render(request, 'configuration_bdd.html', context)
    









