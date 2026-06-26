-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2026 at 06:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vuss`
--
CREATE DATABASE IF NOT EXISTS vuss;
use vuss;
-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `level` varchar(10) NOT NULL DEFAULT 'NORMAL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `user_id`, `level`) VALUES
(1, 7, 'NORMAL');

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('6f13b7934fbe');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sender_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `body`, `created_at`, `sender_id`) VALUES
(1, 'To all', 'This is announcement to all user of the system....', '2026-04-15 09:41:00', 7),
(2, 'To coaches only', 'this is announcement made for coaches only', '2026-04-15 09:48:51', 7),
(3, 'From Coach Ali (Cricket)', 'this is an announcemnt from caoch ali managing cricket and i hope it will go to the participants registered in cricket.', '2026-04-15 09:51:28', 46),
(4, 'From Badminton Coach', 'This is demo announcement sent to the participants registered for sport badminton', '2026-04-16 11:49:45', 62),
(5, 'Appear In upcoming Crick event', 'All the participants are required to joint the crick event....', '2026-04-16 11:52:11', 46),
(6, 'New Badminton Event Added', 'Attention All students ! .The new badminton event has been added . You can register here .', '2026-04-16 11:58:13', 7),
(8, 'Just testing the Announcement feature', 'This is just a test announcement to all of the system users.', '2026-05-11 06:24:08', 7);

-- --------------------------------------------------------

--
-- Table structure for table `announcement_recipients`
--

CREATE TABLE `announcement_recipients` (
  `id` int(11) NOT NULL,
  `announcement_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcement_recipients`
--

INSERT INTO `announcement_recipients` (`id`, `announcement_id`, `recipient_id`) VALUES
(1, 1, 5),
(2, 1, 9),
(3, 1, 19),
(4, 1, 22),
(5, 1, 26),
(6, 1, 28),
(7, 1, 31),
(8, 1, 34),
(9, 1, 36),
(10, 1, 37),
(11, 1, 41),
(12, 1, 42),
(13, 1, 44),
(14, 1, 45),
(15, 1, 46),
(16, 1, 48),
(17, 1, 49),
(18, 1, 50),
(19, 1, 51),
(20, 1, 61),
(21, 1, 62),
(22, 1, 63),
(23, 1, 64),
(24, 1, 65),
(25, 2, 46),
(26, 2, 48),
(27, 2, 62),
(28, 3, 5),
(29, 3, 26),
(30, 3, 37),
(31, 3, 42),
(32, 3, 44),
(33, 3, 49),
(34, 3, 51),
(35, 3, 63),
(36, 3, 64),
(37, 4, 26),
(38, 4, 28),
(39, 4, 31),
(40, 4, 34),
(41, 4, 36),
(42, 4, 37),
(43, 4, 41),
(44, 4, 45),
(45, 4, 50),
(46, 4, 63),
(47, 4, 65),
(51, 5, 5),
(52, 5, 37),
(49, 5, 44),
(50, 5, 49),
(54, 6, 5),
(55, 6, 9),
(56, 6, 19),
(57, 6, 22),
(58, 6, 26),
(59, 6, 28),
(60, 6, 31),
(61, 6, 34),
(62, 6, 36),
(63, 6, 37),
(64, 6, 41),
(65, 6, 42),
(66, 6, 44),
(67, 6, 45),
(68, 6, 46),
(69, 6, 48),
(70, 6, 49),
(71, 6, 50),
(72, 6, 51),
(73, 6, 61),
(74, 6, 62),
(75, 6, 63),
(76, 6, 64),
(77, 6, 65),
(103, 8, 5),
(104, 8, 9),
(105, 8, 19),
(106, 8, 22),
(107, 8, 26),
(108, 8, 28),
(109, 8, 31),
(110, 8, 34),
(111, 8, 36),
(112, 8, 37),
(113, 8, 41),
(114, 8, 42),
(115, 8, 44),
(116, 8, 45),
(117, 8, 46),
(118, 8, 48),
(119, 8, 49),
(120, 8, 50),
(121, 8, 51),
(122, 8, 61),
(123, 8, 62),
(124, 8, 63),
(125, 8, 64),
(126, 8, 65),
(127, 8, 68),
(128, 8, 69),
(129, 8, 70),
(130, 8, 71);

-- --------------------------------------------------------

--
-- Table structure for table `coaches`
--

CREATE TABLE `coaches` (
  `id` int(11) NOT NULL,
  `expertise` text NOT NULL,
  `availability` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coaches`
--

INSERT INTO `coaches` (`id`, `expertise`, `availability`, `user_id`) VALUES
(6, 'Coach Expertise goes here\r\n                        ', 1, 46),
(7, 'Coach Expertise goes here', 1, 48),
(8, 'Coach Expertise goes here', 1, 62);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `name` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `sport_id`, `start_date`, `end_date`, `name`) VALUES
(2, 1, '2026-05-08', '2026-05-14', 'Cricket Tournament'),
(3, 3, '2026-05-07', '2026-05-09', 'Vollyball Tournament'),
(4, 2, '2026-05-06', '2026-05-08', 'Badminton Tournament'),
(6, 1, '2026-05-12', '2026-05-15', 'Cricket Tournament FALL2025'),
(7, 2, '2026-05-10', '2026-05-13', 'Badminton Tournament'),
(8, 2, '2026-05-12', '2026-05-14', 'bd tournament');

-- --------------------------------------------------------

--
-- Table structure for table `event_registrations`
--

CREATE TABLE `event_registrations` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `approved` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_registrations`
--

INSERT INTO `event_registrations` (`id`, `participant_id`, `event_id`, `approved`) VALUES
(3, 13, 2, 1),
(4, 18, 4, 1),
(6, 49, 2, 1),
(7, 45, 3, 1),
(9, 44, 2, 1),
(11, 13, 7, 1),
(12, 23, 7, 1),
(13, 23, 8, 1),
(14, 28, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `event_team_status`
--

CREATE TABLE `event_team_status` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `team_phase_in_event` varchar(20) NOT NULL,
  `participant_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_team_status`
--

INSERT INTO `event_team_status` (`id`, `event_id`, `team_id`, `team_phase_in_event`, `participant_id`) VALUES
(4, 7, NULL, 'Winner', 23),
(5, 8, NULL, 'Winner', 23),
(6, 2, 9, 'Winner', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `match_type` varchar(10) NOT NULL,
  `match_stage` varchar(20) NOT NULL,
  `team1_id` int(11) DEFAULT NULL,
  `team2_id` int(11) DEFAULT NULL,
  `player1_id` int(11) DEFAULT NULL,
  `player2_id` int(11) DEFAULT NULL,
  `winner_participant_id` int(11) DEFAULT NULL,
  `winner_team_id` int(11) DEFAULT NULL,
  `venue_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`id`, `match_type`, `match_stage`, `team1_id`, `team2_id`, `player1_id`, `player2_id`, `winner_participant_id`, `winner_team_id`, `venue_id`, `event_id`, `date_time`) VALUES
(12, 'team', 'group-stage', 7, 9, NULL, NULL, NULL, 9, 9, 2, '2026-05-11 14:00:00'),
(13, 'single', 'group-stage', NULL, NULL, 21, 23, 23, NULL, 9, 7, '2026-05-11 09:00:00'),
(14, 'single', 'final', NULL, NULL, 23, 28, 23, NULL, 8, 8, '2026-05-12 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) NOT NULL,
  `receiver_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `content`, `timestamp`, `is_read`, `receiver_id`) VALUES
(1, 63, 'hi', '2026-04-18 06:26:07', 0, 22),
(2, 22, 'gettt', '2026-04-18 06:26:15', 0, 63),
(3, 63, 'hello how are you', '2026-04-18 06:26:33', 0, 22),
(4, 63, 'are you aware of the upcomming badminton event', '2026-04-18 06:28:10', 0, 22),
(5, 22, 'yes i am', '2026-04-18 06:28:18', 0, 63),
(6, 63, 'hi are you online', '2026-04-18 06:28:49', 0, 22),
(7, 63, 'hello', '2026-04-18 06:28:56', 0, 22),
(8, 63, 'hi', '2026-04-18 06:29:01', 0, 22),
(9, 63, 'yes what\'s up', '2026-04-18 06:33:37', 0, 22),
(10, 63, '', '2026-04-18 06:35:06', 0, 63),
(11, 63, '', '2026-04-18 06:35:07', 0, 63),
(12, 22, 'nothing just testing message functionality', '2026-04-18 06:36:14', 0, 63),
(13, 22, 'oh ok how did it go', '2026-04-18 06:40:43', 0, 63),
(14, 63, 'abi tk tou theek ja ree bs thori c configuration baqi hay', '2026-04-18 06:41:14', 0, 22),
(15, 22, 'chlo baqi b implement kr k btana phir', '2026-04-18 06:46:45', 0, 63),
(16, 63, 'ok hogya', '2026-04-18 06:46:52', 0, 22),
(17, 22, 'hi, junaid', '2026-04-18 06:49:02', 0, 26),
(18, 26, 'hello zammer', '2026-04-18 06:49:08', 0, 22),
(20, 26, 'Hi', '2026-04-18 09:07:52', 0, 46),
(21, 46, 'hy... why were you absent in today\'s event', '2026-04-18 09:08:33', 0, 26),
(22, 26, 'sorry sir.. i had an emergency at homme', '2026-04-18 09:08:48', 0, 46),
(23, 46, 'ok no problem be careful next time', '2026-04-18 09:29:59', 0, 26),
(24, 26, 'thanks a lot', '2026-04-18 14:29:20', 0, 46),
(25, 46, 'good', '2026-04-18 14:30:43', 0, 26),
(26, 26, 'once again thank you coach', '2026-04-18 14:41:13', 0, 46),
(27, 26, 'hi can i ask you one more thing', '2026-04-18 14:44:01', 0, 46),
(28, 26, 'helo', '2026-04-18 14:44:14', 0, 46),
(29, 26, 'hy are you online', '2026-04-18 14:44:26', 0, 46),
(30, 46, 'yes please', '2026-04-18 14:44:37', 0, 26),
(31, 46, '', '2026-04-18 14:44:42', 0, 26),
(32, 26, 'ok bye', '2026-04-18 14:49:35', 0, 46),
(33, 46, 'good', '2026-04-18 14:49:42', 0, 26),
(34, 26, 'teating', '2026-04-18 14:49:57', 0, 46),
(35, 46, 'tata', '2026-04-18 15:03:46', 0, 26),
(36, 46, 'bye', '2026-04-18 15:04:00', 0, 26),
(37, 26, 'bye bye', '2026-04-18 15:04:09', 0, 46),
(64, 26, 'hi', '2026-04-20 09:38:18', 0, 26),
(65, 26, 'hi', '2026-04-20 09:38:22', 0, 26);

-- --------------------------------------------------------

--
-- Table structure for table `participants`
--

CREATE TABLE `participants` (
  `id` int(11) NOT NULL,
  `university_id` varchar(14) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `max_sports_allowed` int(11) NOT NULL DEFAULT 2,
  `achievements` text DEFAULT NULL,
  `past_participation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `participants`
--

INSERT INTO `participants` (`id`, `university_id`, `user_id`, `max_sports_allowed`, `achievements`, `past_participation`) VALUES
(5, NULL, 5, 2, NULL, NULL),
(8, NULL, 9, 2, NULL, NULL),
(10, NULL, 19, 2, NULL, NULL),
(11, NULL, 22, 2, NULL, NULL),
(13, 'bc22002200', 26, 2, 'Man of the match in Final match of season 2024, Best player in vollyball 2023\r\n                        \r\n                        \r\n                        ', 'Cricket Tournament in 2024\r\n\r\n                        \r\n                        \r\n                        \r\n                        '),
(15, NULL, 28, 2, NULL, NULL),
(18, NULL, 31, 2, NULL, NULL),
(21, NULL, 34, 2, NULL, NULL),
(23, NULL, 36, 2, NULL, NULL),
(24, NULL, 37, 2, NULL, NULL),
(28, NULL, 41, 2, NULL, NULL),
(29, NULL, 42, 2, NULL, NULL),
(30, NULL, 44, 2, NULL, NULL),
(31, NULL, 45, 2, NULL, NULL),
(32, NULL, 49, 2, NULL, NULL),
(33, NULL, 50, 2, NULL, NULL),
(34, NULL, 51, 2, NULL, NULL),
(43, NULL, 61, 2, NULL, NULL),
(44, NULL, 63, 2, NULL, NULL),
(45, NULL, 64, 2, NULL, NULL),
(46, NULL, 65, 2, NULL, NULL),
(49, NULL, 68, 2, NULL, NULL),
(50, NULL, 69, 2, NULL, NULL),
(51, NULL, 70, 2, NULL, NULL),
(52, NULL, 71, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `participants_sports`
--

CREATE TABLE `participants_sports` (
  `id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `participant_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `participants_sports`
--

INSERT INTO `participants_sports` (`id`, `status`, `approved_by`, `participant_id`, `sport_id`) VALUES
(1, 'pending', NULL, 5, 2),
(2, 'active', 6, 5, 1),
(8, 'pending', NULL, 10, 2),
(9, 'active', 7, 11, 3),
(12, 'active', 6, 13, 1),
(13, 'active', 8, 13, 2),
(15, 'active', 8, 15, 2),
(19, 'active', 8, 18, 2),
(22, 'active', 8, 21, 2),
(23, 'active', 7, 21, 3),
(26, 'active', 8, 23, 2),
(27, 'active', 7, 23, 3),
(28, 'active', 6, 24, 1),
(29, 'active', 8, 24, 2),
(35, 'active', 8, 28, 2),
(36, 'active', 6, 29, 1),
(37, 'active', 6, 30, 1),
(38, 'active', 8, 31, 2),
(39, 'active', 6, 32, 1),
(40, 'active', 8, 33, 2),
(41, 'active', 6, 34, 1),
(52, 'active', 7, 43, 3),
(53, 'active', 6, 44, 1),
(54, 'active', 8, 44, 2),
(55, 'active', 6, 45, 1),
(56, 'active', 7, 45, 3),
(57, 'active', 8, 46, 2),
(58, 'active', 7, 46, 3),
(63, 'active', 6, 49, 1),
(64, 'pending', NULL, 49, 2),
(65, 'active', 6, 50, 1),
(66, 'pending', NULL, 51, 2),
(67, 'pending', NULL, 51, 3),
(68, 'active', 6, 52, 1),
(69, 'active', 8, 52, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

CREATE TABLE `sports` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `max_participants` int(11) DEFAULT NULL,
  `coach_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sports`
--

INSERT INTO `sports` (`id`, `name`, `description`, `max_participants`, `coach_id`) VALUES
(1, 'Cricket', NULL, NULL, 6),
(2, 'Badminton', NULL, NULL, 8),
(3, 'VollyBall', NULL, NULL, 7);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `max_participants` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sport_id` int(11) NOT NULL,
  `coach_id` int(11) NOT NULL,
  `approved` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`, `max_participants`, `created_at`, `sport_id`, `coach_id`, `approved`) VALUES
(7, 'Team 2', 11, '2026-03-26 13:56:06', 1, 6, 1),
(9, 'Cricket team 3', 11, '2026-04-23 14:04:23', 1, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `team_participants`
--

CREATE TABLE `team_participants` (
  `id` int(11) NOT NULL,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  `team_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `is_captain` tinyint(1) NOT NULL,
  `captain_team_id` int(11) GENERATED ALWAYS AS (case when `is_captain` then `team_id` else NULL end) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_participants`
--

INSERT INTO `team_participants` (`id`, `joined_at`, `team_id`, `participant_id`, `is_captain`) VALUES
(16, '2026-03-26 13:56:22', 7, 32, 0),
(17, '2026-03-26 14:01:40', 7, 5, 0),
(19, '2026-03-26 14:38:34', 7, 24, 0),
(27, '2026-04-23 14:05:38', 9, 50, 0),
(35, '2026-06-10 10:09:50', 7, 13, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('ACTIVE','PENDING','BLOCKED') NOT NULL,
  `role` enum('ADMIN','COACH','PARTICIPANT') NOT NULL
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `status`, `role`) VALUES
(5, 'hammad', 'hammad@example.com', 'scrypt:32768:8:1$qt9Ma8WsN5jgMfrr$14746fb8c853e12059e519461d1ada32f287f2c286dc687e629aa0083cf81c3428fe73ba6e231a437d3c9d2ef131bf8c29b34f2c2de4e4bc959f99f832cae99e', 'ACTIVE', 'PARTICIPANT'),
(7, 'admin', 'admin@example.com', 'scrypt:32768:8:1$E231oNyrMVyJWDBM$82d0b9ce9fbcbe9de0813e6fb24ac21a99631c19c9fabb9b77004e66f5e48d6856fcc9419e846f3f57a1622f4cd2e776140c114d19b92f00f2997293026e8c70', 'ACTIVE', 'ADMIN'),
(9, 'Zubair Ali', 'test@mail.com', 'scrypt:32768:8:1$RgPlbS9cNXn5VrVz$b4b6e110f64a31678ba03f2f7d0f32da3b3c5026d615a0ca9f0ca223fe5abf215aedef4a4f7548a54a2a87302ff270354f8b5146ce676fe83b84aa2c55875cc1', 'ACTIVE', 'PARTICIPANT'),
(19, 'Jacob', 'jacob@example.com', 'scrypt:32768:8:1$Zrl3kJqHdCSrxSp9$b52b4a23b0ddcc7aa4b8b3e19b87d44be54f7c82ea4afbae7a771f5d62a57f4adada155eca9f812055ac767aef3e05e622fe074d1b5427033e192f20edb92ad8', 'ACTIVE', 'PARTICIPANT'),
(22, 'Zameer', 'zameer@example.com', 'scrypt:32768:8:1$BWRKfjP4vkBAURIs$2e4b8e240f13b81ac05417b9c04be3ea9021f326918c4728967c0dc8553b815cec31bbdbd47aa25e246329c1f19c219e03e078547b8d3e2df14be31ed199ef9e', 'ACTIVE', 'PARTICIPANT'),
(26, 'Junaid', 'junaid@example.com', 'scrypt:32768:8:1$pO9Azrwc7fuUDoaN$93cc100d2c792b8c9031b994c893e8a08ca5021816d18b94f900d7ccb80f2cc01fa9b5e52f377b254e1dab8fa192f62c275086d5d6a74a5daadd6c2f511d413d', 'ACTIVE', 'PARTICIPANT'),
(28, 'Tariq', 'tariq@example.com', 'scrypt:32768:8:1$r0MrlhAF58FnP4xC$84f24a3e8ab770793070b559fb86c55f2ec88f181f22e7b89cb4eabc8c93e9543943a7759c637c9008353bde14619ce0132dc46d3c157c60cb500e4177c5b9c0', 'ACTIVE', 'PARTICIPANT'),
(31, 'Faisal', 'faisal@example.com', 'scrypt:32768:8:1$VjfNCgzL0jNhcOsB$eb3d72b4a765c48d376c34f6063efb29e0137449d802086d62fc69280c27f59de3e61504bb5993f2f0bf4a87f4bb04f5e74c3d40d01f5b7db14b2f8c34beecf1', 'ACTIVE', 'PARTICIPANT'),
(34, 'Jahangir', 'jahangir@example.com', 'scrypt:32768:8:1$ihkooIazhhD03lFu$4dd6b6d9be6d85ae3ad92f02c04a9d341323573af817e7a704253bdbd1cb561a2bc01f522120448955fb485319df0d03b52b116eb3d2d4d7e9422217f8acde76', 'ACTIVE', 'PARTICIPANT'),
(36, 'Musa', 'musa@example.com', 'scrypt:32768:8:1$GgIoi724QSiFdGgp$ec4d9924c5270ffa84dd9322e07edc898b1bca579469c71dd677a38d9433043749d18fae365427bde8153a86ce6853ec1e2ebfdbf1fadc85365a27afd295acb5', 'ACTIVE', 'PARTICIPANT'),
(37, 'Asif', 'asif@example.com', 'scrypt:32768:8:1$66uzqGKI3my7LjKl$0204c16d61243999ef7e18427a6437fa2c059a944a40e3f17b2d4f433ec4f876206580dd9749a91428a920ae4fed4c7f546433d0842a78349e4ebd801713e4bc', 'ACTIVE', 'PARTICIPANT'),
(41, 'Mubashar', 'mubashar@example.com', 'scrypt:32768:8:1$gwJKwjTkEabcmY5A$78665b5a40e644976395c834b85641cc279d6415d21e050cc7e6b9816d22f7517bea3206e9907a0089f640d2fd3f25f5a80f6dccefc8f69387e28c71852bd8b6', 'ACTIVE', 'PARTICIPANT'),
(42, 'Hamid', 'hamid@example.com', 'scrypt:32768:8:1$CAUIOX8qgWMb864I$af989ff345e140c00a46841c0e4fa30a9ddd5023c670a20c612d98fb5d4e583d1744d769ab631ddadf178da995b920cdc728869c5bdfe449f6ddd4dc17391233', 'ACTIVE', 'PARTICIPANT'),
(44, 'Tabasum', 'tabasum@example.com', 'scrypt:32768:8:1$CSHyDqYSfkb7TTMO$e3059f08f1077fd3922b80cd696fa6db06660062fb8a2322e59e971c6b39bf6dcc3fcc5d6906610506ff5e5bb90f8629c06deacd88f125c256a80fd8c909481d', 'ACTIVE', 'PARTICIPANT'),
(45, 'Raheel', 'raheel@example.com', 'scrypt:32768:8:1$5ysJ567J8BT5coU5$dd68ca078747d1465c10687df5b638aa6fd719fec897ceb1d8f5790486130f142d76a33a8848b7d30dc265a1ad1650ca6f4659e8348fd0952da1be5276428b4f', 'ACTIVE', 'PARTICIPANT'),
(46, 'Ali', 'ali@example.com', 'scrypt:32768:8:1$NtJ8COUMe2ZTgewM$7dcb12d3687bc6ad7d2b7443ce64364087e55fa058eee6978f00b2bde96cf3a31bc5589a0fa54df9028c38496e887afb41c95ba9313100a160c43a538ef16e1f', 'ACTIVE', 'COACH'),
(48, 'Jawad', 'jawad@example.com', 'scrypt:32768:8:1$JfXIKT1SOUS0oFXl$be0e6e61a2b60a0d6d29a04adca3104427d01264d8897c6ad540942e7797b655e859696506a0a4559e4de6f5c65f35ced4a45d656167d276478fa91d2f1f07be', 'ACTIVE', 'COACH'),
(49, 'Aoun', 'aoun@example.com', 'scrypt:32768:8:1$U2ulcFb6oVriyC67$403fa560e9f4d68fb1ca98523d3a2dfedf2e00348938d6afe7bbdd3e18359e768e49295d200e2c703eebbd7a008ff24fe37f016f7c7c5bab4f9c130136c9ed18', 'ACTIVE', 'PARTICIPANT'),
(50, 'Zeeshan', 'zeshan@example.com', 'scrypt:32768:8:1$17QBrYnECi3igjSm$7d42f7c88553ddb299318c54ee8c14dc029a5a0508236fe9a968475c087591979016b1fe5dc811afe6aefe593218ebcd2a824202835a442a53dac216023556b0', 'ACTIVE', 'PARTICIPANT'),
(51, 'Uzair', 'uzair@example.com', 'scrypt:32768:8:1$SA8H7Zu3IRJJiqBC$458759a941444a4c8165055114b189a8525a91ca8b4a7322afdf327c7c6ff7845b9e26d1b6a5cd42f6d5a5c4bbb78459468da2c8013b3bc8a6f793f8210f91c9', 'ACTIVE', 'PARTICIPANT'),
(61, 'someparticipant', 'someparticipant@example.com', 'scrypt:32768:8:1$byV6FLBNLdF0mEEG$e59fe23568d72c46acef1d5239c78342ade81aad4ebef31ab8770e700d99b2aa991efd0d7b789ad93bc837e4a6334713b2f4036c657729ed43d74cd68e85d711', 'ACTIVE', 'PARTICIPANT'),
(62, 'badminton coach', 'badminton@example.com', 'scrypt:32768:8:1$KggZCoWPBjdbrXR4$79ef92c7ef887c54b07710e73ffa5244547b3109c707ab365852cb60de4581a09750e92c7d7ca8fb84861e469263b018582d277b145f45c92057e428e9f6292a', 'ACTIVE', 'COACH'),
(63, 'pcb', 'pcb@example.com', 'scrypt:32768:8:1$h7NeREvu3cTw11aM$52702b126c1049353cc1fc62e638adb498ee7b0fce9b79c281cc3fde410437608caf9445736d72da623ae121d32bdde907c215982133046bd9a620068db46356', 'ACTIVE', 'PARTICIPANT'),
(64, 'pcv', 'pcv@example.com', 'scrypt:32768:8:1$qjviLOJrZbitnZr3$49e8775cc1c89e19461533613cac934b4039ab1fcb06b194dcc9199b89993d7de12e245d67c0dee6ea792c14769f43d6201ab928b12a38c88acc47c0a79f8e0a', 'ACTIVE', 'PARTICIPANT'),
(65, 'pbv', 'pbv@example.com', 'scrypt:32768:8:1$Y2fOz23FpyzV5KzR$0dfada1391d7c2d1d4914c71af8af9854ae61a65d55eb3407aaf76b92f608f621e3a6e49db639e48db86ed9687034b1e85f819ffe5fca4c61fdbafb2bc21e1f0', 'ACTIVE', 'PARTICIPANT'),
(68, 'Hammad Ali', 'hamadalich1578@gmail.com', 'scrypt:32768:8:1$SvBEQ23fdHKFQrAa$d97e1c2e0bc15930cef321e172b4599f92d1f6a7c3f84cdd19a12c35d5fa667cdb3ac9f921cfc6d3f627d51daee4aaadac82888236c888618280d3f392cd259d', 'ACTIVE', 'PARTICIPANT'),
(69, 'Mubashar Ali ', 'mubali2007@gmail.com', 'scrypt:32768:8:1$4lS23i827z9fy94w$457aa518821f3063635a8d3400417d1cebc9b70ddf4d417dc1105d97c3fa651bdd020b3116541ed74310b546f45d46919731c417cb8a9b63b8cf0aaa6f7b6f8c', 'ACTIVE', 'PARTICIPANT'),
(70, 'ishfaq', 'ishfaq@example.com', 'scrypt:32768:8:1$x9lUH6U7DAX8XTqf$78674d3adc010137af3480c9015b82b3c550b7411ee082414ce50b7edccfd2c3f9eae14fbf15b25f270ac779abc43835379045248b490438a1f3a55102478a8f', 'ACTIVE', 'PARTICIPANT'),
(71, 'demo', 'demo@example.com', 'scrypt:32768:8:1$HQZv30rkU3MiTW8w$b98030abe45a6a720be2799714590e9c6d680006e00c5f0d41a4d485c50087f26fdfaf8349a04c0fbdf76f2a348673b7265588c47629fd6b81a307c9afb9a030', 'ACTIVE', 'PARTICIPANT');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(11) NOT NULL,
  `location` text NOT NULL,
  `availability` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `location`, `availability`) VALUES
(8, 'venue 1', 1),
(9, 'venue 2', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `announcement_recipients`
--
ALTER TABLE `announcement_recipients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_announcement_recipient` (`announcement_id`,`recipient_id`),
  ADD KEY `recipient_id` (`recipient_id`);

--
-- Indexes for table `coaches`
--
ALTER TABLE `coaches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sport_id` (`sport_id`);

--
-- Indexes for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_event_registration` (`event_id`,`participant_id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- Indexes for table `event_team_status`
--
ALTER TABLE `event_team_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_match` (`date_time`,`venue_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `player1_id` (`player1_id`),
  ADD KEY `player2_id` (`player2_id`),
  ADD KEY `team1_id` (`team1_id`),
  ADD KEY `team2_id` (`team2_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `winner_participant_id` (`winner_participant_id`),
  ADD KEY `winner_team_id` (`winner_team_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `participants_sports`
--
ALTER TABLE `participants_sports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_participant_sport` (`participant_id`,`sport_id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `sport_id` (`sport_id`);

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `coach_id` (`coach_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coach_id` (`coach_id`),
  ADD KEY `sport_id` (`sport_id`);

--
-- Indexes for table `team_participants`
--
ALTER TABLE `team_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_team_participant` (`team_id`,`participant_id`),
  ADD UNIQUE KEY `uq_one_captain_per_team` (`captain_team_id`),
  ADD KEY `participant_id` (`participant_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `announcement_recipients`
--
ALTER TABLE `announcement_recipients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `coaches`
--
ALTER TABLE `coaches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_registrations`
--
ALTER TABLE `event_registrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `event_team_status`
--
ALTER TABLE `event_team_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `participants_sports`
--
ALTER TABLE `participants_sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `team_participants`
--
ALTER TABLE `team_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `announcement_recipients`
--
ALTER TABLE `announcement_recipients`
  ADD CONSTRAINT `announcement_recipients_ibfk_1` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcement_recipients_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coaches`
--
ALTER TABLE `coaches`
  ADD CONSTRAINT `coaches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `event_registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_registrations_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_team_status`
--
ALTER TABLE `event_team_status`
  ADD CONSTRAINT `event_team_status_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_team_status_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_team_status_ibfk_3` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`player1_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matches_ibfk_3` FOREIGN KEY (`player2_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matches_ibfk_4` FOREIGN KEY (`team1_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matches_ibfk_5` FOREIGN KEY (`team2_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matches_ibfk_6` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`),
  ADD CONSTRAINT `matches_ibfk_7` FOREIGN KEY (`winner_participant_id`) REFERENCES `participants` (`id`),
  ADD CONSTRAINT `matches_ibfk_8` FOREIGN KEY (`winner_team_id`) REFERENCES `teams` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `participants`
--
ALTER TABLE `participants`
  ADD CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `participants_sports`
--
ALTER TABLE `participants_sports`
  ADD CONSTRAINT `participants_sports_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `participants_sports_ibfk_3` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `participants_sports_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `coaches` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sports`
--
ALTER TABLE `sports`
  ADD CONSTRAINT `sports_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `teams`
--
ALTER TABLE `teams`
  ADD CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coaches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `teams_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `team_participants`
--
ALTER TABLE `team_participants`
  ADD CONSTRAINT `team_participants_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `team_participants_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
