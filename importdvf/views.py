from django.shortcuts import render
from importdvf.forms import ConfigForm
import time

from django.http import HttpResponse

# Create your views here.

def formulaire_configuration(request):
    formulaire = ConfigForm()
    context = {'etape':'1', 'formulaire':formulaire}
    return render(request, 'formulaire_configuration.html', context)
    
def etape_import(request, etape):
    context = None
    print('Etape ', etape)
    if etape =='1':
        formulaire  = ConfigForm(request.POST)
        if formulaire.is_valid():
            print(formulaire.cleaned_data)
            context = {'numero' : '1', 'pourcentage' :'10', 'numero_suivant':'2'}
        else:
            context = {'etape':'1', 'formulaire':formulaire}
            return render(request, 'formulaire_configuration.html', context)
    if etape =='2':
        time.sleep(2)
        context = {'numero' : '2', 'pourcentage' :'40', 'numero_suivant':'3'}
    if etape =='3':
        time.sleep(5)
        return HttpResponse("OK")
    return render(request, 'etapes_import.html', context)
