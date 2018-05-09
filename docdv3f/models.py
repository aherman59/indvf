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

from django.db import models
from django.urls import reverse
from outils import markdown2html
from main.configuration import integrer_liens_doc_variables, integrer_liens_tuto


class DescriptionVariable(models.Model):
    nom = models.CharField(max_length = 255)
    description = models.TextField(null=True, blank=True)
    observation = models.TextField(null=True, blank=True)
    construction = models.TextField(null=True, blank=True)
    limites_precautions = models.TextField(null=True, blank=True)
    fiabilite = models.TextField(null=True, blank=True)
    amelioration = models.TextField(null=True, blank=True)
    
    def __str__(self):
        return self.nom    
    
    @property
    def description_html(self):
        return self._conversion_html(self.description)
    
    @property
    def observation_html(self):
        return self._conversion_html(self.observation)
    
    @property
    def construction_html(self):
        return self._conversion_html(self.construction)
    
    @property
    def limites_precautions_html(self):
        return self._conversion_html(self.limites_precautions)
    
    @property
    def fiabilite_html(self):
        return self._conversion_html(self.fiabilite)
    
    @property
    def amelioration_html(self):
        return self._conversion_html(self.amelioration)
    
    def _conversion_html(self, champ):
        meta, html = markdown2html.convertir_markdown_en_html(champ)
        html = integrer_liens_doc_variables(html)
        html = integrer_liens_tuto(html)
        html = markdown2html.ameliorer_tableaux_avec_bootstrap(html)
        html = markdown2html.centrer_images_avec_bootstrap(html)
        return html

class Variable(models.Model):
    position = models.IntegerField()
    nom = models.CharField(max_length = 255)
    code_modele = models.IntegerField() # 1 pour DVF / 2 pour DVF+ / 3 pour DV3F
    table_associee = models.CharField(max_length = 50)
    depuis_version = models.CharField(max_length = 20)
    jusque_version = models.CharField(max_length = 20, null = True, blank=True)
    type = models.CharField(max_length = 255)
    contrainte = models.CharField(max_length = 3, null = True, blank=True)
    table_pour_creation = models.CharField(max_length = 50, null = True, blank=True)
    description_simplifiee = models.TextField(null=True, blank=True)
    description = models.ForeignKey(DescriptionVariable, null = True, on_delete=models.PROTECT)
    
    def __str__(self):
        return self.nom + ' (' + self.table_associee + ')'
    
    @property
    def url(self):
        return reverse('docdv3f:doc_variable', kwargs={'table': self.table_associee, 'variable': self.nom,})
    
    @property
    def url_table(self):
        return reverse('docdv3f:doc_table', kwargs={'table': self.table_associee,})
    
    @property
    def type_fr(self):
        if self.type == 'serial':
            return 'Entier auto-incrémenté'
        elif self.type.startswith('integer'):
            return self.type.replace('integer', 'Entier')
        elif self.type.startswith('numeric'):
            return self.type.replace('numeric', 'Décimal')
        elif self.type.startswith('varchar'):
            return self.type.replace('varchar', 'Caractère')
        elif self.type == 'boolean':
            return 'Vrai / Faux'
        elif self.type == 'geometry':
            return 'Géométrie'
        return self.type
    
    @property
    def contrainte_fr(self):
        if self.contrainte == 'PK':
            return 'Clef primaire'
        elif self.contrainte == 'U':
            vars_unique = Variable.objects.filter(contrainte = 'U', table_associee = self.table_associee)
            if len(vars_unique) > 1:
                return 'Contrainte d\'unicité sur (' + ', '.join([var.nom for var in vars_unique]) + ')'
            else:
                return 'Contrainte d\'unicité'
        elif self.contrainte == '' or not self.contrainte:
            return 'Pas de contrainte'
        elif self.contrainte == 'C':
            return 'Contrainte de validation'
        return self.contrainte
    
    @property
    def modele(self):
        if self.code_modele < 3:
            return 'DVF+ et DV3F'
        return 'DV3F'
    
    @property
    def start_version(self):
        if self.depuis_version == 'beta':
            return 0
        return int(self.depuis_version)
    
    @property
    def end_version(self):
        if self.jusque_version == 'beta':
            return 0
        if not self.jusque_version or self.jusque_version == '':
            return 9999 
        return int(self.jusque_version)
    
    def is_in_version(self, version):
        if self.start_version <= version and self.end_version >= version:
            return True
        return False
               
                
class ValeurVariable(models.Model):
    valeur = models.CharField(max_length = 255)
    depuis_version = models.CharField(max_length = 20)
    jusque_version = models.CharField(max_length = 20, null = True, blank=True)
    detail = models.TextField(null = True)
    description = models.ForeignKey(DescriptionVariable, null = True, on_delete=models.PROTECT)
    
    def __str__(self):
        return self.valeur + ' (' + str(self.description) + ')'
    
    
class GroupementVariable(models.Model):
    nom = models.CharField(max_length = 255)
    variables_associees = models.ManyToManyField(Variable)
    
    def __str__(self):
        return self.nom
    
    @property
    def lister_html(self):
        variables = self.variables_associees.all().order_by('table_associee', 'position')
        table = ''
        liste = '<p>'
        for i, variable in enumerate(variables):
            chgmt = True if table != variable.table_associee else False
            table = variable.table_associee          
            liste += '</p><p>' if chgmt and i != 0 else ''
            liste += ' table <a href="{1}"><b>{0}</b></a> : '.format(table, variable.url_table) if chgmt else ' - '
            liste += '<a href="{1}">{0}</a>'.format(variable.nom, variable.url) 
        liste +='</p>'   
        return liste
    

def integration_donnees_variables():
    if len(Variable.objects.all()) == 0:
        from importdvf.creation_dvf._dvfgestion import GestionVariablesDVF
        g = GestionVariablesDVF()
        g.charger_tables_depuis_csv('importdvf/creation_dvf/ressources/champs_dvf.csv')
        for tbl in g.tables:
            for var in tbl.variables:
                vdoc = Variable(position = var.position, 
                                nom = var.nom,
                                code_modele = var.code_etape,
                                table_associee = var.table,
                                depuis_version = 'beta',
                                jusque_version = None,
                                type = var.type,
                                contrainte = var.contrainte,
                                table_pour_creation = var.table_pour_creation,
                                description_simplifiee = var.description,
                                description = None)
                vdoc.save()
    

    

