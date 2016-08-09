from django import template
from main import configuration

register = template.Library()

@register.simple_tag
def applications_disponibles():
    return configuration.recuperer_metadonnees_applications_disponibles()
