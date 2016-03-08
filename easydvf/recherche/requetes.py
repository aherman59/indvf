from pg.pgbasics import *
from collections import namedtuple
from datetime import datetime
from main.controle_bdd import ControleBDD

class Requeteur(PgOutils):
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations):
        mutation_nt = namedtuple('Mutation', ['id', 'idmutinvar', 'datemut', 'valeurfonc', 'sbati', 'sterr','codtypbien', 'libtypbien'])
        return [mutation_nt(*mutation) for mutation in mutations]
    
    @classmethod
    def filtrer_mutations(cls, mutations, typologie):
        if typologie == 9999:
            return mutations
        return [mutation for mutation in mutations if int(mutation.codtypbien) == typologie]
    
    @classmethod
    def trier_mutations(cls, mutations, tri):
        if tri == 'id':
            return sorted(mutations, key=lambda x: x.id)
        if tri == 'datemut':
            return sorted(mutations, key=lambda x: datetime.strptime(x.datemut, '%d/%m/%Y'))
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)        
        self.base = 'DV3F' if ControleBDD(hote, base, port, utilisateur, motdepasse).est_une_base_DV3F() else 'DVF+'
 
    def mutations(self, codes_insee, tri):
        mutations = self.recuperer_mutations_dv3f(codes_insee) if self.base == 'DV3F' else self.recuperer_mutations_dvf_plus(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[2] = (mutation[2]).strftime("%d/%m/%Y")
            mutation[3] = str(mutation[3])
            mutation[4] = str(mutation[4])
            mutation[5] = str(mutation[5])
        mutations = self.transformer_mutations_en_namedtuple(mutations)
        return mutations
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dv3f(self, codes_insee):
        return ("', '".join(codes_insee),)
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dvf_plus(self, codes_insee):
        return ("', '".join(codes_insee),)
        
    