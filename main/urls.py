from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.applications, name='applications'),
    url(r'^config_bdd$', views.configuration_bdd, name = 'configuration_bdd'),
]
