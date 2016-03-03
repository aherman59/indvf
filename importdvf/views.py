import json
import os
from collections import namedtuple

from django.shortcuts import render
from django.contrib import messages
from django.http import HttpResponse

from importdvf.forms import ConfigForm

from .creation_dvf import etapes
from .gestion_import import *

# Create your views here.

def formulaire_configuration(request):
    formulaire = ConfigForm()
    return _afficher_formulaire(request, formulaire)

def _afficher_formulaire(request, formulaire):
    print('AFFICHAGE FORMULAIRE')
    constituer_etapes(request)
    #print('session >> ', request.session.items())
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)

def etape_import(request, etape):
    # Ressources
    repertoire_ressources = 'importdvf/creation_dvf/ressources' 
    fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
    fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                        os.path.join(repertoire_ressources,'natcult.csv'),
                        os.path.join(repertoire_ressources,'natcultspe.csv'))

    if request.is_ajax():
        reconstituer_etapes(request)
        if etape == '1':
            print(request.session['etapes'])
            etape_courante = etapes.context_etape(request.session['etapes'], int(etape))
            reussite, fichiers_ordonnes, departements, erreurs = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(request.session['dossier'])
            if reussite:
                request.session['departements'] = departements
                constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes)            
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant)}
                return HttpResponse(json.dumps(data), content_type='application/json')
        elif etape == '8':
            pass
        else:
            etape_courante = etapes.context_etape(request.session['etapes'], int(etape))
            dvf = dvf_objet(request, etape_courante)
            reussite, erreur = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(dvf, *(etape_courante.params[1:]))
            dvf.pgconn.deconnection_postgres()
            if reussite:
                data = {'description':etape_courante.description_prochaine_etape, 
                        'pourcentage':etape_courante.pourcentage, 
                        'etape_suivante':str(etape_courante.numero_suivant)}
                return HttpResponse(json.dumps(data), content_type='application/json')
        
    context = None
    formulaire  = ConfigForm(request.POST)
    if formulaire.is_valid():
        constituer_etapes(request)
        # enregistrement des données formulaire dans la session
        request.session['dossier'] = formulaire.cleaned_data['chemin_dossier']
        request.session['parametres_connexion'] = recuperer_donnees_connexion(formulaire)
        return render(request, 'test.html', context)
    else:
        print('Not OK')
        return _afficher_formulaire(request, formulaire)

def old_etape_import(request, etape):
    context = None
    # Ressources
    repertoire_ressources = 'importdvf/creation_dvf/ressources' 
    fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
    fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                        os.path.join(repertoire_ressources,'natcult.csv'),
                        os.path.join(repertoire_ressources,'natcultspe.csv'))
    reconstituer_etapes(request)
    if etape =='0': # etape 0 : Validation des données transmises
        formulaire  = ConfigForm(request.POST)
        if formulaire.is_valid():
            # enregistrement des données formulaire dans la session
            request.session['dossier'] = formulaire.cleaned_data['chemin_dossier']
            request.session['parametres_connexion'] = recuperer_donnees_connexion(formulaire)
            # lancement étape 0 (le template contient un script js qui déclenche l'execution de l'étape suivante)
            return _lancement_etape_0(request)
        else:
            print('Not OK')
            #return _afficher_formulaire(request, formulaire)
    elif etape == '1': # étape 1 : Vérification des fichiers sources - Préparation des étapes suivantes
        return _lancement_etape_1(request, fichier_gestion_csv, fichiers_annexes)
    else: # etapes suivantes
        return _lancement_etape(request, etape)

def _lancement_etape_0(request):
    print('LANCEMENT ETAPE 0')
    #print('session >> ', request.session['etapes'])
    etape_courante = etapes.context_etape(request.session['etapes'], 0)
    return _afficher_etapes(request, etape_courante)

def _lancement_etape_1(request, fichier_gestion_csv, fichiers_annexes):
    print('LANCEMENT ETAPE 1')
    #print('session >> ', request.session['etapes'])    
    etape_courante = etapes.context_etape(request.session['etapes'], 1)
    reussite, fichiers_ordonnes, departements, erreurs= etapes.fonction_a_executer(etape_courante.fonction_a_executer)(request.session['dossier'])
    if reussite:
        # enregistrement des departements dans la session
        request.session['departements'] = departements
        # creation des étapes suivantes
        constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes)            
        # intégrer les alertes eventuelles et le message de succès
        ajouter_alertes(request, erreurs)
        ajouter_messages_succes(request, ['Vérifications effectuées. Les fichiers suivants seront importés : ' + ', '.join(fichiers_ordonnes)])
        return _afficher_etapes(request, etape_courante)
    else:
        return _afficher_msg(request, erreurs[0], err = True)

def _lancement_etape(request, etape):
    print('LANCEMENT ETAPE ', etape) 
    #print('session >> ', request.session['etapes'])
    charger_notifications(request)
    numero = int(etape)
    etape_courante = etapes.context_etape(request.session['etapes'], numero)
    if etape_courante:
        dvf = dvf_objet(request, etape_courante)
        reussite, msg_err = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(dvf, *(etape_courante.params[1:]))
        dvf.pgconn.deconnection_postgres()
        if reussite:
            ajouter_messages_succes(request, [msg_err])
            return _afficher_etapes(request, etape_courante)
        else:
            return _afficher_msg(request, msg_err, err = True)
    else:
        return _afficher_msg(request, '''L'import des données s'est achevé avec succès. La base DVF+ est prête.''', err = False)            

def _afficher_etapes(request, etape_courante):
    sauvegarder_notifications(request)
    context = {'desc_etape':etape_courante.description_prochaine_etape, 
               'pourcentage':etape_courante.pourcentage, 
               'numero_suivant':str(etape_courante.numero_suivant)}
    return render(request, 'etapes_import.html', context)

def _afficher_msg(request, msg, err):
    context = {'msg': msg, 'err': err}
    return render(request, 'msg_import.html', context)

