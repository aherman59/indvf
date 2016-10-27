'''

#    Copyright (C) 2016  Cerema
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

'''
import os
from collections import namedtuple

from main.configuration import BASE_DIR
from main.forms import ConfigBDDForm
from main.forms import SelectConfigBDDForm
from main.models import ConfigurationBDD

from indicateur.models import ResultatIndicateur

def recuperer_metadonnees_applications_disponibles():
    applis = []
    Appli = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])    
    for racine, repertoires, fichiers in os.walk(BASE_DIR):
        for fichier in fichiers:
            if fichier.lower() == 'metadata.txt':
                with open(os.path.join(racine, fichier), 'rt', encoding ='utf-8') as f:
                    meta ={}
                    for ligne in f:
                        if '=' in ligne:
                            attribut = ligne.split('=')[0]
                            valeur = ligne.split('=')[1]
                            meta[attribut.strip()] = valeur.strip()
                applis.append(Appli(**meta))
    return applis


class ContexteConfigBDD():
    
    def __init__(self, request):
        self.request = request
        self.formulaire = ConfigBDDForm()
        self.formulaire_selection = SelectConfigBDDForm()
        self.id_config = 0
        self.retour = False
        self.main()
    
    @property
    def config_active(self):
        return ConfigurationBDD.objects.configuration_active()
    
    @property
    def verif_bdd_active(self):
        return self.config_active.verification_configuration() if self.config_active else False
    
    def main(self):
        if 'selection' in self.request.POST: # modification de la selection
            if self.request.POST['selection'] != '':
                id_config = int(self.request.POST['selection'])
                self.modification_selection(id_config)
        elif 'annulation' in self.request.POST: # annulation
            self.retour = True
        elif 'suppression' in self.request.POST: # suppression de la selection
            id_config = int(self.request.POST['selection_config'])
            self.suppression(id_config)
        elif 'activation' in self.request.POST: # creation ou modification de la configuration puis activation
            id_config = int(self.request.POST['selection_config'])
            if id_config == 0:
                self.creation()
            else:
                self.modification(id_config) 
    
    def modification_selection(self, id_config):
        self.id_config = id_config
        config = ConfigurationBDD.objects.get(pk = id_config)
        self.formulaire = ConfigBDDForm(instance = config)
        self.formulaire_selection = SelectConfigBDDForm(initial = {'selection' : id_config })
    
    def suppression(self, id_config):
        ConfigurationBDD.objects.supprimer(id_config)
        
    def creation(self):
        configform = ConfigBDDForm(self.request.POST)
        if configform.is_valid():            
            nvelle_config = configform.save(commit=False)
            self.activation(nvelle_config)
        else:
            self.formulaire = configform
    
    def modification(self, id_config):
        config_choisie = ConfigurationBDD.objects.get(pk = id_config)
        configform = ConfigBDDForm(self.request.POST, instance=config_choisie)
        if configform.is_valid():
            configform.save()
            self.activation(config_choisie)
        else:
            self.formulaire = configform
    
    def activation(self, config):
        ConfigurationBDD.objects.desactiver_configurations()
        config.activer()
        ResultatIndicateur.objects.supprimer_tout()
        self.retour = True

        
    