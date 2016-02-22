import os
import csv
from datetime import datetime

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
                 }
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

def creation_tables(dvf, fichier_gestion_csv, fichiers_annexes):
    try:
        dvf.start_script()
        dvf.charger_gestionnaire_depuis_csv(fichier_gestion_csv)
        dvf.effacer_schemas_commencant_par(dvf.prefixe_schemas_departementaux)
        dvf.effacer_et_creer_schemas_dvf()
        dvf.creation_tables_annexes(*fichiers_annexes)    
        dvf.creation_tables()
        dvf.ecrire_entete_log()
        return True, 'Création des schémas et des tables DVF effectuée.'
    except Exception as e:
        return False, str(e)

def import_donnees(dvf, fichier_source, nom_table):
    try:
        dvf.importer(fichier_source, nom_table, recherche_differentielle = True)
        return True, 'Import du fichier {0} effectué.'.format(fichier_source)
    except Exception as e:
        return False, str(e)


def integration_dans_dvf(dvf, table_src, fichier):
    try:
        dvf.ecrire_entete_table_import_dans_log(table_src)
        dvf.maj_tables_avec(table_src)
        return True, 'Intégration des données du fichier {0} dans DVF effectuée.'.format(fichier)
    except Exception as e:
        return False, str(e)

def creation_tables_dvf_plus(dvf_plus, fichier_gestion_csv):
    try:
        dvf_plus.start_script()        
        dvf_plus.charger_gestionnaire_depuis_csv(fichier_gestion_csv)
        dvf_plus.creation_tables_dvf_plus()
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
        dvf_plus.renommage_tables(nom_table_dvf + '_plus')
        return True, 'Modifications de la table {0} effectuées.'.format(nom_table_dvf)
    except Exception as e:
        return False, str(e)
