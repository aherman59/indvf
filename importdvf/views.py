import time
import os
from collections import namedtuple

from django.shortcuts import render
from django.contrib import messages
from django.http import HttpResponse

from importdvf.forms import ConfigForm

from .creation_dvf.dvfclass import DVF, DVF_PLUS
from .creation_dvf import etapes

# Create your views here.

def formulaire_configuration(request):
    formulaire = ConfigForm()
    context = {'etape':'0', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)
    
def etape_import(request, etape):
    context = None
    # Ressources
    repertoire_ressources = 'importdvf/creation_dvf/ressources' 
    fichier_gestion_csv = os.path.join(repertoire_ressources,'champs_dvf.csv')
    fichiers_annexes = (os.path.join(repertoire_ressources,'artcgil135b.csv'),
                        os.path.join(repertoire_ressources,'natcult.csv'),
                        os.path.join(repertoire_ressources,'natcultspe.csv'))
    #description d'une étape
    etape_nt = namedtuple('Etape', ['numero','numero_suivant', 'pourcentage', 'fonction_a_executer', 'params', 'description_prochaine_etape'])
    # reconstitution des étapes enregistrées dans la session (json -> namedtuple)
    if 'etapes' in request.session:
        request.session['etapes'] = [etape_nt(*etape) for etape in request.session['etapes']]
        
    if etape =='0': # etape 0 : Validation des données transmises
        formulaire  = ConfigForm(request.POST)
        if formulaire.is_valid():
            request.session.flush()
            # recuperation des données de connexion
            hote = formulaire.cleaned_data['hote']
            bdd = formulaire.cleaned_data['bdd']
            port = formulaire.cleaned_data['port']
            utilisateur = formulaire.cleaned_data['utilisateur']
            mdp = formulaire.cleaned_data['mdp']
            # enregistrement dans la session
            request.session['chemin_dossier'] = formulaire.cleaned_data['chemin_dossier']
            request.session['parametres_connexion'] = (hote, bdd, port, utilisateur, mdp)
            # creation des deux premières étapes
            request.session['etapes'] = [etape_nt(0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                                         etape_nt(1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF'),]
            # lancement étape 0 (le template contient un script js qui déclenche l'execution de l'étape suivante)
            etape_courante = etapes.context_etape(request.session['etapes'], 0)
            context = {'desc_etape':etape_courante.description_prochaine_etape, 
                       'pourcentage':etape_courante.pourcentage, 
                       'numero_suivant':str(etape_courante.numero_suivant)}          
            return render(request, 'etapes_import.html', context)
        else:
            context = {'etape':'0', 'formulaire':formulaire}
            return render(request, 'formulaire_configuration.html', context)

    elif etape == '1': # étape 1 : Vérification des fichiers sources - Préparation des étapes suivantes
        etape_courante = etapes.context_etape(request.session['etapes'], 1)
        reussite, fichiers_ordonnes, departements, erreurs= etapes.fonction_a_executer(etape_courante.fonction_a_executer)(request.session['chemin_dossier'])
        if reussite:
            request.session['departements'] = departements
            # creation des étapes suivantes
            request.session['etapes'].append(etape_nt(2, 300, '15', 'creation', ('DVF', fichier_gestion_csv, fichiers_annexes), 'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[0])))
            l = len(fichiers_ordonnes)
            for index in range(l): 
                request.session['etapes'].append(etape_nt(300 + 2*index, 301 + 2*index , str(15 + int(85*(index + (1/2))/l)) , 'import', ('DVF', fichiers_ordonnes[index], 'tmp_0'), 'Intégration dans DVF du fichier {0}'.format(fichiers_ordonnes[index])))
                txt_descriptif = 'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[index + 1]) if index + 1 < l else 'Création des tables DVF+'
                request.session['etapes'].append(etape_nt(301 + 2*index, 302 + 2*index, str(15 + int(85*(index + 1)/l)), 'integration', ('DVF', 'tmp_0', fichiers_ordonnes[index]), txt_descriptif))
            # creation des etapes DVF+
            request.session['etapes'].append(etape_nt(302 + 2*(l-1), 4 , '30', 'creation_table_dvf_plus', ('DVF+', fichier_gestion_csv), 'Calculs de la table local'))
            request.session['etapes'].append(etape_nt(4, 5, '65', 'transformation', ('DVF+', fichier_gestion_csv, 'local'), 'Calculs de la table disposition_parcelle'))
            request.session['etapes'].append(etape_nt(5, 6, '85', 'transformation', ('DVF+', fichier_gestion_csv, 'disposition_parcelle'), 'Calculs de la table mutation'))
            request.session['etapes'].append(etape_nt(6, 7, '100', 'transformation', ('DVF+', fichier_gestion_csv, 'mutation'), 'Fin des opérations'))
            
            for erreur in erreurs:
                messages.add_message(request, messages.WARNING, erreur)
            messages.add_message(request, messages.SUCCESS, 'Vérifications effectuées. Les fichiers suivants seront importés : ' + ', '.join(fichiers_ordonnes))
            request.session['notifications'] = [(m.message, m.level) for m in messages.get_messages(request)]
            context = {'desc_etape':etape_courante.description_prochaine_etape, 
                       'pourcentage':etape_courante.pourcentage, 
                       'numero_suivant':str(etape_courante.numero_suivant)}          
            return render(request, 'etapes_import.html', context)
        else:
            context = {'msg': erreurs[0], 'err': True}
            return render(request, 'msg_import.html', context)

    else: # etapes suivantes
        for message, level in request.session['notifications']:
            messages.add_message(request, level, message)
        numero = int(etape)
        etape_courante = etapes.context_etape(request.session['etapes'], numero)
        if etape_courante:
            if etape_courante.params[0] == 'DVF':
                dvf = DVF(*request.session['parametres_connexion'], departements = request.session['departements'])
            elif etape_courante.params[0] == 'DVF+':
                dvf = DVF_PLUS(*request.session['parametres_connexion'], departements = request.session['departements']) 
            reussite, msg_err = etapes.fonction_a_executer(etape_courante.fonction_a_executer)(dvf, *(etape_courante.params[1:]))
            if reussite:
                messages.add_message(request, messages.SUCCESS, msg_err)
                request.session['notifications'] = [(m.message, m.level) for m in messages.get_messages(request)]
                context = {'desc_etape':etape_courante.description_prochaine_etape, 
                           'pourcentage':etape_courante.pourcentage, 
                           'numero_suivant':str(etape_courante.numero_suivant)}
                return render(request, 'etapes_import.html', context)
            else:
                context = {'msg': msg_err, 'err': True}
                return render(request, 'msg_import.html', context)
        else:
            context = {'msg': '''L'import des données s'est achevé avec succès. La base DVF+ est prête.''', 'err': False}
            return render(request, 'msg_import.html', context)
