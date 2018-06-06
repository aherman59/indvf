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

from pg.pgbasics import PgOutils

from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire
from indicateur_v2.models import ResultatIndicateur
from indicateur_v2.forms import IndicateurForm, SelectIndicateurForm
from indicateur_v2.indicateurs import GestionnaireIndicateurs
from indicateur_v2.indicateurs import indicateurs_format_xcharts
from indicateur_v2.indicateurs import indicateurs_actifs_format_csv

class ContexteIndicateur():
    
    def __init__(self, request):
        self.request = request
        self.success = True
        self.charger_indicateur = True
        self.main()
    
    def main(self):
        if self.request.method != 'POST' and self.request.get_full_path() == '/indicateur_v2/': # page démarrage
            self.configuration_initiale()
            self.charger_indicateur = False
        elif 'voir_departement' in self.request.POST: # choix d'un nouveau département
            self.selection_departement(ajout=False)
        elif 'voir_epci' in self.request.POST: # choix d'un nouvel epci
            self.selection_epci(ajout=False)
        elif 'voir_commune' in self.request.POST: # choix d'une nouvelle commune
            self.selection_commune(ajout=False)
        elif 'ajout_departement' in self.request.POST: # ajout d'un nouveau département
            self.selection_departement(ajout=True)
        elif 'ajout_epci' in self.request.POST: # ajout d'un nouvel epci
            self.selection_epci(ajout=True)
        elif 'ajout_commune' in self.request.POST: # ajout d'une nouvelle commune
            self.selection_commune(ajout=True)
        elif 'departement' in self.request.POST: # changement de département
            self.changement_departement()
            self.charger_indicateur = False
    
    @property
    def config_active(self):
        if self.request.session['id_config']:
            return ConfigurationBDD.objects.get(pk = self.request.session['id_config'])
        return None
            
    @property    
    def departements(self):
        if self.config_active:
            return self.config_active.departements_disponibles()
        return None
    
    @property
    def code_departement(self):
        if 'departement' in self.request.session:
            return Departement.objects.get(pk=self.request.session['departement']).code
        return self.config_active.departements_disponibles()[0].code
    
    @property     
    def epcis(self):
        if self.config_active:
            return self.config_active.epcis_disponibles(self.code_departement)
        return None
    
    @property     
    def communes(self):
        if self.config_active:
            return self.config_active.communes_disponibles(self.code_departement)
        return None

    def territoire(self, mise_a_zero = False):
        if mise_a_zero:
            return Territoire.objects.territoire_comparaison_reinitialise()
        return Territoire.objects.territoire_comparaison()
    
    @property
    def typologies(self):
        if 'typologies' in self.request.POST:
            typos = self.request.POST.get('typologies')
            if ',' in typos:
                return typos.split(',')
            elif len(typos) > 0:
                return [typos]                
        return ['11', '12']
    
    @property
    def filtres(self):
        if 'filtres' in self.request.POST:
            filtres = self.request.POST.get('filtres')
            if ',' in filtres:
                return filtres.split(',')
            elif len(filtres) > 0:
                return [filtres]  
        return ['0']
    
    @property
    def devenirs(self):
        if 'devenirs' in self.request.POST:
            devenirs = self.request.POST.get('devenirs')
            if ',' in devenirs:
                return devenirs.split(',')
            elif len(devenirs) > 0:
                return [devenirs]  
        return ['S']
    
    @property
    def periodicite(self):
        if 'annee' in self.request.POST:
            periode = self.request.POST.get('annee')
            return periode
        return 'a'
    
    @property
    def types_indicateur(self):
        if 'indicateurs' in self.request.POST:
            indicateurs = self.request.POST.get('indicateurs')
            if ',' in indicateurs:
                return indicateurs.split(',')
            elif len(indicateurs) > 0:
                return [indicateurs]
        return ['nbtrans', 'total']
    
    @property
    def indicateurs(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires) and self.charger_indicateur:
            gestionnaire = GestionnaireIndicateurs(self.typologies, self.filtres, self.types_indicateur, self.devenirs, self.periodicite)
            return indicateurs_format_xcharts(territoires, gestionnaire, self.config_active)
        return []
    
    @property
    def indicateurs_csv(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires) and self.charger_indicateur:
            return indicateurs_actifs_format_csv(territoires, self.config_active)
        return []
    
    @property
    def titre(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires):
            return ', '.join(['<span class="color'+ str(i) + '-indvf">' 
                          + territoire.nom 
                          + '</span>' for i, territoire in enumerate(territoires)])
        return ''
    
    def configuration_initiale(self):
        _ = Territoire.objects.territoire_comparaison_reinitialise()
        verification = ConfigurationBDD.objects.verifier_configuration_active()
        if verification.validation:
            self.request.session['id_config'] = verification.id
            self.request.session['type_bdd'] = self.config_active.type_bdd
            self.request.session['params'] = self.config_active.parametres_bdd()
            self.initialisation()
        else:
            self.success = False
    
    def changement_departement(self):
        self.initialisation()
        self.request.session['departement'] = int(self.request.POST['departement'])        
    
    def selection_departement(self, ajout):
        self.request.session['departement'] = int(self.request.POST['departement'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_departement(self.request.session['departement'])
    
    def selection_epci(self, ajout):
        self.request.session['epci'] = int(self.request.POST['epci'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_epci(self.request.session['epci'])
    
    def selection_commune(self, ajout):
        self.request.session['commune'] = int(self.request.POST['commune'])
        self.territoire(mise_a_zero=(not ajout)).ajouter_commune(self.request.session['commune']) 
    
    def initialisation(self):
        self.request.session.pop('departement', None)
        self.request.session['epci'] = 0
        self.request.session['commune'] = 0
        
class ContexteConfigIndicateur():
    
    def __init__(self, request):
        self.request = request
        self.formulaire = IndicateurForm()
        self.formulaire_selection = SelectIndicateurForm()
        self.id_indicateur = 0
        self.annulation = False
        self.main()
    
    def main(self):
        if 'selection' in self.request.POST: # modification de la selection
            if self.request.POST['selection'] != '':
                id_indicateur = int(self.request.POST['selection'])
                self.modification_selection(id_indicateur)
        elif 'annulation' in self.request.POST: # annulation
            self.annulation = True
        elif 'suppression' in self.request.POST: # suppression de la selection
            id_indicateur = int(self.request.POST['selection_indicateur'])
            self.suppression(id_indicateur)
        elif 'creation' in self.request.POST: # creation ou modification de l'indicateur
            id_indicateur = int(self.request.POST['selection_indicateur'])
            if id_indicateur == 0:
                self.creation()
            else:
                self.modification(id_indicateur)
    
    def modification_selection(self, id_indicateur):
        self.id_indicateur = id_indicateur
        indicateur = Indicateur.objects.get(pk = self.id_indicateur)
        self.formulaire = IndicateurForm(instance = indicateur)
        self.formulaire_selection = SelectIndicateurForm(initial = {'selection' : self.id_indicateur })

    def suppression(self, id_indicateur):
        Indicateur.objects.supprimer(id_indicateur)
        ResultatIndicateur.objects.supprimer_resultats(id_indicateur)
    
    def creation(self):
        indicateurform = IndicateurForm(self.request.POST)
        if indicateurform.is_valid():
            indicateurform.save()
        else:
            self.formulaire = indicateurform
    
    def modification(self, id_indicateur):
        indicateur_choisi = Indicateur.objects.get(pk = id_indicateur)
        indicateurform = IndicateurForm(self.request.POST, instance = indicateur_choisi)
        if indicateurform.is_valid():       
            indicateurform.save()
            ResultatIndicateur.objects.supprimer_resultats(id_indicateur)
        else:
            self.id_indicateur = id_indicateur
            self.formulaire = indicateurform        
