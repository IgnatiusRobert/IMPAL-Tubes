<?php
require_once 'includes/config.php';

// Check if user is logged in
if (!isLoggedIn()) {
    redirect('login.php');
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['payment_method'])) {
    $schedule_id = (int)$_POST['schedule_id'];
    $selected_seats = json_decode($_POST['selected_seats'], true);
    
    // Store in session for payment page
    $_SESSION['booking_data'] = [
        'schedule_id' => $schedule_id,
        'selected_seats' => $selected_seats
    ];
}

// Check if booking data exists
if (!isset($_SESSION['booking_data'])) {
    redirect('index.php');
}

$booking_data = $_SESSION['booking_data'];
$schedule_id = $booking_data['schedule_id'];
$selected_seats = $booking_data['selected_seats'];

// Fetch schedule details
$sql = "SELECT s.*, m.title, m.poster_url, h.hall_name, t.name as theater_name
        FROM schedules s
        INNER JOIN movies m ON s.movie_id = m.movie_id
        INNER JOIN halls h ON s.hall_id = h.hall_id
        INNER JOIN theaters t ON h.theater_id = t.theater_id
        WHERE s.schedule_id = ?";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $schedule_id);
$stmt->execute();
$schedule = $stmt->get_result()->fetch_assoc();

$total_seats = count($selected_seats);
$total_price = $total_seats * $schedule['price'];

// Process payment
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['payment_method'])) {
    $payment_method = $_POST['payment_method'];
    $booking_code = generateBookingCode();
    
    // Start transaction
    $conn->begin_transaction();
    
    try {
        // Insert booking
        $insert_booking = "INSERT INTO bookings (user_id, schedule_id, booking_code, total_seats, total_price, payment_method, payment_status) 
                          VALUES (?, ?, ?, ?, ?, ?, 'paid')";
        $stmt = $db->prepare($insert_booking);
        $stmt->bind_param("iisids", $_SESSION['user_id'], $schedule_id, $booking_code, $total_seats, $total_price, $payment_method);
        $stmt->execute();
        $booking_id = $conn->insert_id;
        
        // Insert booking seats
        foreach ($selected_seats as $seat) {
            $insert_seat = "INSERT INTO booking_seats (booking_id, seat_id, status) VALUES (?, ?, 'confirmed')";
            $stmt = $db->prepare($insert_seat);
            $stmt->bind_param("ii", $booking_id, $seat['id']);
            $stmt->execute();
        }
        
        // Update available seats
        $update_schedule = "UPDATE schedules SET available_seats = available_seats - ? WHERE schedule_id = ?";
        $stmt = $db->prepare($update_schedule);
        $stmt->bind_param("ii", $total_seats, $schedule_id);
        $stmt->execute();
        
        $conn->commit();
        
        // Clear booking data
        unset($_SESSION['booking_data']);
        
        // Redirect to confirmation
        redirect('confirmation.php?booking_code=' . $booking_code);
        
    } catch (Exception $e) {
        $conn->rollback();
        $error = "Terjadi kesalahan dalam pemrosesan pembayaran. Silakan coba lagi.";
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pembayaran - MyKisah</title>
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
        }

        .logo {
            font-size: 22px;
            font-weight: 700;
            color: #000;
            text-decoration: none;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }

        .booking-summary {
            display: grid;
            gap: 15px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-label {
            color: #666;
            font-size: 14px;
        }

        .summary-value {
            font-weight: 600;
        }

        .seats-display {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .seat-badge {
            background: #5a4af4;
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
        }

        .total-row {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }

        .total-price {
            font-size: 28px;
            color: #5a4af4;
            font-weight: 700;
        }

        .payment-methods {
            display: grid;
            gap: 15px;
        }

        .payment-option {
            border: 2px solid #ddd;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .payment-option:hover {
            border-color: #5a4af4;
            background: #f8f9ff;
        }

        .payment-option input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #5a4af4;
        }

        .payment-option.selected {
            border-color: #5a4af4;
            background: #f8f9ff;
        }

        .payment-icon {
            font-size: 32px;
        }

        .payment-info {
            flex: 1;
        }

        .payment-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 4px;
        }

        .payment-desc {
            font-size: 13px;
            color: #666;
        }

        .btn-submit {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: transform 0.3s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
        }

        .btn-submit:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
    </style>
</head>
<body>
    <header>
        <a href="index.php" class="logo">MyKisah</a>
    </header>

    <div class="container">
        <?php if (isset($error)): ?>
            <div class="alert"><?php echo $error; ?></div>
        <?php endif; ?>

        <div class="card">
            <h2>Ringkasan Pemesanan</h2>
            <div class="booking-summary">
                <div class="summary-row">
                    <span class="summary-label">Film</span>
                    <span class="summary-value"><?php echo htmlspecialchars($schedule['title']); ?></span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Bioskop</span>
                    <span class="summary-value"><?php echo htmlspecialchars($schedule['theater_name']); ?></span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Studio</span>
                    <span class="summary-value"><?php echo htmlspecialchars($schedule['hall_name']); ?></span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Tanggal & Waktu</span>
                    <span class="summary-value">
                        <?php echo formatDate($schedule['show_date']); ?>, 
                        <?php echo date('H:i', strtotime($schedule['show_time'])); ?>
                    </span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Kursi</span>
                    <div class="seats-display">
                        <?php foreach ($selected_seats as $seat): ?>
                            <span class="seat-badge"><?php echo htmlspecialchars($seat['name']); ?></span>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Jumlah Tiket</span>
                    <span class="summary-value"><?php echo $total_seats; ?> tiket</span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Harga per Tiket</span>
                    <span class="summary-value"><?php echo formatPrice($schedule['price']); ?></span>
                </div>
                <div class="summary-row total-row">
                    <span class="summary-label" style="font-size: 18px; font-weight: 600;">Total Pembayaran</span>
                    <span class="total-price"><?php echo formatPrice($total_price); ?></span>
                </div>
            </div>
        </div>

        <div class="card">
            <h2>Metode Pembayaran</h2>
            <form method="POST" action="" id="payment-form">
                <div class="payment-methods">
                    <label class="payment-option">
                        <input type="radio" name="payment_method" value="cash" required>
                        <div class="payment-icon">💵</div>
                        <div class="payment-info">
                            <div class="payment-name">Tunai</div>
                            <div class="payment-desc">Bayar di kasir bioskop</div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="payment_method" value="credit_card" required>
                        <div class="payment-icon">💳</div>
                        <div class="payment-info">
                            <div class="payment-name">Kartu Kredit</div>
                            <div class="payment-desc">Visa, Mastercard, JCB</div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="payment_method" value="debit_card" required>
                        <div class="payment-icon">🏦</div>
                        <div class="payment-info">
                            <div class="payment-name">Kartu Debit</div>
                            <div class="payment-desc">ATM BCA, Mandiri, BNI, BRI</div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="payment_method" value="e-wallet" required>
                        <div class="payment-icon">📱</div>
                        <div class="payment-info">
                            <div class="payment-name">E-Wallet</div>
                            <div class="payment-desc">GoPay, OVO, DANA, ShopeePay</div>
                        </div>
                    </label>
                </div>

                <button type="submit" class="btn-submit">
                    Bayar <?php echo formatPrice($total_price); ?>
                </button>
            </form>
        </div>
    </div>

    <script>
        // Add selected class to payment option when clicked
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.payment-option').forEach(opt => {
                    opt.classList.remove('selected');
                });
                this.classList.add('selected');
            });
        });
    </script>
</body>
</html>