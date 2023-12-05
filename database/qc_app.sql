-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2023 at 08:41 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qc_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `level_process`
--

CREATE TABLE `level_process` (
  `id` int(11) NOT NULL,
  `level_id` varchar(100) NOT NULL,
  `process` varchar(100) NOT NULL,
  `step` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `level_table`
--

CREATE TABLE `level_table` (
  `id` int(11) NOT NULL,
  `level_number` varchar(100) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `no_of_repetitions` varchar(100) NOT NULL,
  `time_of_each_operation` varchar(100) NOT NULL,
  `type` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `level_test_report`
--

CREATE TABLE `level_test_report` (
  `id` int(11) NOT NULL,
  `level_id` varchar(100) NOT NULL,
  `run_no` int(10) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `cv` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `level_test_type`
--

CREATE TABLE `level_test_type` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `runs` int(100) NOT NULL,
  `is_blank` tinyint(1) NOT NULL,
  `is_insertion` tinyint(1) NOT NULL,
  `insertion_limit` int(10) NOT NULL,
  `is_water` tinyint(1) NOT NULL,
  `duration` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `level_test_type`
--

INSERT INTO `level_test_type` (`id`, `type`, `runs`, `is_blank`, `is_insertion`, `insertion_limit`, `is_water`, `duration`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Continuous Blank Test', 5, 1, 0, 0, 0, 15.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(2, 'Continuous Water Test', 5, 0, 0, 0, 1, 15.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(3, 'Re-insertion with Water Test', 3, 0, 1, 10, 1, 0.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(4, 'Re-insertion with Dye Test', 3, 0, 1, 10, 0, 0.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(5, 'Continuous Blank Test with Incubation', 5, 1, 0, 0, 0, 15.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(6, 'Continuous Water Test with Incubation', 5, 0, 0, 0, 1, 15.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL),
(7, 'Sensitivity Test', 10, 0, 1, 0, 0, 0.00, 1, '2023-12-04 06:49:06', '2023-12-04 06:34:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', '2023-12-04 05:22:12', NULL, NULL),
(2, 'trainee', '2023-12-04 05:22:20', NULL, NULL),
(3, 'full-time', '2023-12-04 05:22:29', NULL, NULL),
(4, 'dummy', '2023-12-04 08:41:09', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role` int(11) NOT NULL,
  `status` int(100) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `username`, `password`, `role`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Ankit C', 'ankit@gmail.com', '1234567890', 'ankit', '$2a$10$J5kRetCOUxCbsqn0szqJlu5ph3ewqqauyA8/kEkKS6Unyp6b.EdNa', 1, 0, '2023-12-04 05:25:38', NULL, NULL),
(2, 'Sanjib', 'sanjib@gmail.com', '1234567890', 'sanjib', '$2a$10$FQevkhfprse6TM8SC8pKWuYps6stdSR2hLmuw9VPL600CF3WM60My', 3, 0, '2023-12-04 05:28:45', NULL, NULL),
(3, 'Bijit', 'bijit@gmail.com', '1234567890', 'bijit', '$2a$10$NKrw5LYC2RKCXQG/jUN3oOA8aeWDEFOyWA5acJ/ZR1uyzp1u7w0sy', 2, 1, '2023-12-04 05:30:07', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `level_process`
--
ALTER TABLE `level_process`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level_table`
--
ALTER TABLE `level_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `level_test_type`
--
ALTER TABLE `level_test_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `level_process`
--
ALTER TABLE `level_process`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `level_table`
--
ALTER TABLE `level_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `level_test_type`
--
ALTER TABLE `level_test_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `level_table`
--
ALTER TABLE `level_table`
  ADD CONSTRAINT `level_table_ibfk_1` FOREIGN KEY (`type`) REFERENCES `level_test_type` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
