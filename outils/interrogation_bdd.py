import json
from pg.pgbasics import *
from collections import namedtuple
from datetime import datetime
from .controle_bdd import ControleBDD

class Requeteur(PgOutils):
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations):
        mutation_nt = namedtuple('Mutation', ['id', 
                                              'datemut', 
                                              'anneemut', 
                                              'valeurfonc', 
                                              'sbati', 
                                              'sterr', 
                                              'nblocmut', 
                                              'nbparmut',
                                              'codtypbien', 
                                              'libtypbien'])
        return [mutation_nt(*mutation) for mutation in mutations]
    
    @classmethod
    def filtrer_mutations(cls, mutations, typologie, annee_min, annee_max, valeur_min, valeur_max):
        mutations_filtrees = mutations
        if typologie != 0:
            mutations_filtrees = [mutation for mutation in mutations_filtrees 
                                  if int(mutation.codtypbien) == typologie]
        if annee_min != 0:
            mutations_filtrees = [mutation for mutation in mutations_filtrees 
                                  if int(mutation.anneemut) >= annee_min]
        if annee_max != 0:
            mutations_filtrees = [mutation for mutation in mutations_filtrees 
                                  if int(mutation.anneemut) <= annee_max]
        mutations_filtrees = [mutation for mutation in mutations_filtrees 
                              if float(mutation.valeurfonc) >= valeur_min 
                              and float(mutation.valeurfonc) <= valeur_max]
        return mutations_filtrees    
        
    @classmethod
    def trier_mutations(cls, mutations, tri):
        if tri.startswith('id'):
            mutations_triees = sorted(mutations, key=lambda x: x.id)
        elif tri.startswith('datemut'):
            mutations_triees = sorted(mutations, key=lambda x: datetime.strptime(x.datemut, '%d/%m/%Y'))
        elif tri.startswith('valeurfonc'):
            mutations_triees = sorted(mutations, key=lambda x: float(x.valeurfonc))
        elif tri.startswith('sbati'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.sbati))
        elif tri.startswith('nblocmut'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.nblocmut))
        elif tri.startswith('sterr'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.sterr))
        elif tri.startswith('nbparmut'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.nbparmut))
        if tri.endswith('desc'):
            mutations_triees.reverse()
        return mutations_triees
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script = None):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        ctrlbdd = ControleBDD(hote, base, port, utilisateur, motdepasse)        
        self.base = 'DV3F' if ctrlbdd.est_une_base_DV3F() else 'DVF+'
        self.geobase = True if ctrlbdd.a_les_champs_geometriques() else False
 
    def mutations(self, codes_insee):
        mutations = self.recuperer_mutations_dv3f(codes_insee) if self.base == 'DV3F' else self.recuperer_mutations_dvf_plus(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[1] = (mutation[1]).strftime("%d/%m/%Y")
            mutation[3] = str(mutation[3])
            mutation[4] = str(mutation[4])
            mutation[5] = str(mutation[5])
        mutations = self.transformer_mutations_en_namedtuple(mutations)
        return mutations
    
    def mutations_en_geojson(self, geometrie, xmin, ymin, xmax, ymax, epsg = '2154'):
        '''
        Renvoie un dictionnaire avec toutes les informations pour créer un objet 'FeatureCollection' geojson 
        interprétable par OpenLayers.  
        '''
        if self.geobase:
            mutations = self.recuperer_mutations_avec_geometrie(geometrie, xmin, ymin, xmax, ymax, epsg)
            entites = []
            for mutation in mutations:
                entite = {}
                entite['type'] = 'feature'
                entite['id'] = mutation[0]
                entite['properties'] = {
                                        'idmutation' : mutation[0], 
                                        'codtypbien':mutation[1],
                                        'libtypbien':mutation[2],
                                        'valeurfonc': mutation[3],
                                        'datemut': (mutation[4]).strftime("%d/%m/%Y"),
                                        'sbati': str(mutation[5]),
                                        'sterr': str(mutation[6]),
                                        'nblocmut': str(mutation[7]),
                                        'nbparmut': str(mutation[8]),
                                        }
                entite['geometry'] = json.loads(mutation[9])
                entites.append(entite)
            collection = {}
            collection['type'] = 'FeatureCollection'
            collection['crs'] = {
                            'type': 'name',
                            'properties': {'name': 'EPSG:{0}'.format(epsg)},
                            }
            collection['features'] = entites
            return collection
        return None    
    
    def mutation_detaillee(self, id):
        mutation = None
        mutation_detaillee_nt = namedtuple('Mutation_Detail', ['idmutation',
                                                               'codservch', 
                                                               'refdoc',
                                                               'datemut',
                                                               'valeurfonc', 
                                                               'nblocmut',
                                                               'nblot', 
                                                               'nbparmut', 
                                                               'nbvolmut',
                                                               'libtypbien'])
        if self.base == 'DV3F':
            resultat = self.recuperer_mutation_detaillee_dv3f(id)
        else:
            resultat = self.recuperer_mutation_detaillee_dvf_plus(id)
        mutation = list(resultat[0])
        mutation = mutation_detaillee_nt(*mutation)
        return mutation
    
    def locaux_detailles(self, id):
        locaux =[]
        local_nt = namedtuple('Local', ['idloc', 'idpar', 'sbati', 'nbpprinc', 'libtyploc'])
        if self.base == 'DV3F':
            resultat = self.recuperer_locaux_dv3f(id)
        else:
            resultat = self.recuperer_locaux_dvf_plus(id)
        for ligne in resultat:
            local = list(ligne)
            local = local_nt(*local)
            locaux.append(local)
        return locaux 
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dv3f(self, codes_insee):
        return ("', '".join(codes_insee),)
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dvf_plus(self, codes_insee):
        codtypbien = self.requete_sql['_CODTYPBIEN']
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return ("', '".join(codes_insee), codtypbien, libtypbien)
    
    @select_sql
    def recuperer_mutation_detaillee_dv3f(self, id):
        pass
    
    @select_sql_avec_modification_args
    def recuperer_mutation_detaillee_dvf_plus(self, id):
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return (id, libtypbien)
    
    @select_sql
    def recuperer_locaux_dv3f(self, id):
        pass
    
    @select_sql
    def recuperer_locaux_dvf_plus(self, id):
        pass
    
    @select_sql_avec_modification_args
    def recuperer_mutations_avec_geometrie(self, champ_geometrie, xmin, ymin, xmax, ymax, epsg='2154'):
        codtypbien = self.requete_sql['_CODTYPBIEN']
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return champ_geometrie, xmin, ymin, xmax, ymax, epsg, codtypbien, libtypbien
        
    @select_sql_champ_unique
    def adresses_associees(self, id):
        pass