from django.shortcuts import render, redirect
from main import configuration
from outils import controle_bdd
from pg.pgbasics import *
from .calcul.indicateurs import IndicateurDVF, CalculIndicateur
from main.territoire import integration 
from main.models import Departement, Epci, Commune, Territoire
from indicateur.models import Indicateur, ResultatIndicateur
from indicateur.forms import IndicateurForm, SelectIndicateurForm
import json
 

def indicateurs(request):
    # integration des territoires si nécessaire
    integration.integrer_territoires()
    
    init = False
    # si page de démarrage
    if request.method != 'POST' and request.get_full_path() == '/indicateur/':    
        # verification qu'une configuration a bien été definie 
        config_active = configuration.configuration_active()
        if config_active and controle_bdd.verification_configuration(config_active):
            init = True
        else:
            return redirect('main:configuration_bdd')

    departements = Departement.objects.filter(code__in=controle_bdd.departements_disponibles(configuration.configuration_active()))
    
    if init:
        request.session['params'] = (config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp)        
        request.session['departement'] = int(departements[0].pk)
        request.session['ecpi'] = int(Epci.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['commune'] = int(Commune.objects.filter(departement=request.session['departement'])[0].pk)
        request.session['titre'] = ''
        t = recreer_territoire_comparaison()
        t.ajouter_commune(request.session['commune'])
    
    # changement de département
    if 'departement' in request.POST:
        request.session['departement'] = int(request.POST['departement'])
        
    epcis = Epci.objects.filter(departement=request.session['departement'])
    communes = Commune.objects.filter(departement = request.session['departement'])

    if 'voir_departement' in request.POST:
        t = recreer_territoire_comparaison()
        t.ajouter_departement(request.session['departement'])        
    if 'voir_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        t = recreer_territoire_comparaison()
        t.ajouter_epci(request.session['epci'])        
    if 'voir_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        t = recreer_territoire_comparaison()
        t.ajouter_commune(request.session['commune'])        
    if 'ajout_departement' in request.POST:
        t = territoire_comparaison()
        t.ajouter_departement(request.session['departement'])
    if 'ajout_epci' in request.POST:
        request.session['epci'] = int(request.POST['epci'])
        t = territoire_comparaison()
        t.ajouter_epci(request.session['epci'])
    if 'ajout_commune' in request.POST:
        request.session['commune'] = int(request.POST['commune'])
        t = territoire_comparaison()
        t.ajouter_commune(request.session['commune'])

    indicateursDVF = []
    if not init:
        calculateur = CalculIndicateur(*request.session['params'], script = 'sorties/script_indvf.sql')
        territoires = list(territoire_comparaison().departements.all()) + list(territoire_comparaison().epcis.all()) + list(territoire_comparaison().communes.all())
        request.session['titre'] = ', '.join(['<span class="color'+ str(i) + '-indvf">' + territoire.nom + '</span>' for i, territoire in enumerate(territoires)])
        indicateurs = Indicateur.objects.filter(actif=True).order_by('-code_typo', 'annee_debut', 'type_indic', 'periode', 'unite', 'variable', 'nom')
        
        for num, indicateur in enumerate(indicateurs):
            indic_dvf = IndicateurDVF(indicateur, territoires, calculateur)
            i = {}            
            i['graph'] = indic_dvf.graphique()
            i['idgraph'] = 'graph' + str(num) 
            i['type_graph'] = indicateur.type_graphe
            i['tableau'] = indic_dvf.tableau()
            i['nom'] = indic_dvf.titre()
            indicateursDVF.append(i)
        calculateur.deconnecter()
   
    context = {'departements' : departements, 'epcis' : epcis, 'communes' : communes, 'indicateursDVF' : indicateursDVF}
    return render(request, 'indicateurs.html', context)


def recreer_territoire_comparaison():
    if len(Territoire.objects.filter(nom = 'comparaison')):
        Territoire.objects.get(nom = 'comparaison').delete()
    t = Territoire.objects.create(nom = 'comparaison')
    return t

def territoire_comparaison():
    return Territoire.objects.get(nom = 'comparaison')


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
