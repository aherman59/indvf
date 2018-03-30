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
import urllib.request
import json
import gzip
from collections import namedtuple
from pg.pgbasics import * 

class Cadastre(PgOutils):
    
    URL = 'https://cadastre.data.gouv.fr/data/etalab-cadastre/latest/geojson/communes/'
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script = 'sorties/cadastre.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.url_commune = self.URL + '{1}/{0}/cadastre-{0}-parcelles.json.gz'
               
    @requete_sql
    def creer_table_parcelles_si_inexistante(self, schema, table):
        '''
        Crée le schéma s'il n'existe pas puis crée la table si elle n'existe pas
        '''
        pass
    
    @requete_sql
    def effacer_contrainte_si_existante(self, schema, table, nom_contrainte):
        '''
        Efface la contrainte si elle existe
        '''
        pass

    @select_sql_champ_unique
    def lister_idpar_existants(self, schema, table, code_insee):
        pass
    
    def inserer_parcelles_communales(self, code_insee, schema, table, proxy = None, nouvelles_uniquement=True):
        '''
        Insère les parcelles récupérées pour la commune dans la table spécifiée
        
        Si nouvelles_uniquement est True, seules les parcelles n'ayant pas 
        un idpar existant dans la table sont intégrées. Sinon, elles sont toutes intégrées.
                
        Renvoie True et un message de réussite si la requete a abouti
        Renvoie False et le message d'erreur associé dans le cas inverse
        '''
        reussite, parcelles = self.recuperer_parcelles(code_insee, proxy = proxy)
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
                return False, 'Problème requêtage ou code INSEE incorrect (' + code_insee + ')' 
        
    def inserer_multi_parcelles(self, schema, table, valeurs, epsg = '2154'):
        #geompar = 'st_transform(ST_SetSRID(ST_PolygonFromText(%s), 4326), {0})'.format(epsg)
        geompar_makevalid = 'ST_COLLECTIONEXTRACT(st_transform(ST_SetSRID(ST_MakeValid(ST_PolygonFromText(%s)), 4326), {0}), 3)'.format(epsg)
        #geompar_valid = 'CASE WHEN NOT ST_ISVALID(ST_PolygonFromText(%s)) THEN {1} ELSE {0} END'.format(geompar, geompar_makevalid)
        geomloc = 'st_PointOnSurface({0})'.format(geompar_makevalid)
        source = 'API CADASTRE'
        vecteur = 'V'
        insert = "INSERT INTO {0} VALUES (%s, %s, %s, {1}, {2}, '{3}', '{4}');".format(schema + '.' + table, geompar_makevalid, geomloc, source, vecteur)
        return self.execution_multiple(insert, valeurs)
        
    def creer_valeurs_sql(self, parcelle):        
        liste_point = ', '.join([str(point[0]) + ' ' + str(point[1]) for point in parcelle.coordonnees])
        geometrie = "POLYGON((" + liste_point + "))"                    
        valeurs = (parcelle.departement, parcelle.idpar, float(parcelle.surface), geometrie, geometrie)
        return valeurs        
    
    def recuperer_parcelles(self, code_insee, proxy = None):
        '''
        Renvoie une liste des parcelles de la commune spécifiée issue du cadastre
        
        Les parcelles de la liste sont des namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees']) 
        
        Renvoie True et la liste si la requete aboutit et que le code INSEE est correct
        Renvoie False et None si la requête n'aboutit pas ou que le code INSEE est incorrect
        '''
        parcelles = []
        reussite, entites = self.recuperer_donnees_json_commune(code_insee, proxy = proxy)
        if entites:
            nt_parcelle = namedtuple('Parcelle', ['departement', 'idpar', 'surface', 'coordonnees'])
            departement = code_insee[:2]
            for parcelle in entites['features']:
                if parcelle['geometry']['type'] == 'Polygon':
                    idpar = departement + str(parcelle['properties']['id'][2:])
                    if 'contenance' not in parcelle['properties']:
                        surface = 0
                    else:
                        surface = str(parcelle['properties']['contenance']) or 0
                    coordonnees = parcelle['geometry']['coordinates'][0]
                    parcelles.append(nt_parcelle(departement, idpar, surface, coordonnees))
        return reussite, parcelles

    def recuperer_donnees_json_commune(self, code_insee, proxy = None):
        '''
         Récupère les données des parcelles de la commune issues du cadastre
         
         Renvoie True et le dictionnaire de données si la requete aboutie et que le code INSEE est correct
         Renvoie False et None si la requete n'aboutit pas ou que le code INSEE est incorrect
        '''
        entites = None
        departement = code_insee[:2] if not code_insee.startswith('97') else code_insee[:3]
        try:
            url = self.url_commune.format(code_insee, departement)
            req = urllib.request.Request(url)
            if proxy:
                req.set_proxy(proxy, 'http')
                req.set_proxy(proxy, 'https')
            with urllib.request.urlopen(req) as reponse:
                donnees = gzip.decompress(reponse.read()).decode('utf-8')
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
    def creer_champs_geometriques(self, schema):
        pass
    
    def ajouter_commentaires_champs_geométriques(self):
        for schema in [self.schema_principal] + self.schemas_departementaux:
            valid, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geompar', "geométrie de l'ensemble des contours des parcelles concernées par la mutation")
            valid1, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geomparmut', "géométrie de l'ensemble des contours des parcelles ayant muté")
            valid2, nb = self.ajouter_commentaire_sur_champ(schema, 'mutation', 'geomlocmut', "géométrie de l'ensemble des localisants correspondant à des parcelles surlesquelles un local a muté")
            valid3, nb = self.ajouter_commentaire_sur_champ(schema, 'disposition_parcelle', 'geompar', "géométrie du contour de la parcelle")
            valid4, nb = self.ajouter_commentaire_sur_champ(schema, 'disposition_parcelle', 'geomloc', "géométrie du localisant de la parcelle")
            valid5, nb = self.ajouter_commentaire_sur_champ(schema, 'local', 'geomloc', "géométrie du localisant")
            if not (valid and valid1 and valid2 and valid3 and valid4 and valid5):
                return False
        return True
    
    def mise_a_jour_geometries_local_depuis(self, schema, table):
        for schema_departemental in self.schemas_departementaux:
            valid, nb = self.mise_a_jour_geometries_local_pour_departement_depuis(schema, table, schema_departemental)
            if not valid:
                return False
        return True
    
    def mise_a_jour_geometries_disposition_parcelle_depuis(self, schema, table):
        for schema_departemental in self.schemas_departementaux:
            valid, nb = self.mise_a_jour_geometries_disposition_parcelle_pour_departement_depuis(schema, table, schema_departemental)
            if not valid:
                return False
        return True
    
    def mise_a_jour_geometries_mutation(self):
        for schema_departemental in self.schemas_departementaux:
            valid, nb = self.mise_a_jour_geometries_mutation_pour_departement(schema_departemental)
            if not valid:
                return False
        return True
    
    def creer_index_et_contraintes_geometriques(self):
        for schema_departemental in self.schemas_departementaux:
            valid, nb =self.creer_index_geometriques(schema_departemental)
            if not valid:
                return False
            valid, nb =self.creer_contraintes_geometriques(schema_departemental)
            if not valid:
                return False
        return True
    
    @requete_sql
    def mise_a_jour_geometries_local_pour_departement_depuis(self, schema, table, schema_departemental):
        pass
    
    @requete_sql
    def mise_a_jour_geometries_disposition_parcelle_pour_departement_depuis(self, schema, table, schema_departemental):
        pass

    @requete_sql
    def mise_a_jour_geometries_mutation_pour_departement(self,  schema_departemental):
        pass
    
    @requete_sql
    def creer_index_geometriques(self, schema_departemental):
        pass
    
    @requete_sql
    def creer_contraintes_geometriques(self, schema_departemental):
        pass
    
#eof
