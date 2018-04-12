'''
Module pour la conversion des formats markdown en html dans indvf
'''

import markdown
    
def convertir_markdown_en_html(txt_fiche):
    if txt_fiche.strip() == '':
        return '', ''
    md = markdown.Markdown(output_format = 'html5', encoding='utf-8', extensions=['markdown.extensions.extra', 'markdown.extensions.meta', 'markdown.extensions.toc'])
    txt_html_brut = md.convert(txt_fiche)
    metadonnees = md.Meta
    return metadonnees, txt_html_brut

def ameliorer_tableaux_avec_bootstrap(txt_html):
    return txt_html.replace('<table>', '<table class = "table table-condensed table-striped">')

def centrer_images_avec_bootstrap(txt_html):
    return txt_html.replace('<p><img', '<p class = "p-center"><img style="max-width:100%; height:auto;"')

def integrer_titre_variables_associees(txt_html):
    return txt_html.replace('@-@Variables associées@-@', '<h4 style="margin:0px; padding:0px;"><i class="fa fa-book"></i> DocDV3F</h4>')    

def convertir_html_brut_en_html_bootstrap(html_brut):
    html_bootstrap = ameliorer_tableaux_avec_bootstrap(html_brut)
    html_bootstrap = html_bootstrap.replace('ressources/', '/static/img/tutodvf/')
    html_bootstrap = integrer_titre_variables_associees(html_bootstrap)
    html_bootstrap = centrer_images_avec_bootstrap(html_bootstrap)
    return html_bootstrap
    
# eof