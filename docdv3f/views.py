from django.shortcuts import render
from docdv3f.models import DescriptionVariable, Variable, ValeurVariable, integration_donnees_variables

# Create your views here.


def accueil_doc(request):
    integration_donnees_variables()
    context = None
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

    