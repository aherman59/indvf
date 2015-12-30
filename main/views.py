from django.shortcuts import render
import main.configuration as configuration
from collections import namedtuple

# Create your views here.

def applications(request):
    appli_nt = namedtuple('Application', ['nom', 'description','version', 'classe_fa', 'image', 'url'])

    applis = [appli_nt(nom='ImportDVF+', description='Application permettant d\'importer des données sources DVF dans une base de données PostgreSQL 9.x', 
                       version='2.0', classe_fa='fa fa-database', image = 'img/import.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='InDVF-Indicateurs', description='Application permettant de produire, à partir de DVF+ ou DV3F, des indicateurs agrégés pour différentes échelles géographiques', version='1.0', classe_fa='fa fa-bar-chart', image = 'img/indicateur.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='GeoDVF', description='Application permettant de faciliter la production de cartographies à partir de DVF (projet QGis, export shp, etc)', 
                       version='1.0', classe_fa='fa fa-map', image = 'img/geo.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='DocDV3F', description='Application donnant accès aux documentations DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-book', image = 'img/documentation.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='UseDV3F', description='Application pour mieux comprendre et travailler avec les bases de données DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-info-circle', image = 'img/usedvf.jpg', url='import:formulaire_configuration'),
              appli_nt(nom='TutoDVF', description='Application tutorielle pour démarrer avec DVF et les bases de données DVF+ et DV3F', 
                       version='1.0', classe_fa='fa fa-graduation-cap', image = 'img/tutoriel.jpg', url='import:formulaire_configuration'),
              ]
    
    context = {'applis':applis}
    return render(request, 'applications.html', context)














