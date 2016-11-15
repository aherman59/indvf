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
import csv
from collections import namedtuple
from datetime import datetime

from main.models import Departement, Epci, Commune

def integrer_territoires():
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    fichier_departement_insee = os.path.join(BASE_DIR, 'main/territoire/doc_insee/departement.csv')
    fichier_epci_insee = os.path.join(BASE_DIR,'main/territoire/doc_insee/epci2015.csv')
    fichier_commune_insee = os.path.join(BASE_DIR,'main/territoire/doc_insee/code_insee_france2015.txt')
    fichier_historique_commune = os.path.join(BASE_DIR,'main/territoire/doc_insee/historiq2015.txt')
    #if len(Departement.objects.all()) == 0:
    integrer_departements(fichier_departement_insee)
    #if len(Epci.objects.all()) == 0:
    integrer_epcis(fichier_epci_insee)
    #if len(Commune.objects.all()) == 0:
    integrer_communes(fichier_commune_insee, fichier_historique_commune, fichier_epci_insee)    

def integrer_departements(fichier_departement_insee):
    Departement.objects.all().delete()
    with open(fichier_departement_insee, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = ';')
        for ligne in lignes:
            d = Departement(nom=ligne[2],code=ligne[1])
            d.save()

def integrer_epcis(fichier_epci_insee):
    Epci.objects.all().delete()
    with open(fichier_epci_insee, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = ';')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            if len(Epci.objects.filter(code = str(ligne[2]))) == 0:
                code_departement = ligne[0][:3] if str(ligne[0]).startswith('97') else ligne[0][:2].lower()
                e = Epci(nom=ligne[3], code=ligne[2], departement=Departement.objects.get(code = code_departement))
                e.save()

def integrer_communes(fichier_commune_insee, fichier_historique_commune, fichier_epci_insee):
    Commune.objects.all().delete()
    communes = lister_communes(fichier_commune_insee)
    fusions_separations = recuperer_fusion_separation_communes(fichier_historique_commune)
    epci_communes = correspondance_epci_communes(fichier_epci_insee)
    for commune in communes:
        if commune.code_actualite != '4': # on exclut les 'anciens' codes communaux
            fusion_separation = retourner_fusion_separation(commune.code_commune, fusions_separations)
            epci_comm = retourner_code_epci(commune.code_commune, epci_communes)
            c = Commune(nom = commune.nom,
                        code = commune.code_commune,
                        departement = Departement.objects.get(code = commune.code_departement.lower()),
                        epci = Epci.objects.get(code = epci_comm),
                        code_actualite = commune.code_actualite,
                        commune_absorbante = fusion_separation.commune_absorbante,
                        commune_emancipee = fusion_separation.commune_emancipee,
                        date_absorbtion = fusion_separation.date_absorbtion,
                        date_separation = fusion_separation.date_separation)
            print(c)
            c.save()

def lister_communes(fichier_commune_insee):
    communes = []
    nt_comm1 = _nt_commune()
    with open(fichier_commune_insee, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = '\t')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            code_actualite = ligne[0]
            nom = ligne[15]
            if ligne[14] != '':
                nom += ' ' + ligne[14] 
            code_departement = ligne[5].zfill(2)
            code_commune = ligne[6].zfill(3) if not ligne[5].startswith('97') else ligne[6].zfill(2)
            communes.append(nt_comm1(nom, code_departement, code_departement+code_commune, code_actualite))
    return communes

def correspondance_epci_communes(fichier_epci_insee):
    commune_epci = {}
    with open(fichier_epci_insee, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = ';')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            commune_epci[ligne[0]] = ligne[2]
    return commune_epci

def recuperer_fusion_separation_communes(fichier_historique_commune, date_minimale = '01-01-2005'):
    fusions_separations = {}
    nt_comm2 = _nt_fusion_separation()
    with open(fichier_historique_commune, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = '\t')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            if ligne[6] != '':
                if datetime.strptime(ligne[6],'%d-%M-%Y')>= datetime.strptime(date_minimale, '%d-%M-%Y'):
                    if ligne[8] in ('21', '31', '33'):
                        code_departement = ligne[0].zfill(2)
                        code_commune = ligne[3].zfill(3) if not ligne[5].startswith('97') else ligne[6].zfill(2)
                        commune_absorbante = ligne[13].zfill(5) if ligne[8] in ('31','33') else None
                        commune_emancipee = ligne[13].zfill(5) if ligne[8] == '21' else None 
                        date_absorbtion = datetime.strptime(ligne[6],'%d-%M-%Y') if ligne[8] in ('31','33') else None
                        date_separation = datetime.strptime(ligne[6],'%d-%M-%Y') if ligne[8] == '21' else None
                        fusions_separations[code_departement + code_commune] =  nt_comm2(commune_absorbante, commune_emancipee, date_absorbtion, date_separation)
    return fusions_separations

def retourner_code_epci(code_commune, epci_communes):
    try:
        return epci_communes[code_commune]
    except KeyError as e:
        return 'ZZZZZZZZZ' # epci fictive telle que définie dans le fichier de l'Insee

def retourner_fusion_separation(code_commune, fusions_separations):
    try:
        return fusions_separations[code_commune]
    except KeyError as e:
        nt_comm2 = _nt_fusion_separation()
        return nt_comm2(None, None, None, None)

def _nt_commune():
    return namedtuple('Comm_insee', ['nom', 'code_departement', 'code_commune', 'code_actualite'])

def _nt_fusion_separation():
    return namedtuple('FusionSeparation', ['commune_absorbante', 'commune_emancipee', 'date_absorbtion', 'date_separation'])

    