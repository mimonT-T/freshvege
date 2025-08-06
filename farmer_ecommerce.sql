-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 06, 2025 at 10:07 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `farmer_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'Vegetables', 'Fresh vegetables and leafy greens from local farms', '2025-08-06 19:34:31'),
(2, 'Fruits', 'Seasonal fresh fruits from Bangladesh', '2025-08-06 19:34:31'),
(3, 'Grains', 'Rice, wheat, and other local grains', '2025-08-06 19:34:31'),
(4, 'Pulses', 'Dal, lentils, beans, and legumes', '2025-08-06 19:34:31'),
(5, 'Spices', 'Fresh and dried Bangladeshi spices', '2025-08-06 19:34:31'),
(6, 'Herbs', 'Fresh herbs and medicinal plants', '2025-08-06 19:34:31'),
(7, 'Dried', 'Dried fruits, nuts and preserved items', '2025-08-06 19:34:31'),
(8, 'Juices', 'Fresh fruit juices and drinks', '2025-08-06 19:34:31');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'USA',
  `status` enum('active','inactive','blocked') DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `first_name`, `last_name`, `email`, `phone`, `password_hash`, `date_of_birth`, `gender`, `address`, `city`, `state`, `postal_code`, `country`, `status`, `email_verified`, `created_at`, `updated_at`) VALUES
(1, 'Raiyan', 'Rahman', 'raiyan.rahman@gmail.com', '01712223334', '$2y$10$example_hash_here', NULL, NULL, 'House 42, Road 15, Dhanmondi', 'Dhaka', 'Dhaka Division', '1209', 'USA', 'active', 0, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(2, 'Sharmin', 'Akter', 'sharmin.akter@yahoo.com', '01823334445', '$2y$10$example_hash_here', NULL, NULL, 'Flat B3, Green View Apartment, Uttara', 'Dhaka', 'Dhaka Division', '1230', 'USA', 'active', 0, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(3, 'Garreth', 'Smith', 'garreth.smith@gmail.com', '01934445556', '$2y$10$example_hash_here', NULL, NULL, 'House 78, CDA Residential Area', 'Chattogram', 'Chattogram Division', '4000', 'USA', 'active', 0, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(4, 'Nusrat', 'Jahan', 'nusrat.jahan@outlook.com', '01645556667', '$2y$10$example_hash_here', NULL, NULL, 'Village: Goaldoba, Thana: Sadar', 'Rangpur', 'Rangpur Division', '5400', 'USA', 'active', 0, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(5, 'Mohammad', 'Hasan', 'hasan.mohammad@gmail.com', '01756667778', '$2y$10$example_hash_here', NULL, NULL, 'Nasirabad Housing, GEC Circle', 'Chattogram', 'Chattogram Division', '4000', 'USA', 'active', 0, '2025-08-06 19:34:32', '2025-08-06 19:34:32');

-- --------------------------------------------------------

--
-- Table structure for table `farmers`
--

CREATE TABLE `farmers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `farmers`
--

INSERT INTO `farmers` (`id`, `name`, `email`, `phone`, `address`, `city`, `state`, `postal_code`, `created_at`, `updated_at`) VALUES
(1, 'Rahim Hasnat', 'rahim.farmer@gmail.com', '01712345678', 'Hasnat Bari, Char Dighaldi', 'Chattogram', 'Chattogram Division', '4000', '2025-08-06 19:34:31', '2025-08-06 19:34:31'),
(2, 'Abrar Sayed Tasin', 'tasin.krishi@yahoo.com', '01823456789', 'Tasin Farm, Jatrabari Road', 'Dhaka', 'Dhaka Division', '1204', '2025-08-06 19:34:31', '2025-08-06 19:34:31'),
(3, 'Kuddus Ali', 'kuddusali.farm@gmail.com', '01934567890', 'Ali Bari, Godagari', 'Rajshahi', 'Rajshahi Division', '6100', '2025-08-06 19:34:31', '2025-08-06 19:34:31'),
(4, 'Fatema Begum', 'fatema.organic@hotmail.com', '01645678901', 'Begum Krishi Farm, Savar', 'Dhaka', 'Dhaka Division', '1340', '2025-08-06 19:34:31', '2025-08-06 19:34:31'),
(5, 'Abdul Karim', 'karim.vegetables@gmail.com', '01756789012', 'Karim Bagan, Comilla Sadar', 'Cumilla', 'Chattogram Division', '3500', '2025-08-06 19:34:31', '2025-08-06 19:34:31'),
(6, 'Nasir Uddin', 'nasir.fruits@yahoo.com', '01867890123', 'Nasir Orchard, Dinajpur Sadar', 'Dinajpur', 'Rangpur Division', '5200', '2025-08-06 19:34:31', '2025-08-06 19:34:31');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `payment_status` enum('pending','paid','failed','refunded') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `billing_address` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `order_number`, `total_amount`, `status`, `payment_status`, `payment_method`, `shipping_address`, `billing_address`, `notes`, `order_date`, `delivery_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'ORD-2024-001', 285.00, 'delivered', 'paid', NULL, 'House 42, Road 15, Dhanmondi, Dhaka 1209', NULL, NULL, '2025-08-06 19:34:32', NULL, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(2, 2, 'ORD-2024-002', 450.00, 'processing', 'paid', NULL, 'Flat B3, Green View Apartment, Uttara, Dhaka 1230', NULL, NULL, '2025-08-06 19:34:32', NULL, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(3, 3, 'ORD-2024-003', 180.00, 'pending', 'pending', NULL, 'House 78, CDA Residential Area, Chattogram 4000', NULL, NULL, '2025-08-06 19:34:32', NULL, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(4, 4, 'ORD-2024-004', 320.00, 'shipped', 'paid', NULL, 'Village: Goaldoba, Thana: Sadar, Rangpur 5400', NULL, NULL, '2025-08-06 19:34:32', NULL, '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(5, 5, 'ORD-2024-005', 95.00, 'confirmed', 'paid', NULL, 'Nasirabad Housing, GEC Circle, Chattogram 4000', NULL, NULL, '2025-08-06 19:34:32', NULL, '2025-08-06 19:34:32', '2025-08-06 19:34:32');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `total_price`, `created_at`) VALUES
(1, 1, 1, 2.00, 80.00, 160.00, '2025-08-06 19:34:32'),
(2, 1, 5, 1.50, 75.00, 112.50, '2025-08-06 19:34:32'),
(3, 1, 19, 1.00, 18.00, 18.00, '2025-08-06 19:34:32'),
(4, 2, 11, 3.00, 150.00, 450.00, '2025-08-06 19:34:32'),
(5, 3, 9, 2.00, 80.00, 160.00, '2025-08-06 19:34:32'),
(6, 3, 19, 1.00, 20.00, 20.00, '2025-08-06 19:34:32'),
(7, 4, 14, 2.00, 55.00, 110.00, '2025-08-06 19:34:32'),
(8, 4, 17, 1.50, 110.00, 165.00, '2025-08-06 19:34:32'),
(9, 4, 21, 0.50, 180.00, 90.00, '2025-08-06 19:34:32'),
(10, 5, 7, 1.00, 70.00, 70.00, '2025-08-06 19:34:32'),
(11, 5, 23, 0.50, 40.00, 20.00, '2025-08-06 19:34:32'),
(12, 5, 19, 1.00, 15.00, 15.00, '2025-08-06 19:34:32');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `farmer_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity_available` decimal(10,2) NOT NULL DEFAULT 0.00,
  `image_url` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive','out_of_stock') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `farmer_id`, `category_id`, `unit_id`, `name`, `description`, `price`, `quantity_available`, `image_url`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Fresh Capsicum', 'রঙিন ক্যাপসিকাম, সালাদ ও রান্নার জন্য উপযুক্ত', 80.00, 25.50, 'images/product-1.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(2, 1, 1, 1, 'Fresh Tomatoes', 'টাটকা লাল টমেটো, রান্না ও সালাদের জন্য', 75.00, 30.00, 'images/product-5.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(3, 2, 1, 1, 'Green Beans', 'তাজা শিম, পুষ্টিকর ও সুস্বাদু', 120.00, 15.75, 'images/product-3.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(4, 3, 1, 1, 'Purple Cabbage', 'বেগুনি বাঁধাকপি, ভিটামিন সমৃদ্ধ', 200.00, 20.00, 'images/product-4.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(5, 4, 1, 1, 'Fresh Broccoli', 'সবুজ ব্রকলি, স্বাস্থ্যকর ও পুষ্টিকর', 150.00, 12.50, 'images/product-6.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(6, 5, 1, 1, 'Organic Carrots', 'জৈব গাজর, মিষ্টি ও কুড়কুড়ে', 70.00, 40.00, 'images/product-7.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(7, 2, 1, 6, 'Green Spinach', 'তাজা পালং শাক, আয়রন ও ভিটামিন ভরপুর', 18.00, 50.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(8, 4, 1, 6, 'Red Amaranth', 'লাল শাক, পুষ্টিকর ও স্বাস্থ্যকর', 15.00, 35.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(9, 2, 2, 1, 'Fresh Strawberry', 'মিষ্টি স্ট্রবেরি, ভিটামিন সি সমৃদ্ধ', 80.00, 8.50, 'images/product-2.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(10, 6, 2, 3, 'Bangladeshi Mango', 'দেশী আম (ল্যাংড়া), মিষ্টি ও সুস্বাদু', 150.00, 100.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(11, 6, 2, 3, 'Himsagar Mango', 'হিমসাগর আম, রসালো ও সুগন্ধি', 200.00, 50.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(12, 6, 2, 1, 'Fresh Lemon', 'দেশী লেবু, ভিটামিন সি ও খনিজ সমৃদ্ধ', 120.00, 20.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(13, 3, 3, 7, 'Miniket Rice', 'মিনিকেট চাল, সুগন্ধি ও সুস্বাদু', 55.00, 200.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(14, 1, 3, 7, 'Nazirshail Rice', 'নাজিরশাইল চাল, ঐতিহ্যবাহী স্বাদ', 65.00, 150.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(15, 4, 3, 1, 'Wheat Flour', 'গমের আটা, পুষ্টিকর ও খাঁটি', 45.00, 100.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(16, 5, 4, 1, 'Red Lentils', 'মসুর ডাল, প্রোটিন সমৃদ্ধ', 110.00, 80.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(17, 3, 4, 1, 'Yellow Split Peas', 'মুগ ডাল, সহজ পাচ্য ও পুষ্টিকর', 130.00, 60.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(18, 1, 4, 1, 'Black Gram', 'কালো মাসকলাই ডাল, আয়রন সমৃদ্ধ', 140.00, 45.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(19, 4, 5, 2, 'Fresh Ginger', 'তাজা আদা, ঔষধি গুণ সমৃদ্ধ', 180.00, 25.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(20, 5, 5, 2, 'Green Chili', 'কাঁচা মরিচ, ঝাল ও সুগন্ধি', 200.00, 15.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(21, 2, 5, 3, 'Fresh Onion', 'দেশী পেঁয়াজ, রান্নার প্রয়োজনীয় উপাদান', 40.00, 150.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(22, 6, 8, 5, 'Fresh Fruit Juice', 'মিশ্র ফলের রস, প্রাকৃতিক ও স্বাস্থ্যকর', 100.00, 30.00, 'images/product-8.jpg', 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32'),
(23, 6, 8, 5, 'Mango Juice', 'আমের রস, ১০০% প্রাকৃতিক', 120.00, 25.00, NULL, 'active', '2025-08-06 19:34:32', '2025-08-06 19:34:32');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `abbreviation` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `abbreviation`, `created_at`) VALUES
(1, 'Kilogram', 'kg', '2025-08-06 19:34:31'),
(2, 'Gram', 'g', '2025-08-06 19:34:31'),
(3, 'Piece', 'pcs', '2025-08-06 19:34:31'),
(4, 'Dozen', 'dz', '2025-08-06 19:34:31'),
(5, 'Liter', 'l', '2025-08-06 19:34:31'),
(6, 'Bundle', 'মুঠা', '2025-08-06 19:34:31'),
(7, 'Bag', 'বস্তা', '2025-08-06 19:34:31'),
(8, 'Maund', 'মণ', '2025-08-06 19:34:31'),
(9, 'Seer', 'সের', '2025-08-06 19:34:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cart_item` (`customer_id`,`product_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_customer` (`customer_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `farmers`
--
ALTER TABLE `farmers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_customer` (`customer_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_order_date` (`order_date`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `idx_farmer` (`farmer_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `farmers`
--
ALTER TABLE `farmers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`farmer_id`) REFERENCES `farmers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
