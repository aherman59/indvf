from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.accueil_doc, name='accueil_doc'),
    url(r'^table/(?P<table>[a-z_]+)$', views.doc_table, name='doc_table'),
    url(r'^variable/(?P<table>[a-z_]+)/(?P<variable>[0-9a-z_]+)$', views.doc_variable, name='doc_variable'),
]
