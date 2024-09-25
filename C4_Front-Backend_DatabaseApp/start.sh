#!/bin/bash

# PostgreSQL-Server starten
sudo service postgresql start

# Flask-Anwendung starten
export FLASK_APP=app.py
flask run
