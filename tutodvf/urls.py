from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.accueil, name='accueil'),
    url(r'^(?P<nom_fichier_md>[a-z0-9_]+)$', views.fiche, name = 'fiche')
]
