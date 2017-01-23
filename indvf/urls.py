from django.conf.urls import url, include
from django.contrib import admin
from main.views import views

urlpatterns = [
    url(r'^$', views.applications, name='start'),
    url(r'^import/', include('importdvf.urls', namespace='import')),
    url(r'^main/', include('main.urls', namespace='main')),
    url(r'^indicateur/', include('indicateur.urls', namespace='indicateur')),
    url(r'^recherche/', include('easydvf.urls', namespace='easydvf')),
    url(r'^doc/', include('docdv3f.urls', namespace='docdv3f')),
    url(r'^tuto/', include('tutodvf.urls', namespace='tutodvf')),
    url(r'^geo/', include('geodv3f.urls', namespace='geodv3f')),
    url(r'^export/', include('exportdvf.urls', namespace='exportdvf')),
    url(r'^admin/', admin.site.urls),
]