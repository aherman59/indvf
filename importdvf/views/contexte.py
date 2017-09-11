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

from dvf_plus.controle import RepertoireDonneesDVF
from dvf_plus.traitement import BASE_SQLITE
from dvf_plus.traitement import FICHIERS_ANNEXES
from dvf_plus.traitement.dvfclass import DVF
from dvf_plus.traitement.dvfclass import DVF_PLUS
from dvf_plus.general import _code_erreur

from importdvf.creation_dvf.cadastre import Cadastre
from importdvf.creation_dvf.cadastre import GeomDVF

from main.configuration import BASE_DIR
from importdvf.forms import ConfigForm


class ContexteImport():
    
    def __init__(self, request):
        self.session = request.session
        self.formulaire = ConfigForm(request.POST)
    
    @property
    def success(self):
        if self.formulaire.is_valid():
            self.session['dossier'] = self.formulaire.cleaned_data['chemin_dossier']
            self.session['parametres_connexion'] = self.formulaire.recuperer_donnees_connexion()
            self.session['effacer_schemas_existants'] = self.formulaire.cleaned_data['effacer_schemas_existants']
            self.session['geolocaliser'] = self.formulaire.cleaned_data['geolocaliser']
            self.session['proxy'] = self.formulaire.cleaned_data['proxy']
            self.session['communes_a_geolocaliser'] = None
            return True
        else:
            return False

class ContexteImportAjax():
    
    def __init__(self, request, etape):
        self.request = request
        self.session = request.session
        self.success = True
        self.erreur = None
        self.main(etape)
    
    def main(self, etape):
        if etape == '1':
            self.etape_verification_repertoire()
        elif etape == '2':
            self.etape_creation_tables_dvf()
        elif etape.startswith('3'):
            self.etapes_import_fichiers(int(etape))
        elif etape.startswith('4'):
            self.etapes_integration_fichiers(int(etape))
        elif etape == '5':
            self.etape_creation_tables_dvf_plus()
        elif etape == '6':
            self.etape_calcul_table_local()
        elif etape == '7':
            self.etape_calcul_table_disposition_parcelle()
        elif etape == '8':
            self.etape_calcul_table_mutation()
        elif etape == '9':
            self.etape_renommage()
        elif etape == '10':
            self.etape_creation_cadastre()
        elif etape.startswith('11'):
            self.etape_insertion_parcelles(int(etape))
        elif etape == '12':
            self.etape_integration_geometries()                
    
    def etape_verification_repertoire(self):
        repertoire = RepertoireDonneesDVF(self.session['dossier'])
        if not repertoire.a_un_fichier_valide():
            self.success = False
            self.erreur = repertoire.erreurs[0]
        self.session['fichiers_sources'] = repertoire.fichiers_sources
        self.session['departements'] = repertoire.departements
        self.definition_etape_suivante(2, 10, 'Creation des schémas et tables du modèle DVF')
        self.message = 'Vérification des fichiers terminée. Intégration des fichiers suivants : ' + ', '.join(self.session['fichiers_sources'])
    
    def etape_creation_tables_dvf(self):
        dvf = self.objet_dvf
        dvf.start_script()        
        # préparation des tables
        if self.session['effacer_schemas_existants']:
            success, _ = dvf.effacer_schemas_commencant_par(dvf.prefixe_schemas_departementaux)
            if not success:
                return self.code_erreur('dvf1')
            if not dvf.effacer_et_creer_schemas_dvf():
                return self.code_erreur('dvf1')
            if not dvf.creation_tables():
                return self.code_erreur('dvf1')
        else:
            if not dvf.effacer_et_creer_schemas_dvf_departementaux():
                return self.code_erreur('dvf1')
            if not dvf.creation_tables(recreer_tables_principales=False):
                return self.code_erreur('dvf1')
        if not dvf.creation_tables_annexes(*FICHIERS_ANNEXES):
                return self.code_erreur('dvf1')
        self.definition_etape_suivante(300, 15,'Import des données sources DVF - Fichier {0}'.format(self.session['fichiers_sources'][0]))
        self.message = 'Création des tables DVF effectuée.'
    
    def etapes_import_fichiers(self, etape):
        indice = etape - 300
        nb_fichiers = len(self.session['fichiers_sources'])
        if indice >= nb_fichiers:
            return self.code_erreur('dvf2b', fichier)
        
        dvf = self.objet_dvf       
        fichier = self.session['fichiers_sources'][indice]
        table_src = 'tmp_' + str(indice)       
        if not dvf.importer(fichier, table_src, recherche_differentielle=True):
           return self.code_erreur('dvf2', fichier)
        
        if  nb_fichiers == (indice + 1):
            self.definition_etape_suivante(400, 50,'Intégration dans DVF du fichier {0}'.format(self.session['fichiers_sources'][0]))
        else:
            fichier_suivant = self.session['fichiers_sources'][indice + 1]
            self.definition_etape_suivante(301 + indice, 15 + int(35*indice/nb_fichiers),'Import des données sources DVF - Fichier {0}'.format(fichier_suivant))
        self.message = 'Import du fichier {0} effectué.'.format(fichier)    
        
    def etapes_integration_fichiers(self, etape):
        indice = etape - 400
        nb_fichiers = len(self.session['fichiers_sources'])
        if indice >= nb_fichiers:
            return self.code_erreur('dvf3')
        
        dvf = self.objet_dvf
        if indice == 0:
            dvf.ecrire_entete_log()
        fichier = self.session['fichiers_sources'][indice]
        table_src = 'tmp_' + str(indice)
        dvf.ecrire_entete_table_import_dans_log('{0}'.format(table_src))
        if not dvf.maj_tables_avec('{0}'.format(table_src)):
            return self.code_erreur('dvf3')
                    
        if  nb_fichiers == (indice + 1):
            self.definition_etape_suivante(5, 100,'Création des tables DVF+')
            dvf.end_script()
        else:
            fichier_suivant = self.session['fichiers_sources'][indice + 1]
            self.definition_etape_suivante(401 + indice, 50 + int(50*indice/nb_fichiers),'Intégration dans DVF du fichier {0}'.format(fichier_suivant))
        self.message = 'Intégration des données du fichier {0} dans DVF effectuée.'.format(fichier)
    
    def etape_creation_tables_dvf_plus(self):
        dvf_plus = self.objet_dvf_plus
        dvf_plus.start_script()
        if not dvf_plus.creation_tables_dvf_plus(recreer_tables_principales=self.session['effacer_schemas_existants']):
            return self.code_erreur('dvf_plus1')
        self.definition_etape_suivante(6, 10, 'Calculs pour table local')
        self.message = 'Création des tables DVF+ effectuée.'
    
    def etape_calcul_table_local(self):
        dvf_plus = self.objet_dvf_plus
        if not dvf_plus.effectuer_calculs_local():
            return self.code_erreur('dvf_plus2')
        if not dvf_plus.construire_tables_dvf_plus('local', 'iddispoloc'):
            return self.code_erreur('dvf_plus2')
        self.definition_etape_suivante(7, 40, 'Calculs pour table disposition_parcelle')
        self.message = 'Modifications de la table local effectuées.'
    
    def etape_calcul_table_disposition_parcelle(self):
        dvf_plus = self.objet_dvf_plus
        if not dvf_plus.effectuer_calculs_parcelle():
            return self.code_erreur('dvf_plus2')
        if not dvf_plus.construire_tables_dvf_plus('disposition_parcelle', 'iddispopar'):
            return self.code_erreur('dvf_plus2')
        self.definition_etape_suivante(8, 70, 'Calculs pour table mutation')
        self.message = 'Modifications de la table disposition_parcelle effectuées.'
    
    def etape_calcul_table_mutation(self):
        dvf_plus = self.objet_dvf_plus
        if not dvf_plus.effectuer_calculs_mutation():
            return self.code_erreur('dvf_plus2')
        if not dvf_plus.construire_tables_dvf_plus('mutation', 'idmutation'):
            return self.code_erreur('dvf_plus2')
        self.definition_etape_suivante(9, 95, 'Renommage des tables DVF+')
        self.message = 'Modifications de la table mutation effectuées.'
    
    def etape_renommage(self):
        dvf_plus = self.objet_dvf_plus
        if not dvf_plus.transformation_tables_dvf():
            return self.code_erreur('dvf_plus2')
        self.message = 'Renommage et création des index de tables effectués.'
        if not self.session['geolocaliser']:
            self.definition_etape_suivante(9999, 100, 'Fin du traitement')
        else:
            self.definition_etape_suivante(10, 100, 'Constitution des données cadastrales')
    
    def etape_creation_cadastre(self):
        geomdvf = self.objet_geomdvf
        geomdvf.start_script()
        success, _ = geomdvf.creer_extension_postgis()
        if not success:
            return self.code_erreur('geom1')
        self.session['communes_a_geolocaliser'] = communes = geomdvf.recuperer_communes_a_geolocaliser()
        if len(communes) == 0:
            return self.code_erreur('geom2')
            
        cadastre = self.objet_cadastre
        success, _ = cadastre.creer_table_parcelles_si_inexistante('cadastre', 'parcellaire')
        if not success:
            return self.code_erreur('cada1')
        success, _ = cadastre.effacer_contrainte_si_existante('cadastre', 'parcellaire', 'parcellaire_pkey')
        if not success:
            return self.code_erreur('cada1')
        success, _ = cadastre.ajouter_clef_primaire('cadastre', 'parcellaire', ['idpar'])
        if not success:
            return self.code_erreur('cada1')
        
        self.definition_etape_suivante(1100000, 3, 'Récupération des parcelles de la commune {0}'.format(communes[0]))
        self.message = 'Création de la table cadastre.parcellaire'
    
    def etape_insertion_parcelles(self, etape):
        indice = etape - 1100000
        communes = self.session['communes_a_geolocaliser']
        nb_communes = len(communes)
        if indice >= nb_communes:
            return self.code_erreur('cada2')
        
        cadastre = self.objet_cadastre
        commune = communes[indice]
        proxy = self.session['proxy']
        success, msg = cadastre.inserer_parcelles_communales(commune, 'cadastre', 'parcellaire', proxy = proxy)
        if not success:
            return self.code_erreur('cada2')
        
        if nb_communes == (indice + 1):
            self.definition_etape_suivante(12, 75 ,'Intégration des géométries dans DVF+')
        else:
            commune_suivante = communes[indice + 1]
            self.definition_etape_suivante(1100001 + indice, 3 + int(72*indice/nb_communes),'Récupération des parcelles de la commune {0}'.format(commune_suivante))
        self.message = msg
    
    def etape_integration_geometries(self):
        geomdvf = self.objet_geomdvf
        success, _ = geomdvf.creer_champs_geometriques() if self.session['effacer_schemas_existants'] else True, 0
        if not success:
            return self.code_erreur('geom3')
        if not geomdvf.ajouter_commentaires_champs_geométriques():
            return self.code_erreur('geom3')
        if not geomdvf.mise_a_jour_geometries_local_depuis('cadastre', 'parcellaire'):
            return self.code_erreur('geom3')
        if not geomdvf.mise_a_jour_geometries_disposition_parcelle_depuis('cadastre', 'parcellaire'):
            return self.code_erreur('geom3')
        if not geomdvf.mise_a_jour_geometries_mutation():
            return self.code_erreur('geom3')
        if not geomdvf.creer_index_et_contraintes_geometriques():
            return self.code_erreur('geom3')
        geomdvf.end_script()
        self.definition_etape_suivante(9999, 100, 'Fin du traitement')
        self.message = 'Fin du traitement'
    
    @property
    def objet_dvf(self):
        parametres_connexion = self.session['parametres_connexion']
        departements = self.session['departements']
        script_sql = os.path.join(BASE_DIR, 'sorties/script_dvf.sql')
        log_integration = os.path.join(BASE_DIR, 'sorties/log.txt')
        dvf = DVF(*parametres_connexion, departements=departements, script=script_sql, log=log_integration)
        dvf.charger_gestionnaire_depuis_sqlite(BASE_SQLITE)
        return dvf
    
    @property
    def objet_dvf_plus(self):
        parametres_connexion = self.session['parametres_connexion']
        departements = self.session['departements']
        script_sql = os.path.join(BASE_DIR, 'sorties/script_dvf_plus.sql')
        dvf_plus = DVF_PLUS(*parametres_connexion, departements=departements, script=script_sql)
        dvf_plus.charger_gestionnaire_depuis_sqlite(BASE_SQLITE)
        return dvf_plus
    
    @property
    def objet_cadastre(self):
        parametres_connexion = self.session['parametres_connexion']
        script_sql = os.path.join(BASE_DIR, 'sorties/cadastre.sql')
        cadastre = Cadastre(*parametres_connexion, script=script_sql)
        return cadastre
    
    @property
    def objet_geomdvf(self):
        parametres_connexion = self.session['parametres_connexion']
        departements = self.session['departements']
        script_sql = os.path.join(BASE_DIR, 'sorties/cadastre.sql')
        geomdvf = GeomDVF(*parametres_connexion, departements=departements, script=script_sql)
        return geomdvf
                    
    def code_erreur(self, code, fichier=None):
        message_erreur = 'Code erreur non défini.'
        if code == 'dvf1':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE DE PREPARATION DES TABLES DVF INACHEVEE'''
        elif code == 'dvf2':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE D'IMPORT DU FICHIER {0} IMPOSSIBLE'''.format(fichier or '_')
        elif code == 'dvf2b':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE D'IMPORT DES FICHIERS IMPOSSIBLE'''
        elif code == 'dvf3':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE D'INTEGRATION INACHEVEE'''
        elif code =='dvf_plus1':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE DE PREPARATION DES TABLES DVF+ INACHEVEE'''
        elif code =='dvf_plus2':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE DE CALCUL DES TABLES DVF+ INACHEVEE'''
        elif code =='dvf_plus3':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE DE TRANFORMATION DVF+ FINALE INACHEVEE'''
        elif code =='cada1':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE DE CONSTITUTION DES DONNEES CADASTRALES INACHEVEE'''
        elif code =='cada2':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE D'INTEGRATION DES DONNEES CADASTRALES INACHEVEE'''
        elif code == 'geom1':
            message_erreur = '''TRAITEMENT NON ABOUTI - IMPOSSIBLE DE CHARGER L'EXTENSION POSTGIS'''
        elif code == 'geom2':
            message_erreur = '''TRAITEMENT NON ABOUTI - AUCUNE COMMUNE A GEOLOCALISER'''
        elif code == 'geom3':
            message_erreur = '''TRAITEMENT NON ABOUTI - PHASE D'INTEGRATION DES GEOMETRIES DANS DVF+ INACHEVEE'''
        self.success = False
        self.erreur = message_erreur
    
    def definition_etape_suivante(self, numero, pourcentage, description):
        self.pourcentage_etape_suivante = pourcentage
        self.numero_etape_suivante = numero
        self.description_etape_suivante = description
        
        
  