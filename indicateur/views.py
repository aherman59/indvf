from django.shortcuts import render
from main import configuration
from .calcul.pg import * 

# Create your views here.

def indicateurs(request):
    config_active = configuration.configuration_active()
    test = []
    print(config_active.hote, config_active.bdd, config_active.utilisateur, config_active.mdp, config_active.port)
    if config_active:
        pgoutils = PgOutils(config_active.hote, config_active.bdd, config_active.port, config_active.utilisateur, config_active.mdp, script = 'sorties/script_indvf.sql')
        test = pgoutils.lister_schemas()
    context = {'departements' : test}
    return render(request, 'indicateurs.html', context)
