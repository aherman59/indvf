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
import csv
from django.shortcuts import render
from django.http import HttpResponse
from django.http import Http404
from django.db.models.query import Q

from .description_tables import TABLES, lister_tables
from .models import DescriptionVariable 
from .models import Variable 
from .models import ValeurVariable
from .models import GroupementVariable
from .models import integration_donnees_variables


def accueil_doc(request):
    #integration_donnees_variables()
    context = {'tables' : TABLES}
    return render(request, 'accueil.html', context)

def doc_table(request, table):
    nom_tables_permises = lister_tables()
    if table not in nom_tables_permises:
        raise Http404('Table inexistante')             
    variables = Variable.objects.filter(table_associee = table).order_by('position')
    return render(request, 'table.html', locals())
        
def doc_variable(request, table, variable):
    try:
        variable = Variable.objects.get(table_associee = table, nom = variable)
    except:
        raise Http404('Variable inexistante')
    # recupération des données de la variable (description, valeurs, variables associées)
    desc_variable = variable.description
    valeurs_variable = ValeurVariable.objects.filter(description = desc_variable).order_by('valeur')
    groupements = GroupementVariable.objects.filter(variables_associees = variable)    
    return render(request, 'variable.html', locals())

def recherche(request):    
    if request.method == 'POST':
        contexte_recherche = ContexteRechercheDoc(request.POST)                
        context = {'mots_clefs': contexte_recherche.mots_clefs,
                   'variables' : contexte_recherche.variables,}
        return render(request, 'recherche_doc.html', context)
    else:
        raise Http404('Méthode POST incorrecte')

"""

EXPORT CSV DE LA DOCUMENTATION

"""

def doc_table_csv(request, table):
    nom_tables_permises = lister_tables()
    if table not in nom_tables_permises:
        raise Http404('Table inexistante')             
    variables = Variable.objects.filter(table_associee = table).order_by('position')    
    entete = ['Table', 'Position', 'Nom', 'Description', 'Modèle', 'Contrainte']
    lignes = [(v.table_associee, v.position, v.nom, v.description_simplifiee, v.modele, v.contrainte) for v in variables]        
    return reponse_csv('{0}.csv'.format(table), lignes, entete)

def reponse_csv(nom_fichier, lignes, entete = None):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachement; filename="{0}"'.format(nom_fichier)
    writer = csv.writer(response, delimiter=';')
    if entete:
        writer.writerow(entete)
    for ligne in lignes:
        writer.writerow(ligne)
    return response
      

class ContexteRechercheDoc():

    def __init__(self, post):
        self.variables = []
        self.mots_clefs = '' 
        if 'motclef' in post:
            self.recherche(post['motclef'])
    
    def recherche(self, motclef):
        mots_clefs = self.decoupage(motclef)
        self.variables = self.resultat(mots_clefs)
        self.mots_clefs = ' '.join(mots_clefs)
    
    def decoupage(self, motclef):
        mots_clefs = re.findall(r'[\w]+',str(motclef))
        return [mot for mot in mots_clefs if (mot != '' and len(mot) >= 2)]
    
    def resultat(self, mots_clefs):
        y = Q()
        for mot in mots_clefs:
            y = y & (Q(nom__icontains=mot) | Q(description_simplifiee__icontains=mot))
        return Variable.objects.filter(y).distinct().order_by('nom')
