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

import csv
import json
from datetime import datetime

from django.shortcuts import render, redirect
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.http import HttpResponse

from main.territoire import integration

from .contexte import ContexteFiltre
from .contexte import ContexteRecherche
from .mutation import Mutations
from .mutation import DetailMutation

def recherche(request):
    '''
    Permet de générer la page de résultat des mutations
    
    Une requete ajax sera lancée dès la fin du chargement de la page 
    pour mettre à jour le tableau des mutations (si la variable charger_tableau est True).
    La requete ajax correspond à la réponse de la fonction maj_tableau
    
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    'params' : paramètres de configuration de la bdd active (sert à instancier un objet Requeteur)
    'type_bdd' : type de la base de données DVF+ ou DV3F (sert à instancier un objet Requeteur)
    'titre' : titre pour le territoire affiché
    'mutations' : conserve l'ensemble des mutations du territoire actif
    'typologies' : conserve la liste des typologies disponibles (tuple (code, libelle)) pour le territoire actif
    'annees' : conserve la liste des années de mutation disponibles pour le territoire actif 
    'valeur_min_existante' : conserve la valeur fonciere minimale existante dans la liste des mutations
    'valeur_max_existante' : conserve la valeur fonciere maximale existante dans la liste des mutations
    'typologie' : typologie définie pour le filtre de mutations
    'annee_min' : annee minimale définie pour le filtre de mutations
    'annee_max' : annee maximale définie pour le filtre de mutations
    'valeur_min' : valeur foncière minimale définie pour le filtre de mutations
    'valeur max' : valeur foncière maximale définie pour le filtre de mutations
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    contexte_recherche = ContexteRecherche(request)
    if not contexte_recherche.success:
        return redirect('main:configuration_bdd')
    
    request.session = contexte_recherche.request.session      
    context = {'departements' : contexte_recherche.departements, 
               'epcis' : contexte_recherche.epcis, 
               'communes' : contexte_recherche.communes,
               'charger_tableau': contexte_recherche.charger_tableau,}
    return render(request, 'recherche.html', context)

def maj_tableau(request, page, tri):
    '''
    requete ajax pour l'actualisation du tableau
    '''    
    contexte_filtre = ContexteFiltre(request)
    request.session['parametres_filtre'] = contexte_filtre.parametres    
    
    mutations = Mutations(request.session).avec_filtre(order_by=tri)
    mutations = mutations_de_la_page(page, mutations, 50)       
        
    context = {'mutations': mutations, 
               'tri' : tri,
               'typologies' : request.session['parametres_filtre']['typologies'],
               'annees' : request.session['parametres_filtre']['annees'],}
    return render(request, 'tableau_mutations.html', context)

def recherche_detaillee(request, id):
    '''
    requete ajax pour l'affichage du détail de la mutation
    '''
    detail = DetailMutation(id, request.session)
    reponse = {'mutation': detail.mutation, 
               'locaux': detail.locaux, 
               'parcelles': detail.parcelles, 
               'adresses':detail.adresses}
    return render(request, 'detail_mutation.html', reponse)

def mutations_de_la_page(page, mutations, nb_par_page):
    paginator = Paginator(mutations, nb_par_page)
    try:
        mutations = paginator.page(page)
    except PageNotAnInteger:
        mutations = paginator.page(1)
    except EmptyPage:
        mutations = paginator.page(paginator.num_pages)
    return mutations


"""

EXPORT CSV DES MUTATIONS

"""

def mutations_csv(request):             
    mutations = Mutations(request.session).as_objet()    
    entete = ['Date mutation', 'Type Bien']
    lignes = [(m.datemut, m.libtypbien) for m in mutations]        
    return reponse_csv('sortie.csv', lignes, entete)

def reponse_csv(nom_fichier, lignes, entete = None):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachement; filename="{0}"'.format(nom_fichier)
    writer = csv.writer(response, delimiter=';')
    if entete:
        writer.writerow(entete)
    for ligne in lignes:
        writer.writerow(ligne)
    return response    
  