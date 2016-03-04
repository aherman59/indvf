from django.shortcuts import render

# Create your views here.

def recherche(request):
    context = None
    return render(request, 'recherche.html', context)