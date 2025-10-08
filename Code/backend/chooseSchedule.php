<?php
session_start();
if (!isset($_SESSION['location'])) {
    header("Location: chooseLocation.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $_SESSION['schedule'] = $_POST['schedule'];
    header("Location: chooseSeat.php");
    exit;
}
?>

<h2>Pilih Jadwal</h2>
<form method="POST">
    <select name="schedule" required>
        <option value="13:00">13:00</option>
        <option value="16:00">16:00</option>
        <option value="19:00">19:00</option>
    </select>
    <button type="submit">Lanjut</button>
</form>
