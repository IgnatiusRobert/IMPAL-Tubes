<?php
session_start();
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = $_POST['username'];
    $pass = $_POST['password'];

    $query = $conn->prepare("SELECT * FROM users WHERE username=? AND password=?");
    $query->bind_param("ss", $user, $pass);
    $query->execute();
    $result = $query->get_result();

    if ($result->num_rows > 0) {
        $_SESSION['logged_in'] = true;
        $_SESSION['username'] = $user;
        header("Location: chooseMovie.php");
        exit;
    } else {
        echo "Invalid credentials.";
    }
}
?>
<form method="POST">
  Username: <input type="text" name="username" required><br>
  Password: <input type="password" name="password" required><br>
  <button type="submit">Login</button>
</form>