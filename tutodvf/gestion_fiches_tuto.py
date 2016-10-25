'''

#    Copyright (C) 2016  Cerema
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

'''

import os
from outils import markdown2html
from main.configuration import integrer_liens_doc_variables, integrer_liens_tuto


class RepertoireTuto():
    
    THEMES = {'Tutoriel': 'A', 'Base de données' : 'B', 
              'Méthode' : 'C', 'Variable' : 'D'}
    
    def __init__(self, repertoire):
        if not os.path.isdir(repertoire):
            raise Exception('Répertoire {0} invalide'.format(repertoire))
        self.repertoire = repertoire
        self.fiches = self.charger_fiches()
    
    def charger_fiches(self):
        fiches = [FicheTuto(self.repertoire, fichier) for fichier in os.listdir(self.repertoire) if fichier.endswith('.md')]
        fiches_valides = self._fiches_valides(fiches)
        fiches_valides_triees = self._trier_fiches(fiches_valides)
        return fiches_valides_triees
    
    def fiche(self, nom_fiche):
        position_fiche = self._position(nom_fiche)
        return self.fiches[position_fiche]
    
    def fiche_precedente(self, nom_fiche):
        position_fiche = self._position(nom_fiche)
        if position_fiche > 0:
            return self.fiches[position_fiche - 1]
        return None
    
    def fiche_suivante(self, nom_fiche):
        position_fiche = self._position(nom_fiche)
        if position_fiche < len(self.fiches) - 1:
            return self.fiches[position_fiche + 1]
        return None
    
    def _fiches_valides(self, fiches):    
        return [fiche for fiche in fiches if fiche.est_valide]        
    
    def _trier_fiches(self, fiches):
        fiches = sorted(fiches, key=lambda x: x.numero) # tri par numero
        return sorted(fiches, key=lambda x: self.THEMES[x.theme]) # tri par rubrique
    
    def _position(self, nom_fiche):
        return [i for i, fiche in enumerate(self.fiches) if fiche.nom_fiche == nom_fiche][0]
    
    

class FicheTuto():
    
    def __init__(self, repertoire, fichier):
        self.chemin_fichier = os.path.join(repertoire, fichier)
        if not os.path.isfile(self.chemin_fichier):
            raise Exception('Fichier {0} inexistant'.format(self.chemin_fichier))
        self.nom_fiche = fichier[:-3]
        self.lien = './' + self.nom_fiche
        self.est_valide = self.charger_fiche()
    
    def charger_fiche(self):
        try:
            with open(self.chemin_fichier, encoding='utf-8') as f:
                txt_md = f.read()
                metadonnees, txt_html_brut = markdown2html.convertir_markdown_en_html(txt_md)
                self.construction_metadonnees(metadonnees)
                self.construction_html(txt_html_brut)
                return True
        except Exception as e:
            print(e)
            print("La fiche {0} n'est pas valide.".format(str(self.chemin_fichier)))
            return False
    
    def construction_metadonnees(self, metadonnees):
        self.theme = metadonnees.get('theme')[0].strip() 
        self.titre = metadonnees.get('titre')[0].strip()
        self.numero = metadonnees.get('numero')[0]        
        self.auteurs = metadonnees.get('auteurs')[0].strip()
        self.maj = metadonnees.get('maj')[0].strip()
    
    def construction_html(self, txt_html_brut):
        txt_html_brut = integrer_liens_doc_variables(txt_html_brut)
        txt_html_brut = integrer_liens_tuto(txt_html_brut)
        self.contenu = markdown2html.convertir_html_brut_en_html_bootstrap(txt_html_brut)
                 
        
            
    
    

