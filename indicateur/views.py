from django.shortcuts import render

# Create your views here.

def indicateurs(request):
    context = {}
    return render(request, 'indicateurs.html', context)
