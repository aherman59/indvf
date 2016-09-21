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

from django.shortcuts import render
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from outils.interrogation_bdd import Requeteur

from .filtre import modification_filtre
from .filtre import correction_valeurs_filtre_incorrectes

def maj_tableau(request, page, tri):
    '''

    REQUETE AJAX ACTUALISATION TABLEAU

    '''    
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

def mutations_de_la_page(page, mutations, nb_par_page):
    paginator = Paginator(mutations, nb_par_page)
    try:
        mutations = paginator.page(page)
    except PageNotAnInteger:
        mutations = paginator.page(1)
    except EmptyPage:
        mutations = paginator.page(paginator.num_pages)
    return mutations



def recherche_detaillee(request, id):
    '''

    REQUETE AJAX AFFICHAGE DETAIL MUTATION

    '''
    requeteur = Requeteur(*(request.session['params']), type_base = request.session['type_bdd'], script = 'sorties/requeteur_recherche.sql')
    mutation = requeteur.mutation_detaillee(id) or []
    locaux = requeteur.locaux_detailles(id) or []
    parcelles = requeteur.parcelles_detaillees(id) or []
    adresses = requeteur.adresses_associees(id) or []
    return render(request, 'detail_mutation.html', {'mutation':mutation, 
                                                    'locaux': locaux,
                                                    'parcelles': parcelles, 
                                                    'adresses': ', '.join(adresses)})

