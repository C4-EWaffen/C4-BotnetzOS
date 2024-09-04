#!/bin/bash

# Funktion zur Installation von Paketen auf Debian-basierten Systemen
install_deps() {
    sudo apt update
    sudo apt install -y apache2 php libapache2-mod-php php-mysql
}

# Funktion zur Installation von Paketen auf Red Hat-basierten Systemen
install_redhat_deps() {
    sudo yum update -y
    sudo yum install -y httpd php php-mysqlnd
}

# Funktion zur Installation auf Windows (WSL)
install_windows() {
    echo "Windows-Installation nicht implementiert. Bitte manuell durchführen."
}

# Funktion zur Installation auf Android Termux
install_termux() {
    pkg update
    pkg install -y apache2 php php-mysql
}

# Webserver und PHP-Dateien einrichten
setup_webserver() {
    sudo systemctl start apache2
    sudo systemctl enable apache2

    sudo mkdir -p /var/www/html
    sudo chown -R $USER:$USER /var/www/html

    cat > /var/www/html/index.php <<EOF
<?php
session_start();
include 'db.php';

if (!isset(\$_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

\$vpnServers = \$pdo->query("SELECT * FROM Configurations WHERE key = 'vpn_address'")->fetchAll();
\$agentStatus = \$pdo->query("SELECT * FROM Agents")->fetchAll();
\$targetStatus = \$pdo->query("SELECT * FROM Targets")->fetchAll();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hauptseite</title>
    <style>
        body {
            background-color: #202020;
            color: #E0E0E0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .logo {
            height: 50px;
        }
        nav {
            margin: 20px 0;
        }
        nav a {
            color: #1A73E8;
            text-decoration: none;
            margin: 0 10px;
        }
        .status {
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .status.success {
            background-color: #28a745;
            color: #fff;
        }
        .status.error {
            background-color: #dc3545;
            color: #fff;
        }
        .content {
            width: 80%;
            max-width: 1200px;
        }
        footer {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <img class="logo" src="server-icon.png" alt="Server-Rack Logo">
        <h1>Hauptseite</h1>
    </header>

    <nav>
        <a href="main.php">Start</a>
        <a href="c4-config.php">C4-Konfig</a>
        <a href="connections.php">Connections</a>
        <a href="krypto.php">C4 Krypto-Area</a>
        <a href="btnt.php">C4-Botnetz</a>
        <a href="c4-agents.php">C4-Agents</a>
        <a href="recon.php">Aufklärung</a>
        <a href="software-kits.php">C4-KITs</a>
    </nav>

    <div class="content">
        <h2>Systemübersicht</h2>
        <div class="status success">VPN-Server: <?= \$vpnServers[0]['value'] ?? 'Nicht konfiguriert' ?></div>
        <h3>Agentenstatus</h3>
        <?php foreach (\$agentStatus as \$agent): ?>
            <div class="status <?= \$agent['status'] == 'aktiv' ? 'success' : 'error' ?>">
                Agent <?= htmlspecialchars(\$agent['name']) ?>: <?= htmlspecialchars(\$agent['status']) ?>
            </div>
        <?php endforeach; ?>

        <h3>Zielstatus</h3>
        <?php foreach (\$targetStatus as \$target): ?>
            <div class="status <?= \$target['status'] == 'kompromittiert' ? 'error' : 'success' ?>">
                Ziel <?= htmlspecialchars(\$target['name']) ?>: <?= htmlspecialchars(\$target['status']) ?>
            </div>
        <?php endforeach; ?>

        <!-- Weitere Informationen und Statistiken -->
    </div>

    <footer>
        <p>&copy; 2024 C4-Server</p>
    </footer>
</body>
</html>
EOF

    cat > /var/www/html/krypto.php <<EOF
<?php
session_start();

if (!isset(\$_SESSION['loggedin']) || \$_SESSION['loggedin'] !== true) {
    header('Location: index.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C4 Krypto-Area</title>
    <style>
        body {
            background-color: #202020;
            color: #E0E0E0;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333333;
            width: 100%;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .logo {
            width: 100px;
            height: auto;
            margin-right: 20px;
        }
        h1 {
            color: #1A73E8;
            font-size: 36px;
        }
        nav {
            background-color: #1A73E8;
            width: 100%;
            padding: 10px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        nav a {
            margin: 5px;
            color: #FFFFFF;
            text-decoration: none;
            font-weight: bold;
        }
        .content {
            background-color: #2D2D2D;
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
        }
        footer {
            margin-top: 20px;
            font-size: 12px;
            color: #B0B0B0;
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <img class="logo" src="server-icon.png" alt="Server-Rack Logo">
        <h1>C4 Krypto-Area</h1>
    </header>

    <nav>
        <a href="main.php">Start</a>
        <a href="c4-config.php">C4-Konfig</a>
        <a href="connections.php">Connections</a>
        <a href="krypto.php">C4 Krypto-Area</a>
        <a href="btnt.php">C4-Botnetz</a>
        <a href="c4-agents.php">C4-Agents</a>
        <a href="recon.php">Aufklärung</a>
        <a href="software-kits.php">C4-KITs</a>
    </nav>

    <div class="content">
        <h2>Krypto-Area</h2>
        <p>Verwalten Sie Ihre kryptografischen Einstellungen und Schlüssel hier.</p>
    </div>

    <footer>
        <p>&copy; 2024 C4-Anwendung</p>
    </footer>
</body>
</html>
EOF
}

# Hauptteil des Skripts

echo "Welches System möchten Sie einrichten? (1: Debian-basiert, 2: Red Hat-basiert, 3: Windows, 4: Termux)"
read -r SYSTEM_TYPE

case "$SYSTEM_TYPE" in
    1) install_deps ;;
    2) install_redhat_deps ;;
    3) install_windows ;;
    4) install_termux ;;
    *) echo "Ungültige Auswahl"; exit 1 ;;
esac

setup_webserver

echo "Einrichtung abgeschlossen. Bitte starten Sie den Webserver neu, falls nötig."
