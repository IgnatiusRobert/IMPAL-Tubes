<?php
require_once 'includes/config.php';

$error = '';
$success = '';

// Redirect if already logged in
if (isLoggedIn()) {
    redirect('admin/index.php');
}

// Handle Registration
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['register'])) {
    $username = $db->escape($_POST['username']);
    $email = $db->escape($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];
    $phone = $db->escape($_POST['phone']);
    $full_name = $db->escape($_POST['full_name']);

    if (empty($username) || empty($email) || empty($password) || empty($full_name)) {
        $error = "Semua field harus diisi!";
    } elseif ($password !== $confirm_password) {
        $error = "Password tidak cocok!";
    } elseif (strlen($password) < 6) {
        $error = "Password minimal 6 karakter!";
    } else {
        $check_sql = "SELECT * FROM users WHERE username = ? OR email = ?";
        $check_stmt = $db->prepare($check_sql);
        $check_stmt->bind_param("ss", $username, $email);
        $check_stmt->execute();
        $check_result = $check_stmt->get_result();

        if ($check_result->num_rows > 0) {
            $error = "Username atau email sudah terdaftar!";
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $insert_sql = "INSERT INTO users (username, email, password, full_name, phone) VALUES (?, ?, ?, ?, ?)";
            $insert_stmt = $db->prepare($insert_sql);
            $insert_stmt->bind_param("sssss", $username, $email, $hashed_password, $full_name, $phone);

            if ($insert_stmt->execute()) {
                $success = "Registrasi berhasil! Silakan login.";
            } else {
                $error = "Terjadi kesalahan. Silakan coba lagi.";
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
    body {
        background: linear-gradient(to right, #eef8f8, #d6f1f4);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .card {
        background: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 3px 5px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }
    h2 {margin-bottom:20px;}
    .form-group {
        position:relative;
        margin-bottom:15px;
    }
    input {
        width:100%;
        padding:10px 40px 10px 15px;
        border:none;
        border-radius:25px;
        background:linear-gradient(to right,#e6f8f8,#d7f3f4);
        font-size:14px;
        outline:none;
    }
    .icon {
        position:absolute;
        right:15px;
        top:50%;
        transform:translateY(-50%);
        color:#6a1b9a;
        font-size:16px;
    }
    button {
        background:linear-gradient(to right,#d4f2f5,#a5e4e6);
        border:none;
        padding:10px 0;
        width:100%;
        border-radius:20px;
        font-weight:600;
        cursor:pointer;
        transition:0.3s;
    }
    button:hover {opacity:0.8;}
    p {
        font-size:13px;
        margin-top:10px;
    }
    a {
        color:#6a1b9a;
        text-decoration:none;
    }
    .alert {
        font-size:13px;
        color:red;
        margin-bottom:10px;
    }
</style>
</head>
<body>
<div class="card">
    <h2>Register</h2>

    <?php if ($error): ?>
        <div class="alert"><?= $error ?></div>
    <?php endif; ?>
    <?php if ($success): ?>
        <div class="alert" style="color:green;"><?= $success ?></div>
    <?php endif; ?>

    <form method="POST" action="">
        <div class="form-group">
            <input type="text" name="full_name" placeholder="Nama Lengkap" required>
            <span class="icon">👤</span>
        </div>
        <div class="form-group">
            <input type="text" name="username" placeholder="Username" required>
            <span class="icon">👤</span>
        </div>
        <div class="form-group">
            <input type="email" name="email" placeholder="Email" required>
            <span class="icon">📧</span>
        </div>
        <div class="form-group">
            <input type="tel" name="phone" placeholder="No. Telepon" required>
            <span class="icon">📞</span>
        </div>
        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required>
            <span class="icon">🔒</span>
        </div>
        <div class="form-group">
            <input type="password" name="confirm_password" placeholder="Confirm Password" required>
            <span class="icon">🔒</span>
        </div>
        <button type="submit" name="register">Register</button>
    </form>
    <p>Already have account? <a href="login.php">Login</a></p>
</div>
</body>
</html>
