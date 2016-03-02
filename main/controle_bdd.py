import psycopg2

def tentative_connexion(hote, bdd, utilisateur, mdp, port):
    try:
        conn = psycopg2.connect(host=hote, database=bdd, port=port, user=utilisateur, password=mdp)
        return True, 'OK'
    except Exception as e:
        return False, str(e)
    
