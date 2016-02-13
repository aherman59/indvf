from django.contrib import admin

from indicateur.models import Departement, Epci, Commune, Territoire, Indicateur 
# Register your models here.

admin.site.register(Departement)
admin.site.register(Epci)
admin.site.register(Commune)
admin.site.register(Territoire)
admin.site.register(Indicateur)
