import os
from outils import markdown2html

from django.shortcuts import render, redirect
from django.template.response import TemplateResponse

from main.configuration import BASE_DIR, integrer_liens_doc_variables

REPERTOIRE_FICHES = os.path.join(BASE_DIR, 'tutodvf', 'fiches')

def accueil(request):
    fiches = []        
    for fichier in os.listdir(REPERTOIRE_FICHES):
        if fichier.endswith('.md'):
            chemin_fichier = os.path.join(REPERTOIRE_FICHES, fichier)
            metadonnees, txt = markdown2html.convertir_markdown_en_html(open(chemin_fichier, encoding='utf-8').read())
            fiches.append({'theme' : metadonnees.get('theme')[0].strip(), 
                           'titre' : metadonnees.get('titre')[0].strip(), 
                           'lien' : './' + fichier[:-3],
                           'numero' : metadonnees.get('numero')[0]})
            fiches = sorted(fiches, key=lambda x: x['theme'])
    context = {'fiches' : fiches}
    return render(request, 'sommaire.html', context)
    
def fiche(request, nom_fichier_md):
    fiche = os.path.join(REPERTOIRE_FICHES, nom_fichier_md + '.md')
    try:
        txt_fiche = open(fiche, encoding='utf-8').read()
    except Exception as e:
        print(e)
        return redirect('tutodvf:accueil')
    metadonnees, txt_html_brut = markdown2html.convertir_markdown_en_html(txt_fiche)
    txt_html_brut = integrer_liens_doc_variables(txt_html_brut)
    txt_html_bootstrap = markdown2html.convertir_html_brut_en_html_bootstrap(txt_html_brut)
    context = {'contenu' : txt_html_bootstrap, 'meta' : metadonnees}
    return render(request, 'fiche.html', context)

