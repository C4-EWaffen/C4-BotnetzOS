<?php
session_start();
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $stmt = $pdo->prepare("SELECT * FROM Users WHERE email = :email AND password = :password");
    $stmt->execute(['email' => $email, 'password' => $password]);

    if ($stmt->rowCount() > 0) {
        $_SESSION['user_id'] = $pdo->lastInsertId();
        header("Location: main.php");
        exit();
    } else {
        $error = "Ungültige Anmeldedaten.";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        /* Styling wie zuvor definiert */
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="login.php" method="POST">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <?php if (isset($error)) echo "<p>$error</p>"; ?>
    </div>
</body>
</html>
