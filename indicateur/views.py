from django.shortcuts import render, redirect
from main import configuration, controle_bdd
from pg.pgbasics import *
from .calcul.indicateurs import IndicateurDVF, CalculIndicateur
from .territoire import integration 
from indicateur.models import Departement, Epci, Commune, Territoire, Indicateur
import json
 

def indicateurs(request):
    # integration des territoires si nécessaire
    _integrer_territoires()
    
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
        indicateurs = Indicateur.objects.all()
        
        for num, indicateur in enumerate(indicateurs):
            indic_dvf = IndicateurDVF(indicateur, territoires, calculateur)
            i = {}
            i['nom'] = indicateur.nom
            i['graph'] = indic_dvf.graphique()
            i['idgraph'] = 'graph' + str(num) 
            i['type_graph'] = indicateur.type_graphe
            i['tableau'] = indic_dvf.tableau()
            indicateursDVF.append(i)
        calculateur.deconnecter()
   
    context = {'departements' : departements, 'epcis' : epcis, 'communes' : communes, 'indicateursDVF' : indicateursDVF}
    return render(request, 'indicateurs.html', context)


def _integrer_territoires():
    fichier_departement_insee = 'indicateur/territoire/doc_insee/departement.csv'
    fichier_epci_insee = 'indicateur/territoire/doc_insee/epci2015.csv'
    fichier_commune_insee = 'indicateur/territoire/doc_insee/code_insee_france2015.txt'
    fichier_historique_commune = 'indicateur/territoire/doc_insee/historiq2015.txt'
    if len(Departement.objects.all()) == 0:
        integration.integrer_departements(fichier_departement_insee)
    if len(Epci.objects.all()) == 0:
        integration.integrer_epcis(fichier_epci_insee)
    if len(Commune.objects.all()) == 0:
        integration.integrer_communes(fichier_commune_insee, fichier_historique_commune, fichier_epci_insee)
    if len(Indicateur.objects.all()) == 0:
        integration.integrer_indicateurs()


def recreer_territoire_comparaison():
    if len(Territoire.objects.filter(nom = 'comparaison')):
        Territoire.objects.get(nom = 'comparaison').delete()
    t = Territoire.objects.create(nom = 'comparaison')
    return t

def territoire_comparaison():
    return Territoire.objects.get(nom = 'comparaison')
