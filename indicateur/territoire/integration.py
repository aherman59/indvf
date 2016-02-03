import csv

from indicateur.models import Departement, Epci, Commune

def integrer_departements(fichier_departement_insee):
    Departement.objects.all().delete()
    with open(fichier_departement_insee, 'r') as f:
        lignes = csv.reader(f, delimiter = ';')
        for ligne in lignes:
            d = Departement(nom=ligne[2],code=ligne[1])
            d.save()

def integrer_epcis(fichier_epci_insee):
    Epci.objects.all().delete()
    with open(fichier_epci_insee, 'r') as f:
        lignes = csv.reader(f, delimiter = ';')
        next(lignes) # enlever l'entête
        for ligne in lignes:
            if len(Epci.objects.filter(code = str(ligne[2]))) == 0:
                code_departement = ligne[0][:3] if str(ligne[0]).startswith('97') else ligne[0][:2].lower()
                e = Epci(nom=ligne[3], code=ligne[2], departement=Departement.objects.get(code = code_departement))
                e.save()
