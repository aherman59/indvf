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
