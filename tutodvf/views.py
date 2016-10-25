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

from django.shortcuts import render, redirect
from django.template.response import TemplateResponse

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
