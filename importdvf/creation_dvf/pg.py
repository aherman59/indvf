'''
@author: antoine.herman
'''

import psycopg2
import csv
import os
import sys
from datetime import datetime


'''

DECORATEURS

'''

def requete_sql(fonction):    
    def interne(self, *args, **kwargs):        
        requete = self.requete_sql[fonction.__name__.upper()].format(*args)
        reussite, nb = self.execution_et_ecriture_script(requete)
        return reussite, nb
    return interne

def requete_sql_avec_modification_args(fonction):    
    def interne(self, *args, **kwargs):
        args = fonction(self, *args, **kwargs)        
        requete = self.requete_sql[fonction.__name__.upper()].format(*args)
        reussite, nb = self.execution_et_ecriture_script(requete)
        return reussite, nb
    return interne

def select_sql(fonction):    
    def interne(self, *args, **kwargs):
        requete = self.requete_sql[fonction.__name__.upper()].format(*args)
        resultat = self.execution_et_recuperation(requete)
        return resultat
    return interne

def select_sql_champ_unique(fonction):    
    def interne(self, *args, **kwargs):
        requete = self.requete_sql[fonction.__name__.upper()].format(*args)
        resultat = self.execution_et_recuperation(requete)
        return [r[0] for r in resultat] 
    return interne

def select_sql_valeur_unique(fonction):    
    def interne(self, *args, **kwargs):
        requete = self.requete_sql[fonction.__name__.upper()].format(*args)
        resultat = self.execution_et_recuperation(requete)
        return resultat[0][0] 
    return interne

'''

CLASSES

'''


class PgOutils():
    '''
    Classe permettant de réaliser des opérations simples sous une base de données PostgreSQL
    '''
    
    START_SCRIPT = '''
--
-- Début d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
--

'''

    END_SCRIPT = '''
--
-- Fin d'exécution le {0:%d}/{0:%m}/{0:%Y} à {0:%H}:{0:%M}:{0:%S}
--

'''


    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        '''
        Constructeur
        Se connecte directement à la base de données
        Toutes les requêtes exécutées à partir de l'objet instancié sont écrites dans le fichier script.
        '''
        self.pgconn = PgConn(hote, base, port, utilisateur, motdepasse)
        self.script = script
        
        self.requete_sql = {}
        for classe in self.__class__.__mro__:
            try:
                repertoire_module = os.path.dirname(os.path.abspath(__file__))
                self.charger_requete_sql_depuis(os.path.join(repertoire_module, classe.__name__.lower() + '.sql'))
            except (OSError, IOError) as e:
                print(e)
    
    def charger_requete_sql_depuis(self, fichier):
        with open(fichier, 'rt', encoding = 'UTF-8') as f:
            lignes = f.readlines()
            clef = None
            for ligne in lignes:
                if ligne.strip().startswith('##'):
                    clef = ligne.strip()[2:].strip()
                    self.requete_sql[clef] = ''
                    continue
                self.requete_sql[clef] = self.requete_sql[clef] + ligne
    
    def deconnecter(self):
        '''
        Déconnexion de l'objet à la base de données        '''
        self.pgconn.deconnection_postgres()
        
    def execution(self, sql, max_tentative = 3):
        '''
        Se connecte
        Tente l'execution d'une requete sql (3 fois par défaut)
        Se déconnecte
        Renvoie True si la requete a réussi ainsi que le nombre de lignes modifiées ou renvoyées en fonction du type de requête
        '''
        reussite = False
        nb_lignes_modifiees = -1 
        tentative = 1
        while(tentative <= max_tentative and not reussite):
            try:
                nb_lignes_modifiees = self.pgconn.execute_commit(sql)                
                print(sql)                
                reussite = True                
            except Exception as e:
                print(e)
                print('Tentative ' + str(tentative) + ' échouée...')                
                if tentative == max_tentative:
                    sys.exit('FIN PREMATUREE - TRAITEMENT NON ABOUTI')
                tentative += 1
        return reussite, nb_lignes_modifiees
    
    def execution_et_recuperation(self, sql, max_tentative = 3):
        '''
        Se connecte
        Tente l'execution d'une requete sql (3 fois par défaut)
        Se déconnecte
        Renvoie le résultat de la requete sous forme d'une liste de tuple
        '''
        reussite = False
        nb_lignes_modifiees = -1 
        tentative = 1
        while(tentative <= max_tentative and not reussite):
            try:
                resultat = self.pgconn.execute_recupere(sql)                
                print(sql)                
                reussite = True                
            except Exception as e:
                print(e)
                print('Tentative ' + str(tentative) + ' échouée...')
                if tentative == max_tentative:
                    sys.exit('FIN PREMATUREE - TRAITEMENT NON ABOUTI')
                tentative += 1
        return resultat
        
    def execution_et_ecriture_script(self, sql, max_tentative = 3):
        '''
        Se connecte
        Tente l'execution d'une requete sql (3 fois par défaut)
        Se déconnecte
        Ecrit la requete correspondante dans le fichier script défini
        Renvoie True si la requete a réussi ainsi que le nombre de lignes modifiées ou renvoyées en fonction du type de requête
        '''
        reussite = False
        nb_lignes_modifiees = -1 
        tentative = 1
        while(tentative <= max_tentative and not reussite):
            try:
                nb_lignes_modifiees = self.pgconn.execute_commit(sql)
                self.redaction_script(self.script, sql, False)
                print(sql)                
                reussite = True                
            except Exception as e:
                print(e)
                print('Tentative ' + str(tentative) + ' échouée...')
                if tentative == max_tentative:
                    sys.exit('FIN PREMATUREE - TRAITEMENT NON ABOUTI')
                tentative += 1
        return reussite, nb_lignes_modifiees
    
    def redaction_script(self, file, sql, effacement):
        '''
        Ecrit la requête sql dans le fichier défini.
        Efface le contenu du fichier si effacement est à True
        '''
        mode = 'w' if effacement else 'a'
        try:
            with open(file, mode, encoding = 'utf-8') as f:
                f.write(sql)
        except (IOError, OSError) as e:
            pass
    
    def start_script(self):
        '''
        Ecrit le début d'exécution du script.
        '''
        self.redaction_script(self.script, self.START_SCRIPT.format(datetime.now()), True)
    
    def end_script(self):
        '''
        Ecrit la fin d'exécution du script.
        '''
        self.redaction_script(self.script, self.END_SCRIPT.format(datetime.now()), False)
    
    
    @requete_sql    
    def effacer_schema(self, schema):
        '''
        Supprime le schéma de la base de données s'il existe en CASCADE.
        '''
        pass
    
    def effacer_schemas(self, schemas):        
        '''
        Supprime les schemas de la base de données en CASCADE.             
        '''        
        for schema in schemas:
            self.effacer_schema(schema)
    
    def effacer_schemas_commencant_par(self, prefixe):
        '''
        Supprime les schemas commencant par le préfixe spécifié de la base de données en CASCADE.
        '''
        schemas = self.lister_schemas_commencant_par(prefixe)
        self.effacer_schemas(schemas)
    
    @requete_sql
    def creer_schema(self, schema):
        '''
        Crée le schéma.
        '''
        pass
    
    @requete_sql
    def creer_schema_si_inexistant(self, schema):
        '''
        Crée le schema s'il n'existe pas
        '''
        pass
    
    def effacer_et_creer_schema(self, schema):
        '''
        Supprime le schéma s'il existe et le recrée.
        '''
        reussite, nb = self.effacer_schema(schema)
        if reussite:
            self.creer_schema(schema)
    
    def effacer_et_creer_schemas(self, schemas):
        '''
        Supprime et recrée les schémas.
        '''
        for schema in schemas:
            self.effacer_et_creer_schema(schema)
    
    @requete_sql
    def effacer_et_creer_sequence(self, schema, sequence):
        '''
        Supprime la séquence si elle existe et la recrée.
        '''
        pass
    
    @requete_sql
    def effacer_table(self, schema, table):
        '''
        Supprime la table dans le schéma si elle existe.
        '''
        pass    
    
    def effacer_tables(self, schema, tables):
        '''
        Supprime les tables listées du schéma.
        '''
        for table in tables:
            self.effacer_table(schema, table)            
    
    def effacer_tables_commencant_par(self, schema, prefixe):
        '''
        Supprime les tables du schéma commençant par le prefixe specifié.
        '''
        tables = self.lister_tables_commencant_par(schema, prefixe)
        self.effacer_tables(schema, tables)
    
    @requete_sql
    def renommer_table(self, schema, table, nveau_nom_table):
        pass
    
    @select_sql_champ_unique
    def lister_schemas(self):
        '''
        Renvoie, sous forme de liste, l'ensemble des schémas de la base de données
        '''
        pass
    
    @select_sql_champ_unique
    def lister_schemas_commencant_par(self, prefixe):
        '''
        Renvoie, sous forme de liste, les schémas de la base de données commençant par le préfixe défini
        '''
        pass
    
    @select_sql_champ_unique
    def lister_tables(self, schema):
        '''
        Renvoie, sous forme de liste, les noms des tables du schéma
        '''
        pass
    
    @select_sql_champ_unique
    def lister_tables_commencant_par(self, schema, prefixe):
        '''
        Renvoie, sous forme de liste, les noms des tables du schéma commençant par le préfixe défini
        '''
        pass
    
    @select_sql
    def lister_champs(self, schema, table):
        '''
        Renvoie la liste des champs présents dans la table sous forme de tuples (position, nom, type_de_variable)
        '''
        pass
    
    @requete_sql_avec_modification_args
    def ajouter_clef_primaire(self, schema, table, champs):
        '''
        Ajoute une clef primaire à la table composée de l'ensemble des champs présents dans la liste.
        '''
        return schema, table, ', '.join(champs)
    
    @requete_sql_avec_modification_args
    def ajouter_contrainte_unicite(self, schema, table, champs):
        '''
        Ajoute une contrainte d'unicité à la table composée de l'ensemble des champs présents dans la liste.
        '''
        return schema, table, ', '.join(champs)

    @requete_sql
    def ajouter_contrainte_check(self, schema, table, expression):
        '''
        Ajoute une contrainte de type check à la table avec l'expression définie.
        '''
        pass
    
    @requete_sql_avec_modification_args
    def ajouter_commentaire_sur_champ(self, schema, table, champ, commentaire):
        '''
        Ajout un commentaire au champ de la table.
        Renvoie True si le commentaire a bien été créé.
        '''
        return schema, table, champ, commentaire.replace('\'', '\'\'')
    
    @requete_sql_avec_modification_args
    def ajouter_commentaire_sur_table(self, schema, table, commentaire):
        '''
        Ajout un commentaire à la table.
        Renvoie True si le commentaire a bien été créé.
        '''
        return schema, table, commentaire.replace('\'', '\'\'')
    
    @requete_sql
    def copier_table(self, schema_initial, table_initiale, schema_final, table_finale):
        '''
        Copie les données d'une table initiale dans une nouvelle table.
        Supprime la table de destination si celle-ci existe déjà.
        Renvoie True si le commentaire a bien été créé.
        '''
        pass
    
    @select_sql_valeur_unique
    def compter(self, schema, table):
        '''
        Compter le nombre de ligne de la table
        '''
        pass
    
    @requete_sql
    def creer_extension_fdw(self):
        '''
        Crée l'extension fdw de postgresql
        '''
        pass
    
    @requete_sql
    def creer_serveur_distant_fdw(self, hote_distant, base_distante, port, nom_serveur_distant):
        '''
        Crée un serveur distant pour le foreign data wrapper
        '''
        pass
    
    @requete_sql
    def creer_user_mapping_pour_serveur_distant_fdw(self, utilisateur, nom_serveur_distant, motdepasse):
        '''
        Créer un user mapping pour le serveur distant
        '''
        pass
    
    def mettre_en_place_serveur_distant_fdw(self, hote_distant, base_distante, port, utilisateur, motdepasse, nom_serveur_distant):
        '''
        Prépare un serveur distant fdw et crée un user mapping associé.
        '''
        self.creer_extension_fdw()
        self.creer_serveur_distant_fdw(hote_distant, base_distante, port, nom_serveur_distant) 
        self.creer_user_mapping_pour_serveur_distant_fdw(utilisateur, nom_serveur_distant, motdepasse)
    
    @requete_sql
    def effacer_table_etrangere(self, schema, table):
        pass
    
    @requete_sql_avec_modification_args
    def creer_table_etrangere(self, schema, table, schema_distant, table_distante, champs, nom_serveur):
        '''
        Efface pui crée une table étrangère à partir de la table distante
        la variable champ doit avoir le formalisme prévue par le renvoi de la méthode lister_champs()
        '''
        self.effacer_table_etrangere(schema, table)
        champs_format = ',\n'.join([c[1] + ' ' + c[2] for c in champs])
        return schema, table, schema_distant, table_distante, champs_format, nom_serveur
    
    def copier_table_distante(self, hote_distant, base_distante, port, utilisateur, motdepasse, schema_initial, table_initiale, schema_final, table_finale):
        '''
        Copie une table d'une base de données distante dans la base locale
        '''
        self.mettre_en_place_serveur_distant_fdw(hote_distant, base_distante, port, utilisateur, motdepasse, 'serveur_tmp')
        pgoutils_distant = PgOutils(hote_distant, base_distante, port, utilisateur, motdepasse, self.script)
        champs = pgoutils_distant.lister_champs(schema_initial, table_initiale)
        self.creer_table_etrangere(schema_final, table_finale + '_fdw', schema_initial, table_initiale, champs, 'serveur_tmp') 
        self.copier_table(schema_final, table_finale + '_fdw', schema_final, table_finale)
        self.effacer_table_etrangere(schema_final, table_finale + '_fdw') 
    
    @requete_sql
    def creer_fonction_array_supprimer_null(self):
        pass
    
    @requete_sql
    def creer_fonction_pgcd(self):
        pass
    
    @requete_sql
    def creer_fonction_convertir_date(self):
        pass

    @requete_sql
    def creer_fonction_aggregat_fusion_array(self):
        pass
    
    @requete_sql
    def creer_fonction_array_sort_unique(self):
        pass

class PgConn():
    '''
    Classe permettant de se connecter à une base Postgresql, à y effectuer des requêtes et à y importer des fichiers csv
    '''

    def __init__(self, hote, base, port, utilisateur, motdepasse, connection_directe = True):
        '''
        Constructeur qui prend les paramètres de connexion suivant:
        - hote
        - base
        - utilisateur
        - motdepasse
        
        Par défaut, se connecte directement à la base. Pour ne pas se connecter directement, mettre connection_directe à False.
        '''
        self.connection = None        
        
        self.conn_actif = False
        
        self.hote = hote
        self.base = base
        self.utilisateur = utilisateur
        self.motdepasse = motdepasse
        self.port = port
        if connection_directe:
            self.connection_postgres()     
        
            
    def connection_postgres(self, client_encoding = 'UTF-8'):
        '''
        Connexion à la base PostgreSQL via les paramètres définis lors de la création de l'instance de la classe.
        
        L'encodage du client est considéré par défaut comme du UTF-8. Il peut etre modifier par l'argument client_encoding.        
        
        ''' 
        try:  
            self.connection = psycopg2.connect(host=self.hote, database=self.base, user=self.utilisateur, password=self.motdepasse, port=self.port)
            self.connection.set_client_encoding(client_encoding)            
            self.conn_actif = True            
        except Exception:
            print('Connexion impossible')
            self.conn_actif = False

        
    def deconnection_postgres(self):
        '''
        Deconnexion de la base PostgreSQL si la connexion était établie
        '''
        try:            
            self.connection.close()
            self.conn_actif = False
        except:
            pass
        

    def execute_commit(self, sql):
        '''
        Execute la requete sql et la soumet au serveur, 
        Renvoie également le nombre de lignes modifiés en fonction du type de requete.
        '''
        nb_ligne_affectee = -1
        if not self.conn_actif:
            self.connection_postgres()
        with self.connection.cursor() as curseur: 
            curseur.execute(sql)
            nb_ligne_affectee = curseur.rowcount            
        self.connection.commit()
        return nb_ligne_affectee
    
    
    def execute_recupere(self, sql):
        '''
        Execute la requete sql (SELECT) et renvoie le resultat dans une liste de tuple
        '''
        if not self.conn_actif:
            self.connection_postgres()
        with self.connection.cursor() as curseur:
            curseur.execute(sql)        
            return curseur.fetchall()
    
    def execute_recupere_en_tableau_html(self, sql, entete = None):
        '''
        Execute la requete sql (SELECT) et renvoie le resultat sous forme d'un tableau écrit en html
        
        - entete : liste des intitulés des champs qui seront intégré en tete du tableau (balises <th> ).
        '''
        lignes = self.execute_recupere(sql)
        tableau_html = '<table>\n'
        
        if entete:
                tableau_html += '\t<tr>\n'
                for nom_champ in entete:                
                    tableau_html += '\t\t<th>' + str(nom_champ) + '</th>\n'
                tableau_html += '\t</tr>\n'
        
        for ligne in lignes:
            tableau_html += '\t<tr>\n'            
            for elt in ligne:
                tableau_html += '\t\t<td>' + str(elt) + '</td>\n'
            tableau_html += '\t</tr>\n'
        
        tableau_html += '</table>'
        
        return tableau_html 

    def copy_from_csv(self, fichier_csv, separateur, table, entete):
        
        """
            Copie le fichier csv encodé en UTF-8 dans la table définie de la PostgreSQL.
            
            Si entete est à True, la première ligne sera ignorée.
            
        """ 
        lignes = self._lire_lignes_csv(fichier_csv, separateur)
        self._ecrire_lignes_dans_csv(lignes, 'tmp', entete)
        
        if not self.conn_actif:
            self.connection_postgres()
        
        with open('tmp','r',encoding = 'utf-8') as donnees:
            with self.connection.cursor() as curseur:
                curseur.copy_from(donnees, table, separateur, '')            
            self.connection.commit()
        
        if os.path.exists('tmp'):
            os.remove('tmp')                  


    def _lire_lignes_csv(self, fichier_csv, separateur):
        """ Générateur qui renvoie les lignes d'un fichier csv encodé en UTF-8"""
        with open(fichier_csv, 'r', encoding = 'utf-8') as f:
            for ligne in f:
                yield ligne
                
    def _ecrire_lignes_dans_csv(self, lignes, fichier_sortie, entete):
        ''' Ecriture en UTF-8 dans le fichier de sortie des lignes en omettant l'entete si sa valeur est à True'''
        with open(fichier_sortie, 'wt', encoding = 'utf-8') as f:
            if entete:
                next(lignes)
            for ligne in lignes:
                print(ligne, end='', file=f)

#eof
    
