import os
import re
import zipfile
import io

from pg.pgbasics import *
from main.configuration import BASE_DIR

class ExportQGis():
    
    REPERTOIRE_QGIS = os.path.join(BASE_DIR, 'exportdvf', 'qgis')
    
    def __init__(self, session, box):
        self.type_bdd = session['type_bdd']
        self.params = session['params']
        self.box = box
            
    def nom_prj(self, extension):
        base = self.params[1]
        return 'prj_qgis_' + base + '.' + extension
    
    @property
    def chemin_archive(self):
        return self.chemin(self.nom_prj('zip'))
    
    def chemin(self, fichier):
        return os.path.join(self.REPERTOIRE_QGIS, fichier)

    def flux_archive(self):
        self.modifier_projet_avec_params_bdd()
        fichiers = [self.nom_prj('qgs'), 'interface.ui']        
        with zipfile.ZipFile(self.chemin_archive, 'w') as z:
            for fichier in fichiers:
                z.write(self.chemin(fichier), os.path.join('projet_qgis',fichier))
        return open(self.chemin_archive, 'rb')
    
    def nettoyer(self):
        os.remove(self.chemin(self.nom_prj('qgs')))
            
    def modifier_projet_avec_params_bdd(self):
        # creation vues à prévoir
        projet_modele = self.chemin('projet_qgis_modele.qgs')
        projet_modif = self.chemin(self.nom_prj('qgs'))
        (hote, base, port, utilisateur, _) = self.params
        with open(projet_modele, 'r', encoding='utf-8') as modele:
            with open(projet_modif, 'w', encoding='utf-8', newline='\n') as sortie:
                for ligne in modele:
                    if "dbname='XXXX'" in ligne:
                        ligne = ligne.replace("XXXX", base, 1)
                    if "host=XXXX" in ligne:
                        ligne = ligne.replace("XXXX", hote, 1)
                    if "port=XXXX" in ligne:
                        ligne = ligne.replace("XXXX", port, 1)
                    if "user='XXXX'" in ligne:
                        ligne = ligne.replace("XXXX", utilisateur, 1)
                    if 'xmin' in ligne:
                        xmin = str(self.box[0]).replace(',','.')
                        ligne = re.sub('<xmin>[0-9.,]{1,}</xmin>', '<xmin>{0}</xmin>'.format(xmin), ligne)
                    if 'ymin' in ligne:
                        ymin = str(self.box[1]).replace(',','.')
                        ligne = re.sub('<ymin>[0-9.,]{1,}</ymin>', '<ymin>{0}</ymin>'.format(ymin), ligne)
                    if 'xmax' in ligne:
                        xmax = str(self.box[2]).replace(',','.')
                        ligne = re.sub('<xmax>[0-9.,]{1,}</xmax>', '<xmax>{0}</xmax>'.format(xmax), ligne)
                    if 'ymax' in ligne:
                        ymax = str(self.box[3]).replace(',','.')
                        ligne = re.sub('<ymax>[0-9.,]{1,}</ymax>', '<ymax>{0}</ymax>'.format(ymax), ligne)
                    sortie.write(ligne)                         


class RequeteurExportQGis(PgOutils):
    
    def __init__(self, params, script = None):
        super().__init__(*params, script=script)
    
    @requete_sql
    def generer_vues_qgis(self):
        pass
    
    def emprise(self):
        # xmin, ymin, xmax, ymax
        box = (self.box())[0] if self.box() else (100000, 6000000, 1200000, 7100000)
        return list(box)
    
    @select_sql
    def box(self):
        pass
        
