def reinitialisation_parametres_filtre_dans_session(request):    
    request.session['typologie'] = 0
    request.session['annee_min'] = 0
    request.session['annee_max'] = 0
    reinitialisation_parametres_filtre_valeur_fonciere_min_max_dans_session(request)
    
def reinitialisation_parametres_filtre_valeur_fonciere_min_max_dans_session(request):
    request.session['valeur_min'] = 0
    request.session['valeur_max'] = 10000000000

def calcul_et_enregistrement_modalites_filtre_dans_session(request):
    request.session['typologies'] = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) 
                                                for mutation in request.session['mutations']] + [(0, 'Tous')]), 
                                           key = lambda x : x[1])    
    request.session['annees'] = sorted(set([int(mutation.anneemut) 
                                            for mutation in request.session['mutations']]))
    request.session['valeur_min_existante'] = min([float(mutation.valeurfonc) 
                                                   for mutation in request.session['mutations']])
    request.session['valeur_max_existante'] = max([float(mutation.valeurfonc) 
                                                   for mutation in request.session['mutations']])

def modification_filtre(request):
    fonctions_filtres = {'typologie': modification_filtre_typologie,
                         'annee_min': modification_filtre_annee,
                         'annee_max': modification_filtre_annee,
                         'valeur_min': modification_filtre_valeur_fonciere,
                         'valeur_max': modification_filtre_valeur_fonciere,
                         }
    for key, value in request.POST.items():
        if key in fonctions_filtres.keys():
            fonctions_filtres[key](request, key)

def correction_valeurs_filtre_incorrectes(request):
    fonctions_corrections = {'typologie': correction_filtre_typologie,
                             'annee_min': correction_filtre_annee,
                             'annee_max': correction_filtre_annee,
                             'valeur_min': correction_filtre_valeur_fonciere,
                             'valeur_max': correction_filtre_valeur_fonciere,
                             }
    for key, value in fonctions_corrections.items():
        fonctions_corrections[key](request, key)

def modification_filtre_typologie(request, clef_session):    
    request.session[clef_session] = int(request.POST[clef_session])

def correction_filtre_typologie(request, clef_session):
    typologies_existantes = request.session['typologies']
    if request.session['typologie'] not in [code for code, lib in typologies_existantes]:
        request.session['typologie'] = 0

def modification_filtre_annee(request, clef_session):    
    request.session[clef_session] = int(request.POST[clef_session])

def correction_filtre_annee(request, clef_session):
    annees_existantes = request.session['annees']
    if request.session[clef_session] not in annees_existantes or (request.session[clef_session]==0):
        annee = min(annees_existantes) if clef_session =='annee_min' else max(annees_existantes)
        request.session[clef_session] = annee    

def modification_filtre_valeur_fonciere(request, clef_session):
    valeur_borne = request.session['valeur_min_existante'] 
    if clef_session == 'valeur_max':
        valeur_borne = request.session['valeur_max_existante']
    try:
        request.session[clef_session] = int(request.POST[clef_session])
    except Exception as e:
        request.session[clef_session] = valeur_borne

def correction_filtre_valeur_fonciere(request, clef_session):
    valeur_min = request.session['valeur_min_existante']
    valeur_max = request.session['valeur_max_existante']
    if request.session[clef_session] > valeur_max:
        request.session[clef_session] = valeur_max
    if request.session[clef_session] < valeur_min:
        request.session[clef_session] = valeur_min