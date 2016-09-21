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
from collections import namedtuple

from main.configuration import BASE_DIR

from .creation_dvf import etapes
from .creation_dvf.dvfclass import DVF, DVF_PLUS
from .creation_dvf.cadastre import Cadastre, GeomDVF


def reconstituer_etapes(request):
    '''
    Récupère les étapes enregistrées dans la session et les transforme en namedtuple
    
    si aucun étape n'est enregistrée dans la session, il crée les premières étapes.
    '''
    #description d'une étape
    etape_nt = _definition_etape()
    # reconstitution des étapes enregistrées dans la session (json -> namedtuple)
    if 'etapes' in request.session:
        request.session['etapes'] = [etape_nt(*etape) for etape in request.session['etapes']]
    else:
        constituer_etapes(request)

def constituer_etapes(request):
    '''
    Crée les deux premières étapes du traitement et les enregistre dans la session.
    '''

    etape_nt = _definition_etape()
    # creation des deux premières étapes
    request.session['etapes'] = [
                    etape_nt(0, 1, '5', '', (None,),'Vérification des fichiers sources'),
                    etape_nt(1, 2, '10', 'verification', (None,),'Creation des schémas et tables du modèle DVF')
                    ]


def constituer_etapes_2(request, fichier_gestion_csv, fichiers_annexes, fichiers_ordonnes):
    '''
    Crée les étapes suivantes du traitement (jusqu'à l'integration éventuelle des géométries du cadastre) et les enregistre dans la session.
    '''
    etape_nt = _definition_etape()
    request.session['etapes'] = [
                    etape_nt(2, 300, '15', 'creation', 
                                ('DVF', fichier_gestion_csv, fichiers_annexes, request.session['effacer_schemas_existants']), 
                                'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[0]))]
    l = len(fichiers_ordonnes)
    for index in range(l): 
        request.session['etapes'].append(
                    etape_nt(300 + 2*index, 301 + 2*index, str(15 + int(85*(index + (1/2))/l)), 'import', 
                                ('DVF', fichiers_ordonnes[index], 'tmp_0'), 
                                'Intégration dans DVF du fichier {0}'.format(fichiers_ordonnes[index])))
        txt_descriptif = 'Import des données sources DVF - Fichier {0}'.format(fichiers_ordonnes[index + 1]) if index + 1 < l else 'Création des tables DVF+'
        pourcent = str(15 + int(85*(index + 1)/l)) if index + 1 < l else '5'
        request.session['etapes'].append(
                    etape_nt(301 + 2*index, 302 + 2*index, pourcent, 'integration', 
                                ('DVF', 'tmp_0', fichiers_ordonnes[index]), txt_descriptif))
    # creation des etapes DVF+
    request.session['etapes'].append(
                    etape_nt(302 + 2*(l-1), 4 , '30', 'creation_table_dvf_plus', 
                                ('DVF+', fichier_gestion_csv, request.session['effacer_schemas_existants']), 
                                'Calculs de la table local'))
    request.session['etapes'].append(
                    etape_nt(4, 5, '65', 'transformation', 
                                ('DVF+', fichier_gestion_csv, 'local'), 
                                'Calculs de la table disposition_parcelle'))
    request.session['etapes'].append(
                    etape_nt(5, 6, '85', 'transformation', 
                                ('DVF+', fichier_gestion_csv, 'disposition_parcelle'), 
                                'Calculs de la table mutation'))
    request.session['etapes'].append(
                    etape_nt(6, 7, '95', 'transformation', 
                                ('DVF+', fichier_gestion_csv, 'mutation'), 
                                'Renommage des tables'))
    (txt_descriptif, no_etape) = ('Constitution des données cadastrales', 8) if request.session['geolocaliser'] else ('Fin du traitement', 9999)
    request.session['etapes'].append(
                    etape_nt(7, no_etape, '100', 'renommage', 
                                ('DVF+', fichier_gestion_csv, ['local', 'disposition_parcelle', 'mutation']), 
                                txt_descriptif))
    if request.session['geolocaliser']:
        request.session['etapes'].append(
                    etape_nt(8, 9, '5', 'creation_cadastre', 
                                ('Cadastre',), 'Récupération des parcelles communales'))

def constituer_etapes_3(request):
    '''
    Crée les étapes de constitution des géométries à partir du cadastre
    '''
    etape_nt = _definition_etape()
    communes = request.session['communes_a_geolocaliser']
    l = len(communes)
    commune_initiale = communes[0]
    communes_intermediaires = communes[1:-1]
    l_intermediaire = len(communes_intermediaires)
    commune_finale = communes[l-1]
    if l > 0:
        request.session['etapes'].append(
                    etape_nt(9, 10001, str(5 + int(90/l)), 'insertion_parcelle', 
                                ('Cadastre', commune_initiale, request.session['proxy']), 
                                'Récupération des parcelles de la commune ' + str(communes_intermediaires[0])))

        for i, commune in enumerate(communes_intermediaires[:-1]):
            request.session['etapes'].append(
                    etape_nt(10001 + i, 10002 + i, str(5 + int(90*(i+2)/l)), 'insertion_parcelle', 
                                ('Cadastre', commune, request.session['proxy']), 
                                'Récupération des parcelles de la commune ' + str(communes_intermediaires[i+1])))
        request.session['etapes'].append(
                    etape_nt(10000 + l_intermediaire, 10001 + l_intermediaire, '95', 'insertion_parcelle', 
                                ('Cadastre', communes_intermediaires[l_intermediaire - 1], request.session['proxy']), 
                                'Intégration des géométries dans les tables DVF+.'))
        request.session['etapes'].append(
                    etape_nt(10001 + l_intermediaire, 9999, '100', 'integration_geometries', 
                                ('GeomDVF', request.session['effacer_schemas_existants']), 
                                'Fin du traitement'))
        
def renvoyer_etape(request, numero):
    '''
    Retourne l'étape correpondant au numero spécifié
    '''
    for etape in request.session['etapes']:
        if etape.numero == numero:
            etape_courante = etape 
            return etape_courante
    return None

def executer_etape(request, etape_courante):
    '''
    Execute la fonction décrite dans l'étape courante
    '''
    fonction = etapes.fonction_a_executer(etape_courante.fonction_a_executer)
    if etape_courante.numero == 1:
        params = (request.session['dossier'],)
        reussite, fichiers_ordonnes, departements, erreurs = fonction(*params)
        return reussite, fichiers_ordonnes, departements, erreurs
    else:
        dvf = retourner_objet_dvf(request, etape_courante.params[0])
        reussite, message = fonction(dvf, *(etape_courante.params[1:]))
        dvf.pgconn.deconnection_postgres()
        return reussite, message        


def retourner_objet_dvf(request, type_objet_dvf):
    dvf = None
    if type_objet_dvf == 'DVF':
        dvf = DVF(*request.session['parametres_connexion'], 
                  departements = request.session['departements'], 
                  script = os.path.join(BASE_DIR, 'sorties/script_dvf.sql'),
                  log = os.path.join(BASE_DIR, 'sorties/log.txt'))
    elif type_objet_dvf == 'DVF+':
        dvf = DVF_PLUS(*request.session['parametres_connexion'], 
                       departements = request.session['departements'], 
                       script = os.path.join(BASE_DIR, 'sorties/script_dvf_plus.sql'))
    elif type_objet_dvf == 'Cadastre':
        cadastre = Cadastre(*request.session['parametres_connexion'], 
                            script = os.path.join(BASE_DIR, 'sorties/cadastre.sql'))
        if not request.session['communes_a_geolocaliser']:
            geomdvf = GeomDVF(*request.session['parametres_connexion'], 
                               departements = request.session['departements'], 
                            script = os.path.join(BASE_DIR, 'sorties/cadastre.sql'))
            request.session['communes_a_geolocaliser'] = geomdvf.recuperer_communes_a_geolocaliser()
            constituer_etapes_3(request) 
    elif type_objet_dvf == 'GeomDVF':
        dvf = GeomDVF(*request.session['parametres_connexion'], 
                           departements = request.session['departements'], 
                        script = os.path.join(BASE_DIR, 'sorties/cadastre.sql'))
                       
    return dvf or cadastre

def _definition_etape():
    '''
    Définit un namedtuple pour la gestion des étapes de traitement
    '''
    return namedtuple('Etape', ['numero',
                                'numero_suivant', 
                                'pourcentage', 
                                'fonction_a_executer', 
                                'params', 
                                'description_prochaine_etape'])