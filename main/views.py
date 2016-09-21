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

from django.shortcuts import render, redirect
from collections import namedtuple
from main.forms import ConfigBDDForm, SelectConfigBDDForm
from main.models import ConfigurationBDD
from main import configuration

def applications(request):
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])
    
    applis = configuration.recuperer_metadonnees_applications_disponibles()

    # Pour mémoire, applications à créer mais pas encore de modules et donc métadonnées disponibles.
    applis += [appli_nt(nom='ExportDVF',
                       description='Application permettant des exports de données DVF+ ou DV3F sous différents formats (shp, ods, xls, pdf)', 
                       version='1.0', 
                       classe_fa='fa fa-map', 
                       image = 'img/export.jpg', 
                       url='import:formulaire_configuration'),]
    
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
            actif, configform = creer_et_activer_nouvelle_configuration(request.POST)
            if not actif:
                return _charger_formulaire(request, configform)
        else: # mise à jour
            config_choisie = ConfigurationBDD.objects.get(pk = id_config)
            actif, configform = maj_et_activer_configuration(request.POST, config_choisie)
            if not actif:
                return _charger_formulaire(request, configform)
        return redirect('main:applications') 

def _charger_formulaire(request, configform):
    formulaire = configform
    formulaire_selection = SelectConfigBDDForm()
    config_active = ConfigurationBDD.objects.configuration_active()
    verif_bdd = config_active.verification_configuration() if config_active else False
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_config' : 0, 
               'config_active': config_active,
               'verif_config': verif_bdd,}
    return render(request, 'configuration_bdd.html', context)

def _modification_selection(request):
    id_config = int(request.POST['selection'])
    config = ConfigurationBDD.objects.get(pk = id_config)
    formulaire = ConfigBDDForm(instance = config)
    formulaire_selection = SelectConfigBDDForm(initial = {'selection' : id_config })
    config_active = ConfigurationBDD.objects.configuration_active()
    verif_bdd = config_active.verification_configuration() if config_active else False
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_config' : id_config, 
               'config_active': config_active,
               'verif_config': verif_bdd}
    return render(request, 'configuration_bdd.html', context)

def creer_et_activer_nouvelle_configuration(valeurs_configform):
    configform = ConfigBDDForm(valeurs_configform)
    if configform.is_valid():
        ConfigurationBDD.objects.desactiver_configurations()
        nvelle_config = configform.save(commit=False)
        nvelle_config.activer()
        return True, configform
    else:
        return False, configform

def maj_et_activer_configuration(valeurs_configform, config_choisie):
    configform = ConfigBDDForm(valeurs_configform, instance = config_choisie)
    if configform.is_valid():
        ConfigurationBDD.objects.desactiver_configurations()
        configform.save() 
        config_choisie.activer()
        return True, configform
    else:
        return False, configform





