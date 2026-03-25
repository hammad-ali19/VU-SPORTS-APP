-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2026 at 08:11 AM
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
--
-- Database: `vuss`
--

--
-- Demo changes in database
--


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
('89bdab385fcd');

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
(6, 'Coach Expertise goes here', 1, 46),
(7, 'Coach Expertise goes here', 1, 48);

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
(12, NULL, 23, 2, NULL, NULL),
(13, NULL, 26, 2, NULL, NULL),
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
(34, NULL, 51, 2, NULL, NULL);

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
(10, 'pending', NULL, 12, 1),
(11, 'pending', NULL, 12, 3),
(12, 'pending', NULL, 13, 1),
(13, 'pending', NULL, 13, 2),
(15, 'pending', NULL, 15, 2),
(19, 'pending', NULL, 18, 2),
(22, 'pending', NULL, 21, 2),
(23, 'pending', NULL, 21, 3),
(26, 'pending', NULL, 23, 2),
(27, 'pending', NULL, 23, 3),
(28, 'pending', NULL, 24, 1),
(29, 'pending', NULL, 24, 2),
(35, 'pending', NULL, 28, 2),
(36, 'pending', NULL, 29, 1),
(37, 'active', 6, 30, 1),
(38, 'pending', NULL, 31, 2),
(39, 'active', 6, 32, 1),
(40, 'pending', NULL, 33, 2),
(41, 'active', 6, 34, 1);

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
(2, 'Badminton', NULL, NULL, NULL),
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
(4, 'team a', 11, '2026-03-24 08:32:44', 1, 6);

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
(5, 'hammad', 'hammad@example.com', '123', 'ACTIVE', 'PARTICIPANT'),
(7, 'admin', 'admin@example.com', '123', 'ACTIVE', 'ADMIN'),
(9, 'Zubair Ali', 'test@mail.com', '123', 'ACTIVE', 'PARTICIPANT'),
(19, 'Jacob', 'jacob@example.com', '123', 'ACTIVE', 'PARTICIPANT'),
(22, 'Zameer', 'zameer@example.com', '123', 'ACTIVE', 'PARTICIPANT'),
(23, 'Rashid Azim', 'rashid@example.com', '123', 'BLOCKED', 'PARTICIPANT'),
(26, 'Junaid', 'junaid@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(28, 'Tariq', 'tariq@example.com', '123456', 'ACTIVE', 'PARTICIPANT'),
(31, 'Faisal', 'faisal@example.com', '123456', 'BLOCKED', 'PARTICIPANT'),
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
(51, 'Uzair', 'uzair@example.com', '123456', 'ACTIVE', 'PARTICIPANT');

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
(8, 'venue 1', 1);

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
-- AUTO_INCREMENT for table `coaches`
--
ALTER TABLE `coaches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `participants`
--
ALTER TABLE `participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `participants_sports`
--
ALTER TABLE `participants_sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `team_participants`
--
ALTER TABLE `team_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
