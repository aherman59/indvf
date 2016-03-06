from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.recherche, name='recherche'),
    url(r'^detail/(?P<id>[0-9]+)$', views.recherche_detaillee, name='recherche_detaillee'),
]
