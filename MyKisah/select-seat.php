<?php
require_once 'includes/config.php';

// Check if user is logged in
if (!isLoggedIn()) {
    $_SESSION['redirect_after_login'] = 'select-seat.php?schedule_id=' . $_GET['schedule_id'];
    redirect('login.php');
}

$schedule_id = isset($_GET['schedule_id']) ? (int)$_GET['schedule_id'] : 0;

// Fetch schedule details with movie and theater info
$sql = "SELECT s.*, m.title, m.poster_url, m.duration, m.rating, 
               h.hall_name, t.name as theater_name, t.location
        FROM schedules s
        INNER JOIN movies m ON s.movie_id = m.movie_id
        INNER JOIN halls h ON s.hall_id = h.hall_id
        INNER JOIN theaters t ON h.theater_id = t.theater_id
        WHERE s.schedule_id = ? AND s.status = 'active'";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $schedule_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    redirect('index.php');
}

$schedule = $result->fetch_assoc();

// Fetch all seats for this hall
$seats_sql = "SELECT s.* FROM seats s WHERE s.hall_id = ? ORDER BY s.seat_row, s.seat_number";
$seats_stmt = $db->prepare($seats_sql);
$seats_stmt->bind_param("i", $schedule['hall_id']);
$seats_stmt->execute();
$seats_result = $seats_stmt->get_result();

// Organize seats by row
$seat_layout = [];
while ($seat = $seats_result->fetch_assoc()) {
    $seat_layout[$seat['seat_row']][] = $seat;
}
// Fetch booked seats for this schedule
$booked_sql = "SELECT s.seat_id 
               FROM booking_seats bs
               INNER JOIN bookings b ON bs.booking_id = b.booking_id
               INNER JOIN seats s ON bs.seat_id = s.seat_id
               WHERE b.schedule_id = ? 
               AND bs.status = 'confirmed'";
$booked_stmt = $db->prepare($booked_sql);
$booked_stmt->bind_param("i", $schedule_id);
$booked_stmt->execute();
$booked_result = $booked_stmt->get_result();

$booked_seats = [];
while ($booked = $booked_result->fetch_assoc()) {
    $booked_seats[] = $booked['seat_id'];
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pilih Kursi - MyKisah</title>
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
            padding-bottom: 100px;
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

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
        }

        .movie-info-bar {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .movie-poster-small {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }

        .movie-details h2 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .movie-details p {
            color: #666;
            font-size: 14px;
            margin: 4px 0;
        }

        .screen-section {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .screen {
            background: linear-gradient(to bottom, #555, #333);
            height: 12px;
            border-radius: 50px;
            margin-bottom: 50px;
            position: relative;
        }

        .screen::after {
            content: 'LAYAR';
            position: absolute;
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 12px;
            color: #999;
            letter-spacing: 3px;
        }

        .seats-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
            align-items: center;
        }

        .seat-row {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .row-label {
            font-weight: 600;
            width: 30px;
            text-align: center;
            color: #666;
        }

        .seat {
            width: 40px;
            height: 40px;
            border: 2px solid #ddd;
            border-radius: 8px 8px 2px 2px;
            background: #f5f5f5;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 600;
            color: #999;
        }

        .seat:hover:not(.booked) {
            transform: scale(1.1);
            border-color: #5a4af4;
        }

        .seat.selected {
            background: #5a4af4;
            border-color: #5a4af4;
            color: white;
        }

        .seat.booked {
            background: #e74c3c;
            border-color: #c0392b;
            cursor: not-allowed;
            color: white;
        }

        .seat.vip {
            border-color: #f39c12;
        }

        .legend {
            display: flex;
            gap: 30px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 6px;
            border: 2px solid;
        }

        .sidebar {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            height: fit-content;
            position: sticky;
            top: 90px;
        }

        .sidebar h3 {
            margin-bottom: 20px;
            font-size: 20px;
        }

        .selected-seats-list {
            margin-bottom: 20px;
            min-height: 60px;
        }

        .seat-tag {
            display: inline-block;
            background: #5a4af4;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            margin: 4px;
            font-size: 13px;
            font-weight: 600;
        }

        .price-summary {
            border-top: 2px solid #eee;
            padding-top: 20px;
            margin-top: 20px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .total-price {
            font-size: 24px;
            font-weight: 700;
            color: #5a4af4;
        }

        .btn-continue {
            width: 100%;
            padding: 15px;
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

        .btn-continue:hover {
            transform: translateY(-2px);
        }

        .btn-continue:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: static;
            }
        }
    </style>
</head>
<body>
    <header>
        <a href="index.php" class="logo">MyKisah</a>
    </header>

    <div class="container">
        <div>
            <div class="movie-info-bar">
                <img src="<?php echo htmlspecialchars($schedule['poster_url']); ?>" 
                     alt="<?php echo htmlspecialchars($schedule['title']); ?>" 
                     class="movie-poster-small">
                <div class="movie-details">
                    <h2><?php echo htmlspecialchars($schedule['title']); ?></h2>
                    <p>📍 <?php echo htmlspecialchars($schedule['theater_name']); ?> - <?php echo htmlspecialchars($schedule['hall_name']); ?></p>
                    <p>🕐 <?php echo formatDate($schedule['show_date']); ?> | <?php echo date('H:i', strtotime($schedule['show_time'])); ?></p>
                </div>
            </div>

            <div class="screen-section">
                <div class="screen"></div>
                <div class="seats-container">
                    <?php foreach ($seat_layout as $row => $seats): ?>
                        <div class="seat-row">
                            <div class="row-label"><?php echo $row; ?></div>
                            <?php foreach ($seats as $seat): ?>
                                <?php
                                $is_booked = in_array($seat['seat_id'], $booked_seats);
                                $class = 'seat';
                                if ($is_booked) {
                                    $class .= ' booked';
                                }
                                if ($seat['seat_type'] == 'vip') {
                                    $class .= ' vip';
                                }
                                ?>
                                <div class="<?php echo $class; ?>" 
                                     data-seat-id="<?php echo $seat['seat_id']; ?>"
                                     data-seat-name="<?php echo $row . $seat['seat_number']; ?>"
                                     data-price="<?php echo $schedule['price']; ?>"
                                     <?php if (!$is_booked): ?>onclick="toggleSeat(this)"<?php endif; ?>>
                                    <?php echo $seat['seat_number']; ?>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    <?php endforeach; ?>
                </div>

                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-box" style="background: #f5f5f5; border-color: #ddd;"></div>
                        <span>Tersedia</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-box" style="background: #5a4af4; border-color: #5a4af4;"></div>
                        <span>Dipilih</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-box" style="background: #e74c3c; border-color: #c0392b;"></div>
                        <span>Terisi</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h3>Kursi Dipilih</h3>
            <div class="selected-seats-list" id="selected-seats-display">
                <p style="color: #999; font-size: 14px;">Pilih kursi terlebih dahulu</p>
            </div>

            <div class="price-summary">
                <div class="price-row">
                    <span>Jumlah Kursi:</span>
                    <span id="seat-count">0</span>
                </div>
                <div class="price-row">
                    <span>Harga per Kursi:</span>
                    <span><?php echo formatPrice($schedule['price']); ?></span>
                </div>
                <div class="price-row" style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #eee;">
                    <span>Total:</span>
                    <span class="total-price" id="total-price">Rp 0</span>
                </div>
            </div>

            <form method="POST" action="payment.php" id="booking-form">
                <input type="hidden" name="schedule_id" value="<?php echo $schedule_id; ?>">
                <input type="hidden" name="selected_seats" id="selected-seats-input">
                <button type="submit" class="btn-continue" id="continue-btn" disabled>
                    Lanjut ke Pembayaran
                </button>
            </form>
        </div>
    </div>

    <script>
        let selectedSeats = [];
        const pricePerSeat = <?php echo $schedule['price']; ?>;

        function toggleSeat(element) {
            const seatId = element.dataset.seatId;
            const seatName = element.dataset.seatName;

            if (element.classList.contains('selected')) {
                element.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s.id !== seatId);
            } else {
                element.classList.add('selected');
                selectedSeats.push({ id: seatId, name: seatName });
            }

            updateSummary();
        }

        function updateSummary() {
            const display = document.getElementById('selected-seats-display');
            const countEl = document.getElementById('seat-count');
            const totalEl = document.getElementById('total-price');
            const continueBtn = document.getElementById('continue-btn');
            const seatsInput = document.getElementById('selected-seats-input');

            if (selectedSeats.length === 0) {
                display.innerHTML = '<p style="color: #999; font-size: 14px;">Pilih kursi terlebih dahulu</p>';
                continueBtn.disabled = true;
            } else {
                display.innerHTML = selectedSeats.map(s => 
                    `<span class="seat-tag">${s.name}</span>`
                ).join('');
                continueBtn.disabled = false;
            }

            countEl.textContent = selectedSeats.length;
            const total = selectedSeats.length * pricePerSeat;
            totalEl.textContent = formatPrice(total);
            
            seatsInput.value = JSON.stringify(selectedSeats);
        }

        function formatPrice(price) {
            return 'Rp ' + price.toLocaleString('id-ID');
        }
    </script>
</body>
</html>