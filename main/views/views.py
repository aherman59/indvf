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
from main.views.contexte import recuperer_metadonnees_applications_disponibles
from main.views.contexte import ContexteConfigBDD

def applications(request):
    Appli = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])
    
    applis = recuperer_metadonnees_applications_disponibles()

    # Pour mémoire, applications à créer mais pas encore de modules et donc métadonnées disponibles.
    applis += [Appli(nom='ExportDVF',
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
    contexte_configuration = ContexteConfigBDD(request)
    if contexte_configuration.retour:
        return redirect('main:applications')
    context = {'formulaire': contexte_configuration.formulaire, 
               'formulaire_selection' : contexte_configuration.formulaire_selection,
               'id_config' : contexte_configuration.id_config, 
               'config_active': contexte_configuration.config_active,
               'verif_config': contexte_configuration.verif_bdd_active,}
    return render(request, 'configuration_bdd.html', context)
