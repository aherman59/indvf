from django.db import models
from django.core.urlresolvers import reverse
from outils import markdown2html


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
    
    def description_html(self):
        return self._conversion_html(self.description)
    
    def observation_html(self):
        return self._conversion_html(self.observation)
    
    def construction_html(self):
        return self._conversion_html(self.construction)
    
    def limites_precautions_html(self):
        return self._conversion_html(self.limites_precautions)
    
    def fiabilite_html(self):
        return self._conversion_html(self.fiabilite)
    
    def amelioration_html(self):
        return self._conversion_html(self.amelioration)
    
    def _conversion_html(self, champ):
        meta, html = markdown2html.convertir_markdown_en_html(champ)
        html = self._integrer_liens_variables(html)
        return html
    
    def _integrer_liens_variables(self, html):
        html_separe = html.split('@@')
        html = ''
        for i, elt in enumerate(html_separe):            
            if (i%2 == 1):
                table, variable = elt.split('|')
                url = reverse('docdv3f:doc_variable', kwargs={'table': table, 'variable': variable})
                html += '<a href="{1}">{0}</a>'.format(variable, url)
            else:
                html += elt
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
    description = models.ForeignKey(DescriptionVariable, null = True)
    
    def __str__(self):
        return self.nom + ' (' + self.table_associee + ')'
    
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
    
    def modele(self):
        if self.code_modele < 3:
            return 'DVF+ et DV3F'
        return 'DV3F' 
                
class ValeurVariable(models.Model):
    valeur = models.CharField(max_length = 255)
    depuis_version = models.CharField(max_length = 20)
    jusque_version = models.CharField(max_length = 20, null = True, blank=True)
    detail = models.TextField(null = True)
    description = models.ForeignKey(DescriptionVariable, null = True)
    
    def __str__(self):
        return self.valeur + ' (' + str(self.description) + ')'
    
    
class GroupementVariable(models.Model):
    nom = models.CharField(max_length = 255)
    variables_associees = models.ManyToManyField(Variable)
    


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
    

    

