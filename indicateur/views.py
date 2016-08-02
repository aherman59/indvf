from django.shortcuts import render, redirect
from main import configuration
from pg.pgbasics import *
from .calcul.indicateurs import IndicateurDVF, CalculIndicateur
from main.territoire import integration 
from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire
from indicateur.models import Indicateur, ResultatIndicateur
from indicateur.forms import IndicateurForm, SelectIndicateurForm
import json

'''
PAGE AFFICHAGE INDICATEURS
''' 

def indicateurs(request):
    '''
     permet de générer la page des indicateurs
     
    Les clefs 'departement', 'epci', 'commune' de request.session permettent d'enregistrer la
    selection en cours des entités du menu territoire.
    
    La clef 'config' de request.session enregistre l'id de la configuration active pour la base de données
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()    
    
    if request.method != 'POST' and request.get_full_path() == '/indicateur/':
        # page de démarrage 
        init = True   
        config_active = configuration.configuration_active()
        verif = verification_et_enregistrement_configuration_dans_session(request, config_active)
        if not verif:
             return redirect('main:configuration_bdd') 
    else:
        init = False
        config_active = ConfigurationBDD.objects.get(pk = request.session['config'])
        params_config = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)
        
    departements = config_active.departements_disponibles()
    code_departement_actif = recuperation_code_departement_actif(request, departements, init)
    epcis, communes = recuperation_epcis_communes(request, config_active, code_departement_actif, init)
     
    if not init:  
        territoires = generer_territoire_etude(request)        
        titre = creer_titre_format_html(territoires)
        
        indicateurs_actifs = recuperer_et_classer_indicateurs_actifs()
        calculateur = CalculIndicateur(*params_config, script = 'sorties/script_indvf.sql')
        indicateursDVF = calcul_indicateurs(indicateurs_actifs, calculateur, territoires)
        calculateur.deconnecter()
    else:
        titre = ''
        indicateursDVF = []
       
    context = {'departements' : departements, 
               'epcis' : epcis, 
               'communes' : communes, 
               'indicateursDVF' : indicateursDVF,
               'titre': titre}
    return render(request, 'indicateurs.html', context)

def verification_et_enregistrement_configuration_dans_session(request, config_active):
    if config_active:
        if config_active.verification_configuration():
            request.session['config'] = int(config_active.pk)
            return True                
        else:
            return False
    else:
        return False

def recuperation_code_departement_actif(request, departements, init):            
    if init:    
        request.session['departement'] = int(departements[0].pk)
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
    return Departement.objects.get(pk=request.session['departement']).code

def recuperation_epcis_communes(request, config_active, code_departement, init):
    epcis = config_active.epcis_disponibles(code_departement)
    communes = config_active.communes_disponibles(code_departement)
    if init:
        request.session['epci'] = int(epcis[0].pk)    
        request.session['commune'] = int(communes[0].pk)
    return epcis, communes

def generer_territoire_etude(request):
    if 'voir_departement' in request.POST:
        t = recreer_territoire_comparaison()
        t.ajouter_departement(request.session['departement'])        
    elif 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        t = recreer_territoire_comparaison()
        t.ajouter_epci(request.session['epci'])        
    elif 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        t = recreer_territoire_comparaison()
        t.ajouter_commune(request.session['commune'])        
    elif 'ajout_departement' in request.POST:
        t = territoire_comparaison()
        t.ajouter_departement(request.session['departement'])
    elif 'ajout_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        t = territoire_comparaison()
        t.ajouter_epci(request.session['epci'])
    elif 'ajout_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        t = territoire_comparaison()
        t.ajouter_commune(request.session['commune'])
    else:
        t = territoire_comparaison()
    territoires = (
                    list(t.departements.all()) 
                    + list(t.epcis.all()) 
                    + list(t.communes.all())
                   )
    return territoires

def recreer_territoire_comparaison():
    if len(Territoire.objects.filter(nom = 'comparaison')):
        Territoire.objects.get(nom = 'comparaison').delete()
    t = Territoire.objects.create(nom = 'comparaison')
    return t

def territoire_comparaison():
    return Territoire.objects.get(nom = 'comparaison')

def creer_titre_format_html(territoires):
    return ', '.join(['<span class="color'+ str(i) + '-indvf">' 
                      + territoire.nom 
                      + '</span>' for i, territoire in enumerate(territoires)])
    
def recuperer_et_classer_indicateurs_actifs():
    return Indicateur.objects.filter(actif=True).order_by('-code_typo', 
                                                          'annee_debut', 
                                                          'type_indic', 
                                                          'periode', 
                                                          'unite', 
                                                          'variable', 
                                                          'nom')


def calcul_indicateurs(indicateurs_actifs, calculateur, territoires):
    indicateursDVF = []
    for num, indicateur in enumerate(indicateurs_actifs):
        indic_dvf = IndicateurDVF(indicateur, territoires, calculateur)
        i = {}            
        i['graph'] = indic_dvf.graphique()
        i['idgraph'] = 'graph' + str(num) 
        i['type_graph'] = indicateur.type_graphe
        i['tableau'] = indic_dvf.tableau()
        i['nom'] = indic_dvf.titre()
        indicateursDVF.append(i)
    return indicateursDVF
        
'''

PAGE CONFIGURATION

'''

def configuration_indicateur(request):
    # premier chargement de la page
    if request.method != 'POST' or ('selection' in request.POST and request.POST['selection'] == ''):
        return _charger_formulaire(request, IndicateurForm())
    # annulation 
    elif 'annulation' in request.POST:
        return redirect('indicateur:indicateurs')
    # suppression
    elif 'suppression' in request.POST:
        id_indicateur = int(request.POST['selection_indicateur'])
        indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
        indicateur_choisi.delete()
        ResultatIndicateur.objects.filter(id_indicateur = id_indicateur).delete()
        
        return _charger_formulaire(request, IndicateurForm())
    # modification de la selection
    elif 'selection' in request.POST:
        return _modification_selection(request)
    # activation de la nouvelle configuration
    if 'creation' in request.POST:
        id_indicateur = int(request.POST['selection_indicateur'])
        if id_indicateur == 0: # nouvelle entree
            indicateurform = IndicateurForm(request.POST)            
        else: # mise à jour
            indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
            indicateurform = IndicateurForm(request.POST, instance = indicateur_choisi)
        if indicateurform.is_valid():       
            indicateurform.save()
            ResultatIndicateur.objects.filter(id_indicateur = id_indicateur).delete()        
            return _charger_formulaire(request, IndicateurForm())
        else:
            return _charger_formulaire(request, indicateurform, id_indicateur = id_indicateur)

def _charger_formulaire(request, indicateurform, id_indicateur = 0):
    formulaire = indicateurform
    formulaire_selection = SelectIndicateurForm()    
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_indicateur' : id_indicateur, }
    return render(request, 'configuration_indicateur.html', context)

def _modification_selection(request):
    id_indicateur = int(request.POST['selection'])
    indicateur = Indicateur.objects.get(pk = id_indicateur)
    formulaire = IndicateurForm(instance = indicateur)
    formulaire_selection = SelectIndicateurForm(initial = {'selection' : id_indicateur })
    context = {'formulaire':formulaire, 
               'formulaire_selection' : formulaire_selection,
               'id_indicateur' : id_indicateur,                }
    return render(request, 'configuration_indicateur.html', context)
