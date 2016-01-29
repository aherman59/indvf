import psycopg2
from main.models import ConfigurationBDD

def tentative_connexion(hote, bdd, utilisateur, mdp, port):
    try:
        conn = psycopg2.connect(host=hote, database=bdd, port=port, user=utilisateur, password=mdp)
        return True, 'OK'
    except Exception as e:
        return False, str(e)

def desactiver_connexions():
    for config in ConfigurationBDD.objects.all():
        config.active = False
        config.save()

def configuration_active():
    try: 
        config = ConfigurationBDD.objects.get(active=True)
        return config
    except Exception as e:
        return None

