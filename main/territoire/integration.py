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
import csv
from collections import namedtuple
from datetime import datetime

from main.models import Departement, Epci, Commune

def integrer_territoires():
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    fichier_departement_insee = os.path.join(BASE_DIR, 'main/territoire/doc_insee/departement.csv')
    fichier_epci_insee = os.path.join(BASE_DIR,'main/territoire/doc_insee/epci2016.csv')
    fichier_commune_insee = os.path.join(BASE_DIR,'main/territoire/doc_insee/code_insee_france2016.txt')
    fichier_historique_commune = os.path.join(BASE_DIR,'main/territoire/doc_insee/historiq2016.txt')
    if len(Departement.objects.all()) == 0:
        integrer_departements(fichier_departement_insee)
    if len(Epci.objects.all()) == 0:
        integrer_epcis(fichier_epci_insee)
    if len(Commune.objects.all()) == 0:
        integrer_communes(fichier_commune_insee, fichier_historique_commune, fichier_epci_insee)    

def integrer_departements(fichier_departement_insee):
    Departement.objects.all().delete()
    with open(fichier_departement_insee, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = ';')
        for ligne in lignes:
            d = Departement(nom=ligne[2],code=ligne[1])
            print(d)
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
                print(e)
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
    code_absorption = ['310', '311', '330', '331', '332', '333', '350', '351']
    code_separation = ['210']
    fusions_separations = {}
    nt_comm2 = _nt_fusion_separation()
    with open(fichier_historique_commune, 'r', encoding = 'utf-8') as f:
        lignes = csv.reader(f, delimiter = '\t')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            if ligne[6] != '':
                if datetime.strptime(ligne[6],'%d-%M-%Y')>= datetime.strptime(date_minimale, '%d-%M-%Y'):
                    if ligne[8] in code_absorption + code_separation:
                        code_departement = ligne[0].zfill(2)
                        code_commune = ligne[3].zfill(3) if not ligne[5].startswith('97') else ligne[6].zfill(2)
                        commune_absorbante = ligne[13].zfill(5) if ligne[8] in code_absorption else None
                        commune_emancipee = ligne[13].zfill(5) if ligne[8] in code_separation else None 
                        date_absorbtion = datetime.strptime(ligne[6],'%d-%M-%Y') if ligne[8] in code_absorption else None
                        date_separation = datetime.strptime(ligne[6],'%d-%M-%Y') if ligne[8] in code_separation else None
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

    