from pg.pgbasics import *

class Valideur(PgOutils):
    
    TABLES_DVF_PLUS = ['parcelle', 'adresse', 'suf', 'volume', 'adresse_dispoparc', 'adresse_local', 
                       'disposition', 'lot', 'mutation_article_cgi', 'disposition_parcelle', 'mutation', 'local']
    
    TABLES_ANNEXES = ['ann_nature_culture', 'ann_nature_culture_speciale', 'ann_cgi', 'ann_nature_mutation', 'ann_type_local']

    
    def __init__(self, hote, base, port, utilisateur, motdepasse):
        super().__init__(hote, base, port, utilisateur, motdepasse)
    
    def validation_creation_schemas(self, departements, effacer_schemas_existants):
        schemas_departementaux = self.lister_schemas_commencant_par('dvf_d')
        schema_annexe_ok = ('dvf_annexe' in self.lister_schemas()) 
        departements_presents = [dep[5:] for dep in schemas_departementaux]
        print(departements_presents, departements)
        if set(departements).issubset(set(departements_presents)) and schema_annexe_ok:
            if not effacer_schemas_existants:
                return True
            else :
                if set(departements_presents).issubset(set(departements)):
                    return True
        return False
    
    def validation_creation_tables(self, departements):
        for departement in departements:
            tables = self.lister_tables('dvf_d' + departement)
            if not set(self.TABLES_DVF_PLUS).issubset(tables):
                 return False
        tables_annexes = self.lister_tables('dvf_annexe')
        if not set(self.TABLES_ANNEXES).issubset(tables_annexes):
            return False
        return True