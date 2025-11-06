<?php
require_once 'includes/config.php';

// Check if user is logged in
if (!isLoggedIn()) {
    redirect('login.php');
}

$booking_code = isset($_GET['booking_code']) ? $db->escape($_GET['booking_code']) : '';

if (empty($booking_code)) {
    redirect('index.php');
}

// Fetch booking details
$sql = "SELECT b.*, m.title, m.poster_url, h.hall_name, t.name as theater_name, t.location,
               s.show_date, s.show_time
        FROM bookings b
        INNER JOIN schedules s ON b.schedule_id = s.schedule_id
        INNER JOIN movies m ON s.movie_id = m.movie_id
        INNER JOIN halls h ON s.hall_id = h.hall_id
        INNER JOIN theaters t ON h.theater_id = t.theater_id
        WHERE b.booking_code = ? AND b.user_id = ?";
$stmt = $db->prepare($sql);
$stmt->bind_param("si", $booking_code, $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    redirect('index.php');
}

$booking = $result->fetch_assoc();

// Fetch booked seats
$seats_sql = "SELECT s.seat_row, s.seat_number
              FROM booking_seats bs
              INNER JOIN seats s ON bs.seat_id = s.seat_id
              WHERE bs.booking_id = ?
              ORDER BY s.seat_row, s.seat_number";
$seats_stmt = $db->prepare($seats_sql);
$seats_stmt->bind_param("i", $booking['booking_id']);
$seats_stmt->execute();
$seats_result = $seats_stmt->get_result();

$booked_seats = [];
while ($seat = $seats_result->fetch_assoc()) {
    $booked_seats[] = $seat['seat_row'] . $seat['seat_number'];
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Konfirmasi Pemesanan - MyKisah</title>
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
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
        }

        .success-icon {
            text-align: center;
            font-size: 80px;
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease-out;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 10px;
            color: #27ae60;
        }

        .subtitle {
            color: #666;
            margin-bottom: 30px;
        }

        .booking-code {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .booking-code::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            opacity: 0.1;
        }

        .booking-code-label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
            opacity: 0.9;
        }

        .booking-code-value {
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 3px;
            position: relative;
            z-index: 1;
        }

        .booking-details {
            text-align: left;
            border-top: 1px solid #eee;
            padding-top: 30px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #666;
            font-size: 14px;
        }

        .detail-value {
            font-weight: 600;
            text-align: right;
        }

        .seats-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: flex-end;
        }

        .seat-badge {
            background: #5a4af4;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .total-row {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #eee;
            font-size: 18px;
        }

        .total-amount {
            color: #5a4af4;
            font-size: 24px;
            font-weight: 700;
        }

        .info-box {
            background: #fff9e6;
            border: 1px solid #ffe066;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            text-align: left;
        }

        .info-box-title {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .info-box-text {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
        }

        .buttons {
            display: grid;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s;
            text-decoration: none;
            display: block;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        @media print {
            body {
                background: white;
            }
            .buttons, .info-box {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✅</div>
        
        <div class="card">
            <h1>Pemesanan Berhasil!</h1>
            <p class="subtitle">Terima kasih telah memesan tiket di MyKisah</p>

            <div class="booking-code">
                <div class="booking-code-label">Kode Booking</div>
                <div class="booking-code-value"><?php echo htmlspecialchars($booking['booking_code']); ?></div>
            </div>

            <div class="booking-details">
                <div class="detail-row">
                    <span class="detail-label">Film</span>
                    <span class="detail-value"><?php echo htmlspecialchars($booking['title']); ?></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Bioskop</span>
                    <span class="detail-value"><?php echo htmlspecialchars($booking['theater_name']); ?></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Studio</span>
                    <span class="detail-value"><?php echo htmlspecialchars($booking['hall_name']); ?></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Tanggal</span>
                    <span class="detail-value"><?php echo formatDate($booking['show_date']); ?></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Waktu</span>
                    <span class="detail-value"><?php echo date('H:i', strtotime($booking['show_time'])); ?> WIB</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Kursi</span>
                    <div class="seats-list">
                        <?php foreach ($booked_seats as $seat): ?>
                            <span class="seat-badge"><?php echo htmlspecialchars($seat); ?></span>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Jumlah Tiket</span>
                    <span class="detail-value"><?php echo $booking['total_seats']; ?> tiket</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Metode Pembayaran</span>
                    <span class="detail-value"><?php echo ucwords(str_replace('_', ' ', $booking['payment_method'])); ?></span>
                </div>
                <div class="detail-row total-row">
                    <span class="detail-label">Total Bayar</span>
                    <span class="total-amount"><?php echo formatPrice($booking['total_price']); ?></span>
                </div>
            </div>

            <div class="info-box">
                <div class="info-box-title">⚠️ Penting!</div>
                <div class="info-box-text">
                    Simpan kode booking ini dengan baik. Tunjukkan kode booking Anda di kasir bioskop 
                    untuk mendapatkan tiket fisik. Datang minimal 15 menit sebelum film dimulai.
                </div>
            </div>

            <div class="buttons">
                <a href="profile.php" class="btn btn-primary">Lihat Semua Pesanan</a>
                <a href="index.php" class="btn btn-secondary">Kembali ke Beranda</a>
                <button onclick="window.print()" class="btn btn-secondary">Cetak Tiket</button>
            </div>
        </div>
    </div>
</body>
</html>