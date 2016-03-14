# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-03-10 14:19
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Commune',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=100)),
                ('code', models.CharField(max_length=5)),
                ('code_actualite', models.CharField(max_length=2, null=True)),
                ('commune_absorbante', models.CharField(max_length=5, null=True)),
                ('commune_emancipee', models.CharField(max_length=5, null=True)),
                ('date_absorbtion', models.DateField(null=True)),
                ('date_separation', models.DateField(null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Departement',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=100)),
                ('code', models.CharField(max_length=3, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Epci',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=255)),
                ('code', models.CharField(max_length=15, unique=True)),
                ('departement', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.Departement')),
            ],
        ),
        migrations.CreateModel(
            name='Territoire',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nom', models.CharField(max_length=100, unique=True)),
                ('communes', models.ManyToManyField(to='main.Commune')),
                ('departements', models.ManyToManyField(to='main.Departement')),
                ('epcis', models.ManyToManyField(to='main.Epci')),
            ],
        ),
        migrations.AddField(
            model_name='commune',
            name='departement',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.Departement'),
        ),
        migrations.AddField(
            model_name='commune',
            name='epci',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main.Epci'),
        ),
    ]