#! /bin/sh
python manage.py migrate
rm -fr collectstatic/*
python manage.py collectstatic --no-input
uwsgi --ini /app/uwsgi.ini &
python manage.py qcluster
