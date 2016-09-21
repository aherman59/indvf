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

# Dictionnaire décrivant les tables DVF+ et DV3F
TABLES = [{'nom' : 'Tables principales' , 
           'desc_table' : [{'mutation' : 'table des mutations'},
                      {'disposition_parcelle' : 'table des parcelles attachées à une disposition'},
                      {'local' :'table des locaux'},
                      {'acheteur_vendeur' : 'table anonymisée des acheteurs et des vendeurs'}]
           },
          {'nom' : 'Tables secondaires' , 
           'desc_table' : [{'adresse' : 'table contenant les adresses (provenant des parcelles et des locaux)'},
                      {'adresse_dispoparc' : 'table de liaison entre la table adresse et la table disposition_parcelle'},
                      {'adresse_local' : 'table de liaison entre la table adresse et la table local'},
                      {'disposition' : 'table des dispositions'},
                      {'lot' : 'table des lots (seuls les 5 premiers lots sont mentionnés)'},
                      {'mutation_article_cgi' : 'table des articles du code général des impôts (CGI) attachés à la mutation'},
                      {'parcelle' :'table des parcelles'},
                      {'suf' : 'table des subdivisions fiscales'},
                      {'volume' : 'table des volumes (division de l\'espace dans la hauteur pour certaines co-propriétés verticales'}]
           },
          {'nom' : 'Tables annexes' , 
           'desc_table' : [{'ann_cgi' : 'table contenant les différents articles CGI'},
                            {'ann_nature_culture' : 'table contenant les différentes natures de culture'},
                            {'ann_nature_culture_speciale' : 'table contenant les différentes natures de culture spéciale'},
                             {'ann_nature_mutation' : 'table contenant les natures de mutation'},
                              {'ann_type_local' : 'table contenant les types de locaux'}]
           }
          ]

def lister_tables():
    nom_tables = []
    for groupe in TABLES:
        descriptions = groupe['desc_table']
        for description in descriptions:
            for nom in description.keys():
                nom_tables.append(nom)        
    return nom_tables


#eof