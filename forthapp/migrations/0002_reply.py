# Generated by Django 3.0.8 on 2020-08-17 04:08

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('forthapp', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Reply',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=80)),
                ('visitor', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='forthapp.Visitor')),
            ],
        ),
    ]