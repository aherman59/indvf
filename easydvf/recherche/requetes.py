from pg.pgbasics import *
from collections import namedtuple

class Requeteur(PgOutils):
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)
    
    def mutations(self):
        mutations = self.recuperer_mutations()
        return self.transformer_mutations_en_namedtuple(mutations)
    
    def transformer_mutations_en_namedtuple(self, mutations):
        mutation_nt = namedtuple('Mutation', ['id', 'idmutinvar', 'datemut', 'valeurfonc', 'sbati', 'sterr'])
        return [mutation_nt(*mutation) for mutation in mutations]
    
    @select_sql
    def recuperer_mutations(self):
        pass
        
    