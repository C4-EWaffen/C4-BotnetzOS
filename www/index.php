<?php
session_start();

// Überprüfen, ob der Benutzer eingeloggt ist
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    header('Location: main.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            background-color: #202020;
            color: #E0E0E0;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #2D2D2D;
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }

        h1 {
            color: #1A73E8;
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #1A73E8;
            border-radius: 4px;
            background-color: #333;
            color: #E0E0E0;
        }

        button {
            background-color: #1A73E8;
            color: #FFFFFF;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #155AB5;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="login.php" method="post">
            <input type="text" name="username" placeholder="Benutzername" required>
            <input type="password" name="password" placeholder="Passwort" required>
            <button type="submit">Anmelden</button>
        </form>
    </div>
</body>

</html>
