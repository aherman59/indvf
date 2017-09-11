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

import urllib.request
import json

class RechercheAdresse():
    
    URL_SEARCH = 'http://api-adresse.data.gouv.fr/search/?{0}'
    URL_REVERSE = 'http://api-adresse.data.gouv.fr/reverse/?{0}'
    
    def __init__(self):
        self.reponse = None 
   
    @property
    def nb_resultats(self):
        if not self.reponse or 'features' not in self.reponse:
            return 0
        return len((self.reponse)['features'])
    
    @property
    def adresses(self):
        if not self.reponse or 'features' not in self.reponse:
            return None
        return [Adresse(entite) for entite in (self.reponse)['features']]
    
    @property
    def meilleure_adresse(self):
        if self.nb_resultats == 0:
            return None
        return max(self.adresses, key=lambda x: x.score_recherche)

    def texte(self, recherche):
        donnees = None
        params = urllib.parse.urlencode({'q': recherche})
        try:
            with urllib.request.urlopen(url = self.URL_SEARCH.format(params)) as reponse:
                donnees = reponse.read().decode('utf-8')
                donnees = json.loads(donnees)
        except Exception as e:
            print(e)
            return None
        self.reponse = donnees
    
    def coordonnees(self, longitude, latitude):
        donnees = None
        params = urllib.parse.urlencode({'lon': longitude, 'lat':latitude})
        try:
            with urllib.request.urlopen(url = self.URL_REVERSE.format(params)) as reponse:
                donnees = reponse.read().decode('utf-8')
                donnees = json.loads(donnees)
        except Exception as e:
            print(e)
            return None
        self.reponse = donnees


class Adresse():
    
    def __init__(self, infos):
        self.data = infos['properties'] if 'properties' in infos else None
        self.geom = infos['geometry'] if 'geometry' in infos else None
    
    @property
    def score_recherche(self):
        return self._valeur_data('score')
    
    @property
    def type(self):
        return self._valeur_data('type')
    
    @property
    def libelle(self):
        return self._valeur_data('label')
    
    @property
    def voie(self):
        return self._valeur_data('name')
    
    @property
    def commune(self):
        return self._valeur_data('city')
    
    @property
    def code_insee(self):
        return self._valeur_data('citycode')
    
    @property
    def code_postal(self):
        return self._valeur_data('postcode')
    
    @property
    def departement_region(self):
        return self._valeur_data('context')
        
    @property
    def coordonnees(self):
        return self._valeur_geom('coordinates')

    @property
    def x(self):
        if self.coordonnees:
            return self.coordonnees[0]
        return None
    
    @property
    def y(self):
        if self.coordonnees:
            return self.coordonnees[1]
        return None
    
    def __repr__(self):
        return '{0} - coord : {1},{2} - score : {3}'.format(self.libelle, str(self.x), str(self.y), self.score_recherche)
           
    def _valeur_data(self, clef):
        if self.data is not None and clef in self.data:
            return (self.data)[clef]
        return None
    
    def _valeur_geom(self, clef):
        if self.geom is not None and clef in self.geom:
            return (self.geom)[clef]
        return None
    
        
if __name__ == '__main__':
    import sys
    recherche = RechercheAdresse()
    recherche.coordonnees(2.37, 48.357)
    print(recherche.adresses)
    print(recherche.meilleure_adresse.geom)
    print(recherche.meilleure_adresse.coordonnees)
    recherche.texte('13 rue Bernard Palissy')
    print(recherche.adresses)
    print(recherche.meilleure_adresse.geom)