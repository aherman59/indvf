'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

import csv
import json
from datetime import datetime

from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.http import HttpResponse

from main.territoire import integration

from .contexte import ContexteFiltre
from .contexte import ContexteRecherche
from .mutation import Mutations
from .mutation import DetailMutation

@login_required
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
    mutations = Mutations(request.session).as_objet(order_by = 'datemut')    
    entete = ['Identifiant', 'Code Service', 'Référence Acte', 'Date mutation', 'Type de Bien', 'Valeur Foncière', 'Nb locaux vendus', 'Nb parcelles vendues']
    lignes = [(m.id, m.codservch, m.refdoc, m.datemut, m.libtypbien, m.valeurfonc, m.nblocmut, m.nbparmut) for m in mutations]        
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

#eof  