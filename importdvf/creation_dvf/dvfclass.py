'''
@author: antoine.herman
'''

from datetime import datetime

from .pg import PgOutils, requete_sql, requete_sql_avec_modification_args, select_sql_champ_unique
from ._dvfgestion import GestionVariablesDVF


def log_compte(table):
    """décorateur pour compter les lignes avant et apres insertion dans une table puis les logger"""
    def compteur(fonction):        
        def interne(self, *args, **kwargs):        
            nb_initial = self.compter(self.schema_principal, table)
            resultat = fonction(self, *args, **kwargs)
            nb_final = self.compter(self.schema_principal, table)
            self.ecrire_dans_log(table, nb_initial, nb_final)
            return resultat
        return interne
    return compteur

class DVFMere(PgOutils):
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, script = 'sorties/script.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)        
        self.gestionnaire = GestionVariablesDVF()        
        self.departements = departements
        self.schema_principal = 'dvf'
        self.schema_annexe = 'dvf_annexe'
        self.prefixe_schemas_departementaux = 'dvf_d'
        self.schemas_departementaux = [self.prefixe_schemas_departementaux + dep.upper() for dep in self.departements]
    
    def charger_gestionnaire_depuis_csv(self, fichier_csv):
        self.gestionnaire.charger_tables_depuis_csv(fichier_csv)
    
    def charger_gestionnaire_depuis_postgres(self, hote, base, port, utilisateur, motdepasse, schema, table_des_variables):
        self.gestionnaire.charger_tables_depuis_postgres(hote, base, port, utilisateur, motdepasse, schema, table_des_variables)
    
    def creation_tables_principales_et_departementales(self, tables, code_creation):
        self.creer_tables_principales_vides(tables, code_creation)
        self.creer_tables_departementales_vides(tables, code_creation)
        self.creer_insert_triggers(tables, code_creation)
    
    def creer_tables_principales_vides(self, tables, code_creation):
        for table in tables:
            self.creation_table_depuis_gestionnaire(self.schema_principal, table, code_creation)
            self._ajout_commentaire_table(self.schema_principal, table, code_creation)
            self._ajout_commentaires_champs(self.schema_principal, table, code_creation)
            
    def creation_table_depuis_gestionnaire(self, schema, table, code_creation):
        nom_table_dvf = self.nom_table_dvf(table, code_creation)
        table_obj = self.table(nom_table_dvf, code_creation)
        self.effacer_table(schema, table)
        self._creer_table(schema, table, table_obj.lister_variables_et_types())
    
    @requete_sql
    def _creer_table(self, schema, table, champs):
        pass
    
    def creer_tables_departementales_vides(self, tables, code_creation):
        for schema in self.schemas_departementaux:
            for table in tables:
                self.creation_table_heritee_depuis_gestionnaire(schema, table, code_creation)
                self._ajout_commentaire_table(schema, table, code_creation)
                self._ajout_commentaires_champs(schema, table, code_creation)
    
    def creation_table_heritee_depuis_gestionnaire(self, schema, table, code_creation, schema_mere = 'dvf', table_mere = None):
        table_mere = table if not table_mere else table_mere
        self.effacer_table(schema, table)
        self._creer_table_heritee(schema, table, schema_mere, table_mere)
        self._ajout_clef_primaire(schema, table, code_creation)
        self._ajout_contrainte_unicite(schema, table, code_creation)
        self._ajout_contrainte_check_departement(schema, table, code_creation) 
    
    @requete_sql
    def _creer_table_heritee(self, schema, table, schema_mere, table_mere):       
        pass
    
    def creer_insert_triggers(self, tables, code_creation):
        for table in tables:
            self._ajout_insert_trigger(self.schema_principal, table, code_creation)
    
    def _ajout_clef_primaire(self, schema, table, code_creation):
        champs = self.recuperer_contrainte(table, 'PK', code_creation)        
        if len(champs) > 0:
            self.ajouter_clef_primaire(schema, table, champs)
    
    def _ajout_contrainte_unicite(self, schema, table, code_creation):
        champs = self.recuperer_contrainte(table, 'U', code_creation)        
        if len(champs) > 0:
            self.ajouter_contrainte_unicite(schema, table, champs)
    
    def _ajout_contrainte_check_departement(self, schema, table, code_creation):
        champs = self.recuperer_contrainte(table, 'C', code_creation)
        if len(champs) > 0:
            expression = """{} = '{}'""".format(str(champs[0]), self.departement(schema))
            self.ajouter_contrainte_check(schema, table, expression)
    
    def _ajout_commentaire_table(self, schema, table, code_creation):
        nom_table_dvf = self.nom_table_dvf(table, code_creation)
        commentaire = self.table(nom_table_dvf, code_creation).description    
        self.ajouter_commentaire_sur_table(schema, table, commentaire) 
    
    def _ajout_commentaires_champs(self, schema, table, code_creation):
        for ch, commentaire in self.recuperer_commentaires(table, code_creation).items():
            self.ajouter_commentaire_sur_champ(schema, table, ch, commentaire)
    
    @requete_sql_avec_modification_args
    def _ajout_insert_trigger(self, schema, table, code_creation):        
        champ_dpt = self.recuperer_contrainte(table, 'C', code_creation)[0]        
        condition = ''        
        for departement in self.departements:
            condition += 'IF' if condition == '' else 'ELSIF'            
            condition += ' (NEW.' + champ_dpt + '=\'' + departement.upper() + '\') THEN INSERT INTO ' + self.schema(departement) + '.'+ table +' VALUES(NEW.*); RETURN NULL;\n'
        #condition += 'ELSE RAISE EXCEPTION \'Erreur code dpt\'; '
        condition += 'ELSE RETURN NULL;'
        condition += 'END IF;'         
        return schema, table, condition
    
    def recuperer_contrainte(self, table, typ, code_creation):        
        nom_table_dvf = self.nom_table_dvf(table, code_creation)
        table_obj = self.table(nom_table_dvf, code_creation)                                       
        return [var.nom for var in table_obj.variables if var.contrainte == typ]
    
    def recuperer_commentaires(self, table, code_creation):
        nom_table_dvf = self.nom_table_dvf(table, code_creation)
        table_obj = self.table(nom_table_dvf, code_creation)            
        comment_champs = {}
        for variable in table_obj.variables:
            comment_champs[variable.nom] = variable.description           
        return comment_champs
    
    def nom_table_dvf(self, table, code_creation):
        ''' Renvoie le nom de la table DVF du gestionnaire associé au code_creation (1 pour DVF, 2 pour DVF+ et 3 pour DV3F)'''
        return table[:-5] if code_creation > 1 else table
    
    def table(self, nom_table_dvf, code_creation):
        ''' Renvoie l'objet Table associé au code_creation (1 pour DVF, 2 pour DVF+ et 3 pour DV3F)'''
        if code_creation == 1:         
            table_obj = self.gestionnaire.table(nom_table_dvf).tableDVF()
        elif code_creation == 2:
            table_obj = self.gestionnaire.table(nom_table_dvf).tableDVF_plus()
        elif code_creation == 3:
            table_obj = self.gestionnaire.table(nom_table_dvf)
        return table_obj
    
    def est_schema_departemental(self, schema):
        if schema.startswith(self.prefixe_schemas_departementaux):
            return True
        return False
    
    def departement(self, schema):
        return schema[len(self.prefixe_schemas_departementaux):].upper()
    
    def schema(self, departement):
        return self.prefixe_schemas_departementaux + departement.upper()
        
    

class DVF(DVFMere):
    
    START_SCRIPT = '''---
-- SCRIPT DE CREATION DU MODELE DVF+ 
-- ETAPE 1/2
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--    Jérôme DOUCHE
--
-- Ce script est fourni sous licence Creative Commons 3.0 CC-BY-SA
--
-- Début d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
---

'''

    TABLES = ['mutation', 'mutation_article_cgi', 'disposition', 'disposition_parcelle', 'parcelle',
            'local', 'adresse', 'suf', 'volume', 'lot', 'adresse_dispoparc', 'adresse_local']
    
    TABLES_ANNEXES = ['ann_nature_culture', 'ann_nature_culture_speciale', 'ann_cgi', 
                      'ann_nature_mutation', 'ann_type_local']


    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, script ='sorties/script_dvf.sql', log = 'sorties/log.txt'):        
        DVFMere.__init__(self, hote, base, port, utilisateur, motdepasse, departements = departements, script = script)
        self.log = log
        self.creer_fonctions_sql_dvf()    
               
    def creer_fonctions_sql_dvf(self):
        self.creer_fonction_array_supprimer_null()
        self.creer_fonction_pgcd()        
    
    def effacer_et_creer_schemas_dvf(self):
        schemas = self.schemas_departementaux + [self.schema_principal, self.schema_annexe]
        self.effacer_et_creer_schemas(schemas)
        
    '''
    
    DVF - CREATION TABLES ANNEXES
    
    '''
    
    def creation_tables_annexes(self, fichierArtCGI, fichierNatCult, fichierNatCultSpe):
        self.creer_tables_annexes_vides()
        self.inserer_donnees_tables_annexes()
        self.creer_tables_annexes_temporaires()
        self.copier_fichiers_annexes_csv_dans_tables_annexes_temporaires(fichierArtCGI, fichierNatCult, fichierNatCultSpe)
        self.maj_tables_annexes()
        self.effacer_tables_commencant_par(self.schema_annexe, 'tmp_ann_')
    
    def creer_tables_annexes_vides(self):                
        for table in self.TABLES_ANNEXES:
            self.creation_table_depuis_gestionnaire(self.schema_annexe, table, 1)
            self._ajout_commentaire_table(self.schema_annexe, table, 1)
            self._ajout_commentaires_champs(self.schema_annexe, table, 1)        
    
    @requete_sql_avec_modification_args
    def inserer_donnees_tables_annexes(self):        
        return (self.schema_annexe,)
    
    @requete_sql_avec_modification_args
    def creer_tables_annexes_temporaires(self):
        return (self.schema_annexe,)
    
    def copier_fichiers_annexes_csv_dans_tables_annexes_temporaires(self, fichierArtCGI, fichierNatCult, fichierNatCultSpe):
        self.pgconn.copy_from_csv(fichierNatCult, '|', '{0}.tmp_ann_nature_culture'.format(self.schema_annexe), False)            
        self.pgconn.copy_from_csv(fichierNatCultSpe, '|', '{0}.tmp_ann_nature_culture_speciale'.format(self.schema_annexe), False)
        self.pgconn.copy_from_csv(fichierArtCGI, '|', '{0}.tmp_ann_cgi'.format(self.schema_annexe), False)
        self.redaction_script(self.script, '--\n--\n--\n--\n--\n--\n-- IMPORT DES FICHIERS ANNEXES '+', '.join([fichierNatCult, fichierNatCultSpe, fichierArtCGI])+' PAR UNE INSTRUCTION "COPY FROM"--\n--\n--\n--\n--\n--\n--\n--\n', False)            
         
    @requete_sql_avec_modification_args
    def maj_tables_annexes(self):
        return (self.schema_annexe,)
    
    
    '''
    
    DVF - CREATION TABLES
    
    '''
    
    def creation_tables(self):
        self.creation_tables_principales_et_departementales(self.TABLES, 1)
    
    '''
    
    DVF - IMPORTATION DONNEES BRUTES
    
    '''
    
    def importer(self, fichier, table, recherche_differentielle = True):
        self.creer_schema_si_inexistant('source')
        self.creer_table_import_temporaire()
        self.pgconn.copy_from_csv(fichier, '|', 'source.tmp', True)
        if recherche_differentielle:
            self.creer_table_source_avec_recherche_differentielle(table)
        else:
            self.creer_table_source_sans_recherche_differentielle(table)
        self.effacer_table('source', 'tmp')
    
    @requete_sql
    def creer_table_import_temporaire(self):
        pass
    
    @requete_sql
    def creer_table_source_sans_recherche_differentielle(self, table):
        pass
    
    @requete_sql
    def creer_table_source_avec_recherche_differentielle(self, table):
        pass
    
    '''
    
    DVF - INTEGRATION DONNEES
    
    '''
    
    def integration_dans_dvf(self, tables_sources): 
        self.ecrire_entete_log()       
        for table_src in tables_sources:
            self.ecrire_entete_table_import_dans_log(table_src)
            self.maj_tables_avec(table_src)
    
    def ecrire_entete_log(self):
        self.redaction_script(self.log, 'LOG - INTEGRATION DES DONNEES BRUTES DVF\n', True)
            
    def ecrire_entete_table_import_dans_log(self, table_src):
        self.redaction_script(self.log, '{0}|Nombre de lignes avant intégration|Nombre de lignes après intégration|Nombre de lignes intégrées\n'.format(table_src), False)
    
    def ecrire_dans_log(self, table, nb_initial, nb_final):
        self.redaction_script(self.log, 'Table {0} : {1}|{2}|{3}\n'.format(table, str(nb_initial), str(nb_final), str(int(nb_final - nb_initial))), False)
        
    def maj_tables_avec(self, table_src):
        # Première partie des maj
        self.effacer_table('source', 'tmp_calcul_lot')
        self.creer_table_calcul_lot(table_src)        
        self.maj_table_ann_nature_mutation(table_src)
        self.maj_table_mutation(table_src)
        self.maj_table_mutation_art_cgi(table_src)
        self.maj_table_disposition(table_src)
        self.maj_table_parcelle(table_src)
        self.maj_table_disposition_parcelle(table_src)
        self.maj_table_adresse(table_src)
        # Deuxième partie des maj
        self.effacer_table('source', table_src + '_tmp')
        self.creer_table_temporaire_intermediaire(table_src)
        self.maj_table_local(table_src)
        self.maj_table_volume(table_src)
        self.maj_table_suf(table_src)
        self.maj_table_lot(table_src)
        self.maj_tables_passages_adresses(table_src)        
        self.effacer_table('source', 'tmp_calcul_lot')
        self.effacer_table('source', table_src + '_tmp')
    
    @requete_sql
    def creer_table_calcul_lot(self, table_src):
        pass

    @requete_sql_avec_modification_args
    def maj_table_ann_nature_mutation(self, table_src):
        return self.schema_annexe, table_src
    
    @log_compte('mutation')
    @requete_sql_avec_modification_args
    def maj_table_mutation(self, table_src):
        return self.schema_principal, table_src, self.schema_annexe
    
    @log_compte('mutation_article_cgi')
    @requete_sql_avec_modification_args
    def maj_table_mutation_art_cgi(self, table_src):
        return self.schema_principal, table_src, self.schema_annexe
    
    @log_compte('disposition')
    @requete_sql_avec_modification_args
    def maj_table_disposition(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('parcelle')
    @requete_sql_avec_modification_args
    def maj_table_parcelle(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('disposition_parcelle')
    @requete_sql_avec_modification_args
    def maj_table_disposition_parcelle(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('adresse')
    @requete_sql_avec_modification_args
    def maj_table_adresse(self, table_src):
        return self.schema_principal, table_src

    @requete_sql_avec_modification_args
    def creer_table_temporaire_intermediaire(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('local')
    @requete_sql_avec_modification_args
    def maj_table_local(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('volume')
    @requete_sql_avec_modification_args
    def maj_table_volume(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('suf')
    @requete_sql_avec_modification_args
    def maj_table_suf(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('lot')
    @requete_sql_avec_modification_args
    def maj_table_lot(self, table_src):
        return self.schema_principal, table_src
    
    @log_compte('adresse_local')
    @log_compte('adresse_dispoparc')
    @requete_sql_avec_modification_args
    def maj_tables_passages_adresses(self, table_src):
        return self.schema_principal, table_src
   

class DVF_PLUS(DVFMere):
    
    START_SCRIPT = '''---
-- SCRIPT DE CREATION DU MODELE DVF+ 
-- ETAPE 2/2
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--    Jérôme DOUCHE
--
-- Ce script est fourni sous licence Creative Commons 3.0 CC-BY-SA
--
-- Début d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
---'''

    TABLES = ['local_plus', 'disposition_parcelle_plus', 'mutation_plus']
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, script ='sorties/script_dvf_plus.sql'):        
        DVFMere.__init__(self, hote, base, port, utilisateur, motdepasse, departements, script = script)
    
    '''
    
    DVF+ - CREATION TABLES
    
    '''
    
    def creation_tables_dvf_plus(self):
        self.creation_tables_principales_et_departementales(self.TABLES, 2)
    
    '''
    
    DVF+ - REMPLACEMENT TABLES
    
    '''    
    
    def transformation_tables_dvf(self):
        variables_jointure = {'local' : 'iddispoloc', 'disposition_parcelle': 'iddispopar', 'mutation' : 'idmutation'}
        for table in self.TABLES:
            nom_table_dvf = self.nom_table_dvf(table, 2)            
            if nom_table_dvf == 'local':
                self.effectuer_calculs_local()
            elif nom_table_dvf == 'disposition_parcelle':
                self.effectuer_calculs_parcelle()
            elif nom_table_dvf == 'mutation':
                self.effectuer_calculs_mutation()
            self.construire_tables_dvf_plus(nom_table_dvf, variables_jointure[nom_table_dvf])            
            self.renommage_tables(table)            
    
    '''
    
    DVF+ - CALCULS TEMPORAIRES
    
    '''
        
    def effectuer_calculs_local(self):
        for schema in self.schemas_departementaux:
            self.effacer_tables_commencant_par(schema, 'tmp_')
            self.creation_tables_calculs_temporaires_local(schema)            
    
    def effectuer_calculs_parcelle(self):
        for schema in self.schemas_departementaux:
            self.effacer_tables_commencant_par(schema, 'tmp_')
            self.creation_tables_calculs_temporaires_parcelle(schema)            
    
    def effectuer_calculs_mutation(self):
        for schema in self.schemas_departementaux:
            self.effacer_tables_commencant_par(schema, 'tmp_')
            self.creation_tables_calculs_temporaires_mutation(schema)            
    
    def creation_tables_calculs_temporaires_mutation(self, schema):
        self.creer_table_calcul_ann_nature_mutation_idmutation(schema)
        self.creer_table_calcul_mutation_article_cgi_idmutation(schema)
        self.creer_table_calcul_vefa_idmutation(schema)
        self.creer_table_calcul_disposition_idmutation(schema)
        self.creer_table_calcul_disposition_parcelle_idmutation(schema)
        self.creer_table_calcul_suf_idmutation(schema)
        self.creer_table_calcul_volume_idmutation(schema)
        self.creer_table_calcul_local_idmutation(schema)
    
    def creation_tables_calculs_temporaires_local(self, schema):
        self.creer_table_calcul_local_iddispoloc(schema)
    
    def creation_tables_calculs_temporaires_parcelle(self, schema):
        self.creer_table_calcul_parcelle_iddispopar(schema)
        self.creer_table_calcul_suf_iddispopar(schema)
    
    @requete_sql
    def creer_table_calcul_parcelle_iddispopar(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_suf_iddispopar(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_local_iddispoloc(self, schema):
        pass
    
    @requete_sql_avec_modification_args
    def creer_table_calcul_ann_nature_mutation_idmutation(self, schema):
        return schema, self.schema_annexe
    
    @requete_sql
    def creer_table_calcul_mutation_article_cgi_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_vefa_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_disposition_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_disposition_parcelle_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_suf_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_volume_idmutation(self, schema):
        pass
    
    @requete_sql
    def creer_table_calcul_local_idmutation(self, schema):
        pass
    
    '''
    
    DVF+ - REMPLACEMENT TABLE DVF PAR TABLE DVF+
    
    '''
    
    def construire_tables_dvf_plus(self, nom_table_dvf, variable_jointure):        
        for schema in self.schemas_departementaux:
            self.executer_requete_jointure(schema, nom_table_dvf, variable_jointure)
            self.effacer_tables_commencant_par(schema, 'tmp_')        
    
    def executer_requete_jointure(self, schema, table, variable_jointure):        
        
        champs = self.recuperer_champ_calcule(table)        
        liste_variable = [var.nom for var in self.gestionnaire.table(table).tableDVF_plus().variables]
        
        sql = '''
INSERT INTO %(schema)s.%(table)s
(
    %(variable)s
)
(
SELECT \n\t''' % {'schema':schema, 'table':table + '_plus', 'variable':', '.join(liste_variable)}        
        
        for v in liste_variable:
            indice_table = ''
            for l in champs:
                if v in l[1]:
                    indice_table = str(champs.index(l))
            sql += 't' + indice_table + '.' + v + ',\n\t'        
        sql = sql[:-3]
        sql += '\nFROM '+schema+'.' + table + ' t \n'
        count = 0
        for l in champs:
            sql += 'LEFT JOIN '+schema+'.tmp_calcul_' + l[0] + '_'+variable_jointure+' t' + str(count) + '\n\tON t.'+variable_jointure+' = t' + str(count) +'.'+variable_jointure+'\n'
            count +=1        
        sql += ');\n'
        self.execution_et_ecriture_script(sql)
        
    def recuperer_champ_calcule(self, table):        
        champs = []
        tableDVF = self.gestionnaire.table(table).tableDVF_plus()        
        for table_pour_creation in tableDVF.lister_tables_pour_creation():
            champs.append([table_pour_creation, tableDVF.lister_nom_variables_ayant_table_creation(table_pour_creation)])        
        return champs
    
    def renommage_tables(self, table):
        self.renommer_table_dvf_plus(self.schema_principal, table)
        for schema in self.schemas_departementaux:
            self.renommer_table_dvf_plus(schema, table)
        self.supprimer_trigger_table_dvf_plus(table)        
    
    def renommer_table_dvf_plus(self, schema, table):
        nom_table_dvf = self.nom_table_dvf(table, 2)
        self.effacer_table(schema, nom_table_dvf)
        self.renommer_table(schema, table, nom_table_dvf)
    
    def supprimer_trigger_table_dvf_plus(self, table):
        nom_table_dvf = self.nom_table_dvf(table, 2)
        self.supprimer_trigger(self.schema_principal, nom_table_dvf)
    
    @requete_sql
    def supprimer_trigger(self, schema, table):
        pass        


class FF(PgOutils):
    
    START_SCRIPT = '''---
-- SCRIPT DE PREPARATION DES FICHIERS FONCIERS POUR DVF 
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--
--
-- Début d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
---'''

    CORRESPONDANCE_TABLES = {'local' : 'pb0010_local',
                             'proprio' : 'proprietaire_droit',
                             'parcelle' : 'pnb10_parcelle',
                             'pevprinc' : 'pb40_pevprincipale',
                             'pevdep' : 'pb60_pevdependance',
                             'pev' : 'pb21_pev'}
    
    PREFIXES_TABLE = {'local' : 'idlocal', 'parcelle': 'idpar'}

    
    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, millesimesFF, script = 'sorties/script_prepa_ff.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.millesimesFF = millesimesFF         
        self.departements = departements
        self.prefixe_schemas_departementaux = 'croisement_d'
        self.schemas_departementaux = [self.prefixe_schemas_departementaux + dep.upper() for dep in self.departements]
        self.creer_fonctions_sql_ff()
        
    '''
    
    FF - CREATION FONCTIONS SQL
    
    '''
    
    def creer_fonctions_sql_ff(self):
        self.creer_fonction_convertir_date()
        self.creer_fonction_millesime_max()
        self.creer_fonction_millesime_min()
        self.creer_fonction_correction_jdatat()
    
    @requete_sql_avec_modification_args
    def creer_fonction_millesime_max(self):
        return (str(max(self._conversion_entiere_millesimes())),)
    
    @requete_sql_avec_modification_args    
    def creer_fonction_millesime_min(self):
        return (str(min(self._conversion_entiere_millesimes())),)
    
    @requete_sql
    def creer_fonction_correction_jdatat(self):
        pass
    
    '''
    
    FF - RAPATRIEMENT DES TABLES FF
    
    '''
    
    
    def effacer_et_creer_schemas_travail(self): 
        self.effacer_et_creer_schemas(self.schemas_departementaux)
    
    def rapatrier_tables_departementales_FF(self, hote_ff, base_ff, port, utilisateur, motdepasse):
        for schema in self.schemas_departementaux:
            for nom, nomff in self.CORRESPONDANCE_TABLES.items():
                for millesime in self.millesimesFF:
                    departement = self.departement(schema)
                    self.copier_table_distante(hote_ff, base_ff, port, utilisateur, motdepasse, 
                                               'ff_d{0}_{1}'.format(departement, millesime), 
                                             'd{0}_{1}_{2}'.format(departement, millesime,nomff), 
                                             schema, '{0}ff{1}i'.format(nom, millesime))
    
    '''
    
    FF - CORRECTIONS ET COMPLEMENTS TABLES LOCAUX ET PARCELLES
    
    '''
    
    def preparer_tables_departementales_parcelles_et_locaux(self):
        self.copier_tables_parcelles_et_locaux_avec_jdatatdvf()
        self.completer_jdatatdvf_dans_tables_parcelles_et_locaux()
        self.corriger_jdatadvf_dans_tables_parcelles_et_locaux()
        self.ajouter_champs_issus_des_tables_pev_dans_tables_local()
        self.nettoyer_schemas()
    
    def copier_tables_parcelles_et_locaux_avec_jdatatdvf(self):
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                for prefixe_table, identifiant_table in self.PREFIXES_TABLE.items():
                    self.copier_table_avec_creation_jdatatdvf(schema, prefixe_table, millesime)                   
    
    @requete_sql
    def copier_table_avec_creation_jdatatdvf(self, schema, prefixe_table, millesime):
        pass
    
    
    def completer_jdatatdvf_dans_tables_parcelles_et_locaux(self):
        '''
        Met à jour les jdatatdvf null dans les tables des Fichiers fonciers.
        '''        
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                for prefixe_table, identifiant_table in self.PREFIXES_TABLE.items():            
                        self._complement_dates_du_millesime(schema, prefixe_table, identifiant_table, millesime)
        
    def _complement_dates_du_millesime(self, schema, prefixe_table, identifiant_table, millesime):
        '''
        Met à jour les jdatatdvf null dans la table du millesime specifié des Fichiers fonciers.
        '''
        millesimes_anterieurs, millesimes_posterieurs = self._lister_millesimes_anterieurs_et_posterieurs(millesime)
        for autre_millesime in millesimes_posterieurs:
            self._complement_dates_millesime_depuis_autre_millesime(schema, prefixe_table, millesime, identifiant_table, autre_millesime)
        for autre_millesime in millesimes_anterieurs:
            self._complement_dates_millesime_depuis_autre_millesime(schema, prefixe_table, millesime, identifiant_table, autre_millesime)
        self._complement_dates_manquantes_avec(schema, prefixe_table, millesime, '0101{0}'.format(self._millesime_precedent(millesime)))
    
    @requete_sql
    def _complement_dates_millesime_depuis_autre_millesime(self, schema, prefixe_table, millesime, identifiant_table, autre_millesime):
        pass
    
    @requete_sql
    def _complement_dates_manquantes_avec(self, schema, millesime, prefixe_table, date):
        pass
        
    def corriger_jdatadvf_dans_tables_parcelles_et_locaux(self):
        '''
        Corrige les jdatatdvf dans les tables des Fichiers fonciers (sauf le premier millesime considéré comme la référence).
        '''
        for schema in self.schemas_departementaux:
            for prefixe_table, identifiant_table in self.PREFIXES_TABLE.items():
                self.effacer_table(schema, 'tmp_biens_a_corriger')
                self._creation_table_tmp_biens_a_corriger(schema, identifiant_table)        
                for millesime in self.millesimesFF[1:]: # d'abord reperage pour tous les millesimes
                    self.insertion_biens_a_corriger(schema, prefixe_table, identifiant_table, millesime)
                for millesime in self.millesimesFF[1:]: # ensuite correction pour tous les millesimes  
                    self._correction_dates(schema, prefixe_table, millesime, identifiant_table)    
    
    @requete_sql
    def _creation_table_tmp_biens_a_corriger(self, schema, identifiant_table):
        pass
    
    def insertion_biens_a_corriger(self, schema, prefixe_table, identifiant_table, millesime):
        '''
        Repere les jdatatdvf (qui n'évoluent pas alors que l'idprocpte evolue) dans les tables des Fichiers fonciers à partir du millésime spécifié.
        '''
        millesime_precedent = self._millesime_precedent(millesime)
        # ETAPE 1 : repérer les anomalies dans les millésimes précédents et fixer la date de correction
        millesime_comparaison = self._millesime_precedent(millesime)        
        while millesime_comparaison != '0001':
            self._insertion_biens_a_corriger_etape1(schema, identifiant_table, millesime_precedent, millesime, prefixe_table, millesime_comparaison)            
            millesime_comparaison = self._millesime_precedent(millesime_comparaison)
        # ETAPE 2 : répercuter la date de correction pour les millésimes postérieurs
        for m in self._millesimes_posterieurs(millesime):
            self._insertion_biens_a_corriger_etape2(schema, identifiant_table, millesime_precedent, m, prefixe_table, millesime)
    
    @requete_sql
    def _insertion_biens_a_corriger_etape1(self, schema, identifiant_table, millesime_precedent, millesime, prefixe_table, millesime_comparaison):
        pass
    
    @requete_sql
    def _insertion_biens_a_corriger_etape2(self, schema, identifiant_table, millesime_precedent, m, prefixe_table, millesime):
        pass   
    
    @requete_sql
    def _correction_dates(self, schema, prefixe_table, millesime, identifiant_table):
        pass
    
    def ajouter_champs_issus_des_tables_pev_dans_tables_local(self):
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                self._ajouter_champ_ccthp_et_dcapec(schema, millesime)
                self._ajouter_champs_nb_dependances(schema, millesime)
    
    @requete_sql_avec_modification_args
    def _ajouter_champ_ccthp_et_dcapec(self, schema, millesime):        
        self.effacer_table(schema, 'tmp_localff' + millesime +'_avec_ccthp_et_dcapec')
        return schema, 'tmp_localff' + millesime +'_avec_ccthp_et_dcapec', millesime

    @requete_sql_avec_modification_args
    def _ajouter_champs_nb_dependances(self, schema, millesime):        
        self.effacer_table(schema, 'localff' + millesime)
        return schema, 'localff' + millesime, millesime
    
    def nettoyer_schemas(self):
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                self.copier_table(schema, 'tmp_parcelleff{0}_avec_jdatatdvf'.format(millesime), schema, 'parcelleff{0}'.format(millesime))
            self.effacer_tables_commencant_par(schema, 'tmp_')
            self.effacer_tables_commencant_par(schema, 'pev')
    
    '''
    
    FF - CORRECTIONS ET COMPLEMENTS TABLES PROPRIETAIRES
    
    '''
   
    def preparer_tables_departementales_proprietaires(self):
        self.copier_tables_proprietaires()
        self.ajouter_idprocptes_inexistants_dans_tables_proprio()
    
    def copier_tables_proprietaires(self):
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                self.copier_table(schema, 'proprioff' + millesime + 'i', schema, 'proprioff' + millesime)
    
    def ajouter_idprocptes_inexistants_dans_tables_proprio(self):
        for schema in self.schemas_departementaux:
            for millesime in self.millesimesFF:
                idprocptes = self._recuperer_idprocptes_inexistants_dans_millesime(schema, millesime)
                for idprocpte in idprocptes:
                    self._ajouter_un_idprocpte_inexistant_dans_table_proprio(schema, millesime, idprocpte)
                    
    @select_sql_champ_unique
    def _recuperer_idprocptes_inexistants_dans_millesime(self, schema, millesime):
        pass
    
    @requete_sql
    def _ajouter_un_idprocpte_inexistant_dans_table_proprio(self, schema, millesime, idprocpte):
        pass
   
    '''
    
    FF - OUTILS 
    
    '''
    
    def departement(self, schema):
        return schema[len(self.prefixe_schemas_departementaux):].upper()
    
    def _lister_millesimes_anterieurs_et_posterieurs(self, millesime):
        '''
        Renvoie la liste des millesimes antérieurs et postérieurs sous forme de chaines de caractère.
        '''
        return self._millesimes_anterieurs(millesime), self._millesimes_posterieurs(millesime)
    
    def _millesimes_anterieurs(self, millesime):
        '''
        Renvoie la liste des millesimes antérieurs sous forme de chaines de caractère.
        '''
        return [str(m) for m in self._conversion_entiere_millesimes() if m < int(millesime)]
    
    def _millesimes_posterieurs(self, millesime):
        '''
        Renvoie la liste des millesimes posterieurs sous forme de chaines de caractère.
        '''
        return [str(m) for m in self._conversion_entiere_millesimes() if m > int(millesime)]
    
    def _millesime_precedent(self, millesime):
        '''
        Renvoie le millesime précédent sous forme de chaine de caractère, à défaut renvoie "0001"
        '''
        millesimes_anterieurs = [m for m in self._conversion_entiere_millesimes() if m < int(millesime)]
        if millesimes_anterieurs != []:
            return str(max([m for m in self._conversion_entiere_millesimes() if m < int(millesime)]))
        else:
            return '0001'
    
    def _millesime_suivant(self, millesime):
        return str(min([m for m in self._conversion_entiere_millesimes() if m > int(millesime)]))                
        
    def _conversion_entiere_millesimes(self):
        '''
        Renvoie la liste des millésimes sous forme entière
        '''
        return [int(m) for m in self.millesimesFF]    


class DV3F(DVFMere):
    
    START_SCRIPT = '''---
-- SCRIPT DE CREATION DU MODELE DV3F 
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--
--
-- Début d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
---'''

    PREFIXES_TABLE_IDDVF = {'local' : 'idloc', 'parcelle': 'idpar'}
    
    TABLES = ['local_dv3f', 'disposition_parcelle_dv3f', 'mutation_dv3f']

    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, millesimesFF, script ='sorties/script_dv3f.sql'):        
        DVFMere.__init__(self, hote, base, port, utilisateur, motdepasse, departements, script = script)
        self.millesimesFF = millesimesFF
        self.prefixe_schemas_travail = 'croisement_d'
        self.schemas_travail = [self.prefixe_schemas_travail + dep.upper() for dep in self.departements]
        self.creer_fonctions_sql_dv3f()
        
    '''
    
    DV3F - CREATION FONCTIONS SQL
    
    '''
    
    def creer_fonctions_sql_dv3f(self):
        self.creer_fonction_selection_millesime_proche()
        self.creer_fonction_array_sort_unique()
        self.creer_fonction_aggregat_fusion_array()
        self.creer_fonction_structurer_codtyppro()        
    
    @requete_sql
    def creer_fonction_selection_millesime_proche(self):
        pass
    
    @requete_sql
    def creer_fonction_structurer_codtyppro(self):
        pass
    
    '''
    
    DV3F - PREPARATION RAPATRIEMENT FF - DVF POUR LES LOCAUX ET LES PARCELLES
    
    '''
    
    def creer_tables_synthese_ffans_pour_locaux_et_parcelles(self):
        for schema in self.schemas_travail:
            self.creation_sequence_id_tmp_acheteurs_vendeurs(schema)
            for prefixe_table, identifiant_table_dvf in self.PREFIXES_TABLE_IDDVF.items():
                self.creation_table_croisee_ff_dvf(schema, prefixe_table, self.idff(identifiant_table_dvf), identifiant_table_dvf)
                self.creation_table_synthese_ffans(schema, prefixe_table, identifiant_table_dvf)    
    
    @requete_sql_avec_modification_args
    def creation_table_croisee_ff_dvf(self, schema, prefixe_table, identifiant_table_ff, identifiant_table_dvf):
        self.effacer_table(schema, prefixe_table + '_dvf_ff_par_date_mutation')
        condition_parcelle = 'WHERE parcvendue = TRUE' if prefixe_table == 'parcelle' else ''
                
        union_millesimeFF = ' UNION ALL '.join(                                               
            [self.requete_sql['_SOUS_REQUETE_TABLE_CROISEE_FF_DVF'].format(schema, prefixe_table, 
                       identifiant_table_dvf, 
                       identifiant_table_ff, 
                       condition_parcelle, mill, 
                       self.prefixe_schemas_departementaux + self.departement_travail(schema), 
                       self.table_dvf(prefixe_table)) 
             for mill in self.millesimesFF]
                                               )
                
        return schema, prefixe_table, identifiant_table_dvf, identifiant_table_ff, condition_parcelle, union_millesimeFF, self.prefixe_schemas_departementaux + self.departement_travail(schema), self.table_dvf(prefixe_table)
    
    def creation_sequence_id_tmp_acheteurs_vendeurs(self, schema):
        self.effacer_et_creer_sequence(schema, 'idach_idvend_seq')
    
    @requete_sql_avec_modification_args
    def creation_table_synthese_ffans(self, schema, prefixe_table, identifiant_table_dvf):
        condition_parcelle = 't4.idsec IS NOT NULL AND ' if prefixe_table == 'parcelle' else ''
        jointure_parcelle = self.requete_sql['_SOUS_REQUETE_TABLE_SYNTHESE_FFANS_JOINTURE_PARCELLE'].format(schema) if prefixe_table == 'parcelle' else ''
        self.effacer_table(schema, prefixe_table + '_synthese_ffans')
        return schema, prefixe_table, identifiant_table_dvf, condition_parcelle, jointure_parcelle
    
    '''
    
    DV3F - CREATION DES TABLES ACHETEUR_VENDEUR
    
    '''
   
    def creer_tables_acheteur_vendeur(self):
        self.creation_sequence_identifiant_table_acheteur_vendeur()
        self.creation_sequence_identifiants_groupes_acheteurs_vendeurs()
        for schema in self.schemas_travail:
            self.creation_table_temporaire_droits_ach_vend(schema)            
            self.ajout_identite_groupes_ach_vend(schema)
            self.creation_table_acheteur_vendeur_departementale(schema)
   
    def creation_sequence_identifiant_table_acheteur_vendeur(self):
        self.effacer_et_creer_sequence('public', 'ida_idv_seq')
    
    @requete_sql_avec_modification_args
    def creation_table_temporaire_droits_ach_vend(self, schema):
        sous_requete_local = ' UNION ALL '.join([self.requete_sql['_SOUS_REQUETE_TABLE_TEMPORAIRE_ACH_VEND'].format(schema, 'local', m) for m in self.millesimesFF])
        sous_requete_parcelle = ' UNION ALL '.join([self.requete_sql['_SOUS_REQUETE_TABLE_TEMPORAIRE_ACH_VEND'].format(schema, 'parcelle', m) for m in self.millesimesFF])
        self.effacer_table(schema, 'tmp_achvend')
        return schema, sous_requete_local, sous_requete_parcelle
    
    def creation_sequence_identifiants_groupes_acheteurs_vendeurs(self):
        self.effacer_et_creer_sequence('public', 'groupe_seq')
    
    @requete_sql_avec_modification_args
    def ajout_identite_groupes_ach_vend(self, schema):        
        self.effacer_table(schema, 'tmp_achvend_groupe')
        return (schema,)
    
    @requete_sql_avec_modification_args    
    def creation_table_acheteur_vendeur_departementale(self, schema):
        self.effacer_table(schema, 'acheteur_vendeur')
        sous_requete = ' UNION ALL '.join(                                               
            [self.requete_sql['_SOUS_REQUETE_VENDEUR_LOCAL_NEUF_APPARU'].format(schema, mill) for mill in self.millesimesFF])
        return schema, self.prefixe_schemas_departementaux + self.departement_travail(schema), sous_requete
    
    
    '''
    
    DV3F - CREATION DES TABLES DE SYNTHESE ACHETEURS-VENDEURS POUR LES PARCELLES ET LES LOCAUX
    
    '''    
    
    def creer_tables_synthese_acheteurs_vendeurs_pour_locaux_et_parcelles(self):
        for schema in self.schemas_travail:
            for prefixe_table, identifiant_table in self.PREFIXES_TABLE_IDDVF.items():
                self.creation_table_synthese_ach_vend(schema, prefixe_table, identifiant_table)
                self.integration_donnees_gestionnaire(schema, prefixe_table)
    
    
    @requete_sql_avec_modification_args
    def creation_table_synthese_ach_vend(self, schema, prefixe_table, identifiant_table):        
        self.effacer_table(schema, 'tmp_{0}_synthese_achvend'.format(prefixe_table))
        return schema, prefixe_table, identifiant_table
    
    def integration_donnees_gestionnaire(self, schema, prefixe_table):
        self._integration_donnees_gestionnaire_vendeur(schema, prefixe_table)
        self._integration_donnees_gestionnaire_acheteur(schema, prefixe_table)
        self.effacer_table(schema, 'tmp_{0}_synthese_achvend_gesv'.format(prefixe_table))
    
    @requete_sql_avec_modification_args
    def _integration_donnees_gestionnaire_vendeur(self, schema, prefixe_table):        
        variable_local = ', NULL as ffoccv' if prefixe_table == 'local' else ''        
        sous_requete = ' UNION ALL '.join([self._sous_requete_rapatriement_gestionnaire_vendeurs(schema, prefixe_table, m) for m in self.millesimesFF])
        self.effacer_table(schema, 'tmp_{0}_synthese_achvend_gesv'.format(prefixe_table))
        return schema, prefixe_table, sous_requete, variable_local        
        
    @requete_sql_avec_modification_args
    def _integration_donnees_gestionnaire_acheteur(self, schema, prefixe_table):        
        variable_local = ', NULL as ffocca' if prefixe_table == 'local' else ''        
        sous_requete = ' UNION ALL '.join([self._sous_requete_rapatriement_gestionnaire_acheteurs(schema, prefixe_table, m) for m in self.millesimesFF])
        self.effacer_table(schema, 'tmp_{0}_synthese_achvend_ges'.format(prefixe_table))
        return schema, prefixe_table, sous_requete, variable_local
    
    def _sous_requete_rapatriement_gestionnaire_vendeurs(self, schema, prefixe_table, millesime):        
        variable_local = ', ccthp_recalcule AS ffoccv' if prefixe_table == 'local' else ''
        jointure_local = 'LEFT JOIN {0}.localff{1} tl ON t.idloc = tl.idlocal'.format(schema, millesime) if prefixe_table == 'local' else ''      
        sql = self.requete_sql['_SOUS_REQUETE_RAPATRIEMENT_GESTIONNAIRE_VENDEURS'].format(schema, prefixe_table, millesime, variable_local, jointure_local)
        return sql
    
    def _sous_requete_rapatriement_gestionnaire_acheteurs(self, schema, prefixe_table, millesime):
        
        variable_local = ', ccthp_recalcule AS ffocca' if prefixe_table == 'local' else ''
        jointure_local = 'LEFT JOIN {0}.localff{1} tl ON t.idloc = tl.idlocal'.format(schema, millesime) if prefixe_table == 'local' else ''
        sql = self.requete_sql['_SOUS_REQUETE_RAPATRIEMENT_GESTIONNAIRE_ACHETEURS'].format(schema, prefixe_table, millesime,  variable_local, jointure_local)
        return sql
    
    
    '''
    
    DV3F - CREATION DES TABLES DE SYNTHESE DES CARACTERISTIQUES DES LOCAUX
    
    '''    
    
    def creer_tables_synthese_caracteristiques_locaux(self):
        for schema in self.schemas_travail:
            self.creation_table_synthese_local(schema)
    
    @requete_sql_avec_modification_args
    def creation_table_synthese_local(self, schema):
        
        sous_requete = ' UNION ALL '.join([
                                           self.requete_sql['_SOUS_REQUETE_RAPATRIEMENT_LOCAUX']
                                           .format(schema, self._formatter_variables_FF_locaux_a_integrer(m), m) 
                                           for m in self.millesimesFF
                                           ])
        
        self.effacer_table(schema, 'tmp_local_synthese_caracteristique')
        return schema, sous_requete
    
    def _formatter_variables_FF_locaux_a_integrer(self, millesime):
        m = int(millesime)
        v = {}
        v['ffidbat'] = 'idbat'                           
        v['ffcodinsee'] = 'idcom'
        v['ffcommune'] = 'idcomtxt'
        v['ffnovoie'] = 'dnvoiri'
        v['ffbtq'] = 'dindic'
        v['ffvoie'] = 'dvoilib'
        v['fftyppdl'] = "'-----'" if m < 2012 else 'ctpdl'
        v['ffclascad'] = 'dcapec_recalcule'
        v['ffvalloc'] = 'dvltrt'
        v['ffcodeval'] = 'ccoeva'
        v['fflibeval'] = 'ccoevatxt'
        v['ffcchgeval'] = "'--'" if m < 2013 else 'dnatcg'
        v['ffdchgeval'] = "NULL::DATE" if m < 2013 else 'convertir_date(correction_jdatat(jdatcgl::VARCHAR))'
        v['stabilitel'] = 'stabilite'
        v['ffctyploc'] = 'dteloc'
        v['ffltyploc'] = 'dteloctxt'
        v['ffcnatloc'] = 'cconlc'
        v['fflnatloc'] = 'cconlctxt'
        v['ffcodnace'] = 'ccoape' if m < 2011 else 'cconac'
        v['fflibnace'] = 'ccoapetxt' if m < 2011 else 'cconactxt'
        v['fflochab'] = "CASE WHEN npevaffh = 1 THEN TRUE ELSE FALSE END" if m < 2014 else "CASE WHEN habitat = 1 THEN TRUE ELSE FALSE END"
        v['ffshab'] = 'stoth'
        v['ffsdep'] = 'stotdsueic + stotd'
        v['ffspro'] = 'stotp'
        v['ffsbati'] = 'spevtot'
        v['ffnbpsam'] = 'dnbsam_recalcule::INTEGER'
        v['ffnbpcha'] = 'dnbcha_recalcule::INTEGER'
        v['ffnbpcu8'] = 'dnbcu8_recalcule::INTEGER'
        v['ffnbpcu9'] = 'dnbcu9_recalcule::INTEGER'
        v['ffnbpsea'] = 'dnbsea_recalcule::INTEGER'
        v['ffnbpann'] = 'dnbann_recalcule::INTEGER'
        v['ffnbpprinc'] = 'dnbsam_recalcule::INTEGER + dnbcha_recalcule::INTEGER'
        v['ffnbpgarag'] = 'nbgarpark_recalcule::INTEGER'
        v['ffnbpagrem'] = 'nbagrement_recalcule::INTEGER'
        v['ffnbpterra'] = 'nbterrasse_recalcule::INTEGER'
        v['ffnbppisci'] = 'nbpiscine_recalcule::INTEGER'
        v['ffnbpcav'] = 'nbannexe_recalcule::INTEGER'
        v['geomloc'] = 'geomloc'
        v['srcgeom'] = 'source_geo'
        v['parcvect'] = 'vecteur'        
        return ', '.join([ff +' AS ' + dvf for dvf, ff in v.items()])
    
    
    '''
    
    DV3F - CREATION DES TABLES DE SYNTHESE DES CARACTERISTIQUES DES PARCELLES
    
    '''    
    
    def creer_tables_synthese_caracteristiques_parcelles(self):
        for schema in self.schemas_travail:
            self.creation_table_synthese_parcelle(schema)
    
    @requete_sql_avec_modification_args
    def creation_table_synthese_parcelle(self, schema):        
        sous_requete = ' UNION ALL '.join([
                                           self.requete_sql['_SOUS_REQUETE_RAPATRIEMENT_PARCELLES']
                                           .format(schema, self._formatter_variables_FF_parcelles_a_integrer(m), m) 
                                           for m in self.millesimesFF
                                           ])
        
        self.effacer_table(schema, 'tmp_parcelle_synthese_caracteristique')
        return schema, sous_requete

    def _formatter_variables_FF_parcelles_a_integrer(self, millesime):
        m = int(millesime)
        v = {}
        v['stabilitep'] = 'stabilite'                
        v['ffcodinsee'] = 'idcom'
        v['ffcommune'] = 'idcomtxt'
        v['ffnovoie'] = 'dnvoiri' if m < 2014 else 'dnuvoi'
        v['ffbtq'] = 'dindic'
        v['ffvoie'] = "'---'" if m < 2012 else 'dvoilib'
        v['fftyppdl'] = "'-----'" if m < 2012 else 'ctpdl'
        v['ffsparc'] = 'dcntpa'
        v['ffsterr'] = 'ssuf'
        v['ffdcnt01'] = 'dcnt01'
        v['ffdcnt02'] = 'dcnt02'
        v['ffdcnt03'] = 'dcnt03'
        v['ffdcnt04'] = 'dcnt04'
        v['ffdcnt05'] = 'dcntbois'
        v['ffdcnt06'] = 'dcnt06'
        v['ffdcnt07'] = 'dcnt07'
        v['ffdcnt08'] = 'dcnteau'
        v['ffdcnt09'] = 'dcnt09'
        v['ffdcnt10'] = 'dcnt10'
        v['ffdcnt11'] = 'dcnt11'
        v['ffdcnt12'] = 'dcnt12'
        v['ffdcnt13'] = 'dcnt13'
        v['ffdcntsol'] = 'dcntsol'
        v['ffdcntagri'] = 'dcntagri'
        v['ffdcntnat'] = 'dcntnat'
        v['ffparcbati'] = 'CASE WHEN nlocal > 0 THEN TRUE ELSE FALSE END'
        v['geomloc'] = 'geomloc'
        v['geompar'] = 'geompar'
        v['srcgeom'] = 'source_geo'        
        v['parcvect'] = 'vecteur'        
        return ', '.join([ff +' AS ' + dvf for dvf, ff in v.items()])
    
    
    '''
    
    DV3F - CREATION DES TABLES DV3F
    
    '''
    
    def creer_tables_dv3f(self, recreer_tables_principales = True):
        self.creation_tables_dv3f(recreer_tables_principales)
        for schema in self.schemas_departementaux:
            self.insertion_donnees_local_dv3f(schema)
            self.insertion_donnees_parcelle_dv3f(schema)
            self.creation_table_calcul_parcelle_idmutation(schema)
            self.creation_table_calcul_local_idmutation(schema)
            self.creation_table_calcul_geompar_idmutation(schema)
            self.insertion_donnees_mutation_dv3f(schema)
            self.effacer_tables_commencant_par(schema, 'tmp')
    
    def creation_tables_dv3f(self, recreer_tables_principales):
        if recreer_tables_principales:
            self.creer_tables_principales_vides(self.TABLES, 3)
        self.creer_tables_departementales_vides(self.TABLES, 3)       

    @requete_sql_avec_modification_args
    def insertion_donnees_local_dv3f(self, schema):        
        liste_variable = [var.nom for var in self.gestionnaire.table('local').variables]        
        return schema, ', '.join(liste_variable), self.prefixe_schemas_travail + self.departement_dvf(schema)
    
    @requete_sql_avec_modification_args
    def insertion_donnees_parcelle_dv3f(self, schema):
        liste_variable = [var.nom for var in self.gestionnaire.table('disposition_parcelle').variables]        
        return schema, ', '.join(liste_variable), self.prefixe_schemas_travail + self.departement_dvf(schema)
    
    @requete_sql_avec_modification_args
    def creation_table_calcul_parcelle_idmutation(self, schema):        
        self.effacer_table(schema, 'tmp_calcul_parcelle_idmutation')      
        return (schema,)
    
    @requete_sql_avec_modification_args
    def creation_table_calcul_local_idmutation(self, schema):        
        self.effacer_table(schema, 'tmp_calcul_local_idmutation')      
        return (schema,)
    
    @requete_sql_avec_modification_args
    def creation_table_calcul_geompar_idmutation(self, schema):
        self.effacer_table(schema, 'tmp_calcul_geompar_idmutation')
        return schema, self.prefixe_schemas_travail + self.departement_dvf(schema)
    
    @requete_sql_avec_modification_args
    def insertion_donnees_mutation_dv3f(self, schema):        
        liste_variable = [var.nom for var in self.gestionnaire.table('mutation').variables]        
        return schema, ', '.join(liste_variable)
    
    
    '''
    
    DV3F - OUTILS
    
    '''
   
    def table_dvf(self, prefixe_table):
        if prefixe_table == 'local':
            return 'local'
        elif prefixe_table == 'parcelle':
            return 'disposition_parcelle'
    
    def idff(self, iddvf):
        return iddvf if iddvf == 'idpar' else 'idlocal'
    
    def departement_travail(self, schema):
        return schema[len(self.prefixe_schemas_travail):].upper()
    
    def departement_dvf(self, schema):
        return schema[len(self.prefixe_schemas_departementaux):].upper()

# eof
