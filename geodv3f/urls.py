'''

#    Copyright (C) 2016  Cerema
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.

'''

from django.conf.urls import url

from .views import views

urlpatterns = [
    url(r'^$', views.carto, name='carto'),
    url(r'^requete/(?P<nom_geometrie>[A-z]+)/(?P<xmin>[0-9.-]+)/(?P<ymin>[0-9.-]+)/(?P<xmax>[0-9.-]+)/(?P<ymax>[0-9.-]+)$', views.requete_geom, name = 'requete_geom'),
    url(r'^detail/(?P<id>[0-9]+)$', views.requete_detail_mutation, name='requete_detail'),
]
