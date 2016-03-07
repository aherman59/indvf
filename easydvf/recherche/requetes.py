from pg.pgbasics import *
from collections import namedtuple
from datetime import datetime

class Requeteur(PgOutils):
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)

    def mutations(self, codes_insee, tri):
        mutations = self.recuperer_mutations(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[2] = (mutation[2]).strftime("%d/%m/%Y")
            mutation[3] = str(mutation[3])
            mutation[4] = str(mutation[4])
            mutation[5] = str(mutation[5])
        mutations = self.transformer_mutations_en_namedtuple(mutations, tri)
        return mutations
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations, tri):
        mutation_nt = namedtuple('Mutation', ['id', 'idmutinvar', 'datemut', 'valeurfonc', 'sbati', 'sterr'])
        return cls.tri([mutation_nt(*mutation) for mutation in mutations], tri)
    
    @classmethod
    def tri(cls, mutations, tri):
        if tri == 'id':
            return sorted(mutations, key=lambda x: x.id)
        if tri == 'datemut':
            return sorted(mutations, key=lambda x: datetime.strptime(x.datemut, '%d/%m/%Y'))
    
    @select_sql_avec_modification_args
    def recuperer_mutations(self, codes_insee):
        return ("', '".join(codes_insee),)
        
    