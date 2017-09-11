'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

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
        
