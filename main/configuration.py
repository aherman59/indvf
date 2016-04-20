import os
from collections import namedtuple
from main.models import ConfigurationBDD
from main.forms import ConfigBDDForm

'''

GESTION DES APPLICATIONS POUR LE MENU PRINCIPAL

'''

def recuperer_metadonnees_applications_disponibles():
    applis = []
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
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


'''

GESTION DE LA CONFIGURATION DES BASES DE DONNEES DVF+ ET DV3F

'''

def desactiver_connexions():
    for config in ConfigurationBDD.objects.all():
        config.active = False
        config.save()

def activer(config):
    config.active = True
    config.save()

def configuration_active():
    try: 
        config = ConfigurationBDD.objects.get(active=True)
        return config
    except Exception as e:
        return None

def creer_et_activer_nouvelle_configuration(valeurs_configform):
    configform = ConfigBDDForm(valeurs_configform)
    if configform.is_valid():
        desactiver_connexions()
        nvelle_config = configform.save(commit=False)
        activer(nvelle_config)
        return True, configform
    else:
        return False, configform

def maj_et_activer_configuration(valeurs_configform, config_choisie):
    configform = ConfigBDDForm(valeurs_configform, instance = config_choisie)
    if configform.is_valid():
        desactiver_connexions()
        configform.save() 
        activer(config_choisie)
        return True, configform
    else:
        return False, configform

        
