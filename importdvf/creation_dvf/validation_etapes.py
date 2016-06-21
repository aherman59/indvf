from pg.pgbasics import *

class Valideur(PgOutils):
    
    TABLES_DVF_PLUS = ['parcelle', 'adresse', 'suf', 'volume', 'adresse_dispoparc', 'adresse_local', 
                       'disposition', 'lot', 'mutation_article_cgi', 'disposition_parcelle', 'mutation', 'local']
    
    TABLES_ANNEXES = ['ann_nature_culture', 'ann_nature_culture_speciale', 'ann_cgi', 'ann_nature_mutation', 'ann_type_local']

    
    def __init__(self, hote, base, port, utilisateur, motdepasse):
        super().__init__(hote, base, port, utilisateur, motdepasse)
    
    def validation_creation_tables(self, departements, effacer_schemas_existants):
        schemas_departementaux = self.lister_schemas_commencant_par('dvf_d')
        departements_presents = [dep[5:] for dep in schemas_departementaux]
        if departements in departements_presents:
            if not effacer_schemas_existants:
                return True
            else :
                if departements_presents in departements:
                    return True
                else:
                    return False
             