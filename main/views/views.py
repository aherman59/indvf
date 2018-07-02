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
from django.contrib import messages
from collections import namedtuple

from main.views.contexte import recuperer_metadonnees_applications_disponibles
from main.views.contexte import ContexteConfigBDD
from main.models import ProxyUser

from indvf.settings import MODE_SERVEUR

from django.contrib.auth.decorators import login_required

def applications(request):
    Appli = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])
    applis = recuperer_metadonnees_applications_disponibles()    
    context = {'applis':applis}
    return render(request, 'applications.html', context)

def credits(request):
    return render(request, 'credits.html')

def configuration_bdd(request):
    if not MODE_SERVEUR or request.user.is_staff:
        contexte_configuration = ContexteConfigBDD(request)
        if contexte_configuration.retour:
            return redirect('main:applications')
        context = {'formulaire': contexte_configuration.formulaire, 
                   'formulaire_selection' : contexte_configuration.formulaire_selection,
                   'id_config' : contexte_configuration.id_config, 
                   'config_active': contexte_configuration.config_active,
                   'verif_config': contexte_configuration.verif_bdd_active,}
        return render(request, 'configuration_bdd.html', context)
    else:
        messages.add_message(request, messages.INFO, "Accès impossible - Contacter l'administrateur")
        return redirect('main:applications')


@login_required
def definir_proxy(request):
    context = {'recup_proxy' : ProxyUser.objects.recuperer_proxy(request.user)}
    if 'validation' in request.POST:
        proxy = request.POST['proxy']
        ProxyUser.objects.definir_proxy(request.user, proxy)
        return redirect('main:applications')
    return render(request, 'chgmt_proxy.html', context)    
    
    
