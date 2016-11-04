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

import os
import re

from django.shortcuts import render
from django.http import Http404

from main.configuration import BASE_DIR
from .gestion_fiches_tuto import RepertoireTuto

REPERTOIRE_FICHES = os.path.join(BASE_DIR, 'tutodvf', 'fiches')

def accueil(request):
    fiches = RepertoireTuto(REPERTOIRE_FICHES).fiches        
    context = {'fiches' : fiches}
    return render(request, 'sommaire.html', context)

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
        