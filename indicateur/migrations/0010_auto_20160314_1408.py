# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-03-14 13:08
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indicateur', '0009_resultatindicateur'),
    ]

    operations = [
        migrations.AlterField(
            model_name='indicateur',
            name='code_typo',
            field=models.CharField(choices=[('999', 'Tout type de mutation'), ('8', 'Adjudication'), ('9', 'Expropriation'), ('7', 'Echange'), ('4', 'Volume'), ('31', 'Vefa - Industriel et Commercial'), ('32', 'Vefa - Appart'), ('33', 'Vefa - Maison'), ('34', 'Vefa - Non déterminé'), ('211', 'Non Bati - Terrain naturels'), ('212', 'Non Bati - Terrains forestiers'), ('213', 'Non Bati - Terrains agricoles'), ('221', 'Non Bati - Terrains artificialisés'), ('241', 'Non Bati - Terrains non déterminés'), ('231', 'Non Bati - Terrains mixtes'), ('25', 'Non Bati - Terrain à bâtir'), ('111', 'Bati - Logement/industriel et commercial'), ('112', 'Bati - Industriel et Commercial'), ('121', 'Bati - Appartements'), ('122', 'Bati - Appartement'), ('131', 'Bati - Maisons'), ('132', 'Bati - Maison'), ('141', 'Bati - Bien agricole'), ('142', 'Bati - Dépendance Logement'), ('143', 'Bati - Logement mixte'), ('144', 'Bati - Non déterminé'), ('145', 'Bati - Bien forestier')], max_length=5),
        ),
    ]