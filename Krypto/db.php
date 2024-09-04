<?php
session_start();
include 'config.php'; // Stellen Sie sicher, dass diese Datei Ihre DB-Konfigurationsdaten enthält

// Überprüfen, ob der Benutzer eingeloggt ist
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: index.php');
    exit;
}

// Verbindung zur Datenbank herstellen
try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Verbindung fehlgeschlagen: " . $e->getMessage();
    exit;
}

// Funktionen für Datenbankoperationen
function runQuery($query, $params = []) {
    global $pdo;
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    return $stmt;
}

// Beispielabfrage
$vpnServers = runQuery("SELECT * FROM Configurations WHERE `key` = 'vpn_address'")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Datenbankverwaltung</title>
    <style>
        body {
            background-color: #202020;
            color: #E0E0E0;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            overflow: auto;
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

        button {
            background-color: #1A73E8;
            color: #FFFFFF;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }

        button:hover {
            background-color: #0056b3;
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
        <h1>Datenbankverwaltung</h1>
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
        <h2>Verwalten Sie Ihre Datenbank</h2>

        <form action="db.php" method="post">
            <button type="submit" name="action" value="install">Installieren</button>
            <button type="submit" name="action" value="configure">Konfigurieren</button>
            <button type="submit" name="action" value="view_connections">Verbindungen anzeigen</button>
        </form>

        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $action = $_POST['action'];

            switch ($action) {
                case 'install':
                    // Beispielinstallation
                    echo "<p>Installation wird durchgeführt...</p>";
                    // Hier Ihre Installationslogik einfügen
                    break;
                case 'configure':
                    // Beispielkonfiguration
                    echo "<p>Konfiguration wird durchgeführt...</p>";
                    // Hier Ihre Konfigurationslogik einfügen
                    break;
                case 'view_connections':
                    // Verbindungen anzeigen
                    echo "<h3>Verbindungen</h3>";
                    $connections = runQuery("SHOW PROCESSLIST")->fetchAll();
                    echo "<table border='1'><tr><th>ID</th><th>User</th><th>Host</th><th>DB</th><th>Command</th><th>Time</th><th>State</th><th>Info</th></tr>";
                    foreach ($connections as $conn) {
                        echo "<tr>
                            <td>{$conn['Id']}</td>
                            <td>{$conn['User']}</td>
                            <td>{$conn['Host']}</td>
                            <td>{$conn['db']}</td>
                            <td>{$conn['Command']}</td>
                            <td>{$conn['Time']}</td>
                            <td>{$conn['State']}</td>
                            <td>{$conn['Info']}</td>
                        </tr>";
                    }
                    echo "</table>";
                    break;
            }
        }
        ?>
    </div>

    <footer>
        <p>&copy; 2024 C4-Anwendung</p>
    </footer>
</body>
</html>
