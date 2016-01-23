import os

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
                 'integration': integration_dans_dvf}
    return fonctions[description]

def verification_donnees(repertoire):
    try:
        fichiers = _recuperer_fichiers_txt(repertoire)
        if len(fichiers) > 0:
            erreurs = ['Test 1', 'Erreur 1']
            fichiers_controles = []
            for fichier in fichiers:
                reussite, msg_err = _controler_fichier_txt(fichier)
                if reussite:
                    fichiers_controles.append(fichier)
                else:
                    erreurs.append(msg_err)
            noms_fichier, departements = _ordonner_fichiers_txt(fichiers_controles)
            return True, noms_fichier, departements, erreurs
        else:
            return False, None, None, ['Aucun fichier txt dans le répertoire selectionné.']  
    except Exception as e:
        return False, None, None, [str(e)]

def _recuperer_fichiers_txt(repertoire):
    return [os.path.join(repertoire, fichier) for fichier in os.listdir(repertoire) if fichier.endswith('.txt')]

def _controler_fichier_txt(fichier):
    return True, ''

def _ordonner_fichiers_txt(fichiers):
    return fichiers, ['59', '62']

def creation_tables(dvf, fichier_gestion_csv, fichiers_annexes):
    try:
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
