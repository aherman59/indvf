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
from django.contrib.auth import views as auth_views

urlpatterns = [
    url(r'^$', views.applications, name='applications'),
    url(r'^connexion/$', auth_views.login, {'template_name': 'connexion.html'}, name='connexion'),
    url(r'^deconnexion/$', auth_views.logout, {'next_page': '/main/'}, name='deconnexion'),
    url(r'^changement_mdp/$', auth_views.password_change, {'template_name': 'chgmt_mdp.html', 'post_change_redirect': '/main/'}, name='changement_mdp'),
    url(r'^config_bdd$', views.configuration_bdd, name = 'configuration_bdd'),
    url(r'^credits$', views.credits, name = 'credits'),
]
