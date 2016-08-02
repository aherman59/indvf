from django.shortcuts import render
from django.http import JsonResponse
from pg.pgbasics import *
import json

def carto(request):
    context = None
    return render(request, 'carto.html', context)

def requete_geom(request, geom, xmin, ymin, xmax, ymax):
    pgoutils = PgOutils('localhost', 'dvf_test', '5432', 'postgres', 'postgres')
    geometries = [json.loads(elt[0]) for elt in pgoutils.execution_et_recuperation('''
SELECT ST_ASGEOJSON(geompar)
FROM dvf_d59.mutation 
WHERE geompar IS NOT NULL 
AND geompar && ST_MAKEENVELOPE({0}, {1}, {2}, {3}, 2154)'''.format(xmin, ymin, xmax, ymax))]
    entites = []
    for geometrie in geometries:
        entite = {}
        entite['type'] = 'feature'
        entite['geometry'] = geometrie
        entites.append(entite)
    geojsonobject = {}
    geojsonobject['type'] = 'FeatureCollection'
    geojsonobject['crs'] = {
                            'type': 'name',
                            'properties': {'name': 'EPSG:2154'},
                            }
    geojsonobject['features'] = entites
    return JsonResponse(geojsonobject)

# eof