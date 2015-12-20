from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.step1, name='index'),
    url(r'^step/(?P<etape>[0-9]+)/$', views.step, name='step'),
]
