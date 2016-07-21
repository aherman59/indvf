'''
 @author: antoine.herman
'''
import urllib.request
import json
from collections import namedtuple
from pg.pgbasics import * 

class Cadastre(PgOutils):
    
    URL = 'https://cadastre.api.gouv.fr/commune/'
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script = 'sorties/cadastre.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.url_commune = self.URL + '{0}'
        self.url_parcelle = self.URL + '{0}?{1}'
               
    @requete_sql
    def creer_table_parcelles_si_inexistante(self, schema, table):
        '''
        Crée le schéma s'il n'existe pas puis crée la table si elle n'existe pas
        '''
        pass
    
    @requete_sql
    def effacer_contrainte_clef_primaire_si_existante(self, schema, table, nom_contrainte):
        '''
        Efface la contrainte si elle existe
        '''
        pass

    @select_sql_champ_unique
    def lister_idpar_existants(self, schema, table, code_insee):
        pass
    
    def inserer_parcelles_communales(self, code_insee, schema, table, nouvelles_uniquement=True):
        '''
        Insère les parcelles récupérées pour la commune dans la table spécifiée
        
        Si nouvelles_uniquement est True, seules les parcelles n'ayant pas 
        un idpar existant dans la table sont intégrées. Sinon, elles sont toutes intégrées.
                
        Renvoie True et un message de réussite si la requete a abouti
        Renvoie False et le message d'erreur associé dans le cas inverse
        '''
        reussite, parcelles = self.recuperer_parcelles(code_insee)
        if nouvelles_uniquement:
            parcelles_existantes = self.lister_idpar_existants(schema, table, code_insee)
            parcelles = [parcelle for parcelle in parcelles if parcelle.idpar not in parcelles_existantes]
        if len(parcelles) > 0:
            valeurs_sql = [self.creer_valeurs_sql(parcelle) for parcelle in parcelles]
            reussite, nb = self.inserer_multi_parcelles(schema, table, valeurs_sql)
            if reussite:
                return True, str(len(parcelles)) + ' parcelles insérées pour commune ' + code_insee
            else:
                return False, 'Impossible d\'insérer les parcelles pour commune ' + code_insee
        else:
            if reussite:
                return True, 'Pas de parcelles récupérées pour commune ' + code_insee + ' ou parcelles déjà existantes.'
            else:
                return False, 'Problème requêtage ou code INSEE incorrect'
    
    def inserer_parcelle(self, code_insee, section, numero, schema, table, nouvelles_uniquement=True):
        reussite, parcelle = self.recuperer_parcelle(code_insee, section, numero)
        if nouvelles_uniquement:
            parcelles_existantes = self.lister_idpar_existants(schema, table, code_insee)
            parcelle = parcelle if parcelle.idpar not in parcelles_existantes else None
        if parcelle:
            valeurs_sql = [self.creer_valeurs_sql(parcelle)]
            reussite, nb = self.inserer_multi_parcelles(schema, table, valeurs_sql)
            if reussite:
                return True, 'Parcelle insérée'
            else:
                return False, 'Impossible d\'insérer la parcelle'
        else:
            if reussite:
                return True, 'La parcelle n\'a pas été récupérée ou existe déjà'
            else:
                return False, 'Problème requêtage ou code INSEE incorrect'
    
    
    def inserer_multi_parcelles(self, schema, table, valeurs, epsg = '2154'):
        geompar = 'st_transform(ST_SetSRID(ST_PolygonFromText({1}), 4326), {0})'.format(epsg, '%s')
        geompar_valid = 'CASE WHEN NOT ST_ISVALID({0}) THEN ST_COLLECTIONEXTRACT(ST_MAKEVALID({0}),3) ELSE {0} END'.format(geompar)
        geomloc = 'st_PointOnSurface({0})'.format(geompar)
        source = 'API CADASTRE'
        vecteur = 'V'
        insert = "INSERT INTO {0} VALUES (%s, %s, %s, {1}, {2}, '{3}', '{4}');".format(schema + '.' + table, geompar_valid, geomloc, source, vecteur)
        return self.execution_multiple(insert, valeurs)
        
    def creer_valeurs_sql(self, parcelle):        
        liste_point = ', '.join([str(point[0]) + ' ' + str(point[1]) for point in parcelle.coordonnees])
        geometrie = "POLYGON((" + liste_point + "))"                    
        valeurs = (parcelle.departement, parcelle.idpar, float(parcelle.surface), geometrie, geometrie, geometrie, geometrie)
        return valeurs        
    
    def recuperer_parcelles(self, code_insee):
        '''
        Renvoie une liste des parcelles de la commune spécifiée issue du cadastre
        
        Les parcelles de la liste sont des namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees']) 
        
        Renvoie True et la liste si la requete aboutit et que le code INSEE est correct
        Renvoie False et None si la requête n'aboutit pas ou que le code INSEE est incorrect
        '''
        parcelles = []
        reussite, entites = self.recuperer_donnees_json_commune(code_insee)
        if entites:
            nt_parcelle = namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees'])
            departement = code_insee[:2]
            for parcelle in entites['features']:
                if parcelle['geometry']['type'] == 'Polygon':
                    idpar = departement + str(parcelle['properties']['id'][2:])
                    surface = str(parcelle['properties']['surface'])
                    coordonnees = parcelle['geometry']['coordinates'][0]
                    parcelles.append(nt_parcelle(departement, idpar, surface, coordonnees))
        return reussite, parcelles
    
    def recuperer_parcelle(self, code_insee, section, numero):
        '''
        Renvoie la parcelle spécifiée issue du cadastre
        
        La parcelle est un namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees']) 
        
        Renvoie True et la parcelle si la requete aboutit et que le code INSEE est correct
        Renvoie False et None si la requête n'aboutit pas ou que le code INSEE est incorrect
        '''
        parcelle = None
        reussite, entites = self.recuperer_donnees_json_parcelle(code_insee, section, numero)
        if entites:
            if len(entites['features']) > 0:
                nt_parcelle = namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees'])
                departement = code_insee[:2]
                parcelle = entites['features'][0]
                if parcelle['geometry']['type'] == 'Polygon':
                    idpar = departement + str(parcelle['properties']['id'][2:])
                    surface = str(parcelle['properties']['surface'])
                    coordonnees = parcelle['geometry']['coordinates'][0]
                    parcelle= nt_parcelle(departement, idpar, surface, coordonnees)
        return reussite, parcelle

    def recuperer_donnees_json_commune(self, code_insee):
        '''
         Récupère les données des parcelles de la commune issues du cadastre
         
         Renvoie True et le dictionnaire de données si la requete aboutie et que le code INSEE est correct
         Renvoie False et None si la requete n'aboutit pas ou que le code INSEE est incorrect
        '''
        entites = None
        try:
            with urllib.request.urlopen(url = self.url_commune.format(code_insee)) as reponse:
                donnees = reponse.read().decode('utf-8')
                entites = json.loads(donnees)
        except Exception as e:
            print(e)
            return False, None
        return True, entites
    
    def recuperer_donnees_json_parcelle(self, code_insee, section, numero):
        '''
        Renvoie les données de la parcelle spécifiée issue du cadastre
        
        Renvoie True et les données de la parcelle si la requete aboutie et que le code INSEE est correct
        Renvoie False et None si la requete n'aboutit pas ou que le code INSEE est incorrect
        '''
        entites = None
        params = urllib.parse.urlencode({'section': section, 'numero': numero})
        try:
            with urllib.request.urlopen(url = self.url_parcelle.format(code_insee, params)) as reponse:
                donnees = reponse.read().decode('utf-8')
                entites = json.loads(donnees)
        except Exception as e:
            print(e)
            return False, None
        return True, entites


class GeomDVF(PgOutils):
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, departements, script = 'sorties/script.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)                
        self.departements = [dep.lower() for dep in departements]
        self.schema_principal = 'dvf'
        self.schema_annexe = 'dvf_annexe'
        self.prefixe_schemas_departementaux = 'dvf_d'
        self.schemas_departementaux = [self.prefixe_schemas_departementaux + dep.lower() for dep in self.departements]
  
    @select_sql_champ_unique
    def recuperer_communes_a_geolocaliser(self):
        pass
    
    @requete_sql
    def creer_extension_postgis(self):
        pass
    
    @requete_sql
    def creer_champs_geometriques(self):
        pass
    
    def ajouter_commentaires_champs_geométriques(self):
        for schema in [self.schema_principal] + self.schemas_departementaux:
            valid, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geompar', 'commentaire')
            valid1, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geomparmut', 'commentaire')
            valid2, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geomlocmut', 'commentaire')
            valid3, nb = self.ajouter_commentaire_sur_champ(schema, 'disposition_parcelle', 'geompar', 'commentaire')
            valid4, nb = self.ajouter_commentaire_sur_champ(schema, 'disposition_parcelle', 'geomloc', 'commentaire')
            valid5, nb = self.ajouter_commentaire_sur_champ(schema, 'local', 'geomloc', 'commentaire')
            if not (valid and valid1 and valid2 and valid3 and valid4 and valid5):
                return False, -1
        return True, (len(self.schemas_departementaux) + 1)*6
    
    @requete_sql
    def mise_a_jour_geometries_local_depuis(self, schema, table):
        pass
    
    @requete_sql
    def mise_a_jour_geometries_disposition_parcelle_depuis(self, schema, table):
        pass

    @requete_sql
    def mise_a_jour_geometries_mutation(self):
        pass
    
#eof
