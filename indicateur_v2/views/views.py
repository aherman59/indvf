'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.contrib import messages

from pg.pgbasics import *
from main.territoire import integration 
from .contexte import ContexteIndicateur, ContexteConfigIndicateur
from indvf.settings import MODE_SERVEUR

'''
PAGE AFFICHAGE INDICATEURS
''' 

@login_required
def indicateurs(request):
    '''
    Permet de générer la page des indicateurs
     
    request.session :
    --------------- 
    'departement', 'epci', 'commune' : conserve la selection en cours des entités du menu territoire.
    'id_config' : 'id de la configuration active pour la base de données
    '''
    
    # integration des territoires si la base ne contient pas encore les entités départ./epci/communes
    integration.integrer_territoires()
    
    contexte_indicateur = ContexteIndicateur(request)
    if not contexte_indicateur.success:
        return redirect('main:configuration_bdd')    
    
    request.session = contexte_indicateur.request.session
           
    context = {'departements' : contexte_indicateur.departements, 
               'epcis' : contexte_indicateur.epcis, 
               'communes' : contexte_indicateur.communes, 
               'indicateursDVF' : contexte_indicateur.indicateurs,
               'titre': contexte_indicateur.titre,
               'charger_indicateur': contexte_indicateur.charger_indicateur}
    return render(request, 'indicateur_v2/indicateurs.html', context)
    

@login_required
def configuration_indicateur(request):
    if not MODE_SERVEUR or request.user.is_staff:
        contexte_configuration = ContexteConfigIndicateur(request)
        if contexte_configuration.annulation:
            return redirect('indicateur_v2:indicateurs')
        context = {'formulaire': contexte_configuration.formulaire, 
                   'formulaire_selection' : contexte_configuration.formulaire_selection,
                   'id_indicateur' : contexte_configuration.id_indicateur, }
        return render(request, 'indicateur_v2/configuration_indicateur.html', context)
    else:
        messages.add_message(request, messages.INFO, "Accès impossible - Contacter l'administrateur")
        return redirect('indicateur_v2:indicateurs')

"""

EXPORT CSV DES INDICATEURS

"""

def indicateurs_csv(request):             
    contexte_indicateur = ContexteIndicateur(request)
    return reponse_csv('sortie.csv', contexte_indicateur.indicateurs_csv)

def reponse_csv(nom_fichier, indicateurs):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachement; filename="{0}"'.format(nom_fichier)
    writer = csv.writer(response, delimiter=';')
    for indicateur in indicateurs:
        writer.writerow([indicateur['nom']])
        donnees = indicateur['donnees']
        for i, donnee in enumerate(donnees):
            if i == 0:
                writer.writerow([indicateur['unite']]+[d[0] for d in donnee])
            writer.writerow([indicateur['territoires'][i]]+[d[1] for d in donnee])
        writer.writerow([])
    return response    