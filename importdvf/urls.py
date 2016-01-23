from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.formulaire_configuration, name='formulaire_configuration'),
    url(r'^step/(?P<etape>[0-9]+)/$', views.etape_import, name='etape_import'),
]
