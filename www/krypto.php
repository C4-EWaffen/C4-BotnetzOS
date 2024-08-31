<?php
session_start();

// Überprüfen, ob der Benutzer eingeloggt ist
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
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
        <!-- Weitere Inhalte zur Verwaltung der Krypto-Einstellungen hinzufügen -->
    </div>

    <footer>
        <p>&copy; 2024 C4-Anwendung</p>
    </footer>
</body>

</html>
