-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 26, 2026 at 01:21 PM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `khatabook`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `created_at`) VALUES
(2, 'Akash', '9123456780', '2026-03-26 04:33:40'),
(3, 'Sachin', '9012345678', '2026-03-26 04:33:40'),
(5, 'devid', '9054702563', '2026-03-26 06:33:02'),
(6, 'devid', '9054702563', '2026-03-26 07:53:09'),
(7, '123', '123', '2026-03-26 08:14:56');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `type` enum('Gave','Got') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `trans_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `customer_id`, `type`, `amount`, `note`, `trans_date`, `created_at`) VALUES
(4, 2, 'Got', 1000.00, 'Advance payment', '2026-03-02', '2026-03-26 04:33:53'),
(5, 2, 'Gave', 400.00, 'Goods purchase', '2026-03-06', '2026-03-26 04:33:53'),
(6, 3, 'Gave', 700.00, 'Loan diya', '2026-03-03', '2026-03-26 04:33:53'),
(33, 7, 'Got', 123.00, '', '2026-03-26', '2026-03-26 08:15:04'),
(32, 6, 'Got', 234234.00, '', '2026-03-26', '2026-03-26 07:54:35'),
(31, 6, 'Got', 123213.00, '', '2026-03-26', '2026-03-26 07:54:32'),
(30, 6, 'Got', 1232131.00, '', '2026-03-26', '2026-03-26 07:54:30'),
(29, 6, 'Got', 123.00, '', '2026-03-26', '2026-03-26 07:54:26'),
(27, 3, 'Got', 1111.00, '', '2026-03-26', '2026-03-26 07:45:02'),
(26, 2, 'Got', 1111.00, '', '2026-03-26', '2026-03-26 07:44:54'),
(25, 2, 'Gave', 1111.00, '', '2026-03-26', '2026-03-26 07:44:34'),
(22, 5, 'Got', 1.00, '', '2026-03-26', '2026-03-26 07:23:48');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
