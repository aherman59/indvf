from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.carto, name='carto'),
    url(r'^requete/(?P<geom>[A-z]+)/(?P<xmin>[0-9.-]+)/(?P<ymin>[0-9.-]+)/(?P<xmax>[0-9.-]+)/(?P<ymax>[0-9.-]+)$', views.requete_geom, name = 'requete_geom'),
    url(r'^detail/(?P<id>[0-9]+)$', views.requete_detail_mutation, name='requete_detail'),
]
