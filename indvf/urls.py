from django.urls import re_path, include
from django.contrib import admin
from main.views import views

urlpatterns = [
    re_path(r'^$', views.applications, name='start'),
    re_path(r'^import/', include(('importdvf.urls','import'))),
    re_path(r'^main/', include(('main.urls','main'))),
    re_path(r'^indicateur/', include(('indicateur.urls','indicateur'))),
    re_path(r'^indicateur_v2/', include(('indicateur_v2.urls','indicateur_v2'))),
    re_path(r'^recherche/', include(('easydvf.urls','easydvf'))),
    re_path(r'^doc/', include(('docdv3f.urls','docdv3f'))),
    re_path(r'^tuto/', include(('tutodvf.urls','tutodvf'))),
    re_path(r'^geo/', include(('geodv3f.urls','geodv3f'))),
    re_path(r'^export/', include(('exportdvf.urls','exportdvf'))),
    re_path(r'^admin/', admin.site.urls),
]