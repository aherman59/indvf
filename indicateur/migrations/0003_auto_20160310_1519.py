# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-03-10 14:19
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indicateur', '0002_indicateur_unite'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='commune',
            name='departement',
        ),
        migrations.RemoveField(
            model_name='commune',
            name='epci',
        ),
        migrations.RemoveField(
            model_name='epci',
            name='departement',
        ),
        migrations.RemoveField(
            model_name='territoire',
            name='communes',
        ),
        migrations.RemoveField(
            model_name='territoire',
            name='departements',
        ),
        migrations.RemoveField(
            model_name='territoire',
            name='epcis',
        ),
        migrations.AlterField(
            model_name='indicateur',
            name='type_indic',
            field=models.CharField(choices=[('somme', 'Somme'), ('decompte', 'Décompte'), ('mediane', 'Médiane')], max_length=30),
        ),
        migrations.DeleteModel(
            name='Commune',
        ),
        migrations.DeleteModel(
            name='Departement',
        ),
        migrations.DeleteModel(
            name='Epci',
        ),
        migrations.DeleteModel(
            name='Territoire',
        ),
    ]
