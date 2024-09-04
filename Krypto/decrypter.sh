#!/bin/bash

# Entschlüsselung mit privatem Schlüssel
PRIVATE_KEY_PATH="~/.ssh/id_rsa"
ENC_FILE="/home/$USER/home.enc"
DEC_FILE="/home/$USER/home.dec"

openssl enc -d -aes-256-cbc -in "$ENC_FILE" -out "$DEC_FILE" -pass file:<(cat "$PRIVATE_KEY_PATH")

echo "Entschlüsselung abgeschlossen. Der Inhalt befindet sich unter $DEC_FILE"
