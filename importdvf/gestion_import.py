from collections import namedtuple
from django.contrib import messages
from .creation_dvf.dvfclass import DVF, DVF_PLUS

def constituer_etapes(request):
    #description d'une étape
    etape_nt = _definition_etape()
    # creation des deux premières étapes
    request.session['etapes'] = [etape_nt(0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                    etape_nt(1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF')]

def reconstituer_etapes(request):
    #description d'une étape
    etape_nt = _definition_etape()
    # reconstitution des étapes enregistrées dans la session (json -> namedtuple)
    if 'etapes' in request.session:
        request.session['etapes'] = [etape_nt(*etape) for etape in request.session['etapes']]
    else:
        constituer_etapes(request)

def constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes):
    etape_nt = _definition_etape()
    print(request.session)
    request.session['etapes'] = [etape_nt(2, 300, '15', 
                                              'creation', 
                                              ('DVF', fichier_gestion_csv, fichiers_annexes, request.session['effacer_schemas_existants']), 
                                              'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[0]))]
    l = len(fichiers_ordonnes)
    for index in range(l): 
        request.session['etapes'].append(etape_nt(300 + 2*index, 
                                                  301 + 2*index , 
                                                  str(15 + int(85*(index + (1/2))/l)) , 
                                                  'import', 
                                                  ('DVF', fichiers_ordonnes[index], 'tmp_0'), 
                                                  'Intégration dans DVF du fichier {0}'.format(fichiers_ordonnes[index])))
        txt_descriptif = 'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[index + 1]) if index + 1 < l else 'Création des tables DVF+'
        pourcent = str(15 + int(85*(index + 1)/l)) if index + 1 < l else '5'
        request.session['etapes'].append(etape_nt(301 + 2*index, 
                                                  302 + 2*index, 
                                                  pourcent, 
                                                  'integration', 
                                                  ('DVF', 'tmp_0', fichiers_ordonnes[index]), 
                                                  txt_descriptif))
    # creation des etapes DVF+
    request.session['etapes'].append(etape_nt(302 + 2*(l-1), 4 , '30', 
                                              'creation_table_dvf_plus', 
                                              ('DVF+', fichier_gestion_csv, request.session['effacer_schemas_existants']), 
                                              'Calculs de la table local'))
    request.session['etapes'].append(etape_nt(4, 5, '65', 
                                              'transformation', 
                                              ('DVF+', fichier_gestion_csv, 'local'), 
                                              'Calculs de la table disposition_parcelle'))
    request.session['etapes'].append(etape_nt(5, 6, '85', 
                                              'transformation', 
                                              ('DVF+', fichier_gestion_csv, 'disposition_parcelle'), 
                                              'Calculs de la table mutation'))
    request.session['etapes'].append(etape_nt(6, 7, '95', 
                                              'transformation', 
                                              ('DVF+', fichier_gestion_csv, 'mutation'), 
                                              'Renommmage des tables'))
    request.session['etapes'].append(etape_nt(7, 8, '100', 
                                              'renommage', 
                                              ('DVF+', fichier_gestion_csv, ['local', 'disposition_parcelle', 'mutation']), 
                                              'Fin des opérations'))


def _definition_etape():
    return namedtuple('Etape', ['numero','numero_suivant', 'pourcentage', 'fonction_a_executer', 'params', 'description_prochaine_etape'])

def recuperer_donnees_connexion(formulaire):
    # recuperation des données de connexion
    hote = formulaire.cleaned_data['hote']
    bdd = formulaire.cleaned_data['bdd']
    port = formulaire.cleaned_data['port']
    utilisateur = formulaire.cleaned_data['utilisateur']
    mdp = formulaire.cleaned_data['mdp']
    return (hote, bdd, port, utilisateur, mdp)

def dvf_objet(request, etape_courante):
    dvf = None
    if etape_courante.params[0] == 'DVF':
        dvf = DVF(*request.session['parametres_connexion'], departements = request.session['departements'])
    elif etape_courante.params[0] == 'DVF+':
        dvf = DVF_PLUS(*request.session['parametres_connexion'], departements = request.session['departements'])
    return dvf

def ajouter_messages_succes(request, msgs):
    for msg in msgs:
        messages.add_message(request, messages.SUCCESS, msg)

def ajouter_alertes(request, alertes):
    for alerte in alertes:
        messages.add_message(request, messages.WARNING, alerte)

def sauvegarder_notifications(request):
    request.session['notifications'] = [(m.message, m.level) for m in messages.get_messages(request)]

def charger_notifications(request):
    for message, level in request.session['notifications']:
        messages.add_message(request, level, message)
