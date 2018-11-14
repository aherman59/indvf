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

import os
import re

from django.shortcuts import render, redirect
from django.http import Http404

from main.configuration import BASE_DIR
from .gestion_fiches_tuto import RepertoireTuto

REPERTOIRE_FICHES = os.path.join(BASE_DIR, 'tutodvf', 'fiches')

def accueil(request):
    mode_internet = True if 'doc-datafoncier' in request.build_absolute_uri() else False
    fiches = RepertoireTuto(REPERTOIRE_FICHES).fiches        
    return render(request, 'sommaire.html', locals())

def fiche(request, nom_fiche):
    repertoire = RepertoireTuto(REPERTOIRE_FICHES)
    context = {'fiche_selectionnee' : repertoire.fiche(nom_fiche),
               'fiche_suivante': repertoire.fiche_suivante(nom_fiche),
               'fiche_precedente': repertoire.fiche_precedente(nom_fiche)}
    return render(request, 'fiche.html', context)

def recherche(request):    
    if request.method == 'POST':
        contexte_recherche = ContexteRechercheTuto(request.POST)                
        context = {'mots_clefs': contexte_recherche.mots_clefs,
                   'fiches' : contexte_recherche.fiches,}
        return render(request, 'recherche_tuto.html', context)
    else:
        raise Http404('Méthode POST incorrecte')

class ContexteRechercheTuto():

    def __init__(self, post):
        self.fiches = []
        self.mots_clefs = '' 
        if 'motclef' in post:
            self.recherche(post['motclef'])
    
    def recherche(self, motclef):
        mots_clefs = self.decoupage(motclef)
        self.fiches = self.resultat(mots_clefs)            
        self.mots_clefs = ' '.join(mots_clefs)
    
    def decoupage(self, motclef):
        mots_clefs = re.findall(r'[\w]+',str(motclef))
        return [mot for mot in mots_clefs if (mot != '' and len(mot) >= 3)]
    
    def resultat(self, mots_clefs):
        fiches = RepertoireTuto(REPERTOIRE_FICHES).fiches_avec(mots_clefs)
        for fiche in fiches:
            fiche.extrait = fiche.extrait(mots_clefs)
        return fiches
        