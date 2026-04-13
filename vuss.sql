-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 13, 2026 at 11:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS vuss;
USE vuss;

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
('842d820c2b92');

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
  `name` varchar(128) NOT NULL,
  `event_type` text DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT current_timestamp(),
  `sport_id` int(11) DEFAULT NULL,
  `venue_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `name`, `event_type`, `date_time`, `sport_id`, `venue_id`) VALUES
(17, 'Badminton event 2', NULL, '2026-04-13 11:00:00', 2, 8),
(19, 'cricket event', NULL, '2026-04-16 10:00:00', 1, 8),
(20, 'badminton event', NULL, '2026-04-16 11:00:00', 2, 9),
(21, 'cricket event 2', NULL, '2026-04-18 12:00:00', 1, 9),
(22, 'vollyball event 1', NULL, '2026-04-17 11:30:00', 3, 8);

-- --------------------------------------------------------

--
-- Table structure for table `event_registrations`
--

CREATE TABLE `event_registrations` (
  `id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_registrations`
--

INSERT INTO `event_registrations` (`id`, `participant_id`, `event_id`) VALUES
(24, 44, 17),
(26, 13, 19),
(25, 44, 19),
(27, 13, 21);

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
(46, NULL, 65, 2, NULL, NULL);

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
(9, 'pending', NULL, 11, 3),
(12, 'active', 6, 13, 1),
(13, 'active', 8, 13, 2),
(15, 'pending', NULL, 15, 2),
(19, 'pending', NULL, 18, 2),
(22, 'pending', NULL, 21, 2),
(23, 'active', 7, 21, 3),
(26, 'pending', NULL, 23, 2),
(27, 'pending', 7, 23, 3),
(28, 'active', 6, 24, 1),
(29, 'pending', NULL, 24, 2),
(35, 'pending', NULL, 28, 2),
(36, 'active', 6, 29, 1),
(37, 'active', 6, 30, 1),
(38, 'pending', NULL, 31, 2),
(39, 'active', 6, 32, 1),
(40, 'pending', NULL, 33, 2),
(41, 'active', 6, 34, 1),
(52, 'active', 7, 43, 3),
(53, 'active', 6, 44, 1),
(54, 'active', 8, 44, 2),
(55, 'active', 6, 45, 1),
(56, 'active', 7, 45, 3),
(57, 'active', 8, 46, 2),
(58, 'active', 7, 46, 3);

-- --------------------------------------------------------

--
-- Table structure for table `participant_performance`
--

CREATE TABLE `participant_performance` (
  `id` int(11) NOT NULL,
  `finish_time` int(11) NOT NULL,
  `recorded_at` datetime NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  `event_registration_id` int(11) NOT NULL,
  `recorded_by_coach_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_bests`
--

CREATE TABLE `personal_bests` (
  `id` int(11) NOT NULL,
  `best_time` int(11) NOT NULL,
  `achieved_at` datetime NOT NULL,
  `event_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `coach_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`, `max_participants`, `created_at`, `sport_id`, `coach_id`) VALUES
(6, 'Team 1', 11, '2026-03-26 13:55:53', 1, 6),
(7, 'Team 2', 11, '2026-03-26 13:56:06', 1, 6),
(8, 'Team 1', 7, '2026-03-26 14:51:05', 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `team_participants`
--

CREATE TABLE `team_participants` (
  `id` int(11) NOT NULL,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  `team_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_participants`
--

INSERT INTO `team_participants` (`id`, `joined_at`, `team_id`, `participant_id`) VALUES
(15, '2026-03-26 13:56:11', 7, 30),
(16, '2026-03-26 13:56:22', 7, 32),
(17, '2026-03-26 14:01:40', 7, 5),
(18, '2026-03-26 14:31:20', 6, 34),
(19, '2026-03-26 14:38:34', 7, 24),
(20, '2026-03-26 14:40:57', 6, 13),
(24, '2026-03-26 15:17:09', 6, 29);

-- --------------------------------------------------------

--
-- Table structure for table `team_statistics`
--

CREATE TABLE `team_statistics` (
  `id` int(11) NOT NULL,
  `total_events_participated` int(11) NOT NULL DEFAULT 0,
  `total_points` int(11) NOT NULL DEFAULT 0,
  `average_finish_time` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(5, 'hammad', 'hammad@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(7, 'admin', 'admin@example.com', '123456', 'ACTIVE', 'ADMIN'),
(9, 'Zubair Ali', 'test@mail.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(19, 'Jacob', 'jacob@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(22, 'Zameer', 'zameer@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(26, 'Junaid', 'junaid@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(28, 'Tariq', 'tariq@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(31, 'Faisal', 'faisal@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(34, 'Jahangir', 'jahangir@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(36, 'Musa', 'musa@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(37, 'Asif', 'asif@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(41, 'Mubashar', 'mubashar@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(42, 'Hamid', 'hamid@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(44, 'Tabasum', 'tabasum@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(45, 'Raheel', 'raheel@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(46, 'Ali', 'ali@example.com', '123456', 'ACTIVE', 'COACH'),
(48, 'Jawad', 'jawad@example.com', '123456', 'ACTIVE', 'COACH'),
(49, 'Aoun', 'aoun@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(50, 'Zeeshan', 'zeshan@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(51, 'Uzair', 'uzair@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(61, 'someparticipant', 'someparticipant@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(62, 'badminton coach', 'badminton@example.com', '123456', 'ACTIVE', 'COACH'),
(63, 'pcb', 'pcb@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(64, 'pcv', 'pcv@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(65, 'pbv', 'pbv@example.com', '123456', 'ACTIVE', 'PARTICIPANT');

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
  ADD UNIQUE KEY `date_time` (`date_time`),
  ADD KEY `sport_id` (`sport_id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_event_registration` (`event_id`,`participant_id`),
  ADD KEY `participant_id` (`participant_id`);

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
-- Indexes for table `participant_performance`
--
ALTER TABLE `participant_performance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_perf_event_reg` (`event_registration_id`),
  ADD KEY `recorded_by_coach_id` (`recorded_by_coach_id`);

--
-- Indexes for table `personal_bests`
--
ALTER TABLE `personal_bests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_participant_sport_pb` (`participant_id`,`sport_id`),
  ADD KEY `event_id` (`event_id`),
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
  ADD KEY `participant_id` (`participant_id`);

--
-- Indexes for table `team_statistics`
--
ALTER TABLE `team_statistics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_team_stats` (`team_id`);

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
-- AUTO_INCREMENT for table `coaches`
--
ALTER TABLE `coaches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `event_registrations`
--
ALTER TABLE `event_registrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `participants_sports`
--
ALTER TABLE `participants_sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `participant_performance`
--
ALTER TABLE `participant_performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_bests`
--
ALTER TABLE `personal_bests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `team_participants`
--
ALTER TABLE `team_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `team_statistics`
--
ALTER TABLE `team_statistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `coaches`
--
ALTER TABLE `coaches`
  ADD CONSTRAINT `coaches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `event_registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_registrations_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `participant_performance`
--
ALTER TABLE `participant_performance`
  ADD CONSTRAINT `participant_performance_ibfk_1` FOREIGN KEY (`event_registration_id`) REFERENCES `event_registrations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `participant_performance_ibfk_2` FOREIGN KEY (`recorded_by_coach_id`) REFERENCES `coaches` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `personal_bests`
--
ALTER TABLE `personal_bests`
  ADD CONSTRAINT `personal_bests_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `personal_bests_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `personal_bests_ibfk_3` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE CASCADE;

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

--
-- Constraints for table `team_statistics`
--
ALTER TABLE `team_statistics`
  ADD CONSTRAINT `team_statistics_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
