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