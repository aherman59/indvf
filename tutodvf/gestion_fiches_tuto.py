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
from html.parser import HTMLParser
from outils import markdown2html
from main.configuration import integrer_liens_doc_variables, integrer_liens_tuto


class RepertoireTuto():
    
    THEMES = {'Bien démarrer avec DV3F': 'A', 'Plus loin avec DV3F':'B', 'Mise en place de DVF+/DV3F': 'C', 'Choix méthodologiques dans DV3F' : 'D', 
              'Usages avancés de DV3F' : 'E', 'OLD' : 'F'}
    
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
        recherche = ParserRecherche(mots_clefs)
        recherche.feed(self._contenu)
        return recherche.success
    
    def extrait(self, mots_clefs):
        recherche = ParserRecherche(mots_clefs)
        recherche.feed(self._contenu)
        if recherche.success:
            return recherche.presentation_extraits
    
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


class ParserRecherche(HTMLParser):
    
    def __init__(self, mots_clefs):
        HTMLParser.__init__(self)
        self.mots_clefs = mots_clefs
        self._extraits =[]
    
    def handle_data(self, data):
        HTMLParser.handle_data(self, data)
        for mot in self.mots_clefs:
            if mot in data:
                self._extraits.append(data)
    
    @property
    def success(self):
        for mot in self.mots_clefs:
            extraits_contenant_mot = [extrait for extrait in self._extraits if mot in extrait]
            if len(extraits_contenant_mot) == 0:
                return False
        return True
    
    @property
    def extraits(self):
        return list(set(self._extraits))
    
    @property    
    def presentation_extraits(self):
        extraits = self.extraits
        for mot in self.mots_clefs:
            extraits = [extrait.replace(mot, '<b>{0}</b>'.format(mot)) for extrait in extraits]
        extraits = [extrait for extrait in extraits if all(mot in extrait for mot in self.mots_clefs)] + [extrait for extrait in extraits if not all(mot in extrait for mot in self.mots_clefs)]
        extraits = ['...{0}'.format(extrait) for extrait in extraits[:3]]
        return ' '.join(extraits) + '<b>...</b>'
        
                