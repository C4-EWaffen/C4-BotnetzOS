<?php
session_start();
include 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

// Beispieldaten zum Anzeigen
$vpnServers = $pdo->query("SELECT * FROM Configurations WHERE key = 'vpn_address'")->fetchAll();
$agentStatus = $pdo->query("SELECT * FROM Agents")->fetchAll();
$targetStatus = $pdo->query("SELECT * FROM Targets")->fetchAll();
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
        <div class="status success">VPN-Server: <?= $vpnServers[0]['value'] ?? 'Nicht konfiguriert' ?></div>
        <h3>Agentenstatus</h3>
        <?php foreach ($agentStatus as $agent): ?>
            <div class="status <?= $agent['status'] == 'aktiv' ? 'success' : 'error' ?>">
                Agent <?= htmlspecialchars($agent['name']) ?>: <?= htmlspecialchars($agent['status']) ?>
            </div>
        <?php endforeach; ?>

        <h3>Zielstatus</h3>
        <?php foreach ($targetStatus as $target): ?>
            <div class="status <?= $target['status'] == 'kompromittiert' ? 'error' : 'success' ?>">
                Ziel <?= htmlspecialchars($target['name']) ?>: <?= htmlspecialchars($target['status']) ?>
            </div>
        <?php endforeach; ?>

        <!-- Weitere Informationen und Statistiken -->
    </div>

    <footer>
        <p>&copy; 2024 C4-Server</p>
    </footer>
</body>
</html>
