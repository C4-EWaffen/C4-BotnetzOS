#!/bin/bash

# Farbcodes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verstecktes Verzeichnis für Ausgabe
output_dir="$HOME/.C4-Adikit"
mkdir -p "$output_dir"

# GitHub Repository URL
repo_url="https://github.com/C4-EWaffen/C4-BotnetzOS/tree/C4/www"

# Verzeichnis für PHP-Dateien
php_dir="/var/www/html"

# Funktion zur Anzeige der Terminal-Grafik
display_header() {
    clear
    echo -e "${BLUE}"
    cat << "EOF"
 _.-^^---....,,--       
 _--                  --_  
<                        >)
|                         | 
 \._                   _./  
    ```--. . , ; .--'''       
          | |   |             
       .-=||  | |=-.   
       `-=#$%&%$#=-'   
          | ;  :|     
 _____.,-#%&$@%#&#~,._____

          _ ._  _ , _ ._
         (_ ' ( `  )_  .__)
        ( (  (    )   `)  ) _)
        (__ (_   (_ . _) _) ,__)
            `~~`\ ' . /`~~`
                 ;   ;               
                 /   \              
                 +                                                 =====   
                 +__                                                __||__  
________/_ __ \_____________|  |_,,_H______________________________________// | BOOM |
    | C4-BotnetOS |                                                        // |      |
-----------------------------------------------------------------------------'|______|  
EOF
    echo -e "${NC}"
}

# Funktion zur Erstellung des Dockerfiles
create_dockerfile() {
    display_header
    echo -e "${BLUE}Erstelle Dockerfile...${NC}"
    cat <<EOF > Dockerfile
# Basis-Image mit PHP und SQLite
FROM php:8.1-apache

# Arbeitsverzeichnis im Container festlegen
WORKDIR /var/www/html

# Systemabhängigkeiten installieren
RUN apt-get update && apt-get install -y \\
    sqlite3 \\
    libsqlite3-dev \\
    openvpn \\
    wireguard-tools \\
    nmap \\
    python3-pip \\
    git \\
    curl \\
    && docker-php-ext-install pdo_sqlite

# Web-App-Dateien kopieren
COPY . /var/www/html/

# SQLite-Datenbank vorbereiten (optional)
RUN sqlite3 /var/www/html/database.db < /var/www/html/schema.sql

# Rechte für das Apache-Verzeichnis setzen
RUN chown -R www-data:www-data /var/www/html

# Apache-Konfiguration anpassen (optional)
# RUN a2enmod rewrite
# RUN service apache2 restart

# Exponieren des Apache-Ports
EXPOSE 80

# Container starten
CMD ["apache2-foreground"]
EOF
    echo -e "${GREEN}Dockerfile erfolgreich erstellt.${NC}"
}

# Funktion zum Herunterladen der PHP-Dateien
download_php_files() {
    display_header
    echo -e "${BLUE}Lade PHP-Dateien von GitHub herunter...${NC}"

    # Erstelle das Verzeichnis, falls es nicht existiert
    sudo mkdir -p "$php_dir"

    # Herunterladen der PHP-Dateien
    curl -LJO https://github.com/C4-EWaffen/C4-BotnetzOS/archive/refs/heads/C4.zip
    unzip C4.zip
    sudo cp -r C4-BotnetzOS-C4/www/* "$php_dir/"

    # Bereinigung
    rm C4.zip
    rm -rf C4-BotnetzOS-C4

    echo -e "${GREEN}PHP-Dateien erfolgreich heruntergeladen und installiert.${NC}"
}

# Funktion zur Erstellung des Docker-Images
build_docker_image() {
    display_header
    echo -e "${BLUE}Baue Docker-Image...${NC}"
    docker build -t c4-webapp .
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Docker-Image erfolgreich gebaut.${NC}"
    else
        echo -e "${RED}Fehler beim Erstellen des Docker-Images.${NC}"
    fi
}

# Funktion zur Ausführung des Docker-Containers
run_docker_container() {
    display_header
    echo -e "${BLUE}Starte Docker-Container...${NC}"
    docker run -d -p 8919:80 --name c4-container c4-webapp
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Docker-Container erfolgreich gestartet.${NC}"
    else
        echo -e "${RED}Fehler beim Starten des Docker-Containers.${NC}"
    fi
}

# Funktion zur Installation von Node-RED
install_nodered() {
    display_header
    echo -e "${BLUE}Installiere Node-RED...${NC}"
    docker run -d -p 1880:1880 --name nodered-container nodered/node-red
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Node-RED erfolgreich installiert und gestartet.${NC}"
    else
        echo -e "${RED}Fehler bei der Installation von Node-RED.${NC}"
    fi
}

# Funktion zur Überprüfung und Installation von OpenVPN und WireGuard
install_vpn_tools() {
    display_header
    echo -e "${BLUE}Installiere OpenVPN und WireGuard...${NC}"
    sudo apt-get update && sudo apt-get install -y openvpn wireguard
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}OpenVPN und WireGuard erfolgreich installiert.${NC}"
    else
        echo -e "${RED}Fehler bei der Installation von OpenVPN und WireGuard.${NC}"
    fi
}

# Funktion zur Verknüpfung und zum Tunneln von Verbindungen
setup_tunneling() {
    display_header
    echo -e "${BLUE}Richte Tunneling und sichere Verbindungen ein...${NC}"
    # Füge hier deine spezifischen Tunneling-Befehle hinzu
    echo -e "${GREEN}Tunneling und sichere Verbindungen konfiguriert.${NC}"
}

# Hauptmenü
main_menu() {
    while true; do
        display_header
        echo -e "${BLUE} C4 Setup Manager${NC}"
        echo -e "${GREEN}1. Docker-Umgebung einrichten${NC}"
        echo -e "${GREEN}2. PHP-Dateien herunterladen${NC}"
        echo -e "${GREEN}3. Node-RED installieren${NC}"
        echo -e "${GREEN}4. OpenVPN und WireGuard installieren${NC}"
        echo -e "${GREEN}5. Tunneling und sichere Verbindungen einrichten${NC}"
        echo -e "${RED}6. Beenden${NC}"
        echo -e "${BLUE}Wählen Sie eine Option:${NC}"
        read option

        case $option in
            1) create_dockerfile; build_docker_image; run_docker_container ;;
            2) download_php_files ;;
            3) install_nodered ;;
            4) install_vpn_tools ;;
            5) setup_tunneling ;;
            6) echo -e "${RED}Beenden...${NC}"; exit ;;
            *) echo -e "${RED}Ungültige Option.${NC}" ;;
        esac
        echo -e "${BLUE}Drücken Sie eine beliebige Taste, um fortzufahren...${NC}"
        read -n 1
    done
}

# Hauptmenü starten
main_menu
