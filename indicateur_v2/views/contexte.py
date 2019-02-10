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
        if self.request.method != 'POST' and self.request.get_full_path() == '/dv3f/indicateur_v2/': # page démarrage
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
    def conditions_perso(self):
        if 'perso' in self.request.POST:
            perso = self.request.POST.get('perso')
            if ',' in perso:
                return perso.split(',')
            elif len(perso) > 0:
                return [perso]
        return []
    
    @property
    def periodicite(self):
        if 'annee' in self.request.POST:
            periode = self.request.POST.get('annee')
            return periode
        return 'a'
    
    @property
    def an_min_max(self):
        if 'an_min_max' in self.request.POST:
            an_min_max = self.request.POST.get('an_min_max')            
            if ',' in an_min_max:
                return sorted([int(a) for a in an_min_max.split(',')])
        return [2013,2016]
    
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
            gestionnaire = GestionnaireIndicateurs(self.typologies, self.filtres, self.types_indicateur, self.devenirs, self.periodicite, self.an_min_max, self.conditions_perso)
            return indicateurs_format_xcharts(territoires, gestionnaire, self.config_active)
        return []
    
    @property
    def indicateurs_csv(self):
        territoires = self.territoire().lister_entites_administratives()
        if len(territoires) and self.charger_indicateur:
            gestionnaire = GestionnaireIndicateurs(self.typologies, self.filtres, self.types_indicateur, self.devenirs, self.periodicite, self.an_min_max)
            return indicateurs_actifs_format_csv(territoires, gestionnaire, self.config_active)
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
        
