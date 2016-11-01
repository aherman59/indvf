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
        self._fiches = self.charger_fiches()
    
    @property
    def fiches(self):
        return self._fiches
    
    def fiches_avec(self, mots_clefs):
        return [fiche for fiche in self._fiches if fiche.avec(mots_clefs)]
                
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
    
    def charger_fiches(self):
        fiches = self._fiches_tuto()
        fiches_valides = self._fiches_valides(fiches)
        fiches_valides_triees = self._trier_fiches(fiches_valides)
        return fiches_valides_triees 
    
    def _fiches_tuto(self):
        for fichier in os.listdir(self.repertoire):
            if fichier.endswith('.md'):
                yield FicheTuto(self.repertoire, fichier)
    
    def _fiches_valides(self, fiches):    
        return (fiche for fiche in fiches if fiche.est_valide)        
    
    def _trier_fiches(self, fiches):
        fiches = sorted(fiches, key=lambda x: x.numero) # tri par numero
        return sorted(fiches, key=lambda x: self.THEMES[x.theme]) # tri par rubrique
    
    def _position(self, nom_fiche):
        return [i for i, fiche in enumerate(self.fiches) if fiche.nom_fiche == nom_fiche][0]    
    

class FicheTuto():
    
    def __init__(self, repertoire, fichier):
        self.fichier = fichier
        self.chemin_fichier = self.validation_chemin_fichier(repertoire, fichier)
        self.est_valide = self.charger_fiche()

    @property
    def nom_fiche(self):
        return self.fichier[:-3]
    
    @property
    def lien(self):
        return './' + self.nom_fiche
    
    @property
    def theme(self):
        return self._theme
    
    @property
    def titre(self):
        return self._titre
    
    @property
    def numero(self):
        return self._numero
    
    @property
    def auteurs(self):
        return self._auteurs
    
    @property
    def maj(self):
        return self._maj
    
    @property
    def contenu(self):
        return self._contenu
    
    def avec(self, mots_clefs):
        for mot in mots_clefs:
            if mot not in self._contenu:
                return False
        return True
    
    def validation_chemin_fichier(self, repertoire, fichier):
        chemin_fichier = os.path.join(repertoire, fichier)
        if not os.path.isfile(chemin_fichier):
            raise Exception('Fichier {0} inexistant'.format(chemin_fichier))
        return chemin_fichier        
    
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
        self._theme = metadonnees.get('theme')[0].strip() 
        self._titre = metadonnees.get('titre')[0].strip()
        self._numero = metadonnees.get('numero')[0]        
        self._auteurs = metadonnees.get('auteurs')[0].strip()
        self._maj = metadonnees.get('maj')[0].strip()
    
    def construction_html(self, txt_html_brut):
        txt_html_brut = integrer_liens_doc_variables(txt_html_brut)
        txt_html_brut = integrer_liens_tuto(txt_html_brut)
        self._contenu = markdown2html.convertir_html_brut_en_html_bootstrap(txt_html_brut)
        