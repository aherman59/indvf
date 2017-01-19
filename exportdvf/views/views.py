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
