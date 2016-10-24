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
import re
from django.shortcuts import render
from django.http import Http404
from django.db.models.query import Q

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
    # recupération des données de la variable (description, valeurs, variables associées)
    desc_variable = variable.description
    valeurs_variable = ValeurVariable.objects.filter(description = desc_variable).order_by('valeur')
    groupements = GroupementVariable.objects.filter(variables_associees = variable)    
    context = {'variable':variable, 'desc_variable': desc_variable, 'valeurs_variable':valeurs_variable, 'groupements':groupements}
    return render(request, 'variable.html', context)

def recherche(request):
    
    if request.method == 'POST':
        variables = []
        if 'motclef' in request.POST:
            mots_clefs = re.findall(r'[\w\+]+',str(request.POST['motclef']))
            mots_clefs = [mot for mot in mots_clefs if (mot != '' and len(mot) >= 2)]
            
            # RECHERCHE VARIABLES 
            if(len(mots_clefs) == 1):
                variables = Variable.objects.filter(Q(nom__istartswith=mots_clefs[0])).distinct()
            else:
                y = Q()
                for mot in mots_clefs:
                    y = y & Q(nom__icontains=mot)
                
                variables = Variable.objects.filter(y).distinct().order_by('nom')
                
        context = {'mots_clefs': ' '.join(mots_clefs),
                   'variables' : variables
                   }
        return render(request, 'recherche_doc.html', context)
    else:
        raise Http404('Méthode POST incorrecte')
        
        
        