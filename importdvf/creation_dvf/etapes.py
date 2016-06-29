import os
import csv
from datetime import datetime

from . import validation_etapes

def context_etape(ETAPES, numero):
    for etape in ETAPES:
        if etape.numero == numero:
            etape_courante = etape 
            return etape_courante
    return None

def fonction_a_executer(description):
    fonctions = {'verification': verification_donnees,
                 'creation': creation_tables,
                 'import': import_donnees, 
                 'integration': integration_dans_dvf,
                 'creation_table_dvf_plus':creation_tables_dvf_plus,
                 'transformation': transformation,
                 'renommage': renommage,
                 'creation_cadastre': creation_cadastre,
                 'insertion_parcelle': insertion_parcelle,
                 'integration_geometries': integration_geometries,}
    return fonctions[description]

def verification_donnees(repertoire):
    try:
        fichiers = _recuperer_fichiers_txt(repertoire)
        if len(fichiers) > 0:
            erreurs = []
            departements = []
            fichiers_controles = []
            for fichier in fichiers:
                reussite, departements_tmp, date_max, msg_err = _controler_fichier_txt(fichier)
                if reussite:
                    fichiers_controles.append((date_max, fichier))
                    departements = list(set(departements + departements_tmp))
                else:
                    erreurs.append(msg_err)
            noms_fichiers = _ordonner_fichiers_txt(fichiers_controles)
            return True, noms_fichiers, departements, erreurs
        else:
            return False, None, None, ['Aucun fichier txt dans le répertoire selectionné.']  
    except Exception as e:
        return False, None, None, [str(e)]

def _recuperer_fichiers_txt(repertoire):
    return [os.path.join(repertoire, fichier) for fichier in os.listdir(repertoire) if fichier.endswith('.txt')]

def _controler_fichier_txt(fichier):
    departements = []
    date_max = datetime(1,1,1,0,0)
    with open(fichier, 'r') as f:
        csv_reader = csv.reader(f, delimiter = '|')
        next(csv_reader)
        for n, ligne in enumerate(csv_reader):
            if len(ligne) != 43:
                return False, [], None, 'La ligne {0} du fichier {1} ne possède pas le bon nombre de champs. Le fichier est ignoré.'.format(str(n+1), fichier)
            if ligne[18] not in departements:
                departements.append(ligne[18])
            if datetime.strptime(ligne[8], '%d/%m/%Y') > date_max:
                date_max =  datetime.strptime(ligne[8], '%d/%m/%Y')
    return True, departements, date_max, ''

def _ordonner_fichiers_txt(fichiers):
    fichiers.sort()
    fichiers_ordonnes = [fichier for date, fichier in fichiers]
    fichiers_ordonnes.reverse()
    return fichiers_ordonnes

def creation_tables(dvf, fichier_gestion_csv, fichiers_annexes, effacer_schemas_existants):
    
    ## génération des schémas et tables
    dvf.start_script()
    dvf.charger_gestionnaire_depuis_csv(fichier_gestion_csv)
    if effacer_schemas_existants:
        valid, nb = dvf.effacer_schemas_commencant_par(dvf.prefixe_schemas_departementaux)
        if valid:
            valid2 = dvf.effacer_et_creer_schemas_dvf()
            if valid2:
                valid_creation_table = dvf.creation_tables()
    else:
        valid = dvf.effacer_et_creer_schemas_dvf_departementaux()
        if valid:
            valid_creation_table = dvf.creation_tables(recreer_tables_principales=False)
    if valid_creation_table:
        valid_preparation = dvf.creation_tables_annexes(*fichiers_annexes)
    dvf.ecrire_entete_log()

    if not valid_preparation:    
        return False, 'Echec de la création des schémas et tables.'
    else:
        return True, 'Création des tables DVF effectuée.'

def import_donnees(dvf, fichier_source, nom_table):

    valid_import = dvf.importer(fichier_source, nom_table, recherche_differentielle = True)
    if valid_import:
        return True, 'Import du fichier {0} effectué.'.format(fichier_source)
    else:
        return False, 'Impossible d\'importer le fichier {0}.'.format(fichier_source)


def integration_dans_dvf(dvf, table_src, fichier):
    
    dvf.ecrire_entete_table_import_dans_log(table_src)
    valid_integration = dvf.maj_tables_avec(table_src)
    if valid_integration:
        return True, 'Intégration des données du fichier {0} dans DVF effectuée.'.format(fichier)
    else:
        return False, 'Impossible d\'integrer le fichier {0} dans la base.'.format(fichier)

def creation_tables_dvf_plus(dvf_plus, fichier_gestion_csv, effacer_schemas_existants):
    try:
        dvf_plus.start_script()        
        dvf_plus.charger_gestionnaire_depuis_csv(fichier_gestion_csv)
        dvf_plus.creation_tables_dvf_plus(recreer_tables_principales = effacer_schemas_existants)
        return True, 'Création des tables DVF+ effectuée.'
    except Exception as e:
        return False, str(e)

def transformation(dvf_plus, fichier_gestion_csv, nom_table_dvf):
    try:
        variables_jointure = {'local' : 'iddispoloc', 'disposition_parcelle': 'iddispopar', 'mutation' : 'idmutation'}
        if nom_table_dvf == 'local':
            dvf_plus.effectuer_calculs_local()
        elif nom_table_dvf == 'disposition_parcelle':
            dvf_plus.effectuer_calculs_parcelle()
        elif nom_table_dvf == 'mutation':
            dvf_plus.effectuer_calculs_mutation()
        dvf_plus.charger_gestionnaire_depuis_csv(fichier_gestion_csv)        
        dvf_plus.construire_tables_dvf_plus(nom_table_dvf, variables_jointure[nom_table_dvf])            
        return True, 'Modifications de la table {0} effectuées.'.format(nom_table_dvf)
    except Exception as e:
        return False, str(e)

def renommage(dvf_plus, fichier_gestion_csv, tables):
    try:
        dvf_plus.charger_gestionnaire_depuis_csv(fichier_gestion_csv)
        dvf_plus.transformation_tables_dvf()
        return True, 'Renommage des tables.'
    except Exception as e:
        return False, str(e)
    
def creation_cadastre(cadastre):
    try:
        cadastre.creer_table_parcelles('cadastre', 'parcellaire')
        return True, 'Création de la table cadastre.parcellaire'
    except Exception as e:
        return False, str(e)

def insertion_parcelle(cadastre, commune):
    try:
        cadastre.inserer_parcelles_communales(commune, 'cadastre', 'parcellaire')
        return True, 'Intégration des parcelles de la commune' + commune
    except Exception as e:
        return False, str(e)

def integration_geometries(cadastre):
    return True, 'Intégration des géométries'    