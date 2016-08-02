from django.shortcuts import render

def carto(request):
    context = None
    return render(request, 'carto.html', context)

# eof