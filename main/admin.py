from django.contrib import admin

from main.models import Departement, Epci, Commune, Territoire
# Register your models here.

admin.site.register(Departement)
admin.site.register(Epci)
admin.site.register(Commune)
admin.site.register(Territoire)
