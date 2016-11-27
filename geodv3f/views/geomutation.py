from datetime import datetime
import json
from pg.pgbasics import *

class GeoMutations():
    
    def __init__(self, session, nom_geometrie=None, emprise=None, epsg='2154'):
        self.epsg = epsg
        if emprise is not None and nom_geometrie is not None:
            self.mutations =  self.calcul(session, nom_geometrie, emprise)
        else:
            self.mutations = session['geomutations']
    
    def calcul(self, session, nom_geometrie, emprise): 
        mutations = RequeteurGeoDV3F(session).recuperer_mutations_avec_geometrie(nom_geometrie, emprise, epsg=self.epsg)
        return [GeoMutation(mutation).as_tuple() for mutation in mutations] # permet de formatter les champs date, etc.
    
    def as_list(self):
        return self.mutations
        
    def as_objet(self):
        return [GeoMutation(mutation) for mutation in self.mutations]
    
    def as_geojson(self):
        collection = {}
        collection['type'] = 'FeatureCollection'
        collection['crs'] = {
                        'type': 'name',
                        'properties': {'name': 'EPSG:{0}'.format(self.epsg)},
                        }
        collection['features'] = [mutation.as_geojson() for mutation in self.as_objet()]
        return collection

    def get(self, idmutation):
        for mutation in self.mutations:
            m = GeoMutation(mutation)
            if int(m.id) == int(idmutation):
                return m

class DetailMutation():
    
    def __init__(self, idmutation, session):
        self.idmutation = idmutation
        self.session = session
        self.mutation = GeoMutations(session).get(idmutation)
    
    @property
    def locaux(self):
        locs = RequeteurGeoDV3F(self.session).recuperer_locaux(self.idmutation)
        return [Local(l) for l in locs]
    
    @property
    def parcelles(self):
        pars = RequeteurGeoDV3F(self.session).recuperer_parcelles(self.idmutation)
        return [Parcelle(p) for p in pars]
    
    @property
    def adresses(self):
        adrs = RequeteurGeoDV3F(self.session).adresses_associees(self.idmutation)
        return ', '.join(adrs)

class GeoMutation():
    
    def __init__(self, mutation):        
        self.dv3f = True if len(mutation) > 15 else False
        self.id = mutation[0]
        self._datemut = mutation[1]
        self.anneemut = mutation[2]
        self._valeurfonc = mutation[3]
        self._sbati = mutation[4]
        self._sterr = mutation[5]
        self.nblocmut = mutation[6]
        self.nbparmut = mutation[7]
        self.codtypbien = mutation[8]
        self.libtypbien = mutation[9]
        self.codservch = mutation[10]
        self.refdoc = mutation[11]
        self.nblot = mutation[12]
        self.nbvolmut = mutation[13]
        self.geometrie = mutation[14]
        self._l_nomv = mutation[15] if self.dv3f else None
        self._l_noma = mutation[16] if self.dv3f else None                                                     
    
    def as_tuple(self):
        return (self.id, self.datemut, self.anneemut, 
                self.valeurfonc, self.sbati, self.sterr, 
                self.nblocmut, self.nbparmut, 
                self.codtypbien, self.libtypbien,
                self.codservch, self.refdoc, self.nblot, self.nbvolmut, 
                self.geometrie, self.l_nomv, self.l_noma)
    
    def as_geojson(self):
        entite = {}
        entite['type'] = 'feature'
        entite['id'] = self.id
        entite['properties'] = {
                                'idmutation' : self.id, 
                                'codtypbien': self.codtypbien,
                                'libtypbien':self.libtypbien,
                                'valeurfonc': self.valeurfonc,
                                'datemut': self.datemut,
                                'sbati': self.sbati,
                                'sterr': self.sterr,
                                'nblocmut': self.nblocmut,
                                'nbparmut': self.nbparmut,
                                }
        entite['geometry'] = json.loads(self.geometrie)
        return entite
    
    @property
    def l_nomv(self):
        if isinstance(self._l_nomv, str):
            return self._l_nomv
        if not self._l_nomv:
            return '--' if not self.dv3f else 'Non rapatrié'
        return ', '.join(self._l_nomv).replace('_X_', 'Personne physique anonymisée')
    
    @property
    def l_noma(self):
        if isinstance(self._l_noma, str):
            return self._l_noma
        if not self._l_noma:
            return '--' if not self.dv3f else 'Non rapatrié'
        return ', '.join(self._l_noma).replace('_X_', 'Personne physique anonymisée')
    
    @property
    def datemut(self):
        if isinstance(self._datemut, str):
            return self._datemut
        return (self._datemut).strftime("%d/%m/%Y")
    
    @property
    def valeurfonc(self):
        return str(self._valeurfonc)
    
    @property
    def sterr(self):
        return str(self._sterr)

    @property
    def sbati(self):
        return str(self._sbati)


class Local():
    
    def __init__(self, local):
        self.dv3f = True if len(local) > 5 else False
        self.idloc = local[0]
        self.idpar = local[1]
        self._sbati = local[2]
        self._nbpprinc = local[3]
        self.libtyploc = local[4]
        self._ffancst = local[5] if self.dv3f else None
    
    @property
    def sbati(self):
        if self._sbati is None:
            return '--'
        return str(self._sbati)
    
    @property
    def nbpprinc(self):
        if self._nbpprinc is None:
            return '--'
        return str(self._nbpprinc)
    
    @property
    def ffancst(self):
        if self._ffancst is None:
            return '--' if not self.dv3f else 'Non rapatrié'
        return str(self._ffancst)


class Parcelle():
    
    def __init__(self, parcelle):
        self.idpar = parcelle[0]
        self._sterr = parcelle[1]
    
    @property
    def sterr(self):
        return str(self._sterr)
        

class Centre():
    
    def __init__(self, session, limit=10000):
        self.x, self.y = self.calcul(session, limit)
    
    def calcul(self, session, limit):
        resultat = RequeteurGeoDV3F(session).recuperer_point_central(limit)
        return resultat[0]
    
    def as_text(self):
        return '[' + str(self.x) + ', ' + str(self.y) + ']'

  
class RequeteurGeoDV3F(PgOutils):
    
    def __init__(self, session, script = None):
        super().__init__(*session['params'], script=script)
        self.type_base = session['type_bdd']
    
    @select_sql
    def recuperer_point_central(self, limit):
        pass
    
    def recuperer_mutations_avec_geometrie(self, champ_geometrie, emprise, epsg='2154'):
        if self.type_base == 'DV3F':
            resultat = self.recuperer_mutations_dv3f_avec_geometrie(champ_geometrie, emprise, epsg)
        elif self.type_base == 'DVF+':
            resultat = self.recuperer_mutations_dvf_plus_avec_geometrie(champ_geometrie, emprise, epsg)
        else:
            return []
        return resultat
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dv3f_avec_geometrie(self, champ_geometrie, emprise, epsg='2154'):
        [xmin, ymin, xmax, ymax] = emprise
        return champ_geometrie, xmin, ymin, xmax, ymax, epsg
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dvf_plus_avec_geometrie(self, champ_geometrie, emprise, epsg='2154'):
        [xmin, ymin, xmax, ymax] = emprise
        codtypbien = self.requete_sql['_CODTYPBIEN']
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return champ_geometrie, xmin, ymin, xmax, ymax, epsg, codtypbien, libtypbien
    
    def recuperer_locaux(self, idmutation):
        if self.type_base == 'DV3F':
            resultat = self.recuperer_locaux_dv3f(idmutation)
        elif self.type_base == 'DVF+':
            resultat = self.recuperer_locaux_dvf_plus(idmutation)
        else:
            return []
        return resultat
    
    @select_sql
    def recuperer_locaux_dv3f(self, idmutation):
        pass
    
    @select_sql
    def recuperer_locaux_dvf_plus(self, idmutation):
        pass

    def recuperer_parcelles(self, idmutation):
        if self.type_base == 'DV3F':
            resultat = self.recuperer_parcelles_dv3f(idmutation)
        elif self.type_base == 'DVF+':
            resultat = self.recuperer_parcelles_dvf_plus(idmutation)
        else:
            return []
        return resultat
    
    @select_sql
    def recuperer_parcelles_dv3f(self, idmutation):
        pass
    
    @select_sql
    def recuperer_parcelles_dvf_plus(self, idmutation):
        pass
    
    @select_sql_champ_unique
    def adresses_associees(self, idmutation):
        pass
        