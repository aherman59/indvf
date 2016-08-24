import json
from pg.pgbasics import *
from collections import namedtuple
from datetime import datetime
from .controle_bdd import ControleBDD

class Requeteur(PgOutils):
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations):
        Mutation = namedtuple('Mutation', ['id', 
                                              'datemut', 
                                              'anneemut', 
                                              'valeurfonc', 
                                              'sbati', 
                                              'sterr', 
                                              'nblocmut', 
                                              'nbparmut',
                                              'codtypbien', 
                                              'libtypbien'])
        return [Mutation(*mutation) for mutation in mutations]
    
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
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, type_base = None, script = None):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
        self.base = self.detecter_type_base(type_base, hote, base, port, utilisateur, motdepasse)
        self.geobase = self.detecter_si_geobase(hote, base, port, utilisateur, motdepasse)
        
    def detecter_type_base(self, type_base, hote, base, port, utilisateur, motdepasse):
        if type_base in ['DVF+', 'DV3F']:
            return type_base
        else:
            try:
                ctrlbdd = ControleBDD(hote, base, port, utilisateur, motdepasse)
                if ctrlbdd.est_une_base_DV3F():        
                    return 'DV3F'  
                elif ctrlbdd.est_une_base_DVF_plus():        
                    return 'DVF+'
                else:
                    return None
            except Exception as e:
                print(e)
                return None
    
    def detecter_si_geobase(self, hote, base, port, utilisateur, motdepasse):
        if self.base == 'DV3F':
            return True
        elif self.base == 'DVF+':
            try:
                ctrlbdd = ControleBDD(hote, base, port, utilisateur, motdepasse)
                return ctrlbdd.a_les_champs_geometriques()
            except Exception as e:
                print(e)
                return False
        else:
            return False
    
    def creer_fonctions_utiles(self):
        self.creer_aggregat_mediane_10()                
 
    def mutations(self, codes_insee):
        mutations = self.recuperer_mutations(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[1] = (mutation[1]).strftime("%d/%m/%Y")
            mutation[3] = str(mutation[3])
            mutation[4] = str(mutation[4])
            mutation[5] = str(mutation[5])
        mutations = self.transformer_mutations_en_namedtuple(mutations)
        return mutations
            
    def recuperer_mutations(self, codes_insee):
        if self.base == 'DV3F' and len(codes_insee) > 0:
            return self.recuperer_mutations_dv3f(codes_insee)
        elif self.base == 'DVF+' and len(codes_insee) > 0:
            return self.recuperer_mutations_dvf_plus(codes_insee)
        else:
            return []
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dv3f(self, codes_insee):
        return ("', '".join(codes_insee),)
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dvf_plus(self, codes_insee):
        codtypbien = self.requete_sql['_CODTYPBIEN']
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return ("', '".join(codes_insee), codtypbien, libtypbien)
    
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
    
    @select_sql_avec_modification_args
    def recuperer_mutations_avec_geometrie(self, champ_geometrie, xmin, ymin, xmax, ymax, epsg='2154'):
        codtypbien = self.requete_sql['_CODTYPBIEN']
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return champ_geometrie, xmin, ymin, xmax, ymax, epsg, codtypbien, libtypbien
    
    def localisant_moyen(self, nb_points):
        resultat = self.recuperer_localisant_moyen(nb_points)
        return list(resultat[0])
    
    @select_sql
    def recuperer_localisant_moyen(self, nb_points):
        pass
        
    def mutation_detaillee(self, id):
        Mutation_detaillee = namedtuple('Mutation_Detail', ['idmutation',
                                                               'codservch', 
                                                               'refdoc',
                                                               'datemut',
                                                               'valeurfonc', 
                                                               'nblocmut',
                                                               'nblot', 
                                                               'nbparmut', 
                                                               'nbvolmut',
                                                               'libtypbien'])
        mutation = self.recuperer_mutation_detaillee(id)
        mutation = Mutation_detaillee(*mutation)
        return mutation

    def recuperer_mutation_detaillee(self, id):
        if self.base == 'DV3F':
            resultat = self.recuperer_mutation_detaillee_dv3f(id)
        elif self.base == 'DVF+':
            resultat = self.recuperer_mutation_detaillee_dvf_plus(id)
        else:
            return None
        return list(resultat[0])
    
    @select_sql
    def recuperer_mutation_detaillee_dv3f(self, id):
        pass
    
    @select_sql_avec_modification_args
    def recuperer_mutation_detaillee_dvf_plus(self, id):
        libtypbien = self.requete_sql['_LIBTYPBIEN']
        return (id, libtypbien)
    

    def locaux_detailles(self, id):
        locaux =[]
        Local = namedtuple('Local', ['idloc', 'idpar', 'sbati', 'nbpprinc', 'libtyploc'])
        resultat = self.recuperer_locaux(id)
        for ligne in resultat:
            local = list(ligne)
            local = Local(*local)
            locaux.append(local)
        return locaux

    def recuperer_locaux(self, id):
        if self.base == 'DV3F':
            resultat = self.recuperer_locaux_dv3f(id)
        elif self.base == 'DVF+':
            resultat = self.recuperer_locaux_dvf_plus(id)
        else:
            return []
        return resultat
    
    @select_sql
    def recuperer_locaux_dv3f(self, id):
        pass
    
    @select_sql
    def recuperer_locaux_dvf_plus(self, id):
        pass
    
    
    def parcelles_detaillees(self, id):
        parcelles =[]
        Parcelle = namedtuple('Parcelle', ['idpar', 'sterr'])
        resultat = self.recuperer_parcelles(id)
        for ligne in resultat:
            parcelle = list(ligne)
            parcelle = Parcelle(*parcelle)
            parcelles.append(parcelle)
        return parcelles  

    def recuperer_parcelles(self, id):
        if self.base == 'DV3F':
            resultat = self.recuperer_parcelles_dv3f(id)
        elif self.base == 'DVF+':
            resultat = self.recuperer_parcelles_dvf_plus(id)
        else:
            return []
        return resultat
    
    @select_sql
    def recuperer_parcelles_dv3f(self, id):
        pass
    
    @select_sql
    def recuperer_parcelles_dvf_plus(self, id):
        pass
        
    @select_sql_champ_unique
    def adresses_associees(self, id):
        pass
    
    
    '''
    CALCUL AGGREGATS
    '''
    
    @requete_sql    
    def creer_aggregat_mediane_10(self):
        pass
    
    @select_sql_avec_modification_args
    def calculer_somme_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def calculer_somme_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def compter_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus

    @select_sql_avec_modification_args
    def compter_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", annee_debut, annee_fin, code_typo, variables_typologie_dvf_plus
    
    @select_sql_avec_modification_args
    def calculer_mediane_10_par_annee(self, variable, codes_insee, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus
    
    @select_sql_avec_modification_args
    def calculer_mediane_10_multi_annee(self, variable, codes_insee, annee_debut, annee_fin, code_typo):
        code_typo = self.condition_code_typo(code_typo)
        variables_typologie_dvf_plus = self.ajout_variables_typologies()
        return variable, "'" + "', '".join(codes_insee) + "'", code_typo, variables_typologie_dvf_plus
    
    def condition_code_typo(self, code_typo):
        return '' if code_typo == '999' else " WHERE codtypbien='{0}' ".format(code_typo)
    
    def ajout_variables_typologies(self):
        if self.base == 'DV3F':
            return ''
        elif self.base == 'DVF+':
            codtypbien = self.requete_sql['_CODTYPBIEN']
            libtypbien = self.requete_sql['_LIBTYPBIEN']
            return ', ' + codtypbien + ', ' + libtypbien
    
    