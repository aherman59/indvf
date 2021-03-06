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
from collections import namedtuple

from django.urls import reverse

from main.models import ConfigurationBDD
'''

VARIABLES POUR TOUTES LES APPLICATIONS

'''

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

'''

FONCTIONS POUR TOUTES LES APPLICATIONS

'''

def integrer_liens_doc_variables(html):
    '''
    utile pour les applications TutoDVF et DocDV3F
    '''
    html_separe = html.split('@@')
    html = ''
    for i, elt in enumerate(html_separe):            
        if (i%2 == 1):
            table, variable = elt.split('|')
            url = reverse('docdv3f:doc_variable', kwargs={'table': table, 'variable': variable})
            html += '<a href="{1}">{0}</a>'.format(variable, url)
        else:
            html += elt
    return html

def integrer_liens_tuto(html):
    '''
    utile pour les applications TutoDVF et DocDV3F
    '''
    html_separe = html.split('@TUTO@')
    html = ''
    for i, elt in enumerate(html_separe):            
        if (i%2 == 1):
            nb_section = len(elt.split('|'))
            if nb_section == 2:
                fiche_tuto, descriptif = elt.split('|')
            elif nb_section == 3:
                fiche_tuto, descriptif, ancre = elt.split('|')
            url = reverse('tutodvf:fiche', kwargs={'nom_fiche': fiche_tuto})
            html += '<a href="{1}">{0}</a>'.format(descriptif, url) if nb_section == 2 else '<a href="{1}#{2}">{0}</a>'.format(descriptif, url, ancre)
        else:
            html += elt
    return html



