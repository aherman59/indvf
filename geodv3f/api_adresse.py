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