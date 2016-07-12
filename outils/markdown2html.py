'''
Module pour la conversion des formats markdown en html dans indvf
'''

import markdown
    
def convertir_markdown_en_html(txt_fiche):
    if txt_fiche.strip() == '':
        return '', ''
    md = markdown.Markdown(output_format = 'html5', encoding='utf-8', extensions=['markdown.extensions.extra', 'markdown.extensions.meta'])
    txt_html_brut = md.convert(txt_fiche)
    metadonnees = md.Meta
    return metadonnees, txt_html_brut

def ameliorer_tableaux_avec_bootstrap(txt_html):
    return txt_html.replace('<table>', '<table class = "table table-condensed table-striped">')

def centrer_images_avec_bootstrap(txt_html):
    return txt_html.replace('<p><img', '<p class = "p-center"><img')    

def convertir_html_brut_en_html_bootstrap(html_brut):
    html_bootstrap = ameliorer_tableaux_avec_bootstrap(txt_html)
    html_bootstrap = html_bootstrap.replace('ressources/', '/static/img/tutodvf/')
    html_bootstrap = centrer_images_avec_bootstrap(html_bootstrap)
    return html_bootstrap
    
# eof