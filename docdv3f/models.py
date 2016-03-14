from django.db import models


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
    

    

