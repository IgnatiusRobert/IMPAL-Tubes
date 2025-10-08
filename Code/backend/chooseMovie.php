<?php
session_start();
if (!isset($_SESSION['logged_in'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $_SESSION['movie'] = $_POST['movie'];
    header("Location: chooseLocation.php");
    exit;
}
?>

<h2>Pilih Film</h2>
<form method="POST">
    <select name="movie" required>
        <option value="Chainsaw Man">Chainsaw Man</option>
        <option value="Keadilan">Keadilan</option>
    </select>
    <button type="submit">Lanjut</button>
</form>
