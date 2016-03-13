# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-02-03 20:52
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indicateur', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='commune',
            name='code',
            field=models.CharField(max_length=5, unique=True),
        ),
        migrations.AlterField(
            model_name='departement',
            name='code',
            field=models.CharField(max_length=3, unique=True),
        ),
        migrations.AlterField(
            model_name='epci',
            name='code',
            field=models.CharField(max_length=15, unique=True),
        ),
    ]
