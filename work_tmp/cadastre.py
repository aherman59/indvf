
import urllib.request
import json
from collections import namedtuple
from pgbasics import * 

class Cadastre(PgOutils):
    
    URL = 'https://cadastre.api.gouv.fr/commune/'
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script = 'sorties/cadastre.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.url_commune = self.URL + '{0}'
        self.url_parcelle = self.URL + '{0}?{1}'
        
    @requete_sql
    def creer_table_parcelles(self, schema, table):
        '''
        Crée le schéma s'il n'existe pas puis crée la table
        '''
        pass
    
    def inserer_parcelles_communales(self, code_insee, schema, table):
        entites = self.recuperer_parcelles_communes(code_insee)
        if entites and len(entites['features']) > 0:
            parcelles = self.preparer_parcelles(entites, code_insee)
            print('Commune ', code_insee, ' :', len(parcelles),' parcelles')
            valeurs_sql = [self.creer_valeurs_sql(parcelle) for parcelle in parcelles]
            self.inserer_multi_parcelles(schema, table, valeurs_sql)
        else: # Problèmes
            if entites:
                print('Pas de données pour commune ', code_insee)
            else:
                print('Problème requêtage')
    
    def inserer_parcelle_unique(self, code_insee, section, numero, schema, table):
        entites = self.recuperer_parcelle(code_insee, section, numero)
        if entites and len(entites['features']) == 1:
            parcelles = self.preparer_parcelles(entites, code_insee)
            valeurs_sql = [self.creer_valeurs_sql(parcelle) for parcelle in parcelles]
            self.inserer_multi_parcelles(schema, table, valeurs_sql)
        else: # Problèmes
            if entites and len(entites['features']) == 0:
                print('Pas de données pour ', code_insee, '000' ,section, numero)
            elif entites and len(entites['features']) > 1:
                print('Plusieurs entités récupérées pour ', code_insee, '000' ,section, numero)
            else : 
                print('Problème requêtage')
    
    
    def inserer_multi_parcelles(self, schema, table, valeurs, epsg = '2154'):
        insert = 'INSERT INTO {0} VALUES (%s, %s, %s, st_transform(ST_SetSRID(ST_PolygonFromText(%s), 4326), {1}));'.format(schema + '.' + table, epsg)
        self.execution_multiple(insert, valeurs)
        
    def creer_valeurs_sql(self, parcelle):        
        liste_point = ', '.join([str(point[0]) + ' ' + str(point[1]) for point in parcelle.coordonnees])
        geometrie = "POLYGON((" + liste_point + "))"                    
        valeurs = (parcelle.departement, parcelle.idpar, float(parcelle.surface), geometrie)
        return valeurs        
    
    def recuperer_parcelles_communes(self, code_insee):
        entites = None
        try:
            with urllib.request.urlopen(url = self.url_commune.format(code_insee)) as reponse:
                donnees = reponse.read().decode('utf-8')
                entites = json.loads(donnees)
        except Exception as e:
            print(e)
        return entites
    
    def recuperer_parcelle(self, code_insee, section, numero):
        entites = None
        params = urllib.parse.urlencode({'section': section, 'numero': numero})
        try:
            with urllib.request.urlopen(url = self.url_parcelle.format(code_insee, params)) as reponse:
                donnees = reponse.read().decode('utf-8')
                entites = json.loads(donnees)
        except Exception as e:
            print(e)
        return entites
    
    def preparer_parcelles(self, entites, code_insee):
        parcelles = []
        nt_parcelle = namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees'])
        departement = code_insee[:2]
        for parcelle in entites['features']:
            if parcelle['geometry']['type'] == 'Polygon':
                idpar = departement + str(parcelle['properties']['id'][2:])
                surface = str(parcelle['properties']['surface'])
                coordonnees = parcelle['geometry']['coordinates'][0]
                parcelles.append(nt_parcelle(departement, idpar, surface, coordonnees))
        return parcelles

if __name__ == '__main__':
    
    parametre_connexion = ('localhost', 'dvf', '5432', 'postgres', 'postgres')
    cada = Cadastre(*parametre_connexion)
    schema, table = 'cadastre', 'dep59'
    cada.creer_table_parcelles(schema, table)
    for code_insee in ['59001', '59002', '59003', '59007', '59350']:
        cada.inserer_parcelles_communales(code_insee, schema, table)
    #cada.inserer_parcelle_unique('59005', '0A', '0005', schema, table)

#eof
