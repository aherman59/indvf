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
        
    def as_objet(self, order_by = None):        
        mutations = [Mutation(mutation) for mutation in self.mutations]
        if order_by:
            return self.trier(mutations, order_by)
        return mutations
    
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
        mutations_triees = mutations
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
    
    def get(self, idmutation):
        for mutation in self.mutations:
            m = Mutation(mutation)
            if int(m.id) == int(idmutation):
                return m

    
class DetailMutation():
    
    def __init__(self, idmutation, session):
        self.idmutation = idmutation
        self.session = session
        self.mutation = Mutations(session).get(idmutation)
    
    @property
    def locaux(self):
        locs = RequeteurEasyDVF(self.session).recuperer_locaux(self.idmutation)
        return [Local(l) for l in locs]
    
    @property
    def parcelles(self):
        pars = RequeteurEasyDVF(self.session).recuperer_parcelles(self.idmutation)
        return [Parcelle(p) for p in pars]
    
    @property
    def adresses(self):
        adrs = RequeteurEasyDVF(self.session).adresses_associees(self.idmutation)
        return ', '.join(adrs)    

class Mutation():
    
    def __init__(self, mutation):     
        self.dv3f = True if len(mutation) > 14 else False
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
        self._l_nomv = mutation[14] if self.dv3f else None
        self._l_noma = mutation[15] if self.dv3f else None
                                                             
    
    def as_tuple(self):
        return (self.id, self.datemut, self.anneemut, 
                self.valeurfonc, self.sbati, self.sterr, 
                self.nblocmut, self.nbparmut, 
                self.codtypbien, self.libtypbien,
                self.codservch, self.refdoc, self.nblot, self.nbvolmut, self.l_nomv, self.l_noma)
    
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
        