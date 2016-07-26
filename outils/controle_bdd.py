import psycopg2
from pg.pgbasics import *

def tentative_connexion(hote, bdd, utilisateur, mdp, port):
    '''
    Tente une connexion à la base PostgreSQL spécifiée
    '''
    try:
        conn = psycopg2.connect(host=hote, database=bdd, port=port, user=utilisateur, password=mdp)
        return True, 'OK'
    except Exception as e:
        return False, str(e)  
    
class ControleBDD(PgOutils):

    TABLES_DVF_PLUS = ['parcelle', 'adresse', 'suf', 'volume', 'adresse_dispoparc', 'adresse_local', 
                       'disposition', 'lot', 'mutation_article_cgi', 'disposition_parcelle', 'mutation', 'local']
    
    TABLES_ANNEXES = ['ann_nature_culture', 'ann_nature_culture_speciale', 'ann_cgi', 'ann_nature_mutation', 'ann_type_local']

    CHAMPS_MUTATION_DVF_PLUS = ['idmutation', 'idmutinvar', 'idnatmut', 'codservch', 'refdoc', 'datemut', 'anneemut',
                                'moismut', 'coddep', 'libnatmut', 'nbartcgi', 'l_artcgi', 'vefa', 'valeurfonc', 'nbdispo',
                                'nblot', 'nbcomm', 'l_codinsee', 'nbsection', 'l_section', 'nbpar', 'l_idpar', 'nbparmut',
                                'l_idparmut', 'nbsuf', 'sterr', 'l_dcnt', 'nbvolmut', 'nblocmut', 'l_idlocmut', 'nblocmai',
                                'nblocapt', 'nblocdep', 'nblocact', 'nbapt1pp', 'nbapt2pp', 'nbapt3pp', 'nbapt4pp',
                                'nbapt5pp', 'nbmai1pp', 'nbmai2pp', 'nbmai3pp', 'nbmai4pp', 'nbmai5pp', 'sbati', 'sbatmai',
                                'sbatapt', 'sbatact', 'sapt1pp', 'sapt2pp', 'sapt3pp', 'sapt4pp', 'sapt5pp', 'smai1pp',
                                'smai2pp', 'smai3pp', 'smai4pp', 'smai5pp']
    
    CHAMPS_DISPOSITION_PARCELLE_DVF_PLUS = ['iddispopar', 'iddispo', 'idparcelle', 'idmutation', 'idpar', 'coddep', 'codcomm', 'prefsect',
                                             'nosect', 'noplan', 'datemut', 'anneemut', 'moismut', 'parcvendue', 'nbmutjour', 'nbmutannee',
                                              'datemutpre', 'l_idmutpre', 'datemutsui', 'l_idmutsui', 'dcnt01', 'dcnt02', 'dcnt03', 'dcnt04',
                                               'dcnt05', 'dcnt06', 'dcnt07', 'dcnt08', 'dcnt09', 'dcnt10', 'dcnt11', 'dcnt12', 'dcnt13',
                                                'dcntsol', 'dcntagri', 'dcntnat']
    
    CHAMPS_LOCAL_DVF_PLUS = ['iddispoloc', 'iddispopar', 'idpar', 'idmutation', 'idloc', 'identloc', 'codtyploc', 'libtyploc',
                              'nbpprinc', 'sbati', 'coddep', 'datemut', 'anneemut', 'moismut', 'nbmutjour', 'nbmutannee', 'datemutpre',
                               'l_idmutpre', 'datemutsui', 'l_idmutsui']
    
    CHAMPS_MUTATION_DV3F = ['l_idv', 'l_nomv', 'codtypprov', 'fiabmaxv', 'l_ida', 'l_noma', 'codtypproa', 'fiabmaxa', 'ffsparc', 'ffsterr',
                             'l_ffdcnt', 'nbpardisp', 'nbparapp', 'ffnblocmai', 'ffnblocapt', 'ffnblocdep', 'ffnblocact', 'ffnbactsec', 
                             'ffnbactter', 'ffnbloch', 'nblocanc', 'nblocrecen', 'nblocneuf', 'ffancstmin', 'ffancstmax', 'ffnbloc1pp',
                              'ffnbloc2pp', 'ffnbloc3pp', 'ffnbloc4pp', 'ffnbloc5pp', 'ffnbpgarag', 'ffnbpterra', 'ffnbppisci', 'ffnbpcav',
                               'nblocdisp', 'nblocapp', 'ffsbati', 'ffshab', 'ffsdep', 'ffspro', 'occupation', 'codtypbien', 'libtypbien',
                                'rapatffloc', 'rapatffpar', 'geomlocmut', 'geomparmut', 'geompar']
    
    CHAMPS_DISPOSITION_PARCELLE_DV3F = ['ffidcpv', 'fiabilitev', 'l_idv', 'nbdroiprov', 'l_nomv', 'nbdroigesv', 'l_nomgesv', 'codtypprov',
                                         'ffidcpa', 'fiabilitea', 'l_ida', 'nbdroiproa', 'l_noma', 'nbdroigesa', 'l_nomgesa', 'codtypproa', 'ffdatemut',
                                          'exactffdvf', 'stabilitep', 'ffcodinsee', 'ffcommune', 'ffnovoie', 'ffbtq', 'ffvoie', 'fftyppdl',
                                           'ffsparc', 'ffsterr', 'ffdcnt01', 'ffdcnt02', 'ffdcnt03', 'ffdcnt04', 'ffdcnt05', 'ffdcnt06', 'ffdcnt07',
                                            'ffdcnt08', 'ffdcnt09', 'ffdcnt10', 'ffdcnt11', 'ffdcnt12', 'ffdcnt13', 'ffdcntsol', 'ffdcntagri', 'ffdcntnat',
                                             'ffparcbati', 'ffanref', 'ffanvend', 'ffanach', 'geomloc', 'geompar', 'srcgeom', 'parcvect']
    
    CHAMPS_LOCAL_DV3F = ['ffidcpv', 'fiabilitev', 'l_idv', 'nbdroiprov', 'l_nomv', 'nbdroigesv', 'l_nomgesv',
                          'codtypprov', 'ffidcpa', 'fiabilitea', 'l_ida', 'nbdroiproa', 'l_noma', 'nbdroigesa',
                           'l_nomgesa', 'codtypproa', 'ffdatemut', 'exactffdvf', 'ffancst', 'anciennete', 'ffidbat',
                            'ffcodinsee', 'ffcommune', 'ffnovoie', 'ffbtq', 'ffvoie', 'fftyppdl', 'ffclascad',
                             'ffvalloc', 'ffcodeval', 'fflibeval', 'ffcchgeval', 'ffdchgeval', 'stabilitel',
                              'ffctyploc', 'ffltyploc', 'ffcnatloc', 'fflnatloc', 'ffcodnace', 'fflibnace',
                               'fflochab', 'ffoccv', 'ffocca', 'ffshab', 'ffsdep', 'ffspro', 'ffsbati',
                               'ffnbpsam', 'ffnbpcha', 'ffnbpcu8', 'ffnbpcu9', 'ffnbpsea', 'ffnbpann',
                                 'ffnbpprinc', 'ffnbpgarag', 'ffnbpagrem', 'ffnbpterra', 'ffnbppisci',
                                  'ffnbpcav', 'ffanref', 'ffanvend', 'ffanach', 'geomloc', 'srcgeom', 'parcvect']



    def __init__(self, hote, base, port, utilisateur, motdepasse, script = 'sorties/tmp.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)

    def est_une_base_DVF_plus(self):
        if not self.a_schemas_principaux():
            return False
        if not self.a_au_moins_un_schema_departemental():
            return False
        if not self.a_les_tables_dvf_plus():
            return False
        if not self.a_les_champs_dvf_plus():
            return False
        return True
    
    def est_une_base_DV3F(self):
        if not self.est_une_base_DVF_plus():
            return False
        if not self.a_les_tables_dv3f():
            return False
        if not self.a_les_champs_dv3f():
            return False
        return True

    def a_schemas_principaux(self):
        schemas = self.lister_schemas()
        if 'dvf' in schemas and 'dvf_annexe' in schemas:
            return True
        return False

    def a_au_moins_un_schema_departemental(self):
        return True if len(self.schemas_departementaux()) >= 1 else False

    def a_les_tables_dvf_plus(self):
        for schema in ['dvf'] + self.schemas_departementaux():
            tables = self.lister_tables(schema)
            if not set(self.TABLES_DVF_PLUS).issubset(set(tables)):
                return False
        tables = self.lister_tables('dvf_annexe')
        print([champ[1] for champ in self.lister_champs('dvf', 'local')])
        if not set(self.TABLES_ANNEXES).issubset(set(tables)):
                return False
        return True
    
    def a_les_tables_dv3f(self):
        for schema in ['dvf'] + self.schemas_departementaux():
            tables = self.lister_tables(schema)
            if not 'acheteur_vendeur' in tables:
                return False        
        return True

    def a_les_champs_dvf_plus(self):
        correspondance = {'mutation' : self.CHAMPS_MUTATION_DVF_PLUS, 
                          'disposition_parcelle' : self.CHAMPS_DISPOSITION_PARCELLE_DVF_PLUS,
                          'local' : self.CHAMPS_LOCAL_DVF_PLUS}
        return self._comparaison_champs(correspondance)
    
    def a_les_champs_dv3f(self):
        print([champ[1] for champ in self.lister_champs('dvf', 'mutation')])
        print([champ[1] for champ in self.lister_champs('dvf', 'disposition_parcelle')])
        print([champ[1] for champ in self.lister_champs('dvf', 'local')])
        correspondance = {'mutation' : self.CHAMPS_MUTATION_DV3F, 
                          'disposition_parcelle' : self.CHAMPS_DISPOSITION_PARCELLE_DV3F,
                          'local' : self.CHAMPS_LOCAL_DV3F}
        return self._comparaison_champs(correspondance)
        
    def _comparaison_champs(self, correspondance):
        for schema in ['dvf'] + self.schemas_departementaux():
            for table, CHAMPS in correspondance.items():
                champs = [champ[1] for champ in self.lister_champs(schema, table)]
                if not set(CHAMPS).issubset(set(champs)):
                    return False
        return True
    
    def schemas_departementaux(self):
        return self.lister_schemas_commencant_par('dvf_d')
    
    @select_sql_champ_unique
    def lister_codes_insee_commune(self, departement):
        pass
    
        
    
