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
from collections import namedtuple

from indvf.settings import ACTIVATED_APPS

from main.configuration import BASE_DIR
from main.forms import ConfigBDDForm
from main.forms import SelectConfigBDDForm
from main.models import ConfigurationBDD

from indicateur_v2.models import ResultatIndicateur

def recuperer_metadonnees_applications_disponibles():
    applis = []
    Appli = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])    
    for app in ACTIVATED_APPS:
        for racine, repertoires, fichiers in os.walk(os.path.join(BASE_DIR, app)):
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


def is_version_complete():
    '''
    Renvoie Vrai si les applications actives correspondent pour au moins l'une d'elles à des applications AppDVF de la version locale
    Renvoie Faux s'il s'agit uniquement d'une affichage de la documentation et du tutoriel (notamment pour la version web)
    '''
    for app in ACTIVATED_APPS:
        if app not in ['main', 'docdv3f', 'tutodvf']:
            return True
    return False

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
            self.id_config = id_config
            self.formulaire = configform
            self.formulaire_selection = SelectConfigBDDForm(initial = {'selection' : id_config })
    
    def activation(self, config):
        ConfigurationBDD.objects.desactiver_configurations()
        config.activer()
        ResultatIndicateur.objects.supprimer_tout()
        self.retour = True

        
    