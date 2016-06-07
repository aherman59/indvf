import os
import markdown

from django.shortcuts import render, redirect
from django.template.response import TemplateResponse

from main.configuration import BASE_DIR

REPERTOIRE_FICHES = os.path.join(BASE_DIR, 'tutodvf', 'fiches')

def accueil(request):
    fiches = []        
    for fichier in os.listdir(REPERTOIRE_FICHES):
        if fichier.endswith('.md'):
            chemin_fichier = os.path.join(REPERTOIRE_FICHES, fichier)
            metadonnees, txt = convertir_markdown_en_html(open(chemin_fichier, encoding='utf-8').read())
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
    metadonnees, txt_html_brut = convertir_markdown_en_html(txt_fiche)
    txt_html_bootstrap = _convertir_html_brut_en_html_bootstrap(txt_html_brut)
    context = {'contenu' : txt_html_bootstrap, 'meta' : metadonnees}
    return render(request, 'fiche.html', context)
    
def convertir_markdown_en_html(txt_fiche):
    md = markdown.Markdown(output_format = 'html5', encoding='utf-8', extensions=['markdown.extensions.extra', 'markdown.extensions.meta'])
    txt_html_brut = md.convert(txt_fiche)
    metadonnees = md.Meta
    return metadonnees, txt_html_brut    

def _convertir_html_brut_en_html_bootstrap(html_brut):
    html_bootstrap = html_brut.replace('<table>', '<table class = "table table-condensed table-striped">')
    html_bootstrap = html_bootstrap.replace('ressources/', '/static/img/tutodvf/')
    html_bootstrap = html_bootstrap.replace('<p><img', '<p class = "p-center"><img')
    return html_bootstrap
