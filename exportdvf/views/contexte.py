import os
from main.models import ConfigurationBDD

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
