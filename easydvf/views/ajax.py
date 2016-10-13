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

from .filtre import ContexteFiltre

from .mutation import Mutations

def maj_tableau(request, page, tri):
    '''

    REQUETE AJAX ACTUALISATION TABLEAU

    '''    
    contexte = ContexteFiltre(request)
    request.session['parametres_filtre'] = contexte.parametres    
    
    mutations = Mutations(request.session).avec_filtre(order_by=tri)
    mutations = mutations_de_la_page(page, mutations, 50)       
        
    context = {'mutations': mutations, 
               'tri' : tri,
               'typologies' : request.session['parametres_filtre']['typologies'],
               'annees' : request.session['parametres_filtre']['annees'],}
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
    m = DetailMutation(id, request.session)
    reponse = {'mutation': m.mutation, 'locaux': m.locaux, 'parcelles': m.parcelles, 'adresses':m.adresses}
    return render(request, 'detail_mutation.html', reponse)
    
    requeteur = Requeteur(*(request.session['params']), type_base = request.session['type_bdd'], script = 'sorties/requeteur_recherche.sql')
    mutation = requeteur.mutation_detaillee(id) or []
    locaux = requeteur.locaux_detailles(id) or []
    parcelles = requeteur.parcelles_detaillees(id) or []
    adresses = requeteur.adresses_associees(id) or []
    return render(request, 'detail_mutation.html', {'mutation':mutation, 
                                                    'locaux': locaux,
                                                    'parcelles': parcelles, 
                                                    'adresses': ', '.join(adresses)})

