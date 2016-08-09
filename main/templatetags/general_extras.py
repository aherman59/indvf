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