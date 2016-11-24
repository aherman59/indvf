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
from django.http import HttpResponse

from pg.pgbasics import *
from main.territoire import integration 
from .contexte import ContexteIndicateur, ContexteConfigIndicateur

'''
PAGE AFFICHAGE INDICATEURS
''' 

def indicateurs(request):
    '''
    Permet de générer la page des indicateurs
     
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    contexte_indicateur = ContexteIndicateur(request)
    if not contexte_indicateur.success:
        return redirect('main:configuration_bdd')    
    
    request.session = contexte_indicateur.request.session
           
    context = {'departements' : contexte_indicateur.departements, 
               'epcis' : contexte_indicateur.epcis, 
               'communes' : contexte_indicateur.communes, 
               'indicateursDVF' : contexte_indicateur.indicateurs,
               'titre': contexte_indicateur.titre,
               'charger_indicateur': contexte_indicateur.charger_indicateur}
    return render(request, 'indicateurs.html', context)
    

def configuration_indicateur(request):
    contexte_configuration = ContexteConfigIndicateur(request)
    if contexte_configuration.annulation:
        return redirect('indicateur:indicateurs')
    context = {'formulaire': contexte_configuration.formulaire, 
               'formulaire_selection' : contexte_configuration.formulaire_selection,
               'id_indicateur' : contexte_configuration.id_indicateur, }
    return render(request, 'configuration_indicateur.html', context)

"""

EXPORT CSV DES INDICATEURS

"""

def indicateurs_csv(request):             
    contexte_indicateur = ContexteIndicateur(request)
    return reponse_csv('sortie.csv', contexte_indicateur.indicateurs_csv)

def reponse_csv(nom_fichier, indicateurs):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachement; filename="{0}"'.format(nom_fichier)
    writer = csv.writer(response, delimiter=';')
    for indicateur in indicateurs:
        writer.writerow([indicateur['nom']])
        donnees = indicateur['donnees']
        for i, donnee in enumerate(donnees):
            if i == 0:
                writer.writerow([indicateur['unite']]+[d[0] for d in donnee])
            writer.writerow([indicateur['territoires'][i]]+[d[1] for d in donnee])
        writer.writerow([])
    return response    