import os
from collections import namedtuple
from main.models import ConfigurationBDD
'''

VARIABLES POUR TOUTES LES APPLICATIONS

'''

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

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
