from django.shortcuts import render
from django.http import Http404

from .description_tables import TABLES, lister_tables
from .models import DescriptionVariable, Variable, ValeurVariable, GroupementVariable, integration_donnees_variables

def accueil_doc(request):
    #integration_donnees_variables()
    context = {'tables' : TABLES}
    return render(request, 'accueil.html', context)

def doc_table(request, table):
    nom_tables_permises = lister_tables()
    if table not in nom_tables_permises:
        raise Http404('Table inexistante')             
    variables = Variable.objects.filter(table_associee = table)
    context = {'variables':variables, 'table' : table}
    return render(request, 'table.html', context)

def doc_variable(request, table, variable):
    try:
        variable = Variable.objects.get(table_associee = table, nom = variable)
    except:
        raise Http404('Variable inexistante')
    # recupération des données de la variable (description, valeurs, variables associées
    desc_variable = variable.description
    valeurs_variable = ValeurVariable.objects.filter(description = desc_variable).order_by('valeur')
    groupements = GroupementVariable.objects.filter(variables_associees = variable)    
    context = {'variable':variable, 'desc_variable': desc_variable, 'valeurs_variable':valeurs_variable, 'groupements':groupements}
    return render(request, 'variable.html', context)

    