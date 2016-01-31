from main.models import ConfigurationBDD
from main.forms import ConfigBDDForm

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
        return True
    else:
        return False

def maj_et_activer_configuration(valeurs_configform, config_choisie):
    configform = ConfigBDDForm(valeurs_configform, instance = config_choisie)
    if configform.is_valid():
        desactiver_connexions()
        configform.save() 
        activer(config_choisie)
        return True
    else:
        return False

        
