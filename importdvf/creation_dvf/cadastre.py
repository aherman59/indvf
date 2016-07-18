
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
    
    def inserer_parcelles_communales(self, code_insee, schema, table):
        '''
        Insère les parcelles récupérées pour la commune dans la table spécifiée
                
        Renvoie True et un message de réussite si la requete a abouti
        Renvoie False et le message d'erreur associé dans le cas inverse
        '''
        reussite, parcelles = self.recuperer_parcelles(code_insee)
        if len(parcelles) > 0:
            valeurs_sql = [self.creer_valeurs_sql(parcelle) for parcelle in parcelles]
            self.inserer_multi_parcelles(schema, table, valeurs_sql)
            return True, str(len(parcelles)) + ' parcelles insérées pour commune ' + code_insee
        else:
            if reussite:
                return True, 'Pas de parcelles récupérées pour commune ' + code_insee
            else:
                return False, 'Problème requêtage ou code INSEE incorrect'
    
    def inserer_parcelle(self, code_insee, section, numero, schema, table):
        reussite, parcelle = self.recuperer_parcelle(code_insee, section, numero)
        if parcelle:
            valeurs_sql = [self.creer_valeurs_sql(parcelle)]
            self.inserer_multi_parcelles(schema, table, valeurs_sql)
            return True, 'Parcelle insérée'
        else:
            if reussite:
                return True, 'La parcelle n\'a pas été récupérée'
            else:
                return False, 'Problème requêtage ou code INSEE incorrect'
    
    
    def inserer_multi_parcelles(self, schema, table, valeurs, epsg = '2154'):
        insert = 'INSERT INTO {0} VALUES (%s, %s, %s, st_transform(ST_SetSRID(ST_PolygonFromText(%s), 4326), {1}));'.format(schema + '.' + table, epsg)
        self.execution_multiple(insert, valeurs)
        
    def creer_valeurs_sql(self, parcelle):        
        liste_point = ', '.join([str(point[0]) + ' ' + str(point[1]) for point in parcelle.coordonnees])
        geometrie = "POLYGON((" + liste_point + "))"                    
        valeurs = (parcelle.departement, parcelle.idpar, float(parcelle.surface), geometrie)
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
    
    '''
    Travail sur DVF+
    '''
    
    @select_sql_champ_unique
    def recuperer_communes_a_geolocaliser(self):
        pass
    
    @requete_sql
    def creer_extension_postgis(self):
        pass
    
    @requete_sql
    def creer_champs_geometriques(self):
        pass

#eof
