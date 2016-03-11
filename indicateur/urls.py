from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.indicateurs, name='indicateurs'),
    url(r'^configuration_indicateur$', views.configuration_indicateur, name='configuration_indicateur')
]
