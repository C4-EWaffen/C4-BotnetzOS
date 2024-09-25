#!/bin/bash

# Erkennen des Betriebssystems
OS=$(uname -s)

# Installationsbefehle für verschiedene Betriebssysteme
if [ "$OS" == "Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip postgresql postgresql-contrib
elif [ "$OS" == "Darwin" ]; then
    brew update
    brew install python3 postgresql
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Python-Abhängigkeiten installieren
pip3 install -r requirements.txt

# PostgreSQL-Datenbank einrichten
sudo -u postgres psql -c "CREATE DATABASE mydatabase;"
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"

echo "Installation abgeschlossen!"
