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
    mode_internet = True if 'doc-datafoncier' in request.build_absolute_uri() else False
    context = {'tables' : TABLES, 'mode_internet': mode_internet}
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
    entete = ['Table', 
              'Position', 
              'Nom', 
              'Description', 
              'Modèle', 
              'DV3F v1', 
              'DV3F v2', 
              'Contrainte']
    lignes = [(v.table_associee, 
               v.position, 
               v.nom, 
               v.description_simplifiee, 
               v.modele,
               'X' if v.is_in_version(1) else '',
               'X' if v.is_in_version(2) else '', 
               v.contrainte) for v in variables]        
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
