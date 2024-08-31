<?php
session_start();
include 'db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

// Hier können Sie Logik für das Anzeigen und Bearbeiten von Konfigurationen hinzufügen
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C4-Konfiguration</title>
    <style>
        /* Styling wie zuvor definiert */
    </style>
</head>
<body>
    <header>
        <img class="logo" src="server-icon.png" alt="Server-Rack Logo">
        <h1>C4-Konfiguration</h1>
    </header>

    <nav>
        <a href="main.php">Start</a>
        <a href="c4-config.php">C4-Konfig</a>
        <a href="connections.php">Connections</a>
        <a href="krypto.php">C4 Krypto-Area</a>
        <a href="btnt.php">C4-Botnetz</a>
        <a href**`c4-config.php` Fortsetzung:**

```php
        <a href="c4-agents.php">C4-Agents</a>
        <a href="recon.php">Aufklärung</a>
        <a href="software-kits.php">C4-KITs</a>
    </nav>

    <div class="content">
        <h2>Konfigurationen bearbeiten</h2>
        <form action="update-config.php" method="POST">
            <label for="key">Konfigurationsschlüssel:</label>
            <input type="text" id="key" name="key" required>

            <label for="value">Wert:</label>
            <input type="text" id="value" name="value" required>

            <button type="submit">Speichern</button>
        </form>

        <!-- Hier können Sie die bestehenden Konfigurationen anzeigen -->
    </div>

    <footer>
        <p>&copy; 2024 C4-Server</p>
    </footer>
</body>
</html>
