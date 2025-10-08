<?php
session_start();
if (!isset($_SESSION['movie'])) {
    header("Location: chooseMovie.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $_SESSION['location'] = $_POST['location'];
    header("Location: chooseSchedule.php");
    exit;
}
?>

<h2>Pilih Lokasi untuk <?= $_SESSION['movie']; ?></h2>
<form method="POST">
    <select name="location" required>
        <option value="XXI Bandung">XXI Bandung</option>
        <option value="CGV Paris Van Java">CGV PVJ</option>
    </select>
    <button type="submit">Lanjut</button>
</form>
