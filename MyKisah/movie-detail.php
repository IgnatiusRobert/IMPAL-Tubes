<?php
require_once 'includes/config.php';

// Get movie ID from URL
$movie_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Fetch movie details
$sql = "SELECT * FROM movies WHERE movie_id = ?";
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $movie_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    redirect('index.php');
}

$movie = $result->fetch_assoc();

// Fetch available theaters for this movie
$theater_sql = "SELECT DISTINCT t.* 
                FROM theaters t
                INNER JOIN halls h ON t.theater_id = h.theater_id
                INNER JOIN schedules s ON h.hall_id = s.hall_id
                WHERE s.movie_id = ? 
                  AND s.status = 'active'
                  AND s.show_date >= CURDATE()
                ORDER BY t.name";
$theater_stmt = $db->prepare($theater_sql);
$theater_stmt->bind_param("i", $movie_id);
$theater_stmt->execute();
$theaters = $theater_stmt->get_result();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($movie['title']); ?> - MyKisah</title>
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

        .movie-hero {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 40px;
        }

        .poster-container {
            position: relative;
        }

        .poster {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }

        .movie-info h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .movie-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            color: #666;
            font-size: 14px;
        }

        .movie-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .rating-badge {
            background: #5a4af4;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .description {
            line-height: 1.8;
            margin-bottom: 30px;
            color: #555;
        }

        .theaters-section {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .theaters-section h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .theater-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .theater-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .theater-location {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .schedule-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 12px;
        }

        .time-button {
            padding: 12px;
            border: 2px solid #ddd;
            background: white;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
            display: block;
            font-weight: 600;
        }

        .time-button:hover {
            border-color: #5a4af4;
            color: #5a4af4;
            transform: translateY(-2px);
        }

        .time-button .time {
            font-size: 16px;
            display: block;
            margin-bottom: 4px;
        }

        .time-button .price {
            font-size: 12px;
            color: #666;
        }

        .no-schedule {
            padding: 30px;
            text-align: center;
            color: #999;
        }

        @media (max-width: 768px) {
            .movie-hero {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .poster-container {
                max-width: 300px;
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
    <header>
        <a href="index.php" class="logo">MyKisah</a>
        <nav>
            <a href="index.php">Home</a>
            <?php if (isLoggedIn()): ?>
                <a href="profile.php">Profil</a>
                <a href="logout.php">Logout</a>
            <?php else: ?>
                <a href="login.php">Login</a>
            <?php endif; ?>
        </nav>
    </header>

    <div class="movie-hero">
        <div class="poster-container">
            <img src="<?php echo htmlspecialchars($movie['poster_url']); ?>" 
                 alt="<?php echo htmlspecialchars($movie['title']); ?>" 
                 class="poster">
        </div>
        <div class="movie-info">
            <h1><?php echo htmlspecialchars($movie['title']); ?></h1>
            <div class="movie-meta">
                <span>⏱️ <?php echo $movie['duration']; ?> menit</span>
                <span class="rating-badge"><?php echo htmlspecialchars($movie['rating']); ?></span>
                <span>🎭 <?php echo htmlspecialchars($movie['genre']); ?></span>
            </div>
            <p class="description"><?php echo nl2br(htmlspecialchars($movie['description'])); ?></p>
        </div>
    </div>

    <div class="theaters-section">
        <h2>Pilih Bioskop & Jadwal</h2>
        
        <?php if ($theaters->num_rows > 0): ?>
            <?php while ($theater = $theaters->fetch_assoc()): ?>
                <div class="theater-card">
                    <div class="theater-name"><?php echo htmlspecialchars($theater['name']); ?></div>
                    <div class="theater-location">
                        📍 <?php echo htmlspecialchars($theater['location']); ?>
                    </div>
                    
                    <?php
                    $schedule_sql = "SELECT s.*, h.hall_name 
                                    FROM schedules s
                                    INNER JOIN halls h ON s.hall_id = h.hall_id
                                    WHERE h.theater_id = ? 
                                    AND s.movie_id = ? 
                                    AND s.status = 'active'
                                    AND s.show_date >= CURDATE()
                                    ORDER BY s.show_date, s.show_time";
                    $schedule_stmt = $db->prepare($schedule_sql);
                    $schedule_stmt->bind_param("ii", $theater['theater_id'], $movie_id);
                    $schedule_stmt->execute();
                    $schedules = $schedule_stmt->get_result();
                    ?>
                    
                    <?php if ($schedules->num_rows > 0): ?>
                        <div class="schedule-grid">
                            <?php while ($schedule = $schedules->fetch_assoc()): ?>
                                <a href="select-seat.php?schedule_id=<?php echo $schedule['schedule_id']; ?>" 
                                   class="time-button">
                                    <span class="time">
                                        <?php echo date('H:i', strtotime($schedule['show_time'])); ?>
                                    </span>
                                    <span class="price">
                                        <?php echo formatPrice($schedule['price']); ?>
                                    </span>
                                </a>
                            <?php endwhile; ?>
                        </div>
                    <?php else: ?>
                        <div class="no-schedule">Tidak ada jadwal tersedia</div>
                    <?php endif; ?>
                </div>
            <?php endwhile; ?>
        <?php else: ?>
            <div class="theater-card">
                <div class="no-schedule">Belum ada jadwal untuk film ini</div>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>