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

import os
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from .contexte import ContexteExport
from .export.export_qgis import ExportQGis
from .export.export_qgis import RequeteurExportQGis

@login_required
def choix(request):
    contexte_export = ContexteExport(request)
    if not contexte_export.success:
        return redirect('main:configuration_bdd')    
    request.session = contexte_export.request.session    
    return render(request, 'choix_export.html', None) 

@login_required
def projet_qgis(request):
    if request.session['type_bdd'] != 'DV3F':
        return redirect('main:configuration_bdd')
    requeteur_export = RequeteurExportQGis(request.session['params'])
    success, _ = requeteur_export.generer_vues_qgis()
    if not success:
        return redirect('main:configuration_bdd')
    box = requeteur_export.emprise()
    export_qgis = ExportQGis(request.session, box)     
    response = HttpResponse(export_qgis.flux_archive(), content_type='application/zip')
    response['Content-Disposition'] = 'attachment; filename={0}'.format(export_qgis.nom_prj('zip'))
    export_qgis.nettoyer()
    return response
