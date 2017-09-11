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

from main.models import ConfigurationBDD, Departement, Epci, Commune, Territoire

from .mutation import Mutations


class ContexteRecherche():
    
    def __init__(self, request):
        self.request = request
        self.success = True
        self.filtre = ContexteFiltre(self.request)
        self.charger_tableau = False
        self.main()
    
    def main(self):
        if self.request.method != 'POST' and self.request.get_full_path() == '/recherche/': # page démarrage
            self.configuration_initiale()
        elif 'departement' in self.request.POST: # changement de département
            self.selection_departement()
        elif 'voir_epci' in self.request.POST: # choix d'un epci
            self.selection_epci()
        elif 'voir_commune' in self.request.POST: # choix d'une commune
            self.selection_commune()
        self.request.session['parametres_filtre'] = self.filtre.parametres
    
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
    
    def configuration_initiale(self):
        verification = ConfigurationBDD.objects.verifier_configuration_active()
        if verification.validation:
            self.request.session['id_config'] = verification.id
            self.request.session['type_bdd'] = self.config_active.type_bdd
            self.request.session['params'] = self.config_active.parametres_bdd()
            self.initialisation()
        else:
            self.success = False
    
    def selection_departement(self):
        self.initialisation()
        self.request.session['departement'] = int(self.request.POST['departement'])
    
    def selection_epci(self):
        self.request.session['epci'] = int(self.request.POST['epci'])
        if self.request.session['epci'] == 0:
            self.charger_tableau = False
            return
        self.request.session['titre'] = Epci.objects.get(pk = self.request.session['epci']).nom
        codes_insee = [str(c.code) for c in Commune.objects.filter(epci = self.request.session['epci'])]
        self.request.session['mutations'] = self.calcul_mutations(codes_insee)
        self.filtre.definir_modalites(Mutations(self.request.session).as_objet())
        self.charger_tableau = True
    
    def selection_commune(self):
        self.request.session['commune'] = int(self.request.POST['commune'])
        if self.request.session['commune'] == 0:
            self.charger_tableau = False
            return
        self.request.session['titre'] = Commune.objects.get(pk = self.request.session['commune']).nom
        codes_insee = [str(Commune.objects.get(pk = self.request.session['commune']).code),]
        self.request.session['mutations'] = self.calcul_mutations(codes_insee)
        self.filtre.definir_modalites(Mutations(self.request.session).as_objet())
        self.charger_tableau = True 
    
    def initialisation(self):
        self.request.session.pop('departement', None)
        self.request.session['epci'] = 0
        self.request.session['commune'] = 0
        self.request.session['titre'] = ''
        self.request.session['mutations'] = []
        self.filtre.initialiser_valeurs()
    
    def calcul_mutations(self, codes_insee):
        return Mutations(self.request.session, codes_insee).as_list()


class ContexteFiltre():
    
    def __init__(self, request):
        self.session = request.session
        self.parametres = self.session['parametres_filtre'] if 'parametres_filtre' in self.session else dict()
        self.main(request.POST)
        
    def initialiser_valeurs(self):
        self.parametres['typologie'] = 0
        self.parametres['annee_min'] = 0
        self.parametres['annee_max'] = 0
        self.parametres['valeur_min'] = 0
        self.parametres['valeur_max'] = 10000000000
        
    def definir_modalites(self, mutations):
        self.parametres['typologies'] = sorted(set([(int(mutation.codtypbien), mutation.libtypbien.capitalize()) 
                                                for mutation in mutations] + [(0, 'Tous')]), key = lambda x : x[1])    
        self.parametres['annees'] = sorted(set([int(mutation.anneemut) for mutation in mutations]))
        valeurs_foncieres = [mutation.valeurfonc for mutation in mutations if mutation.valeurfonc != '--']
        self.parametres['valeur_min_existante'] = min([float(val) for val in valeurs_foncieres])
        self.parametres['valeur_max_existante'] = max([float(val) for val in valeurs_foncieres])
        self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
        self.parametres['valeur_max'] = self.parametres['valeur_max_existante']
        if self.parametres['annee_min'] == 0:
            self.parametres['annee_min'] = min(self.parametres['annees'])
        if self.parametres['annee_max'] == 0:
            self.parametres['annee_max'] = max(self.parametres['annees'])    

    def main(self, post):
        if 'typologie' in post:
            self.selection_typologie(post['typologie'])
        elif 'annee_min' in post:
            self.selection_annee_min(post['annee_min'])
        elif 'annee_max' in post:
            self.selection_annee_max(post['annee_max'])
        elif 'valeur_min' in post:
            self.selection_valeur_min(post['valeur_min'])
        elif 'valeur_max' in post:
            self.selection_valeur_max(post['valeur_max'])        
    
    def selection_typologie(self, code_typo):
        code_typo = int(code_typo)        
        if code_typo in [code for (code, libelle) in self.parametres['typologies']]:
            self.parametres['typologie'] = code_typo
        else:
            self.parametres['typologie'] = 0
    
    def selection_annee_min(self, annee_min):
        annee_min = int(annee_min)
        if annee_min in self.parametres['annees']:
            self.parametres['annee_min'] = annee_min
        else:
            self.parametres['annee_min'] = min(self.parametres['annees'])
    
    def selection_annee_max(self, annee_max):
        annee_max = int(annee_max)
        if annee_max in self.parametres['annees']:
            self.parametres['annee_max'] = annee_max
        else:
            self.parametres['annee_max'] = max(self.parametres['annees'])
    
    def selection_valeur_min(self, valeur_min):
        
        try:
            valeur_min = int(valeur_min)
            if valeur_min >= self.parametres['valeur_min_existante']:
                self.parametres['valeur_min'] = valeur_min
            else:
                self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
        except Exception as e:
            self.parametres['valeur_min'] = self.parametres['valeur_min_existante']
    
    def selection_valeur_max(self, valeur_max):
        try:
            valeur_max = int(valeur_max)
            if valeur_max <= self.parametres['valeur_max_existante']:
                self.parametres['valeur_max'] = valeur_max
            else:
                self.parametres['valeur_max'] = self.parametres['valeur_max_existante']
        except Exception as e:
            self.parametres['valeur_max'] = self.parametres['valeur_max_existante']   
