<?php
try {
    $pdo = new PDO('sqlite:database.db');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Datenbankverbindung fehlgeschlagen: " . $e->getMessage();
}
?>
