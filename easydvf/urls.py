from django.conf.urls import url
from .views import views
from .views import ajax

urlpatterns = [
    url(r'^$', views.recherche, name='recherche'),
    url(r'^detail/(?P<id>[0-9]+)$', ajax.recherche_detaillee, name='recherche_detaillee'),
    url(r'^modification_affichage_table/(?P<tri>[A-z]+)/(?P<page>[0-9]+)$', ajax.maj_tableau, name='maj_tableau'),
]
