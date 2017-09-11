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

from django.contrib import admin

from docdv3f.models import DescriptionVariable, Variable, ValeurVariable, GroupementVariable

# action d'administration pour copier des enregistrements existants
def copier_enregistrement(modeladmin, request, queryset):
    for objet in queryset:
        objet.id = None
        objet.save()
copier_enregistrement.short_description = 'Copier les enregistrements sélectionnées'

class VariableAdmin(admin.ModelAdmin):
    list_display = ('nom', 'type', 'table_associee', 'position','description_simplifiee', 'contrainte', 'description', 'code_modele')
    ordering = ('table_associee', 'position')
    search_fields = ('nom', 'table_associee')
    
    fieldsets = (
       ('Général', {
            'classes': ['wide', 'extrapretty',],
            'fields': ('nom', 'type', 'table_associee', 'position', 'contrainte', 'code_modele')
        }),
        ('Description', {
           'classes': ['wide', 'extrapretty',],
           'description': 'Chaque variable est rattachée à une description plus fine issue de DescriptionVariable',
           'fields': ('description_simplifiee','depuis_version', 'jusque_version', 'table_pour_creation', 'description' )
        }),
    )

class DescriptionVariableAdmin(admin.ModelAdmin):
    list_display = ('nom',)
    fieldsets = (
       ('Description', {
            'classes': ['wide', 'extrapretty',],
            'fields': ('nom', 'description', 'observation'),
            'description': 'La description peut être attachée aux variables du même nom issue de différentes tables.',
        }),
        ('Construction', {
           'classes': ['wide', 'extrapretty',],
           'description': 'Le champ construction explicite la manière dont a été construite la variable.',
           'fields': ('construction',)
        }),
        ('Thématique', {
           'classes': ['wide', 'extrapretty',],
           'description': 'Ces champs apportent des précisions d\'ordre thématique sur la façon d\'utiliser la variable.',
           'fields': ('limites_precautions','fiabilite', 'amelioration')
        }),
    )
    actions = [copier_enregistrement]
    
class ValeurVariableAdmin(admin.ModelAdmin):
    list_display = ('description','valeur', 'detail')
    ordering = ('description','valeur')
    search_fields = ('description', 'valeur')
    fieldsets = (
       ('Valeur', {
            'classes': ['wide', 'extrapretty',],
            'fields': ('valeur', 'detail'),
        }),
        ('Version', {
           'classes': ['wide', 'extrapretty',],
           'fields': ('depuis_version','jusque_version')
        }),
        ('Description associée', {
           'classes': ['wide', 'extrapretty',],           
           'fields': ('description',)
        }),
    )
    
    actions = [copier_enregistrement]
    
class GroupementVariableAdmin(admin.ModelAdmin):
    list_display = ('nom',)
    ordering = ('nom',)
    search_fields = ('description', 'variables_associees',)
    fieldsets = (
       ('Association', {
            'classes': ['wide', 'extrapretty',],
            'fields': ('nom', 'variables_associees'),
        }),
    )

admin.site.register(DescriptionVariable, DescriptionVariableAdmin)
admin.site.register(Variable, VariableAdmin)
admin.site.register(ValeurVariable, ValeurVariableAdmin)
admin.site.register(GroupementVariable, GroupementVariableAdmin)
