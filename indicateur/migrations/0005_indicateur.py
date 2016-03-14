# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-02-08 20:44
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indicateur', '0004_auto_20160205_2220'),
    ]

    operations = [
        migrations.CreateModel(
            name='Indicateur',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type_indic', models.CharField(max_length=100)),
                ('periode', models.CharField(choices=[('a', 'annuel'), ('ma', 'multi-annuel')], max_length=2)),
                ('annee_debut', models.IntegerField(null=True)),
                ('annee_fin', models.IntegerField(null=True)),
                ('code_typo', models.CharField(max_length=5)),
            ],
        ),
    ]