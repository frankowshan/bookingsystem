-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2026 at 03:11 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booking_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `room_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `booking_type` enum('room','service','event') DEFAULT 'room',
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `booking_date` date NOT NULL,
  `booking_time` time DEFAULT NULL,
  `guests` int DEFAULT '1',
  `status` enum('pending','confirmed','checked_in','checked_out','completed','cancelled') DEFAULT 'pending',
  `special_requests` text,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','partial','paid','refunded') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`),
  KEY `service_id` (`service_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `room_id`, `service_id`, `booking_type`, `check_in_date`, `check_out_date`, `booking_date`, `booking_time`, `guests`, `status`, `special_requests`, `total_amount`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'room', '2026-04-04', '2026-04-06', '2026-03-29', NULL, 2, 'checked_in', '453534', 199.98, 'pending', '2026-03-29 14:38:00', '2026-03-29 14:38:53');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price_per_night` decimal(10,2) NOT NULL,
  `capacity` int DEFAULT '2',
  `size_sqm` int DEFAULT NULL,
  `bed_type` varchar(50) DEFAULT NULL,
  `amenities` text,
  `image_url` varchar(255) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `category_id`, `room_number`, `name`, `description`, `price_per_night`, `capacity`, `size_sqm`, `bed_type`, `amenities`, `image_url`, `is_available`, `is_active`, `created_at`) VALUES
(1, 1, '101', 'Standard Single Room', 'Cozy single room perfect for solo travelers', 99.99, 1, 25, 'Single Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe', NULL, 0, 1, '2026-03-29 14:37:49'),
(2, 1, '102', 'Standard Double Room', 'Comfortable double room with modern amenities', 149.99, 2, 30, 'Queen Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe', NULL, 1, 1, '2026-03-29 14:37:49'),
(3, 1, '103', 'Standard Twin Room', 'Room with two twin beds', 139.99, 2, 28, 'Twin Beds', 'WiFi, TV, Air Conditioning, Mini Bar, Safe', NULL, 1, 1, '2026-03-29 14:37:49'),
(4, 2, '201', 'Deluxe King Room', 'Spacious room with king bed and city views', 249.99, 2, 45, 'King Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Balcony, City View, Premium Toiletries', NULL, 1, 1, '2026-03-29 14:37:49'),
(5, 2, '202', 'Deluxe Twin Room', 'Large room with twin beds', 229.99, 2, 40, 'Twin Beds', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Balcony', NULL, 1, 1, '2026-03-29 14:37:49'),
(6, 2, '203', 'Deluxe Double Room', 'Premium double room', 269.99, 2, 50, 'Queen Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Balcony, Ocean View', NULL, 1, 1, '2026-03-29 14:37:49'),
(7, 3, '301', 'Executive Suite', 'Luxurious suite with separate living area', 449.99, 3, 65, 'King Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Living Room, Bathtub, Premium Toiletries', NULL, 1, 1, '2026-03-29 14:37:49'),
(8, 3, '302', 'Junior Suite', 'Elegant suite with cozy living space', 399.99, 2, 55, 'King Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Living Area, Bathtub', NULL, 1, 1, '2026-03-29 14:37:49'),
(9, 4, '401', 'Presidential Suite', 'The ultimate luxury experience', 999.99, 4, 120, 'King Bed', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Living Room, Dining Room, Private Jacuzzi, Butler Service', NULL, 1, 1, '2026-03-29 14:37:49'),
(10, 5, '501', 'Family Room Deluxe', 'Perfect for families with kids', 349.99, 4, 55, 'Queen + Twin', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Kids Corner, Two Bathrooms', NULL, 1, 1, '2026-03-29 14:37:49'),
(11, 5, '502', 'Family Suite', 'Spacious family accommodation', 399.99, 5, 70, 'King + Bunk', 'WiFi, TV, Air Conditioning, Mini Bar, Safe, Kids Area, Game Console', NULL, 1, 1, '2026-03-29 14:37:49');

-- --------------------------------------------------------

--
-- Table structure for table `room_categories`
--

DROP TABLE IF EXISTS `room_categories`;
CREATE TABLE IF NOT EXISTS `room_categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `icon` varchar(50) DEFAULT 'hotel',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `room_categories`
--

INSERT INTO `room_categories` (`category_id`, `name`, `description`, `icon`, `is_active`) VALUES
(1, 'Standard Room', 'Comfortable rooms with essential amenities', 'hotel', 1),
(2, 'Deluxe Room', 'Spacious rooms with premium amenities', 'bed', 1),
(3, 'Suite', 'Luxurious suites with separate living area', 'meeting_room', 1),
(4, 'Presidential Suite', 'Ultimate luxury with exclusive features', 'stars', 1),
(5, 'Family Room', 'Perfect for families', 'family_restroom', 1);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `duration_minutes` int DEFAULT NULL,
  `icon` varchar(50) DEFAULT 'spa',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`service_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `category_id`, `name`, `description`, `price`, `duration_minutes`, `icon`, `is_active`, `created_at`) VALUES
(2, 1, 'Deep Tissue Massage', 'Intensive therapy for muscle tension', 119.99, 95, 'self_improvement', 1, '2026-03-29 14:37:49'),
(3, 1, 'Hot Stone Therapy', 'Heated basalt stone treatment', 149.99, 75, 'whatshot', 1, '2026-03-29 14:37:49'),
(4, 1, 'Aromatherapy Treatment', 'Relaxing essential oil treatment', 79.99, 45, 'local_florist', 1, '2026-03-29 14:37:49'),
(5, 2, 'Fine Dining Experience', 'Gourmet 5-course meal', 199.99, 120, 'restaurant', 1, '2026-03-29 14:37:49'),
(6, 2, 'Buffet Breakfast', 'International breakfast buffet', 45.00, 60, 'free_breakfast', 1, '2026-03-29 14:37:49'),
(7, 2, 'Afternoon Tea Service', 'Traditional afternoon tea', 55.00, 60, 'local_cafe', 1, '2026-03-29 14:37:49'),
(8, 3, 'Infinity Pool Access', 'Rooftop pool with views', 35.00, NULL, 'pool', 1, '2026-03-29 14:37:49'),
(9, 3, 'Pool Cabana Rental', 'Private pool cabana', 89.99, 240, 'beach_access', 1, '2026-03-29 14:37:49'),
(10, 4, 'Fitness Center Access', '24/7 gym access', 25.00, NULL, 'fitness_center', 1, '2026-03-29 14:37:49'),
(11, 4, 'Personal Training Session', 'One-on-one training', 75.00, 60, 'sports_gymnastics', 1, '2026-03-29 14:37:49'),
(12, 4, 'Yoga Class', 'Group yoga session', 35.00, 60, 'accessibility_new', 1, '2026-03-29 14:37:49'),
(13, 5, 'Airport Transfer', 'Luxury car transfer', 75.00, NULL, 'local_taxi', 1, '2026-03-29 14:37:49'),
(14, 5, 'City Tour', 'Guided tour of attractions', 149.99, 240, 'tour', 1, '2026-03-29 14:37:49');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','admin','staff') DEFAULT 'customer',
  `avatar` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `phone`, `password`, `role`, `avatar`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@luxuryhotel.com', '+1 234 567 8901', 'admin123', 'admin', NULL, 1, '2026-03-29 14:37:49', '2026-03-29 14:37:49');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
