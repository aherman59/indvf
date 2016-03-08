from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.recherche, name='recherche'),
    url(r'^par_(?P<tri>[A-z]+)$', views.recherche, name='recherche_triee'),
    url(r'^par_(?P<tri>[A-z]+)/(?P<page>[0-9]+)$', views.recherche, name='recherche_triee_page'),
    url(r'^detail/(?P<id>[0-9]+)$', views.recherche_detaillee, name='recherche_detaillee'),
]
