<?php
function buyMovieTicket($user, $movie, $location, $schedule, $seat) {
    // --- Precondition 1 ---
    if (!$user['isLoggedIn']) {
        echo "❌ Error: User must be logged in before making payments.<br>";
        return;
    }

    // --- Precondition 2 ---
    if (empty($movie)) {
        echo "❌ Error: Please choose a movie first.<br>";
        return;
    }

    // --- Precondition 3 ---
    if (empty($location)) {
        echo "❌ Error: Please select a location after choosing a movie.<br>";
        return;
    }

    // --- Precondition 4 ---
    if (empty($schedule)) {
        echo "❌ Error: Please choose a schedule after selecting location.<br>";
        return;
    }

    // --- Precondition 5 ---
    if (empty($seat)) {
        echo "❌ Error: Please choose a seat before making payment.<br>";
        return;
    }

    // --- All Preconditions Passed ---
    $pricePerSeat = 45000;
    $totalPrice = $pricePerSeat * count((array)$seat);

    // --- Postcondition ---
    $receipt = [
        'movie_title' => $movie,
        'location_name' => $location,
        'schedule_time' => $schedule,
        'seat_number' => is_array($seat) ? implode(", ", $seat) : $seat,
        'total_price' => $totalPrice
    ];

    generateReceipt($receipt);
}

// Helper function: Receipt generator
function generateReceipt($receipt) {
    echo "<h2>🎟 Booking Receipt</h2>";
    echo "<p><strong>Movie:</strong> " . htmlspecialchars($receipt['movie_title']) . "</p>";
    echo "<p><strong>Location:</strong> " . htmlspecialchars($receipt['location_name']) . "</p>";
    echo "<p><strong>Schedule:</strong> " . htmlspecialchars($receipt['schedule_time']) . "</p>";
    echo "<p><strong>Seat(s):</strong> " . htmlspecialchars($receipt['seat_number']) . "</p>";
    echo "<p><strong>Total Price:</strong> Rp " . number_format($receipt['total_price'], 0, ',', '.') . "</p>";
    echo "<p><em>Payment successful. Receipt generated successfully.</em></p>";
}

// --- Example Simulation ---
$user = ['isLoggedIn' => true];
$movie = "Chainsaw Man: Reze Arc";
$location = "Cinema XXI Plaza Indonesia";
$schedule = "19:30 - 09 Oct 2025";
$seat = ["B4", "B5"];

buyMovieTicket($user, $movie, $location, $schedule, $seat);
?>
