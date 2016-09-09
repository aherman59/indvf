import os

from django.shortcuts import render, redirect
from django.template.response import TemplateResponse

from main.configuration import BASE_DIR
from .gestion_fiches_tuto import obtenir_fiches_disponibles

REPERTOIRE_FICHES = os.path.join(BASE_DIR, 'tutodvf', 'fiches')

def accueil(request): 
    FICHES = obtenir_fiches_disponibles(REPERTOIRE_FICHES)   
    context = {'fiches' : FICHES}
    return render(request, 'sommaire.html', context)

def fiche(request, nom_fichier_md):
    FICHES = obtenir_fiches_disponibles(REPERTOIRE_FICHES)
    for i, fiche_tuto in enumerate(FICHES):
        if fiche_tuto['lien'].endswith(nom_fichier_md):
            fiche_selectionnee = fiche_tuto
            fiche_suivante = FICHES[i+1] if i < len(FICHES) else None
            fiche_precedente = FICHES[i-1] if i > 0 else None
    context = {'fiche_selectionnee' : fiche_selectionnee,
               'fiche_suivante': fiche_suivante,
               'fiche_precedente':fiche_precedente}
    return render(request, 'fiche.html', context)
