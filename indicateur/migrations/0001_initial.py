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

# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-20 20:22
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Indicateur',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=255)),
                ('type_indic', models.CharField(choices=[('somme', 'Somme'), ('compte', 'Décompte'), ('mediane_10', 'Médiane')], max_length=30)),
                ('unite', models.CharField(max_length=30, null=True)),
                ('periode', models.CharField(choices=[('a', 'annuel'), ('ma', 'multi-annuel')], max_length=2)),
                ('variable', models.CharField(max_length=50)),
                ('annee_debut', models.IntegerField()),
                ('annee_fin', models.IntegerField()),
                ('code_typo', models.CharField(choices=[('999', 'Tout type de mutation'), ('8', 'Adjudication'), ('9', 'Expropriation'), ('7', 'Echange'), ('4', 'Volume'), ('31', 'Vefa - Industriel et Commercial'), ('32', 'Vefa - Appart'), ('33', 'Vefa - Maison'), ('34', 'Vefa - Non déterminé'), ('211', 'Non Bati - Terrain naturels'), ('212', 'Non Bati - Terrains forestiers'), ('213', 'Non Bati - Terrains agricoles'), ('221', 'Non Bati - Terrains artificialisés'), ('241', 'Non Bati - Terrains non déterminés'), ('231', 'Non Bati - Terrains mixtes'), ('25', 'Non Bati - Terrain à bâtir'), ('111', 'Bati - Logement/industriel et commercial'), ('112', 'Bati - Industriel et Commercial'), ('121', 'Bati - Appartements'), ('122', 'Bati - Appartement'), ('131', 'Bati - Maisons'), ('132', 'Bati - Maison'), ('141', 'Bati - Bien agricole'), ('142', 'Bati - Dépendance Logement'), ('143', 'Bati - Logement mixte'), ('144', 'Bati - Non déterminé'), ('145', 'Bati - Bien forestier')], max_length=5)),
                ('type_graphe', models.CharField(choices=[('bar', 'diagramme à barre'), ('line-dotted', 'diagramme point-ligne')], max_length=20)),
                ('actif', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='ResultatIndicateur',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('id_territoire', models.IntegerField()),
                ('type_territoire', models.CharField(max_length=50)),
                ('id_indicateur', models.IntegerField()),
                ('annee', models.IntegerField(null=True)),
                ('resultat', models.IntegerField()),
            ],
        ),
    ]
