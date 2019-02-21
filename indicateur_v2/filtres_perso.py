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
from main.configuration import BASE_DIR


class PersoManager():
    
    FICHIER_CONDITIONS = os.path.join(BASE_DIR, 'indicateur_v2', 'CONDITIONS.sql')
    
    def __init__(self):
        self.conditions_perso = self.charger_conditions()
    
    def charger_conditions(self):
        requete_sql = {}
        with open(self.FICHIER_CONDITIONS, 'rt', encoding = 'UTF-8') as f:
            lignes = f.readlines()
            clef = None
            for ligne in lignes:
                if ligne.strip().startswith('##'):
                    clef = ligne.strip()[2:].strip()
                    requete_sql[clef] = ''
                    continue
                requete_sql[clef] = requete_sql[clef] + ligne
        
        pos = 1
        conditions = []
        for clef, requete in requete_sql.items():
            condition = ConditionPerso(self.identifiant(pos), clef, requete)
            if condition.is_valid():
                conditions.append(condition)
                pos += 1
        return conditions
    
    def get_condition_by_id(self, identifiant):
        for condition in self.conditions_perso:
            if condition.identifiant == identifiant:
                return condition
        return None
          
    def identifiant(self, position):
        alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return alpha[position-1]
   
    
    
class ConditionPerso():
    
    def __init__(self, identifiant, nom, condition):
        self.identifiant = identifiant
        self.nom = nom
        self.condition = condition
    
    def is_valid(self):
        '''
        A faire évoluer
        '''
        return True