from pg.pgbasics import *
from collections import namedtuple
from datetime import datetime
from main.controle_bdd import ControleBDD

class Requeteur(PgOutils):
    
    @classmethod
    def transformer_mutations_en_namedtuple(cls, mutations):
        mutation_nt = namedtuple('Mutation', ['id', 'codservch', 'refdoc', 'datemut', 'valeurfonc', 'sbati', 'sterr','codtypbien', 'libtypbien'])
        return [mutation_nt(*mutation) for mutation in mutations]
    
    @classmethod
    def filtrer_mutations(cls, mutations, typologie):
        if typologie == 0:
            return mutations
        return [mutation for mutation in mutations if int(mutation.codtypbien) == typologie]
    
    @classmethod
    def trier_mutations(cls, mutations, tri):
        if tri.startswith('id'):
            mutations_triees = sorted(mutations, key=lambda x: x.id)
        if tri.startswith('datemut'):
            mutations_triees = sorted(mutations, key=lambda x: datetime.strptime(x.datemut, '%d/%m/%Y'))
        if tri.startswith('valeurfonc'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.valeurfonc.replace(' ', '')))
        if tri.startswith('sbati'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.sbati.replace(' ', '')))
        if tri.startswith('sterr'):
            mutations_triees = sorted(mutations, key=lambda x: int(x.sterr.replace(' ', '')))
        if tri.endswith('desc'):
            mutations_triees.reverse()
        return mutations_triees
    
    def __init__(self, hote, base, port, utilisateur, motdepasse, script):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)        
        self.base = 'DV3F' if ControleBDD(hote, base, port, utilisateur, motdepasse).est_une_base_DV3F() else 'DVF+'
 
    def mutations(self, codes_insee):
        mutations = self.recuperer_mutations_dv3f(codes_insee) if self.base == 'DV3F' else self.recuperer_mutations_dvf_plus(codes_insee)        
        mutations = [list(mutation) for mutation in mutations]
        for mutation in mutations:
            mutation[3] = (mutation[3]).strftime("%d/%m/%Y")
            mutation[4] = self._separateur_millier(str(round(mutation[4])))
            mutation[5] = self._separateur_millier(str(mutation[5]))
            mutation[6] = self._separateur_millier(str(mutation[6]))
        mutations = self.transformer_mutations_en_namedtuple(mutations)
        return mutations
    
    def mutation_detaillee(self, id):
        resultat = self.recuperer_mutation_detaillee_dv3f() if self.base == 'DV3F' else self.recuperer_mutation_detaillee_dvf_plus(id)
        mutation = list(resultat[0])
        mutation_detaillee_nt = namedtuple('Mutation_Detail', ['nblocmut', 'nbparmut', 'libtypbien'])
        mutation = mutation_detaillee_nt(*mutation)
        return mutation 
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dv3f(self, codes_insee):
        return ("', '".join(codes_insee),)
    
    @select_sql_avec_modification_args
    def recuperer_mutations_dvf_plus(self, codes_insee):
        return ("', '".join(codes_insee),)
    
    @select_sql
    def recuperer_mutation_detaillee_dv3f(self, id):
        pass
    
    @select_sql
    def recuperer_mutation_detaillee_dvf_plus(self, id):
        pass
    
    def _separateur_millier(self, nombre, sep = ' '):
        if nombre:
            if len(nombre) <= 3:
                return nombre
            else:
                return self._separateur_millier(nombre[:-3], sep) + sep + nombre[-3:]
        
    