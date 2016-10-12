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

class ContexteFiltre():
    
    def __init__(self, request):
        self.session = request.session
        self.parametres = self.session['parametres_filtre'] if 'parametres_filtre' in self.session else dict()
        self.main(request.POST)
        
    def initialiser_valeurs(self):
        self.parametres['typologie'] = 0
        self.parametres['annee_min'] = 0
        self.parametres['annee_max'] = 0
        self.parametres['valeur_min'] = 0
        self.parametres['valeur_max'] = 10000000000
        
    def definir_modalites(self, mutations):
        self.parametres['typologies'] = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) 
                                                for mutation in mutations] + [(0, 'Tous')]), key = lambda x : x[1])    
        self.parametres['annees'] = sorted(set([int(mutation.anneemut) for mutation in mutations]))
        self.parametres['valeur_min_existante'] = min([float(mutation.valeurfonc) for mutation in mutations])
        self.parametres['valeur_max_existante'] = max([float(mutation.valeurfonc) for mutation in mutations])
        self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
        self.parametres['valeur_max'] = self.parametres['valeur_max_existante']
        if self.parametres['annee_min'] == 0:
            self.parametres['annee_min'] = min(self.parametres['annees'])
        if self.parametres['annee_max'] == 0:
            self.parametres['annee_max'] = max(self.parametres['annees'])    

    def main(self, post):
        if 'typologie' in post:
            self.selection_typologie(post['typologie'])
        elif 'annee_min' in post:
            self.selection_annee_min(post['annee_min'])
        elif 'annee_max' in post:
            self.selection_annee_max(post['annee_max'])
        elif 'valeur_min' in post:
            self.selection_valeur_min(post['valeur_min'])
        elif 'valeur_max' in post:
            self.selection_valeur_max(post['valeur_max'])        
    
    def selection_typologie(self, code_typo):
        code_typo = int(code_typo)        
        if code_typo in [code for (code, libelle) in self.parametres['typologies']]:
            self.parametres['typologie'] = code_typo
        else:
            self.parametres['typologie'] = 0
    
    def selection_annee_min(self, annee_min):
        annee_min = int(annee_min)
        if annee_min in self.parametres['annees']:
            self.parametres['annee_min'] = annee_min
        else:
            self.parametres['annee_min'] = min(self.parametres['annees'])
    
    def selection_annee_max(self, annee_max):
        annee_max = int(annee_max)
        if annee_max in self.parametres['annees']:
            self.parametres['annee_max'] = annee_max
        else:
            self.parametres['annee_max'] = max(self.parametres['annees'])
    
    def selection_valeur_min(self, valeur_min):
        
        try:
            valeur_min = int(valeur_min)
            if valeur_min >= self.parametres['valeur_min_existante']:
                self.parametres['valeur_min'] = valeur_min
            else:
                self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
        except Exception as e:
            self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
    
    def selection_valeur_max(self, valeur_max):
        try:
            valeur_max = int(valeur_max)
            if valeur_max <= self.parametres['valeur_max_existante']:
                self.parametres['valeur_max'] = valeur_max
            else:
                self.parametres['valeur_max'] = self.parametres['valeur_max_existante']
        except Exception as e:
            self.parametres['valeur_max'] = self.parametres['valeur_max_existante']   
