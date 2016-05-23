from django.shortcuts import render
from docdv3f.models import DescriptionVariable, Variable, ValeurVariable, integration_donnees_variables

# Dictionnaire décrivant les tables DVF+ et DV3F
TABLES = [{'nom' : 'Tables principales' , 
           'desc_table' : [{'mutation' : 'table des mutations'},
                      {'disposition_parcelle' : 'table des parcelles attachées à une disposition'},
                      {'local' :'table des locaux'},
                      {'acheteur_vendeur' : 'table anonymisée des acheteurs et des vendeurs'}]
           },
          {'nom' : 'Tables secondaires' , 
           'desc_table' : [{'adresse' : 'table contenant les adresses (provenant des parcelles et des locaux'},
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

def accueil_doc(request):
    #integration_donnees_variables()
    context = {'tables' : TABLES}
    return render(request, 'accueil.html', context)

def doc_table(request, table):
    variables = Variable.objects.filter(table_associee = table)
    context = {'variables':variables, 'table' : table}
    return render(request, 'table.html', context)

def doc_variable(request, table, variable):
    variable = Variable.objects.get(table_associee = table, nom = variable)
    desc_variable = variable.description
    valeurs_variable = ValeurVariable.objects.filter(description = desc_variable)
    context = {'variable':variable, 'desc_variable': desc_variable, 'valeurs_variable':valeurs_variable}
    return render(request, 'variable.html', context)

    