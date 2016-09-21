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

from django import template
from django.template.defaultfilters import stringfilter

register = template.Library()


@register.filter
@stringfilter
def separateur_millier(nombre):
    if '.' in nombre:
        sep_decimal = '.'
    elif ',' in nombre:
        sep_decimal = ','
    else:
        return _separateur_millier_entier(nombre)
    return _separateur_millier_entier(nombre.split(sep_decimal)[0]) + '.' + nombre.split(sep_decimal)[1]

def _separateur_millier_entier(nombre, sep = ' '):
        if nombre:
            if len(nombre) <= 3:
                return nombre
            else:
                return _separateur_millier_entier(nombre[:-3], sep) + sep + nombre[-3:]