<?php
// profile.php
require_once 'includes/config.php';

if (!isLoggedIn()) {
    redirect('login.php');
}

// Fetch user's bookings
$sql = "SELECT b.*, m.title, m.poster_url, h.hall_name, t.name as theater_name,
               s.show_date, s.show_time
        FROM bookings b
        INNER JOIN schedules s ON b.schedule_id = s.schedule_id
        INNER JOIN movies m ON s.movie_id = m.movie_id
        INNER JOIN halls h ON s.hall_id = h.hall_id
        INNER JOIN theaters t ON h.theater_id = t.theater_id
        WHERE b.user_id = ?
        ORDER BY b.booking_date DESC";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$bookings = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil - MyKisah</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fefefe, #cef3f8);
            color: #333;
            min-height: 100vh;
        }

        header {
            background: #fff;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 22px;
            font-weight: 700;
            color: #000;
            text-decoration: none;
        }

        nav a {
            text-decoration: none;
            color: #555;
            margin-left: 20px;
            font-weight: 600;
        }

        nav a:hover {
            color: #5a4af4;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .profile-header {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: white;
        }

        .profile-info h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .profile-info p {
            color: #666;
            font-size: 14px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .bookings-grid {
            display: grid;
            gap: 20px;
        }

        .booking-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 20px;
            align-items: center;
            transition: transform 0.3s;
        }

        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
        }

        .booking-poster {
            width: 100px;
            height: 140px;
            object-fit: cover;
            border-radius: 8px;
        }

        .booking-info h3 {
            font-size: 18px;
            margin-bottom: 8px;
        }

        .booking-detail {
            color: #666;
            font-size: 14px;
            margin: 4px 0;
        }

        .booking-code {
            background: #f0f0f0;
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 13px;
            margin-top: 10px;
            display: inline-block;
        }

        .booking-status {
            text-align: right;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }

        .status-paid {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .booking-price {
            font-size: 20px;
            font-weight: 700;
            color: #5a4af4;
            margin-top: 10px;
        }

        .no-bookings {
            background: white;
            border-radius: 12px;
            padding: 60px;
            text-align: center;
            color: #999;
        }

        .no-bookings h3 {
            margin-bottom: 10px;
        }

        .no-bookings a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background: #5a4af4;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .booking-card {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .booking-status {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <header>
        <a href="index.php" class="logo">MyKisah</a>
        <nav>
            <a href="index.php">Beranda</a>
            <a href="logout.php">Logout</a>
        </nav>
    </header>

    <div class="container">
        <div class="profile-header">
            <div class="profile-icon">👤</div>
            <div class="profile-info">
                <h1><?php echo htmlspecialchars($_SESSION['full_name']); ?></h1>
                <p>@<?php echo htmlspecialchars($_SESSION['username']); ?></p>
            </div>
        </div>

        <h2>Riwayat Pemesanan</h2>

        <?php if ($bookings->num_rows > 0): ?>
            <div class="bookings-grid">
                <?php while ($booking = $bookings->fetch_assoc()): ?>
                    <div class="booking-card">
                        <img src="<?php echo htmlspecialchars($booking['poster_url']); ?>" 
                             alt="<?php echo htmlspecialchars($booking['title']); ?>" 
                             class="booking-poster">
                        
                        <div class="booking-info">
                            <h3><?php echo htmlspecialchars($booking['title']); ?></h3>
                            <p class="booking-detail">
                                📍 <?php echo htmlspecialchars($booking['theater_name']); ?> - 
                                <?php echo htmlspecialchars($booking['hall_name']); ?>
                            </p>
                            <p class="booking-detail">
                                📅 <?php echo formatDate($booking['show_date']); ?> | 
                                🕐 <?php echo date('H:i', strtotime($booking['show_time'])); ?>
                            </p>
                            <p class="booking-detail">
                                🎫 <?php echo $booking['total_seats']; ?> tiket
                            </p>
                            <span class="booking-code">
                                Kode: <?php echo htmlspecialchars($booking['booking_code']); ?>
                            </span>
                        </div>

                        <div class="booking-status">
                            <span class="status-badge status-<?php echo $booking['payment_status']; ?>">
                                <?php 
                                $status_labels = [
                                    'paid' => 'Lunas',
                                    'pending' => 'Pending',
                                    'cancelled' => 'Dibatalkan'
                                ];
                                echo $status_labels[$booking['payment_status']];
                                ?>
                            </span>
                            <div class="booking-price">
                                <?php echo formatPrice($booking['total_price']); ?>
                            </div>
                        </div>
                    </div>
                <?php endwhile; ?>
            </div>
        <?php else: ?>
            <div class="no-bookings">
                <h3>Belum ada riwayat pemesanan</h3>
                <p>Mulai pesan tiket film favorit Anda sekarang!</p>
                <a href="index.php">Jelajahi Film</a>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>