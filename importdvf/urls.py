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
    url(r'^$', views.formulaire_configuration, name='formulaire_configuration'),
    url(r'^step/(?P<etape>[0-9]+)/$', views.etape_import, name='etape_import'),
    url(r'^erreur/$', views.erreur, name='erreur'),
    url(r'^fin_import/$', views.fin_import, name='fin_import')
]
