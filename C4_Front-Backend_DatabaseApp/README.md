# Netzwerk- und VPN-Verwaltungsanwendung

## Installation

1. Klonen Sie das Repository:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```
2. Führen Sie das Installationsskript aus:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## Starten der Anwendung

1. Führen Sie das Startskript aus:
   ```bash
   chmod +x start.sh
   ./start.sh
   ```

## Konfigurationsdateien

- `config.py`: Konfigurationsdatei für die Flask-Anwendung.
- `requirements.txt`: Liste der Python-Abhängigkeiten.

## Nutzung

- Die Anwendung wird auf `http://localhost:5000` laufen.
- Verwenden Sie die API-Endpunkte, um Verbindungen zu erstellen und abzurufen.

## API-Endpunkte

- `POST /connections`: Erstellen einer neuen Verbindung.
- `GET /connections`: Abrufen aller Verbindungen.

## Netzwerkvisualisierung

- Die Netzwerkvisualisierung wird mit D3.js implementiert und in der Benutzeroberfläche angezeigt.
