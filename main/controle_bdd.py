import psycopg2
from pg.pgbasics import *

def tentative_connexion(hote, bdd, utilisateur, mdp, port):
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

    def __init__(self, hote, base, port, utilisateur, motdepasse, script = 'sorties/tmp.sql'):
        super().__init__(hote, base, port, utilisateur, motdepasse, script)

    def est_une_base_DVF_plus(self):
        if not self.a_schemas_principaux():
            return False
        if not self.a_au_moins_un_schema_departemental():
            return False
        if not self.a_les_tables_dvf_plus():
            return False
        if not self.a_les_champs_dvf_plus_principaux():
            return False
        return True

    def a_schemas_principaux(self):
        schemas = self.lister_schemas()
        if 'dvf' in schemas and 'dvf_annexe' in schemas:
            return True
        return False

    def a_au_moins_un_schema_departemental(self):
        return True if len(self.lister_schemas_commencant_par('dvf_d')) >= 1 else False

    def a_les_tables_dvf_plus(self):
        for schema in ['dvf'] + self.lister_schemas_commencant_par('dvf_d'):
            tables = self.lister_tables(schema)
            if not set(self.TABLES_DVF_PLUS).issubset(set(tables)):
                return False
        tables = self.lister_tables('dvf_annexe')
        print([champ[1] for champ in self.lister_champs('dvf', 'mutation')])
        if not set(self.TABLES_ANNEXES).issubset(set(tables)):
                return False
        return True

    def a_les_champs_dvf_plus_principaux(self):
        for schema in ['dvf'] + self.lister_schemas_commencant_par('dvf_d'):
            champs = [champ[1] for champ in self.lister_champs('dvf', 'mutation')]
            if not set(self.CHAMPS_MUTATION_DVF_PLUS).issubset(set(champs)):
                return False
        return True
