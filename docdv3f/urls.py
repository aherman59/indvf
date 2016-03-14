from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.accueil_doc, name='accueil_doc'),
]
