'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

from django.db import models


class ResultatIndicateurManager(models.Manager):
    
    def resultat_as_tuple(self, indicateur, id_territoire, type_territoire):
        resultats = self.filter(id_indicateur = indicateur.id).filter(id_territoire = id_territoire).filter(type_territoire=type_territoire)
        if len(resultats) == 0:
            return None
        annee_debut = indicateur.annee_debut
        annee_fin = indicateur.annee_fin
        if indicateur.periode == 'ma':
            return ((str(annee_debut) + ' - ' + str(annee_fin), resultats[0].resultat),)
        elif indicateur.periode == 'a':
            r = [(str(result.annee), result.resultat) for result in resultats]
            return tuple(sorted(r, key = lambda x : int(x[0])))
    
    def supprimer_resultats(self, id_indicateur):
        self.filter(id_indicateur = id_indicateur).delete()
    
    def supprimer_tout(self):
        self.all().delete()             

        
class ResultatIndicateur(models.Model):
    id_territoire = models.IntegerField()
    type_territoire = models.CharField(max_length = 50)
    id_indicateur = models.IntegerField()
    annee = models.IntegerField(null = True)
    resultat = models.IntegerField()
    
    objects = ResultatIndicateurManager()
