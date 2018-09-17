from django.urls import re_path, include
from django.contrib import admin
from main.views import views

urlpatterns = [
    re_path(r'^dv3f/$', views.applications, name='start'),
    re_path(r'^dv3f/main/', include(('main.urls','main'))),
    re_path(r'^dv3f/import/', include(('importdvf.urls','import'))),
    re_path(r'^dv3f/indicateur/', include(('indicateur.urls','indicateur'))),
    re_path(r'^dv3f/indicateur_v2/', include(('indicateur_v2.urls','indicateur_v2'))),
    re_path(r'^dv3f/recherche/', include(('easydvf.urls','easydvf'))),
    re_path(r'^dv3f/doc/', include(('docdv3f.urls','docdv3f'))),
    re_path(r'^dv3f/tuto/', include(('tutodvf.urls','tutodvf'))),
    re_path(r'^dv3f/geo/', include(('geodv3f.urls','geodv3f'))),
    re_path(r'^dv3f/export/', include(('exportdvf.urls','exportdvf'))),
    re_path(r'^dv3f/admin/', admin.site.urls),
]