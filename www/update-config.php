<?php
session_start();
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_SESSION['user_id'])) {
    $key = $_POST['key'];
    $value = $_POST['value'];

    $stmt = $pdo->prepare("INSERT OR REPLACE INTO Configurations (key, value) VALUES (:key, :value)");
    $stmt->execute(['key' => $key, 'value' => $value]);

    header("Location: c4-config.php?status=success");
    exit();
} else {
    header("Location: login.php");
    exit();
}
?>
