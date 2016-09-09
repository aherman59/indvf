import os
from outils import markdown2html
from main.configuration import integrer_liens_doc_variables, integrer_liens_tuto

THEMES = {'Tutoriel': 'A', 
          'Base de données' : 'B', 
          'Méthode' : 'C', 
          'Variable' : 'D'}

def obtenir_fiches_disponibles(repertoire):
    fiches = []        
    for fichier in os.listdir(repertoire):
        if fichier.endswith('.md'):
            try :
                chemin_fichier = os.path.join(repertoire, fichier)
                metadonnees, txt_html_brut = markdown2html.convertir_markdown_en_html(open(chemin_fichier, encoding='utf-8').read())
                txt_html_brut = integrer_liens_doc_variables(txt_html_brut)
                txt_html_brut = integrer_liens_tuto(txt_html_brut)
                txt_html_bootstrap = markdown2html.convertir_html_brut_en_html_bootstrap(txt_html_brut)
                fiches.append({'theme' : metadonnees.get('theme')[0].strip(), 
                               'titre' : metadonnees.get('titre')[0].strip(), 
                               'lien' : './' + fichier[:-3],
                               'numero' : metadonnees.get('numero')[0],
                               'contenu' : txt_html_bootstrap,
                               'auteurs' : metadonnees.get('auteurs')[0].strip(),
                               'maj' : metadonnees.get('maj')[0].strip()})
            except Exception as e:
                "La fiche " + str(fichier) + " n'est pas valide."
    fiches = sorted(fiches, key=lambda x: int(x['numero']))
    fiches = sorted(fiches, key=lambda x: THEMES[x['theme']])
    return fiches

