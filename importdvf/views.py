from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.http import HttpResponse
import time

# Create your views here.


def step1(request):
    context = {'numero' : '0', 'pourcentage' : '15', 'numero_suivant':'1'}
    return render(request, 'templates/template.html', context)
    
def step(request, etape):

    context = None
    print('Etape ', etape)
    if etape =='1':
        time.sleep(5)
        context = {'numero' : '1', 'pourcentage' :'26', 'numero_suivant':'2'}
    if etape =='2':
        time.sleep(25)
        context = {'numero' : '2', 'pourcentage' :'40', 'numero_suivant':'3'}
    if etape =='3':
        time.sleep(0)
        return HttpResponse("OK")
    return render(request, 'templates/template.html', context)
