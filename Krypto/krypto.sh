#!/bin/bash

# Erstelle Schlüsselpaar
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

# Symmetrische Verschlüsselung
REMOTE_DIR="/home/$USER"
PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)
ssh user@remote 'openssl enc -aes-256-cbc -salt -in '$REMOTE_DIR' -out '$REMOTE_DIR'.enc -pass file:<(echo $PUBLIC_KEY)'

echo "Verschlüsselung abgeschlossen. Der verschlüsselte Inhalt ist unter $REMOTE_DIR.enc"
