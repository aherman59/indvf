from datetime import datetime
from pg.pgbasics import *

class Mutations():
    
    def __init__(self, session, codes_insee=None):
        if codes_insee is not None:
            mutations = self.calcul(codes_insee, session)
        else:
            mutations = session['mutations']
        self.mutations = mutations
        self.session = session
    
    def calcul(self, codes_insee, session): 
        mutations = RequeteurEasyDVF(session).recuperer_mutations(codes_insee)
        return [Mutation(mutation).as_tuple() for mutation in mutations] # permet de formatter les champs date, etc.
    
    def as_list(self):
        return self.mutations
        
    def as_objet(self):
        return [Mutation(mutation) for mutation in self.mutations]
    
    def avec_filtre(self, order_by='id'):
        mutations = self.as_objet()
        parametres = self.session['parametres_filtre']
        if parametres['typologie'] != 0:
            mutations = [m for m in mutations if int(m.codtypbien) == parametres['typologie']]
        if parametres['annee_min'] != 0:
            mutations = [m for m in mutations if int(m.anneemut) >= parametres['annee_min']]
        if parametres['annee_max'] != 0:
            mutations = [m for m in mutations if int(m.anneemut) <= parametres['annee_max']]
        mutations = [m for m in mutations if parametres['valeur_min'] <= float(m.valeurfonc) <= parametres['valeur_max']]
        return self.trier(mutations, order_by)
    
    def trier(self, mutations, tri):
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
            
class Mutation():
    
    def __init__(self, mutation):
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
    
    def as_tuple(self):
        return (self.id, self.datemut, self.anneemut, 
                self.valeurfonc, self.sbati, self.sterr, 
                self.nblocmut, self.nbparmut, self.codtypbien, self.libtypbien)
    
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
    
class RequeteurEasyDVF(PgOutils):
    
    def __init__(self, session, script = None):
        super().__init__(*session['params'], script=script)
        self.type_base = session['type_bdd']
    
    def recuperer_mutations(self, codes_insee):
        if self.type_base == 'DV3F':
            return self.recuperer_mutations_dv3f(codes_insee)
        elif self.type_base == 'DVF+':
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
        