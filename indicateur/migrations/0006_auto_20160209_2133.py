# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-02-09 21:33
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indicateur', '0005_indicateur'),
    ]

    operations = [
        migrations.CreateModel(
            name='Territoire',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=100, unique=True)),
                ('communes', models.ManyToManyField(to='indicateur.Commune')),
                ('departements', models.ManyToManyField(to='indicateur.Departement')),
                ('epcis', models.ManyToManyField(to='indicateur.Epci')),
            ],
        ),
        migrations.AddField(
            model_name='indicateur',
            name='actif',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='indicateur',
            name='variable',
            field=models.CharField(default='valeurfonc', max_length=50),
            preserve_default=False,
        ),
    ]
