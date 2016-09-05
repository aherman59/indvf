import os
from collections import namedtuple

from django.core.urlresolvers import reverse

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
            fiche_tuto, descriptif = elt.split('|')
            url = reverse('tutodvf:fiche', kwargs={'nom_fichier_md': fiche_tuto})
            html += '<a href="{1}">{0}</a>'.format(descriptif, url)
        else:
            html += elt
    return html


'''

GESTION DES APPLICATIONS POUR LE MENU PRINCIPAL

'''

def recuperer_metadonnees_applications_disponibles():
    applis = []
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])    
    for racine, repertoires, fichiers in os.walk(BASE_DIR):
        for fichier in fichiers:
            if fichier.lower() == 'metadata.txt':
                with open(os.path.join(racine, fichier), 'rt', encoding ='utf-8') as f:
                    meta ={}
                    for ligne in f:
                        if '=' in ligne:
                            attribut = ligne.split('=')[0]
                            valeur = ligne.split('=')[1]
                            meta[attribut.strip()] = valeur.strip()
                applis.append(appli_nt(**meta))
    return applis
