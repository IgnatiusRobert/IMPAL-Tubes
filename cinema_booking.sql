-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2026 at 08:26 AM
-- Server version: 8.0.41
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `user_id` int NOT NULL,
  `schedule_id` int NOT NULL,
  `booking_code` varchar(20) NOT NULL,
  `total_seats` int NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_method` enum('cash','credit_card','debit_card','e-wallet') NOT NULL,
  `payment_status` enum('pending','paid','cancelled') DEFAULT 'pending',
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `schedule_id`, `booking_code`, `total_seats`, `total_price`, `payment_method`, `payment_status`, `booking_date`) VALUES
(6, 1, 580, 'BK2025111574813B', 2, 120000.00, 'e-wallet', 'paid', '2025-11-15 08:26:06'),
(7, 5, 581, 'BK202511212C0B69', 4, 240000.00, 'cash', 'paid', '2025-11-21 11:12:09'),
(8, 5, 581, 'BK202511214A6EA4', 2, 120000.00, 'credit_card', 'paid', '2025-11-21 11:13:05'),
(9, 6, 581, 'BK20251121E9AAC0', 2, 120000.00, 'e-wallet', 'paid', '2025-11-21 11:23:37'),
(10, 6, 581, 'BK20251121AA3538', 1, 60000.00, 'debit_card', 'paid', '2025-11-21 11:26:54'),
(11, 1, 582, 'BK20251121853B58', 4, 2800000.00, 'e-wallet', 'cancelled', '2025-11-21 11:33:01'),
(12, 1, 581, 'BK202511217F0249', 9, 540000.00, 'cash', 'paid', '2025-11-21 11:38:21'),
(13, 1, 581, 'BK202511210ADF17', 3, 180000.00, 'debit_card', 'paid', '2025-11-21 11:47:04'),
(14, 7, 581, 'BK2025112154575E', 74, 4440000.00, 'cash', 'cancelled', '2025-11-21 14:54:01'),
(15, 7, 581, 'BK2025112199FED6', 1, 60000.00, 'cash', 'paid', '2025-11-21 14:58:42'),
(16, 5, 583, 'BK20251123D047E1', 21, 1680000.00, 'e-wallet', 'paid', '2025-11-23 08:33:01'),
(17, 1, 584, 'BK20251126619E38', 13, 13000000.00, 'debit_card', 'paid', '2025-11-26 12:48:25'),
(18, 1, 583, 'BK20251129A5A507', 3, 240000.00, 'cash', 'paid', '2025-11-28 23:40:02'),
(19, 1, 583, 'BK202511298EEBEA', 2, 160000.00, 'e-wallet', 'paid', '2025-11-28 23:42:06'),
(20, 1, 583, 'BK2025112958E140', 3, 240000.00, 'debit_card', 'paid', '2025-11-28 23:44:23'),
(21, 1, 583, 'BK20251129ABCCFD', 3, 240000.00, 'cash', 'paid', '2025-11-28 23:57:40'),
(22, 8, 583, 'BK202511297C9C6A', 8, 640000.00, 'cash', 'paid', '2025-11-29 00:05:59'),
(23, 8, 583, 'BK20251129F9367A', 24, 1920000.00, 'e-wallet', 'paid', '2025-11-29 00:07:58'),
(24, 1, 583, 'BK20251129C7AECD', 12, 960000.00, 'cash', 'paid', '2025-11-29 11:52:35'),
(25, 6, 583, 'BK202511291732FE', 2, 160000.00, 'e-wallet', 'paid', '2025-11-29 11:56:47'),
(26, 9, 583, 'BK202511295D385F', 3, 240000.00, 'debit_card', 'paid', '2025-11-29 12:18:33'),
(27, 1, 583, 'BK202511290137CE', 2, 160000.00, 'cash', 'paid', '2025-11-29 12:22:28'),
(28, 1, 583, 'BK202511295FCBCC', 2, 160000.00, 'credit_card', 'paid', '2025-11-29 12:24:23'),
(29, 1, 587, 'BK20251129BBCE44', 7, 840000.00, 'cash', 'paid', '2025-11-29 12:50:05'),
(31, 10, 589, 'BK202601046916C8', 7, 350000.00, 'cash', 'cancelled', '2026-01-04 16:08:40'),
(33, 10, 589, 'BK20260104D108DB', 4, 200000.00, 'cash', 'cancelled', '2026-01-04 16:22:16'),
(34, 1, 591, 'BK20260104A65C0A', 8, 5600000.00, 'debit_card', 'paid', '2026-01-04 16:26:34');

-- --------------------------------------------------------

--
-- Table structure for table `booking_seats`
--

CREATE TABLE `booking_seats` (
  `booking_seat_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `seat_id` int NOT NULL,
  `status` enum('reserved','confirmed','cancelled') DEFAULT 'reserved'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking_seats`
--

INSERT INTO `booking_seats` (`booking_seat_id`, `booking_id`, `seat_id`, `status`) VALUES
(16, 6, 289, 'confirmed'),
(17, 6, 299, 'confirmed'),
(18, 7, 269, 'confirmed'),
(19, 7, 279, 'confirmed'),
(20, 7, 289, 'confirmed'),
(21, 7, 299, 'confirmed'),
(22, 8, 309, 'confirmed'),
(23, 8, 310, 'confirmed'),
(24, 9, 301, 'confirmed'),
(25, 9, 307, 'confirmed'),
(26, 10, 328, 'confirmed'),
(27, 11, 349, 'cancelled'),
(28, 11, 330, 'cancelled'),
(29, 11, 319, 'cancelled'),
(30, 11, 299, 'cancelled'),
(31, 12, 270, 'confirmed'),
(32, 12, 259, 'confirmed'),
(33, 12, 281, 'confirmed'),
(34, 12, 273, 'confirmed'),
(35, 12, 271, 'confirmed'),
(36, 12, 260, 'confirmed'),
(37, 12, 262, 'confirmed'),
(38, 12, 261, 'confirmed'),
(39, 12, 272, 'confirmed'),
(40, 13, 340, 'confirmed'),
(41, 13, 349, 'confirmed'),
(42, 13, 339, 'confirmed'),
(43, 14, 314, 'cancelled'),
(44, 14, 315, 'cancelled'),
(45, 14, 334, 'cancelled'),
(46, 14, 335, 'cancelled'),
(47, 14, 345, 'cancelled'),
(48, 14, 344, 'cancelled'),
(49, 14, 354, 'cancelled'),
(50, 14, 355, 'cancelled'),
(51, 14, 356, 'cancelled'),
(52, 14, 336, 'cancelled'),
(53, 14, 326, 'cancelled'),
(54, 14, 306, 'cancelled'),
(55, 14, 296, 'cancelled'),
(56, 14, 286, 'cancelled'),
(57, 14, 276, 'cancelled'),
(58, 14, 266, 'cancelled'),
(59, 14, 265, 'cancelled'),
(60, 14, 275, 'cancelled'),
(61, 14, 285, 'cancelled'),
(62, 14, 316, 'cancelled'),
(63, 14, 295, 'cancelled'),
(64, 14, 294, 'cancelled'),
(65, 14, 284, 'cancelled'),
(66, 14, 274, 'cancelled'),
(67, 14, 264, 'cancelled'),
(68, 14, 263, 'cancelled'),
(69, 14, 283, 'cancelled'),
(70, 14, 282, 'cancelled'),
(71, 14, 292, 'cancelled'),
(72, 14, 291, 'cancelled'),
(73, 14, 290, 'cancelled'),
(74, 14, 280, 'cancelled'),
(75, 14, 300, 'cancelled'),
(76, 14, 302, 'cancelled'),
(77, 14, 312, 'cancelled'),
(78, 14, 311, 'cancelled'),
(79, 14, 321, 'cancelled'),
(80, 14, 322, 'cancelled'),
(81, 14, 332, 'cancelled'),
(82, 14, 342, 'cancelled'),
(83, 14, 353, 'cancelled'),
(84, 14, 352, 'cancelled'),
(85, 14, 350, 'cancelled'),
(86, 14, 341, 'cancelled'),
(87, 14, 331, 'cancelled'),
(88, 14, 330, 'cancelled'),
(89, 14, 329, 'cancelled'),
(90, 14, 319, 'cancelled'),
(91, 14, 320, 'cancelled'),
(92, 14, 343, 'cancelled'),
(93, 14, 351, 'cancelled'),
(94, 14, 357, 'cancelled'),
(95, 14, 358, 'cancelled'),
(96, 14, 348, 'cancelled'),
(97, 14, 337, 'cancelled'),
(98, 14, 338, 'cancelled'),
(99, 14, 327, 'cancelled'),
(100, 14, 317, 'cancelled'),
(101, 14, 318, 'cancelled'),
(102, 14, 308, 'cancelled'),
(103, 14, 298, 'cancelled'),
(104, 14, 297, 'cancelled'),
(105, 14, 287, 'cancelled'),
(106, 14, 288, 'cancelled'),
(107, 14, 278, 'cancelled'),
(108, 14, 277, 'cancelled'),
(109, 14, 267, 'cancelled'),
(110, 14, 268, 'cancelled'),
(111, 14, 347, 'cancelled'),
(112, 14, 346, 'cancelled'),
(113, 14, 293, 'cancelled'),
(114, 14, 303, 'cancelled'),
(115, 14, 304, 'cancelled'),
(116, 14, 305, 'cancelled'),
(117, 15, 266, 'confirmed'),
(118, 16, 478, 'confirmed'),
(119, 16, 477, 'confirmed'),
(120, 16, 475, 'confirmed'),
(121, 16, 476, 'confirmed'),
(122, 16, 474, 'confirmed'),
(123, 16, 472, 'confirmed'),
(124, 16, 473, 'confirmed'),
(125, 16, 471, 'confirmed'),
(126, 16, 470, 'confirmed'),
(127, 16, 469, 'confirmed'),
(128, 16, 468, 'confirmed'),
(129, 16, 467, 'confirmed'),
(130, 16, 455, 'confirmed'),
(131, 16, 456, 'confirmed'),
(132, 16, 457, 'confirmed'),
(133, 16, 458, 'confirmed'),
(134, 16, 459, 'confirmed'),
(135, 16, 461, 'confirmed'),
(136, 16, 460, 'confirmed'),
(137, 16, 463, 'confirmed'),
(138, 16, 462, 'confirmed'),
(139, 17, 862, 'confirmed'),
(140, 17, 863, 'confirmed'),
(141, 17, 864, 'confirmed'),
(142, 17, 869, 'confirmed'),
(143, 17, 870, 'confirmed'),
(144, 17, 871, 'confirmed'),
(145, 17, 872, 'confirmed'),
(146, 17, 873, 'confirmed'),
(147, 17, 874, 'confirmed'),
(148, 17, 875, 'confirmed'),
(149, 17, 876, 'confirmed'),
(150, 17, 877, 'confirmed'),
(151, 17, 878, 'confirmed'),
(152, 18, 464, 'confirmed'),
(153, 18, 465, 'confirmed'),
(154, 18, 466, 'confirmed'),
(155, 19, 449, 'confirmed'),
(156, 19, 450, 'confirmed'),
(157, 20, 410, 'confirmed'),
(158, 20, 411, 'confirmed'),
(159, 20, 412, 'confirmed'),
(160, 21, 451, 'confirmed'),
(161, 21, 452, 'confirmed'),
(162, 21, 453, 'confirmed'),
(163, 22, 431, 'confirmed'),
(164, 22, 432, 'confirmed'),
(165, 22, 443, 'confirmed'),
(166, 22, 444, 'confirmed'),
(167, 22, 445, 'confirmed'),
(168, 22, 446, 'confirmed'),
(169, 22, 447, 'confirmed'),
(170, 22, 448, 'confirmed'),
(171, 23, 359, 'confirmed'),
(172, 23, 360, 'confirmed'),
(173, 23, 361, 'confirmed'),
(174, 23, 362, 'confirmed'),
(175, 23, 363, 'confirmed'),
(176, 23, 364, 'confirmed'),
(177, 23, 365, 'confirmed'),
(178, 23, 366, 'confirmed'),
(179, 23, 367, 'confirmed'),
(180, 23, 368, 'confirmed'),
(181, 23, 369, 'confirmed'),
(182, 23, 370, 'confirmed'),
(183, 23, 371, 'confirmed'),
(184, 23, 372, 'confirmed'),
(185, 23, 373, 'confirmed'),
(186, 23, 374, 'confirmed'),
(187, 23, 375, 'confirmed'),
(188, 23, 376, 'confirmed'),
(189, 23, 377, 'confirmed'),
(190, 23, 378, 'confirmed'),
(191, 23, 379, 'confirmed'),
(192, 23, 380, 'confirmed'),
(193, 23, 381, 'confirmed'),
(194, 23, 382, 'confirmed'),
(195, 24, 383, 'confirmed'),
(196, 24, 384, 'confirmed'),
(197, 24, 385, 'confirmed'),
(198, 24, 386, 'confirmed'),
(199, 24, 387, 'confirmed'),
(200, 24, 388, 'confirmed'),
(201, 24, 389, 'confirmed'),
(202, 24, 390, 'confirmed'),
(203, 24, 391, 'confirmed'),
(204, 24, 392, 'confirmed'),
(205, 24, 393, 'confirmed'),
(206, 24, 394, 'confirmed'),
(207, 25, 395, 'confirmed'),
(208, 25, 406, 'confirmed'),
(209, 26, 400, 'confirmed'),
(210, 26, 401, 'confirmed'),
(211, 26, 402, 'confirmed'),
(212, 27, 439, 'confirmed'),
(213, 27, 440, 'confirmed'),
(214, 28, 433, 'confirmed'),
(215, 28, 434, 'confirmed'),
(216, 29, 563, 'confirmed'),
(217, 29, 564, 'confirmed'),
(218, 29, 574, 'confirmed'),
(219, 29, 575, 'confirmed'),
(220, 29, 576, 'confirmed'),
(221, 29, 577, 'confirmed'),
(222, 29, 578, 'confirmed'),
(227, 31, 131, 'cancelled'),
(228, 31, 139, 'cancelled'),
(229, 31, 147, 'cancelled'),
(230, 31, 155, 'cancelled'),
(231, 31, 163, 'cancelled'),
(232, 31, 154, 'cancelled'),
(233, 31, 162, 'cancelled'),
(237, 33, 131, 'cancelled'),
(238, 33, 139, 'cancelled'),
(239, 33, 154, 'cancelled'),
(240, 33, 161, 'cancelled'),
(241, 34, 651, 'confirmed'),
(242, 34, 652, 'confirmed'),
(243, 34, 653, 'confirmed'),
(244, 34, 654, 'confirmed'),
(245, 34, 655, 'confirmed'),
(246, 34, 656, 'confirmed'),
(247, 34, 657, 'confirmed'),
(248, 34, 658, 'confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `halls`
--

CREATE TABLE `halls` (
  `hall_id` int NOT NULL,
  `theater_id` int NOT NULL,
  `hall_name` varchar(50) NOT NULL,
  `total_seats` int NOT NULL,
  `seat_layout` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `halls`
--

INSERT INTO `halls` (`hall_id`, `theater_id`, `hall_name`, `total_seats`, `seat_layout`, `created_at`) VALUES
(1, 1, 'Studio 1', 100, NULL, '2025-10-29 12:45:59'),
(2, 1, 'Studio 2', 80, NULL, '2025-10-29 12:45:59'),
(3, 2, 'Studio 1', 120, NULL, '2025-10-29 12:45:59'),
(4, 3, 'Studio 1', 100, NULL, '2025-10-29 12:45:59'),
(5, 1, 'Studio 3', 100, NULL, '2025-10-29 16:00:03'),
(6, 1, 'Studio 4', 80, NULL, '2025-10-29 16:00:03'),
(7, 2, 'Studio 2', 120, NULL, '2025-10-29 16:00:03'),
(8, 3, 'Studio 2', 100, NULL, '2025-10-29 16:00:03');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `movie_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `duration` int NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  `trailer_url` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `status` enum('now_playing','coming_soon','archived') DEFAULT 'now_playing',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`movie_id`, `title`, `description`, `duration`, `genre`, `rating`, `poster_url`, `trailer_url`, `release_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Chainsaw Man - The Movie: Reze Arc', 'Denji dan Power menghadapi musuh baru yang berbahaya dalam arc Reze yang penuh aksi dan drama.', 115, 'Action, Anime', 'R', 'images/poster_csm.jpg', 'https://www.youtube.com/watch?v=tAzAhDNdehs&t=1s', '2025-10-15', 'now_playing', '2025-10-29 12:45:59', '2026-01-04 16:06:04'),
(2, 'The Verdict', 'Seorang pengacara muda berjuang untuk mengungkap kebenaran di balik kasus pembunuhan yang rumit.', 130, 'Drama, Thriller', 'PG-13', 'images/poster_keadilan.jpg', NULL, '2025-11-05', 'coming_soon', '2025-10-29 12:45:59', '2025-10-29 14:05:37'),
(3, 'Dune: Part Three', 'Petualangan epik Paul Atreides berlanjut dalam chapter final yang spektakuler.', 165, 'Sci-Fi, Adventure', 'PG-13', 'images/poster_dune.jpg', NULL, '2025-10-20', 'now_playing', '2025-10-29 12:45:59', '2025-10-29 15:25:17'),
(4, 'The Last Guardian', 'Sebuah keluarga harus bertahan hidup saat dunia dilanda bencana apokaliptik.', 140, 'Action, Drama', 'R', 'images/poster_guardian.jpg', NULL, '2025-11-12', 'coming_soon', '2025-10-29 12:45:59', '2025-11-23 07:58:56'),
(5, 'Jujutsu Kaisen 0', 'Violent misfortunes frequently occur around 16-year-old Yuuta Okkotsu, a timid victim of high school bullying. Yuuta is saddled with a monstrous curse, a power that dishes out brutal revenge against his bullies. Rika Orimoto, Yuuta\'s curse, is a shadow from his tragic childhood and a potentially lethal threat to anyone who dares wrong him.\r\n\r\nYuuta\'s unique situation catches the attention of Satoru Gojou, a powerful sorcerer who teaches at Tokyo Prefectural Jujutsu High School. Gojou sees immense potential in Yuuta, and he hopes to help the boy channel his deadly burden into a force for good. Yet Yuuta struggles to find his place among his talented classmates: the selectively mute Toge Inumaki, weapons expert Maki Zenin, and Panda.\r\n\r\nYuuta clumsily utilizes Rika on missions with the other first-year students, but the grisly aftermath of Rika\'s tremendous displays of power draws the interest of the calculating curse user Suguru Getou. As Getou strives to claim Rika\'s strength and use it to eliminate all non-jujutsu users from the world, Yuuta fights alongside his friends to stop the genocidal plot.', 104, 'Action, Fantasy', 'PG', 'images/poster_jjk0.jpg', NULL, '2022-01-10', 'now_playing', '2025-10-29 14:08:47', '2025-11-28 15:43:02'),
(6, 'Your Name', 'Dua remaja saling bertukar tubuh dan terhubung oleh nasib.', 106, 'Romance, Drama', 'PG', 'images/poster_yourname.jpg', NULL, '2016-08-26', 'coming_soon', '2025-10-29 14:08:47', '2025-10-29 15:32:51'),
(7, 'Suzume', 'Gadis SMA yang membantu menutup pintu antar dunia agar bencana tidak terjadi.', 121, 'Adventure, Fantasy', 'PG', 'images/poster_suzume.jpg', NULL, '2023-04-15', 'coming_soon', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(8, 'Demon Slayer: Mugen Train', 'Tanjiro dan teman-temannya menghadapi iblis kuat di dalam kereta misterius.', 117, 'Action, Fantasy', 'R', 'images/poster_kny_mugen.jpg', NULL, '2020-10-16', 'archived', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(9, 'One Piece Film: Red', 'Luffy dan kru Topi Jerami bertemu diva legendaris, Uta.', 115, 'Action, Adventure', 'PG', 'images/poster_op_red.jpg', NULL, '2022-08-06', 'now_playing', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(10, 'Weathering With You', 'Seorang anak laki-laki bertemu gadis yang dapat mengubah cuaca.', 112, 'Fantasy, Romance', 'PG', 'images/poster_weathering.jpg', NULL, '2019-07-19', 'coming_soon', '2025-10-29 14:08:47', '2025-10-29 15:45:13'),
(11, 'Blue Lock - Episode Nagi', 'Nagi Seishiro berusaha mengungkap potensi terbesarnya dalam program Blue Lock.', 91, 'Sports, Drama', 'PG-13', 'images/poster_bl_nagi.jpg', NULL, '2024-06-01', 'coming_soon', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(12, 'The First Slam Dunk', 'Tim Shohoku berjuang dalam pertandingan penentuan melawan Sannoh.', 124, 'Sports, Drama', 'PG', 'images/poster_slamdunk.jpg', NULL, '2022-12-03', 'now_playing', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(13, 'Haikyuu!! The Dumpster Battle', 'Karasuno vs Nekoma dalam pertandingan yang sangat menentukan.', 95, 'Sports', 'PG', 'images/poster_haikyuu.jpg', NULL, '2024-02-16', 'now_playing', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(14, 'Spirited Away', 'Seorang gadis terjebak di dunia roh dan harus menemukan jalan pulang.', 125, 'Fantasy, Adventure', 'PG', 'images/poster_spiritedaway.jpg', NULL, '2001-07-20', 'archived', '2025-10-29 14:08:47', '2025-10-29 14:08:47'),
(15, 'Perjalanan Pria Solo', 'Perjalanan Pria Solo dari publik jadi Presiden', 164, 'Drama, Comedy', 'R', 'images/IMG_0215.jpg', NULL, '2025-11-28', 'archived', '2025-11-21 11:28:40', '2025-11-21 12:21:07'),
(16, 'Violet Evergarden Movie', 'Several years have passed since the end of The Great War. As the radio tower in Leidenschaftlich continues to be built, telephones will soon become more relevant, leading to a decline in demand for \"Auto Memory Dolls.\" Even so, Violet Evergarden continues to rise in fame after her constant success with writing letters. However, sometimes the one thing you long for is the one thing that does not appear.\r\n\r\nViolet Evergarden Movie follows Violet as she continues to comprehend the concept of emotion and the meaning of love. At the same time, she pursues a glimmer of hope that the man who once told her, \"I love you,\" may still be alive even after the many years that have passed.', 140, 'Drama, Romance', 'PG-13', 'images/poster_violet.jpg', NULL, '2020-09-18', 'now_playing', '2025-11-29 12:47:41', '2025-11-29 12:47:41'),
(20, 'Avatar', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 162, 'Action, Adventure, Fantasy, Sci-Fi', 'PG-13', 'images/avatar.jpg', 'https://youtu.be/5PSNL1qE6VY?si=mkJRfareWCfU688T', '2009-12-18', 'now_playing', '2026-01-04 16:24:46', '2026-01-04 16:24:46');

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `schedule_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `hall_id` int NOT NULL,
  `show_date` date NOT NULL,
  `show_time` time NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `available_seats` int NOT NULL,
  `status` enum('active','full','cancelled') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`schedule_id`, `movie_id`, `hall_id`, `show_date`, `show_time`, `price`, `available_seats`, `status`, `created_at`) VALUES
(580, 1, 4, '2025-11-15', '19:20:00', 60000.00, 118, 'active', '2025-11-15 08:14:50'),
(581, 3, 4, '2025-11-21', '20:20:00', 60000.00, 152, 'active', '2025-11-21 11:11:54'),
(582, 15, 4, '2025-11-21', '19:30:00', 700000.00, 100, 'active', '2025-11-21 11:31:53'),
(583, 1, 3, '2025-11-29', '16:00:00', 80000.00, 15, 'active', '2025-11-23 07:32:42'),
(584, 9, 8, '2025-11-26', '20:20:00', 1000000.00, 87, 'active', '2025-11-26 12:41:57'),
(585, 16, 3, '2025-11-29', '21:00:00', 100000.00, 120, 'active', '2025-11-29 12:48:15'),
(587, 16, 5, '2025-11-29', '20:00:00', 120000.00, 93, 'active', '2025-11-29 12:49:03'),
(588, 16, 1, '2025-11-29', '20:00:00', 120000.00, 100, 'active', '2025-11-29 12:49:22'),
(589, 1, 2, '2026-01-04', '23:30:00', 500000.00, 80, 'active', '2026-01-04 16:06:43'),
(591, 20, 6, '2026-01-05', '12:10:00', 700000.00, 72, 'active', '2026-01-04 16:25:46');

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `seat_id` int NOT NULL,
  `hall_id` int NOT NULL,
  `seat_row` varchar(5) NOT NULL,
  `seat_number` int NOT NULL,
  `seat_type` enum('regular','vip','premium') DEFAULT 'regular'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`seat_id`, `hall_id`, `seat_row`, `seat_number`, `seat_type`) VALUES
(1, 1, 'H', 1, 'vip'),
(2, 1, 'G', 1, 'vip'),
(3, 1, 'F', 1, 'vip'),
(4, 1, 'E', 1, 'premium'),
(5, 1, 'D', 1, 'premium'),
(6, 1, 'C', 1, 'premium'),
(7, 1, 'B', 1, 'regular'),
(8, 1, 'A', 1, 'regular'),
(9, 1, 'H', 2, 'vip'),
(10, 1, 'G', 2, 'vip'),
(11, 1, 'F', 2, 'vip'),
(12, 1, 'E', 2, 'premium'),
(13, 1, 'D', 2, 'premium'),
(14, 1, 'C', 2, 'premium'),
(15, 1, 'B', 2, 'regular'),
(16, 1, 'A', 2, 'regular'),
(17, 1, 'H', 3, 'vip'),
(18, 1, 'G', 3, 'vip'),
(19, 1, 'F', 3, 'vip'),
(20, 1, 'E', 3, 'premium'),
(21, 1, 'D', 3, 'premium'),
(22, 1, 'C', 3, 'premium'),
(23, 1, 'B', 3, 'regular'),
(24, 1, 'A', 3, 'regular'),
(25, 1, 'H', 4, 'vip'),
(26, 1, 'G', 4, 'vip'),
(27, 1, 'F', 4, 'vip'),
(28, 1, 'E', 4, 'premium'),
(29, 1, 'D', 4, 'premium'),
(30, 1, 'C', 4, 'premium'),
(31, 1, 'B', 4, 'regular'),
(32, 1, 'A', 4, 'regular'),
(33, 1, 'H', 5, 'vip'),
(34, 1, 'G', 5, 'vip'),
(35, 1, 'F', 5, 'vip'),
(36, 1, 'E', 5, 'premium'),
(37, 1, 'D', 5, 'premium'),
(38, 1, 'C', 5, 'premium'),
(39, 1, 'B', 5, 'regular'),
(40, 1, 'A', 5, 'regular'),
(41, 1, 'H', 6, 'vip'),
(42, 1, 'G', 6, 'vip'),
(43, 1, 'F', 6, 'vip'),
(44, 1, 'E', 6, 'premium'),
(45, 1, 'D', 6, 'premium'),
(46, 1, 'C', 6, 'premium'),
(47, 1, 'B', 6, 'regular'),
(48, 1, 'A', 6, 'regular'),
(49, 1, 'H', 7, 'vip'),
(50, 1, 'G', 7, 'vip'),
(51, 1, 'F', 7, 'vip'),
(52, 1, 'E', 7, 'premium'),
(53, 1, 'D', 7, 'premium'),
(54, 1, 'C', 7, 'premium'),
(55, 1, 'B', 7, 'regular'),
(56, 1, 'A', 7, 'regular'),
(57, 1, 'H', 8, 'vip'),
(58, 1, 'G', 8, 'vip'),
(59, 1, 'F', 8, 'vip'),
(60, 1, 'E', 8, 'premium'),
(61, 1, 'D', 8, 'premium'),
(62, 1, 'C', 8, 'premium'),
(63, 1, 'B', 8, 'regular'),
(64, 1, 'A', 8, 'regular'),
(65, 1, 'H', 9, 'vip'),
(66, 1, 'G', 9, 'vip'),
(67, 1, 'F', 9, 'vip'),
(68, 1, 'E', 9, 'premium'),
(69, 1, 'D', 9, 'premium'),
(70, 1, 'C', 9, 'premium'),
(71, 1, 'B', 9, 'regular'),
(72, 1, 'A', 9, 'regular'),
(73, 1, 'H', 10, 'vip'),
(74, 1, 'G', 10, 'vip'),
(75, 1, 'F', 10, 'vip'),
(76, 1, 'E', 10, 'premium'),
(77, 1, 'D', 10, 'premium'),
(78, 1, 'C', 10, 'premium'),
(79, 1, 'B', 10, 'regular'),
(80, 1, 'A', 10, 'regular'),
(129, 2, 'H', 1, 'vip'),
(130, 2, 'G', 1, 'vip'),
(131, 2, 'F', 1, 'premium'),
(132, 2, 'E', 1, 'premium'),
(133, 2, 'D', 1, 'premium'),
(134, 2, 'C', 1, 'premium'),
(135, 2, 'B', 1, 'regular'),
(136, 2, 'A', 1, 'regular'),
(137, 2, 'H', 2, 'vip'),
(138, 2, 'G', 2, 'vip'),
(139, 2, 'F', 2, 'premium'),
(140, 2, 'E', 2, 'premium'),
(141, 2, 'D', 2, 'premium'),
(142, 2, 'C', 2, 'premium'),
(143, 2, 'B', 2, 'regular'),
(144, 2, 'A', 2, 'regular'),
(145, 2, 'H', 3, 'vip'),
(146, 2, 'G', 3, 'vip'),
(147, 2, 'F', 3, 'premium'),
(148, 2, 'E', 3, 'premium'),
(149, 2, 'D', 3, 'premium'),
(150, 2, 'C', 3, 'premium'),
(151, 2, 'B', 3, 'regular'),
(152, 2, 'A', 3, 'regular'),
(153, 2, 'H', 4, 'vip'),
(154, 2, 'G', 4, 'vip'),
(155, 2, 'F', 4, 'premium'),
(156, 2, 'E', 4, 'premium'),
(157, 2, 'D', 4, 'premium'),
(158, 2, 'C', 4, 'premium'),
(159, 2, 'B', 4, 'regular'),
(160, 2, 'A', 4, 'regular'),
(161, 2, 'H', 5, 'vip'),
(162, 2, 'G', 5, 'vip'),
(163, 2, 'F', 5, 'premium'),
(164, 2, 'E', 5, 'premium'),
(165, 2, 'D', 5, 'premium'),
(166, 2, 'C', 5, 'premium'),
(167, 2, 'B', 5, 'regular'),
(168, 2, 'A', 5, 'regular'),
(169, 2, 'H', 6, 'vip'),
(170, 2, 'G', 6, 'vip'),
(171, 2, 'F', 6, 'premium'),
(172, 2, 'E', 6, 'premium'),
(173, 2, 'D', 6, 'premium'),
(174, 2, 'C', 6, 'premium'),
(175, 2, 'B', 6, 'regular'),
(176, 2, 'A', 6, 'regular'),
(177, 2, 'H', 7, 'vip'),
(178, 2, 'G', 7, 'vip'),
(179, 2, 'F', 7, 'premium'),
(180, 2, 'E', 7, 'premium'),
(181, 2, 'D', 7, 'premium'),
(182, 2, 'C', 7, 'premium'),
(183, 2, 'B', 7, 'regular'),
(184, 2, 'A', 7, 'regular'),
(185, 2, 'H', 8, 'vip'),
(186, 2, 'G', 8, 'vip'),
(187, 2, 'F', 8, 'premium'),
(188, 2, 'E', 8, 'premium'),
(189, 2, 'D', 8, 'premium'),
(190, 2, 'C', 8, 'premium'),
(191, 2, 'B', 8, 'regular'),
(192, 2, 'A', 8, 'regular'),
(193, 2, 'H', 9, 'vip'),
(194, 2, 'G', 9, 'vip'),
(195, 2, 'F', 9, 'premium'),
(196, 2, 'E', 9, 'premium'),
(197, 2, 'D', 9, 'premium'),
(198, 2, 'C', 9, 'premium'),
(199, 2, 'B', 9, 'regular'),
(200, 2, 'A', 9, 'regular'),
(201, 2, 'H', 10, 'vip'),
(202, 2, 'G', 10, 'vip'),
(203, 2, 'F', 10, 'premium'),
(204, 2, 'E', 10, 'premium'),
(205, 2, 'D', 10, 'premium'),
(206, 2, 'C', 10, 'premium'),
(207, 2, 'B', 10, 'regular'),
(208, 2, 'A', 10, 'regular'),
(259, 4, 'J', 1, 'regular'),
(260, 4, 'I', 1, 'regular'),
(261, 4, 'H', 1, 'regular'),
(262, 4, 'G', 1, 'regular'),
(263, 4, 'F', 1, 'regular'),
(264, 4, 'E', 1, 'regular'),
(265, 4, 'D', 1, 'regular'),
(266, 4, 'C', 1, 'regular'),
(267, 4, 'B', 1, 'vip'),
(268, 4, 'A', 1, 'vip'),
(269, 4, 'J', 2, 'regular'),
(270, 4, 'I', 2, 'regular'),
(271, 4, 'H', 2, 'regular'),
(272, 4, 'G', 2, 'regular'),
(273, 4, 'F', 2, 'regular'),
(274, 4, 'E', 2, 'regular'),
(275, 4, 'D', 2, 'regular'),
(276, 4, 'C', 2, 'regular'),
(277, 4, 'B', 2, 'vip'),
(278, 4, 'A', 2, 'vip'),
(279, 4, 'J', 3, 'regular'),
(280, 4, 'I', 3, 'regular'),
(281, 4, 'H', 3, 'regular'),
(282, 4, 'G', 3, 'regular'),
(283, 4, 'F', 3, 'regular'),
(284, 4, 'E', 3, 'regular'),
(285, 4, 'D', 3, 'regular'),
(286, 4, 'C', 3, 'regular'),
(287, 4, 'B', 3, 'vip'),
(288, 4, 'A', 3, 'vip'),
(289, 4, 'J', 4, 'regular'),
(290, 4, 'I', 4, 'regular'),
(291, 4, 'H', 4, 'regular'),
(292, 4, 'G', 4, 'regular'),
(293, 4, 'F', 4, 'regular'),
(294, 4, 'E', 4, 'regular'),
(295, 4, 'D', 4, 'regular'),
(296, 4, 'C', 4, 'regular'),
(297, 4, 'B', 4, 'vip'),
(298, 4, 'A', 4, 'vip'),
(299, 4, 'J', 5, 'regular'),
(300, 4, 'I', 5, 'regular'),
(301, 4, 'H', 5, 'regular'),
(302, 4, 'G', 5, 'regular'),
(303, 4, 'F', 5, 'regular'),
(304, 4, 'E', 5, 'regular'),
(305, 4, 'D', 5, 'regular'),
(306, 4, 'C', 5, 'regular'),
(307, 4, 'B', 5, 'vip'),
(308, 4, 'A', 5, 'vip'),
(309, 4, 'J', 6, 'regular'),
(310, 4, 'I', 6, 'regular'),
(311, 4, 'H', 6, 'regular'),
(312, 4, 'G', 6, 'regular'),
(313, 4, 'F', 6, 'regular'),
(314, 4, 'E', 6, 'regular'),
(315, 4, 'D', 6, 'regular'),
(316, 4, 'C', 6, 'regular'),
(317, 4, 'B', 6, 'vip'),
(318, 4, 'A', 6, 'vip'),
(319, 4, 'J', 7, 'regular'),
(320, 4, 'I', 7, 'regular'),
(321, 4, 'H', 7, 'regular'),
(322, 4, 'G', 7, 'regular'),
(323, 4, 'F', 7, 'regular'),
(324, 4, 'E', 7, 'regular'),
(325, 4, 'D', 7, 'regular'),
(326, 4, 'C', 7, 'regular'),
(327, 4, 'B', 7, 'vip'),
(328, 4, 'A', 7, 'vip'),
(329, 4, 'J', 8, 'regular'),
(330, 4, 'I', 8, 'regular'),
(331, 4, 'H', 8, 'regular'),
(332, 4, 'G', 8, 'regular'),
(333, 4, 'F', 8, 'regular'),
(334, 4, 'E', 8, 'regular'),
(335, 4, 'D', 8, 'regular'),
(336, 4, 'C', 8, 'regular'),
(337, 4, 'B', 8, 'vip'),
(338, 4, 'A', 8, 'vip'),
(339, 4, 'J', 9, 'regular'),
(340, 4, 'I', 9, 'regular'),
(341, 4, 'H', 9, 'regular'),
(342, 4, 'G', 9, 'regular'),
(343, 4, 'F', 9, 'regular'),
(344, 4, 'E', 9, 'regular'),
(345, 4, 'D', 9, 'regular'),
(346, 4, 'C', 9, 'regular'),
(347, 4, 'B', 9, 'vip'),
(348, 4, 'A', 9, 'vip'),
(349, 4, 'J', 10, 'regular'),
(350, 4, 'I', 10, 'regular'),
(351, 4, 'H', 10, 'regular'),
(352, 4, 'G', 10, 'regular'),
(353, 4, 'F', 10, 'regular'),
(354, 4, 'E', 10, 'regular'),
(355, 4, 'D', 10, 'regular'),
(356, 4, 'C', 10, 'regular'),
(357, 4, 'B', 10, 'vip'),
(358, 4, 'A', 10, 'vip'),
(359, 3, 'A', 1, 'regular'),
(360, 3, 'A', 2, 'regular'),
(361, 3, 'A', 3, 'regular'),
(362, 3, 'A', 4, 'regular'),
(363, 3, 'A', 5, 'regular'),
(364, 3, 'A', 6, 'regular'),
(365, 3, 'A', 7, 'regular'),
(366, 3, 'A', 8, 'regular'),
(367, 3, 'A', 9, 'regular'),
(368, 3, 'A', 10, 'regular'),
(369, 3, 'A', 11, 'regular'),
(370, 3, 'A', 12, 'regular'),
(371, 3, 'B', 1, 'regular'),
(372, 3, 'B', 2, 'regular'),
(373, 3, 'B', 3, 'regular'),
(374, 3, 'B', 4, 'regular'),
(375, 3, 'B', 5, 'regular'),
(376, 3, 'B', 6, 'regular'),
(377, 3, 'B', 7, 'regular'),
(378, 3, 'B', 8, 'regular'),
(379, 3, 'B', 9, 'regular'),
(380, 3, 'B', 10, 'regular'),
(381, 3, 'B', 11, 'regular'),
(382, 3, 'B', 12, 'regular'),
(383, 3, 'C', 1, 'regular'),
(384, 3, 'C', 2, 'regular'),
(385, 3, 'C', 3, 'regular'),
(386, 3, 'C', 4, 'regular'),
(387, 3, 'C', 5, 'regular'),
(388, 3, 'C', 6, 'regular'),
(389, 3, 'C', 7, 'regular'),
(390, 3, 'C', 8, 'regular'),
(391, 3, 'C', 9, 'regular'),
(392, 3, 'C', 10, 'regular'),
(393, 3, 'C', 11, 'regular'),
(394, 3, 'C', 12, 'regular'),
(395, 3, 'D', 1, 'regular'),
(396, 3, 'D', 2, 'regular'),
(397, 3, 'D', 3, 'regular'),
(398, 3, 'D', 4, 'regular'),
(399, 3, 'D', 5, 'regular'),
(400, 3, 'D', 6, 'regular'),
(401, 3, 'D', 7, 'regular'),
(402, 3, 'D', 8, 'regular'),
(403, 3, 'D', 9, 'regular'),
(404, 3, 'D', 10, 'regular'),
(405, 3, 'D', 11, 'regular'),
(406, 3, 'D', 12, 'regular'),
(407, 3, 'E', 1, 'regular'),
(408, 3, 'E', 2, 'regular'),
(409, 3, 'E', 3, 'regular'),
(410, 3, 'E', 4, 'regular'),
(411, 3, 'E', 5, 'regular'),
(412, 3, 'E', 6, 'regular'),
(413, 3, 'E', 7, 'regular'),
(414, 3, 'E', 8, 'regular'),
(415, 3, 'E', 9, 'regular'),
(416, 3, 'E', 10, 'regular'),
(417, 3, 'E', 11, 'regular'),
(418, 3, 'E', 12, 'regular'),
(419, 3, 'F', 1, 'regular'),
(420, 3, 'F', 2, 'regular'),
(421, 3, 'F', 3, 'regular'),
(422, 3, 'F', 4, 'regular'),
(423, 3, 'F', 5, 'regular'),
(424, 3, 'F', 6, 'regular'),
(425, 3, 'F', 7, 'regular'),
(426, 3, 'F', 8, 'regular'),
(427, 3, 'F', 9, 'regular'),
(428, 3, 'F', 10, 'regular'),
(429, 3, 'F', 11, 'regular'),
(430, 3, 'F', 12, 'regular'),
(431, 3, 'G', 1, 'regular'),
(432, 3, 'G', 2, 'regular'),
(433, 3, 'G', 3, 'regular'),
(434, 3, 'G', 4, 'regular'),
(435, 3, 'G', 5, 'regular'),
(436, 3, 'G', 6, 'regular'),
(437, 3, 'G', 7, 'regular'),
(438, 3, 'G', 8, 'regular'),
(439, 3, 'G', 9, 'regular'),
(440, 3, 'G', 10, 'regular'),
(441, 3, 'G', 11, 'regular'),
(442, 3, 'G', 12, 'regular'),
(443, 3, 'H', 1, 'regular'),
(444, 3, 'H', 2, 'regular'),
(445, 3, 'H', 3, 'regular'),
(446, 3, 'H', 4, 'regular'),
(447, 3, 'H', 5, 'regular'),
(448, 3, 'H', 6, 'regular'),
(449, 3, 'H', 7, 'regular'),
(450, 3, 'H', 8, 'regular'),
(451, 3, 'H', 9, 'regular'),
(452, 3, 'H', 10, 'regular'),
(453, 3, 'H', 11, 'regular'),
(454, 3, 'H', 12, 'regular'),
(455, 3, 'I', 1, 'regular'),
(456, 3, 'I', 2, 'regular'),
(457, 3, 'I', 3, 'regular'),
(458, 3, 'I', 4, 'regular'),
(459, 3, 'I', 5, 'regular'),
(460, 3, 'I', 6, 'regular'),
(461, 3, 'I', 7, 'regular'),
(462, 3, 'I', 8, 'regular'),
(463, 3, 'I', 9, 'regular'),
(464, 3, 'I', 10, 'regular'),
(465, 3, 'I', 11, 'regular'),
(466, 3, 'I', 12, 'regular'),
(467, 3, 'J', 1, 'regular'),
(468, 3, 'J', 2, 'regular'),
(469, 3, 'J', 3, 'regular'),
(470, 3, 'J', 4, 'regular'),
(471, 3, 'J', 5, 'regular'),
(472, 3, 'J', 6, 'regular'),
(473, 3, 'J', 7, 'regular'),
(474, 3, 'J', 8, 'regular'),
(475, 3, 'J', 9, 'regular'),
(476, 3, 'J', 10, 'regular'),
(477, 3, 'J', 11, 'regular'),
(478, 3, 'J', 12, 'regular'),
(479, 5, 'A', 1, 'regular'),
(480, 5, 'A', 2, 'regular'),
(481, 5, 'A', 3, 'regular'),
(482, 5, 'A', 4, 'regular'),
(483, 5, 'A', 5, 'regular'),
(484, 5, 'A', 6, 'regular'),
(485, 5, 'A', 7, 'regular'),
(486, 5, 'A', 8, 'regular'),
(487, 5, 'A', 9, 'regular'),
(488, 5, 'A', 10, 'regular'),
(489, 5, 'B', 1, 'regular'),
(490, 5, 'B', 2, 'regular'),
(491, 5, 'B', 3, 'regular'),
(492, 5, 'B', 4, 'regular'),
(493, 5, 'B', 5, 'regular'),
(494, 5, 'B', 6, 'regular'),
(495, 5, 'B', 7, 'regular'),
(496, 5, 'B', 8, 'regular'),
(497, 5, 'B', 9, 'regular'),
(498, 5, 'B', 10, 'regular'),
(499, 5, 'C', 1, 'regular'),
(500, 5, 'C', 2, 'regular'),
(501, 5, 'C', 3, 'regular'),
(502, 5, 'C', 4, 'regular'),
(503, 5, 'C', 5, 'regular'),
(504, 5, 'C', 6, 'regular'),
(505, 5, 'C', 7, 'regular'),
(506, 5, 'C', 8, 'regular'),
(507, 5, 'C', 9, 'regular'),
(508, 5, 'C', 10, 'regular'),
(509, 5, 'D', 1, 'regular'),
(510, 5, 'D', 2, 'regular'),
(511, 5, 'D', 3, 'regular'),
(512, 5, 'D', 4, 'regular'),
(513, 5, 'D', 5, 'regular'),
(514, 5, 'D', 6, 'regular'),
(515, 5, 'D', 7, 'regular'),
(516, 5, 'D', 8, 'regular'),
(517, 5, 'D', 9, 'regular'),
(518, 5, 'D', 10, 'regular'),
(519, 5, 'E', 1, 'regular'),
(520, 5, 'E', 2, 'regular'),
(521, 5, 'E', 3, 'regular'),
(522, 5, 'E', 4, 'regular'),
(523, 5, 'E', 5, 'regular'),
(524, 5, 'E', 6, 'regular'),
(525, 5, 'E', 7, 'regular'),
(526, 5, 'E', 8, 'regular'),
(527, 5, 'E', 9, 'regular'),
(528, 5, 'E', 10, 'regular'),
(529, 5, 'F', 1, 'regular'),
(530, 5, 'F', 2, 'regular'),
(531, 5, 'F', 3, 'regular'),
(532, 5, 'F', 4, 'regular'),
(533, 5, 'F', 5, 'regular'),
(534, 5, 'F', 6, 'regular'),
(535, 5, 'F', 7, 'regular'),
(536, 5, 'F', 8, 'regular'),
(537, 5, 'F', 9, 'regular'),
(538, 5, 'F', 10, 'regular'),
(539, 5, 'G', 1, 'regular'),
(540, 5, 'G', 2, 'regular'),
(541, 5, 'G', 3, 'regular'),
(542, 5, 'G', 4, 'regular'),
(543, 5, 'G', 5, 'regular'),
(544, 5, 'G', 6, 'regular'),
(545, 5, 'G', 7, 'regular'),
(546, 5, 'G', 8, 'regular'),
(547, 5, 'G', 9, 'regular'),
(548, 5, 'G', 10, 'regular'),
(549, 5, 'H', 1, 'regular'),
(550, 5, 'H', 2, 'regular'),
(551, 5, 'H', 3, 'regular'),
(552, 5, 'H', 4, 'regular'),
(553, 5, 'H', 5, 'regular'),
(554, 5, 'H', 6, 'regular'),
(555, 5, 'H', 7, 'regular'),
(556, 5, 'H', 8, 'regular'),
(557, 5, 'H', 9, 'regular'),
(558, 5, 'H', 10, 'regular'),
(559, 5, 'I', 1, 'regular'),
(560, 5, 'I', 2, 'regular'),
(561, 5, 'I', 3, 'regular'),
(562, 5, 'I', 4, 'regular'),
(563, 5, 'I', 5, 'regular'),
(564, 5, 'I', 6, 'regular'),
(565, 5, 'I', 7, 'regular'),
(566, 5, 'I', 8, 'regular'),
(567, 5, 'I', 9, 'regular'),
(568, 5, 'I', 10, 'regular'),
(569, 5, 'J', 1, 'regular'),
(570, 5, 'J', 2, 'regular'),
(571, 5, 'J', 3, 'regular'),
(572, 5, 'J', 4, 'regular'),
(573, 5, 'J', 5, 'regular'),
(574, 5, 'J', 6, 'regular'),
(575, 5, 'J', 7, 'regular'),
(576, 5, 'J', 8, 'regular'),
(577, 5, 'J', 9, 'regular'),
(578, 5, 'J', 10, 'regular'),
(579, 6, 'A', 1, 'regular'),
(580, 6, 'A', 2, 'regular'),
(581, 6, 'A', 3, 'regular'),
(582, 6, 'A', 4, 'regular'),
(583, 6, 'A', 5, 'regular'),
(584, 6, 'A', 6, 'regular'),
(585, 6, 'A', 7, 'regular'),
(586, 6, 'A', 8, 'regular'),
(587, 6, 'B', 1, 'regular'),
(588, 6, 'B', 2, 'regular'),
(589, 6, 'B', 3, 'regular'),
(590, 6, 'B', 4, 'regular'),
(591, 6, 'B', 5, 'regular'),
(592, 6, 'B', 6, 'regular'),
(593, 6, 'B', 7, 'regular'),
(594, 6, 'B', 8, 'regular'),
(595, 6, 'C', 1, 'regular'),
(596, 6, 'C', 2, 'regular'),
(597, 6, 'C', 3, 'regular'),
(598, 6, 'C', 4, 'regular'),
(599, 6, 'C', 5, 'regular'),
(600, 6, 'C', 6, 'regular'),
(601, 6, 'C', 7, 'regular'),
(602, 6, 'C', 8, 'regular'),
(603, 6, 'D', 1, 'regular'),
(604, 6, 'D', 2, 'regular'),
(605, 6, 'D', 3, 'regular'),
(606, 6, 'D', 4, 'regular'),
(607, 6, 'D', 5, 'regular'),
(608, 6, 'D', 6, 'regular'),
(609, 6, 'D', 7, 'regular'),
(610, 6, 'D', 8, 'regular'),
(611, 6, 'E', 1, 'regular'),
(612, 6, 'E', 2, 'regular'),
(613, 6, 'E', 3, 'regular'),
(614, 6, 'E', 4, 'regular'),
(615, 6, 'E', 5, 'regular'),
(616, 6, 'E', 6, 'regular'),
(617, 6, 'E', 7, 'regular'),
(618, 6, 'E', 8, 'regular'),
(619, 6, 'F', 1, 'regular'),
(620, 6, 'F', 2, 'regular'),
(621, 6, 'F', 3, 'regular'),
(622, 6, 'F', 4, 'regular'),
(623, 6, 'F', 5, 'regular'),
(624, 6, 'F', 6, 'regular'),
(625, 6, 'F', 7, 'regular'),
(626, 6, 'F', 8, 'regular'),
(627, 6, 'G', 1, 'regular'),
(628, 6, 'G', 2, 'regular'),
(629, 6, 'G', 3, 'regular'),
(630, 6, 'G', 4, 'regular'),
(631, 6, 'G', 5, 'regular'),
(632, 6, 'G', 6, 'regular'),
(633, 6, 'G', 7, 'regular'),
(634, 6, 'G', 8, 'regular'),
(635, 6, 'H', 1, 'regular'),
(636, 6, 'H', 2, 'regular'),
(637, 6, 'H', 3, 'regular'),
(638, 6, 'H', 4, 'regular'),
(639, 6, 'H', 5, 'regular'),
(640, 6, 'H', 6, 'regular'),
(641, 6, 'H', 7, 'regular'),
(642, 6, 'H', 8, 'regular'),
(643, 6, 'I', 1, 'regular'),
(644, 6, 'I', 2, 'regular'),
(645, 6, 'I', 3, 'regular'),
(646, 6, 'I', 4, 'regular'),
(647, 6, 'I', 5, 'regular'),
(648, 6, 'I', 6, 'regular'),
(649, 6, 'I', 7, 'regular'),
(650, 6, 'I', 8, 'regular'),
(651, 6, 'J', 1, 'regular'),
(652, 6, 'J', 2, 'regular'),
(653, 6, 'J', 3, 'regular'),
(654, 6, 'J', 4, 'regular'),
(655, 6, 'J', 5, 'regular'),
(656, 6, 'J', 6, 'regular'),
(657, 6, 'J', 7, 'regular'),
(658, 6, 'J', 8, 'regular'),
(659, 7, 'A', 1, 'regular'),
(660, 7, 'A', 2, 'regular'),
(661, 7, 'A', 3, 'regular'),
(662, 7, 'A', 4, 'regular'),
(663, 7, 'A', 5, 'regular'),
(664, 7, 'A', 6, 'regular'),
(665, 7, 'A', 7, 'regular'),
(666, 7, 'A', 8, 'regular'),
(667, 7, 'A', 9, 'regular'),
(668, 7, 'A', 10, 'regular'),
(669, 7, 'A', 11, 'regular'),
(670, 7, 'A', 12, 'regular'),
(671, 7, 'B', 1, 'regular'),
(672, 7, 'B', 2, 'regular'),
(673, 7, 'B', 3, 'regular'),
(674, 7, 'B', 4, 'regular'),
(675, 7, 'B', 5, 'regular'),
(676, 7, 'B', 6, 'regular'),
(677, 7, 'B', 7, 'regular'),
(678, 7, 'B', 8, 'regular'),
(679, 7, 'B', 9, 'regular'),
(680, 7, 'B', 10, 'regular'),
(681, 7, 'B', 11, 'regular'),
(682, 7, 'B', 12, 'regular'),
(683, 7, 'C', 1, 'regular'),
(684, 7, 'C', 2, 'regular'),
(685, 7, 'C', 3, 'regular'),
(686, 7, 'C', 4, 'regular'),
(687, 7, 'C', 5, 'regular'),
(688, 7, 'C', 6, 'regular'),
(689, 7, 'C', 7, 'regular'),
(690, 7, 'C', 8, 'regular'),
(691, 7, 'C', 9, 'regular'),
(692, 7, 'C', 10, 'regular'),
(693, 7, 'C', 11, 'regular'),
(694, 7, 'C', 12, 'regular'),
(695, 7, 'D', 1, 'regular'),
(696, 7, 'D', 2, 'regular'),
(697, 7, 'D', 3, 'regular'),
(698, 7, 'D', 4, 'regular'),
(699, 7, 'D', 5, 'regular'),
(700, 7, 'D', 6, 'regular'),
(701, 7, 'D', 7, 'regular'),
(702, 7, 'D', 8, 'regular'),
(703, 7, 'D', 9, 'regular'),
(704, 7, 'D', 10, 'regular'),
(705, 7, 'D', 11, 'regular'),
(706, 7, 'D', 12, 'regular'),
(707, 7, 'E', 1, 'regular'),
(708, 7, 'E', 2, 'regular'),
(709, 7, 'E', 3, 'regular'),
(710, 7, 'E', 4, 'regular'),
(711, 7, 'E', 5, 'regular'),
(712, 7, 'E', 6, 'regular'),
(713, 7, 'E', 7, 'regular'),
(714, 7, 'E', 8, 'regular'),
(715, 7, 'E', 9, 'regular'),
(716, 7, 'E', 10, 'regular'),
(717, 7, 'E', 11, 'regular'),
(718, 7, 'E', 12, 'regular'),
(719, 7, 'F', 1, 'regular'),
(720, 7, 'F', 2, 'regular'),
(721, 7, 'F', 3, 'regular'),
(722, 7, 'F', 4, 'regular'),
(723, 7, 'F', 5, 'regular'),
(724, 7, 'F', 6, 'regular'),
(725, 7, 'F', 7, 'regular'),
(726, 7, 'F', 8, 'regular'),
(727, 7, 'F', 9, 'regular'),
(728, 7, 'F', 10, 'regular'),
(729, 7, 'F', 11, 'regular'),
(730, 7, 'F', 12, 'regular'),
(731, 7, 'G', 1, 'regular'),
(732, 7, 'G', 2, 'regular'),
(733, 7, 'G', 3, 'regular'),
(734, 7, 'G', 4, 'regular'),
(735, 7, 'G', 5, 'regular'),
(736, 7, 'G', 6, 'regular'),
(737, 7, 'G', 7, 'regular'),
(738, 7, 'G', 8, 'regular'),
(739, 7, 'G', 9, 'regular'),
(740, 7, 'G', 10, 'regular'),
(741, 7, 'G', 11, 'regular'),
(742, 7, 'G', 12, 'regular'),
(743, 7, 'H', 1, 'regular'),
(744, 7, 'H', 2, 'regular'),
(745, 7, 'H', 3, 'regular'),
(746, 7, 'H', 4, 'regular'),
(747, 7, 'H', 5, 'regular'),
(748, 7, 'H', 6, 'regular'),
(749, 7, 'H', 7, 'regular'),
(750, 7, 'H', 8, 'regular'),
(751, 7, 'H', 9, 'regular'),
(752, 7, 'H', 10, 'regular'),
(753, 7, 'H', 11, 'regular'),
(754, 7, 'H', 12, 'regular'),
(755, 7, 'I', 1, 'regular'),
(756, 7, 'I', 2, 'regular'),
(757, 7, 'I', 3, 'regular'),
(758, 7, 'I', 4, 'regular'),
(759, 7, 'I', 5, 'regular'),
(760, 7, 'I', 6, 'regular'),
(761, 7, 'I', 7, 'regular'),
(762, 7, 'I', 8, 'regular'),
(763, 7, 'I', 9, 'regular'),
(764, 7, 'I', 10, 'regular'),
(765, 7, 'I', 11, 'regular'),
(766, 7, 'I', 12, 'regular'),
(767, 7, 'J', 1, 'regular'),
(768, 7, 'J', 2, 'regular'),
(769, 7, 'J', 3, 'regular'),
(770, 7, 'J', 4, 'regular'),
(771, 7, 'J', 5, 'regular'),
(772, 7, 'J', 6, 'regular'),
(773, 7, 'J', 7, 'regular'),
(774, 7, 'J', 8, 'regular'),
(775, 7, 'J', 9, 'regular'),
(776, 7, 'J', 10, 'regular'),
(777, 7, 'J', 11, 'regular'),
(778, 7, 'J', 12, 'regular'),
(779, 8, 'A', 1, 'regular'),
(780, 8, 'A', 2, 'regular'),
(781, 8, 'A', 3, 'regular'),
(782, 8, 'A', 4, 'regular'),
(783, 8, 'A', 5, 'regular'),
(784, 8, 'A', 6, 'regular'),
(785, 8, 'A', 7, 'regular'),
(786, 8, 'A', 8, 'regular'),
(787, 8, 'A', 9, 'regular'),
(788, 8, 'A', 10, 'regular'),
(789, 8, 'B', 1, 'regular'),
(790, 8, 'B', 2, 'regular'),
(791, 8, 'B', 3, 'regular'),
(792, 8, 'B', 4, 'regular'),
(793, 8, 'B', 5, 'regular'),
(794, 8, 'B', 6, 'regular'),
(795, 8, 'B', 7, 'regular'),
(796, 8, 'B', 8, 'regular'),
(797, 8, 'B', 9, 'regular'),
(798, 8, 'B', 10, 'regular'),
(799, 8, 'C', 1, 'regular'),
(800, 8, 'C', 2, 'regular'),
(801, 8, 'C', 3, 'regular'),
(802, 8, 'C', 4, 'regular'),
(803, 8, 'C', 5, 'regular'),
(804, 8, 'C', 6, 'regular'),
(805, 8, 'C', 7, 'regular'),
(806, 8, 'C', 8, 'regular'),
(807, 8, 'C', 9, 'regular'),
(808, 8, 'C', 10, 'regular'),
(809, 8, 'D', 1, 'regular'),
(810, 8, 'D', 2, 'regular'),
(811, 8, 'D', 3, 'regular'),
(812, 8, 'D', 4, 'regular'),
(813, 8, 'D', 5, 'regular'),
(814, 8, 'D', 6, 'regular'),
(815, 8, 'D', 7, 'regular'),
(816, 8, 'D', 8, 'regular'),
(817, 8, 'D', 9, 'regular'),
(818, 8, 'D', 10, 'regular'),
(819, 8, 'E', 1, 'regular'),
(820, 8, 'E', 2, 'regular'),
(821, 8, 'E', 3, 'regular'),
(822, 8, 'E', 4, 'regular'),
(823, 8, 'E', 5, 'regular'),
(824, 8, 'E', 6, 'regular'),
(825, 8, 'E', 7, 'regular'),
(826, 8, 'E', 8, 'regular'),
(827, 8, 'E', 9, 'regular'),
(828, 8, 'E', 10, 'regular'),
(829, 8, 'F', 1, 'regular'),
(830, 8, 'F', 2, 'regular'),
(831, 8, 'F', 3, 'regular'),
(832, 8, 'F', 4, 'regular'),
(833, 8, 'F', 5, 'regular'),
(834, 8, 'F', 6, 'regular'),
(835, 8, 'F', 7, 'regular'),
(836, 8, 'F', 8, 'regular'),
(837, 8, 'F', 9, 'regular'),
(838, 8, 'F', 10, 'regular'),
(839, 8, 'G', 1, 'regular'),
(840, 8, 'G', 2, 'regular'),
(841, 8, 'G', 3, 'regular'),
(842, 8, 'G', 4, 'regular'),
(843, 8, 'G', 5, 'regular'),
(844, 8, 'G', 6, 'regular'),
(845, 8, 'G', 7, 'regular'),
(846, 8, 'G', 8, 'regular'),
(847, 8, 'G', 9, 'regular'),
(848, 8, 'G', 10, 'regular'),
(849, 8, 'H', 1, 'regular'),
(850, 8, 'H', 2, 'regular'),
(851, 8, 'H', 3, 'regular'),
(852, 8, 'H', 4, 'regular'),
(853, 8, 'H', 5, 'regular'),
(854, 8, 'H', 6, 'regular'),
(855, 8, 'H', 7, 'regular'),
(856, 8, 'H', 8, 'regular'),
(857, 8, 'H', 9, 'regular'),
(858, 8, 'H', 10, 'regular'),
(859, 8, 'I', 1, 'regular'),
(860, 8, 'I', 2, 'regular'),
(861, 8, 'I', 3, 'regular'),
(862, 8, 'I', 4, 'regular'),
(863, 8, 'I', 5, 'regular'),
(864, 8, 'I', 6, 'regular'),
(865, 8, 'I', 7, 'regular'),
(866, 8, 'I', 8, 'regular'),
(867, 8, 'I', 9, 'regular'),
(868, 8, 'I', 10, 'regular'),
(869, 8, 'J', 1, 'regular'),
(870, 8, 'J', 2, 'regular'),
(871, 8, 'J', 3, 'regular'),
(872, 8, 'J', 4, 'regular'),
(873, 8, 'J', 5, 'regular'),
(874, 8, 'J', 6, 'regular'),
(875, 8, 'J', 7, 'regular'),
(876, 8, 'J', 8, 'regular'),
(877, 8, 'J', 9, 'regular'),
(878, 8, 'J', 10, 'regular');

-- --------------------------------------------------------

--
-- Table structure for table `theaters`
--

CREATE TABLE `theaters` (
  `theater_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `theaters`
--

INSERT INTO `theaters` (`theater_id`, `name`, `location`, `city`, `address`, `created_at`) VALUES
(1, 'Cinema XXI - Tunjungan Plaza', 'Tunjungan Plaza', 'Surabaya', 'Jl. Tunjungan No.1, Surabaya', '2025-10-29 12:45:59'),
(2, 'Cinema XXI - Galaxy Mall', 'Galaxy Mall', 'Surabaya', 'Jl. Dharmahusada Indah Timur No.35-37, Surabaya', '2025-10-29 12:45:59'),
(3, 'Cinema XXI - Pakuwon Mall', 'Pakuwon Mall', 'Surabaya', 'Jl. Puncak Indah Lontar No.2, Surabaya', '2025-10-29 12:45:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('customer','admin') DEFAULT 'customer',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `full_name`, `phone`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@mykisah.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', '081234567890', 'admin', '2025-10-29 12:45:59', '2025-10-29 12:45:59'),
(2, 'user1', 'user1@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Doe', '081234567891', 'customer', '2025-10-29 12:45:59', '2025-10-29 12:45:59'),
(3, 'IshowSpeed', 'banter@gmail.com', '$2y$10$FzK2AcHnZYtKgtNgehrSAusIVfKGwsbTsqgoBbbyAGK5C.Ojvx8qS', 'Raden Mas Banter', '0888888888', 'customer', '2025-10-29 16:21:46', '2025-10-29 16:21:46'),
(4, 'Rennn', 'coba@gmail.com', '$2y$10$/.976QWyA/d9cXfdN2GhEu7ctyTmaU9iqbrtrh0hTKfuZtymQS0fe', 'Rendi', '09109238293', 'customer', '2025-10-31 10:12:46', '2025-10-31 10:12:46'),
(5, 'Ren', 'gatau@gmail.com', '$2y$10$OhMoDBmXiVVQKqsWcPihsu1mVuFc2pIiEHMQ19DSPqRE31BGrLiuS', 'Rendi gg', '08319264985', 'customer', '2025-11-21 11:08:37', '2025-11-21 11:08:37'),
(6, 'Igna', 'robertcorneleio56@gmail.com', '$2y$10$1LhVeMG1dA02PJmhOGFt9eA.CtMSxjnjWXRc7Cde6HJ9OYdb5XPJi', 'Ignatius', '085608128185', 'customer', '2025-11-21 11:16:07', '2025-11-21 11:16:07'),
(7, 'PandaJack', 'example@email.com', '$2y$10$DivUYbpxR2DMM9cDRwM3PeA9GO1sGIqNEvRFIE14Jz.5mCDeICukO', 'PandaJack', '08123456789', 'customer', '2025-11-21 14:53:10', '2025-11-21 14:53:10'),
(8, 'Rendi', 'richard20gons@gmail.com', '$2y$10$oWnhysgaL7H3Bmp.NEEVd.DCHoEBp9DZs43j6xFf9dKLmIjcguK1S', 'Richard Edgar Gonassis', '088217450399', 'customer', '2025-11-29 00:05:22', '2025-11-29 00:05:22'),
(9, 'abc', 'abc@gmail.com', '$2y$10$KAKWhfLsm5BL7Yzpb4N5kujPuFumejmPcu5dVO2d.MKw8pYOufInC', 'J', '1111111111', 'customer', '2025-11-29 12:16:06', '2025-11-29 12:16:06'),
(10, 'tester', 'tester@gmail.com', '$2y$10$SPO9sZNDy6rN0IIVrGvU3ehJwe5CepdtnmjYq80yS8uky6AJZKf52', 'richard', '08123455677', 'customer', '2026-01-04 16:08:11', '2026-01-04 16:08:11'),
(11, 'tes12', 'tes12@gmail.com', '$2y$10$6cH4p3NG0J3qhSWqOk1D0OI5MBTjiD.8LbqAuG8RW3eyFkgmM735G', 'tes12', '081234567890', 'customer', '2026-01-04 16:23:23', '2026-01-04 16:23:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD UNIQUE KEY `booking_code` (`booking_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `booking_seats`
--
ALTER TABLE `booking_seats`
  ADD PRIMARY KEY (`booking_seat_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `seat_id` (`seat_id`);

--
-- Indexes for table `halls`
--
ALTER TABLE `halls`
  ADD PRIMARY KEY (`hall_id`),
  ADD KEY `theater_id` (`theater_id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`movie_id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `hall_id` (`hall_id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`seat_id`),
  ADD UNIQUE KEY `unique_seat` (`hall_id`,`seat_row`,`seat_number`);

--
-- Indexes for table `theaters`
--
ALTER TABLE `theaters`
  ADD PRIMARY KEY (`theater_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `booking_seats`
--
ALTER TABLE `booking_seats`
  MODIFY `booking_seat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=249;

--
-- AUTO_INCREMENT for table `halls`
--
ALTER TABLE `halls`
  MODIFY `hall_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `movie_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `schedule_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=592;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `seat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=879;

--
-- AUTO_INCREMENT for table `theaters`
--
ALTER TABLE `theaters`
  MODIFY `theater_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_seats`
--
ALTER TABLE `booking_seats`
  ADD CONSTRAINT `booking_seats_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_seats_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`) ON DELETE CASCADE;

--
-- Constraints for table `halls`
--
ALTER TABLE `halls`
  ADD CONSTRAINT `halls_ibfk_1` FOREIGN KEY (`theater_id`) REFERENCES `theaters` (`theater_id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `schedules_ibfk_2` FOREIGN KEY (`hall_id`) REFERENCES `halls` (`hall_id`) ON DELETE CASCADE;

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`hall_id`) REFERENCES `halls` (`hall_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
