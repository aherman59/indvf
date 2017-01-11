import os
import zipfile
import io
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from pg.pgbasics import *
from main.configuration import BASE_DIR
from main.models import ConfigurationBDD

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
        return render(request, 'choix_export.html', None)
    requeteur_export = RequeteurExportQGis(request.session['params'])
    requeteur_export.generer_vues_qgis()
    box = requeteur_export.box()
    export_qgis = ExportQGis(request.session, box)     
    response = HttpResponse(export_qgis.flux_archive(), content_type='application/zip')
    response['Content-Disposition'] = 'attachment; filename={0}'.format(export_qgis.nom_prj('zip'))
    export_qgis.nettoyer()
    return response

class ContexteExport():
    
    def __init__(self, request):
        self.request = request
        self.success = True
        self.main()
        
    def main(self):
        self.configuration_initiale()
    
    @property
    def config_active(self):
        if self.request.session['id_config']:
            return ConfigurationBDD.objects.get(pk = self.request.session['id_config'])
        return None
    
    def configuration_initiale(self):
        verification = ConfigurationBDD.objects.verifier_configuration_active()
        if verification.validation:
            self.request.session['id_config'] = verification.id
            self.request.session['type_bdd'] = self.config_active.type_bdd
            self.request.session['params'] = self.config_active.parametres_bdd()
        else:
            self.success = False

class ExportQGis():
    
    REPERTOIRE_QGIS = os.path.join(BASE_DIR, 'exportdvf', 'qgis')
    
    def __init__(self, session, box):
        # à faire : verifier DV3F
        self.type_bdd = session['type_bdd']
        self.params = session['params']
        self.box = box
            
    def nom_prj(self, extension):
        base = self.params[1]
        return 'prj_qgis_' + base + '.' + extension
    
    @property
    def chemin_archive(self):
        return self.chemin(self.nom_prj('zip'))
    
    def chemin(self, fichier):
        return os.path.join(self.REPERTOIRE_QGIS, fichier)

    def flux_archive(self):
        self.modifier_projet_avec_params_bdd()
        fichiers = [self.nom_prj('qgs'), 'interface.ui']        
        with zipfile.ZipFile(self.chemin_archive, 'w') as z:
            for fichier in fichiers:
                z.write(self.chemin(fichier), os.path.join('projet_qgis',fichier))
        return open(self.chemin_archive, 'rb')
    
    def nettoyer(self):
        os.remove(self.chemin_archive)
        os.remove(self.chemin(self.nom_prj('qgs')))
            
    def modifier_projet_avec_params_bdd(self):
        # creation vues à prévoir
        projet_modele = self.chemin('projet_qgis_modele.qgs')
        projet_modif = self.chemin(self.nom_prj('qgs'))
        (hote, base, port, utilisateur, _) = self.params
        with open(projet_modele, 'r', encoding='utf-8') as modele:
            with open(projet_modif, 'w', encoding='utf-8', newline='\n') as sortie:
                for ligne in modele:
                    if "dbname='XXXX'" in ligne:
                        ligne = ligne.replace("XXXX", base, 1)
                    if "host=XXXX" in ligne:
                        ligne = ligne.replace("XXXX", hote, 1)
                    if "port=XXXX" in ligne:
                        ligne = ligne.replace("XXXX", port, 1)
                    if "user='XXXX'" in ligne:
                        ligne = ligne.replace("XXXX", utilisateur, 1)
                    sortie.write(ligne)                         


class RequeteurExportQGis(PgOutils):
    
    def __init__(self, params, script = None):
        super().__init__(*params, script=script)
    
    @requete_sql
    def generer_vues_qgis(self):
        pass
    
    def box(self):
        pass
        