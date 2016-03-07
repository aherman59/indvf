from pg.pgbasics import *
from collections import namedtuple

class Requeteur(PgOutils):
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations):
        mutation_nt = namedtuple('Mutation', ['id', 'idmutinvar', 'datemut', 'valeurfonc', 'sbati', 'sterr'])
        return [mutation_nt(*mutation) for mutation in mutations]
    
    def mutations(self, codes_insee):
        mutations = self.recuperer_mutations(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[2] = (mutation[2]).strftime("%d/%m/%Y")
            mutation[3] = str(mutation[3])
            mutation[4] = str(mutation[4])
            mutation[5] = str(mutation[5])
        mutations = self.transformer_mutations_en_namedtuple(mutations)
        return mutations
    
    @select_sql_avec_modification_args
    def recuperer_mutations(self, codes_insee):
        return ("', '".join(codes_insee),)
        
    