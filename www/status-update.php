<?php
include 'db.php';

function update_status($table, $id, $status) {
    global $pdo;
    $stmt = $pdo->prepare("UPDATE $table SET status = :status WHERE id = :id");
    $stmt->execute(['status' => $status, 'id' => $id]);
}

if (isset($_GET['agent_id']) && isset($_GET['status'])) {
    update_status('Agents', $_GET['agent_id'], $_GET['status']);
}

if (isset($_GET['target_id']) && isset($_GET['status'])) {
    update_status('Targets', $_GET['target_id'], $_GET['status']);
}

header("Location: main.php");
exit();
?>
