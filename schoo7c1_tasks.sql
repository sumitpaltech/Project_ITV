-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 29, 2026 at 11:39 AM
-- Server version: 5.7.23-23
-- PHP Version: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schoo7c1_tasks`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_logs`
--

CREATE TABLE `import_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_imported_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_18_102738_create_import_logs_table', 1),
(5, '2026_04_17_124628_create_task_trackers_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task_tracker`
--

CREATE TABLE `task_tracker` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_mail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_member` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `file_attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `task_tracker`
--

INSERT INTO `task_tracker` (`id`, `title`, `description`, `category`, `department`, `assigned_to`, `user_mail`, `team_member`, `priority`, `start_date`, `due_date`, `completion_date`, `status`, `remarks`, `file_attachment`, `created_at`, `updated_at`) VALUES
(2, 'Shipping bill|ORM|BOE|IRM', 'Bill of Entry Import - Outstanding (Summary)', NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(3, 'Master SKU', NULL, NULL, 'Accounts', 'Anil', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(4, 'BG Status (open&closed)', 'Bank Guarantee', NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(5, 'GST state MIS', NULL, NULL, 'Accounts', 'Anil', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(6, 'Self Consumption (Filaments/Spareparts,Resins)', NULL, NULL, 'Accounts', 'Sharda', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(7, 'FOC list (Expenses In curred)', NULL, NULL, 'Accounts', 'Sharda', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(8, 'Suspense-MIS', NULL, NULL, 'Accounts', 'Sarita', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(9, 'PTS vs.Tally (Sales,Debtors,Inventory,Advances)', NULL, NULL, 'Accounts', 'Sarita', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(10, 'Limit utilization report (Interest,FD,Remittence charges)', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(11, 'Insurances', 'Declaration on Monthly Basis to Insurance Agent (Stock plus Marine Cargo(Sales,Purchase etc)', NULL, 'Accounts', 'Sharda', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(12, 'PT Sand tally integration', NULL, NULL, 'Accounts', 'Nikhil', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(13, 'PO/GRN Tally report - add in daily MIS', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(14, 'Remittence MIS-Vishal', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(15, 'Monthly Ledger reconcillation', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(16, 'Inventory Audit monthly-SCM team', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(17, 'Icegate Wallet balance', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(18, 'Export IGST, RoDTEP etc report - preparea MIS', 'The RoDTEP scheme provides for rebate of Central, State and Local duties/taxes/levies which are not refunded under any other duty remission schemes.(Remission of Duties and Taxes on Exported Products)', NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(19, 'LUT file-All exports under LUT (closure doc)', 'PDF File (LUT Certificate from Department) for FY25-26.What is LUT? An LUT,or Letter of Undertaking, in GST allows Indian exporters to ship goods or services abroad without paying Integrated GST (IGST) upfront.', NULL, 'Accounts', 'Anil', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(20, 'TDS Filling status', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(21, 'COD payments reco', 'Daily MIS', NULL, 'Accounts', 'Anil', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(22, 'Sales return MIS', NULL, NULL, 'Accounts', 'Sarita', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:04', '2026-05-15 11:44:04'),
(23, 'Bank advice', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(24, 'Swift charges MIS', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(25, 'Insurance claim status', NULL, NULL, 'Accounts', 'Sharda', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(26, 'Shipping bill pending of RBI mail mis', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(27, 'Compliances folder -TDS,GST,Reurns,ROC,PTRC,PTEC,LUT,PT', NULL, NULL, 'Accounts', 'KanaiyalalSir', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(28, 'FIRC Report -Full Traceability - Pending (ACC)', NULL, NULL, 'Accounts', 'VishalS', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(29, 'boe updates', NULL, NULL, 'Accounts', 'SushilJi', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(30, 'p&l discussion', NULL, NULL, 'Accounts', 'SushilJi', 'accounts@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(31, 'AOP', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(32, 'FOC sub distributors & Product placement pan india', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(33, 'Exhibition Calendar -a Pictures b Expensesc Timeline', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(34, 'Exhibition performance', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(35, '3 pin Mandatory inall the printers -implementation', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(36, 'Reseller Policy', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(37, 'Targets Mis', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(38, 'Top 10 clients -Monthly|Quatrly|HalfYearly|Yearlyvisit', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(39, 'reseller review', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(40, 'Ideal Labs (makeinindia)', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(41, 'q2 scanner add', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(42, 'wasp (concrete3dprinter)', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(43, 'Postings (FB/IG/LK/Web/yt)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(44, 'Wikipedia', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(45, 'Acos', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(46, 'Influencers mis - FOC', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(47, 'Targetsof SM vs actual (FB likes/linked infollowers/yt Follows/ig followers)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(48, '3Idea-seo|Google analytics report 3idea (on page|off page|ai)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(49, '3D filaments-Google analytics|seo report(on page|off page|ai)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(50, 'Brochures', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(51, 'All Domain reviews(|laseren gravers.in)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(52, 'Blogs', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(53, 'Daily Expense Reports', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(54, 'Non Moving /clearance', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(55, 'Metricool review', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(56, 'Emails|whatsapp data base review', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(57, '3idea app', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(58, 'Affiliate marketing', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(59, 'Presentations', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(60, 'Signature', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(61, 'News letter', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(62, 'Thank you card', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(63, 'Youtube monetization', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(64, 'Services vertical(repairs|services)-Techtbin tegrated in website', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(65, 'Domain purchase-Getting www.3idea.com', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(66, 'Chat bot:Live', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(67, 'Refurbished:Meta Campaign', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(68, 'Laser Engraver-Website', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(69, '3DScanner-Web site pending', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(70, 'Setting festival Campaign', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(71, 'Credentials file for all (FB,IG,X,Linkedin,Email,softwares)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(72, '3D filament daily MIS', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(73, 'Kobras 15 influencers', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(74, 'Snap make ru 15 influencers', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(75, 'Mono 4.5in fluencers', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(76, 'Ender 3v 3promotion', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(77, 'To caalaser', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(78, 'Filamenths to 30 + influencers on that grp', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(79, 'Adsmaterial review (email&whatsapp((templates))folder', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:05', '2026-05-15 11:44:05'),
(80, 'Whatsappads activation & report', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(81, 'Largest variety off ilaments (video+commercial)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(82, 'web site app ads', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(83, 'Banners on web site update', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(84, 'Linkedin#1strategy', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(85, 'Masse mail analytics (review of db)', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(86, 'Maitricool review', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(87, 'Form next review', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(88, 'Web site BWR', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(89, 'Mass emails of BWR', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(90, 'Bulk order of filaments and settings in 3d filaments web site', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(91, 'Timshoes', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(92, 'Eye glasses', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(93, 'Shoe branding', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(94, 'Dental', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(95, 'Spareparts & accessories campaigns', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(96, 'Color fabb', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(97, '3df website', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(98, 'laser engraver website', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(99, 'Dispatch every day reports', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(100, 'Costing Automation', 'dispatch automation -web site (nikhil)', NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(101, 'Amazon price sheets (AZuae|AZindia|Fk', 'UAE working progress', NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(102, 'One consolidated sheet', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(103, 'VBA programming', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(104, 'Ecommerce costings of (flipkart/jio)', 'NA-Clearence need', NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(105, 'Export costing', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(106, 'Services Costing', 'NA-Clearence need', NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(107, 'Reseller costings & MIS', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(108, 'Margin MIS', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(109, 'Clearances MIS', 'NA-Clearence need', NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(110, 'Refurbished Costings', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(111, 'Tender costing Sheet', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(112, 'MRP', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(113, 'Pricing system', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(114, 'BOE FOLDER (APRIL25-APRIL24)', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(115, 'AMAZONUSA', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(116, 'Inventory audit', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(117, 'Master sheet', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(118, 'Boe files + transportation + clearnce', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(119, 'Pricing of 3df', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(120, 'laser & scanner price review', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(121, 'A egingin ventoryre price and offers', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(122, 'Competitor pricing of amazon and website daily basis', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(123, 'Cod review', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(124, 'dispatch dec review', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(125, 'charges master file (freight|courier)', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(126, 'Amazon UAE workin progress thus', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(127, 'LCC (done) thus', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(128, 'Scrap MIS', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(129, 'Resller Module', NULL, NULL, 'Costing', 'Rachna', 'costing@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(130, 'ALL Dashboards Update', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(131, 'Every day Analysis of complete data', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(132, 'Calling MIS UPDATE', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(133, 'Competitor pricing (az|website)', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(134, 'Complainces Dashboard - IFRC/ORM/IRM/GST/BOE', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(135, 'DC-DCt bknocked of by Akshay', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(136, 'Debtors-Detail edlist with reasonstb prepared', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(137, 'FOC dashboard -Daily', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(138, 'IC-Self consumption -a review IC list from Accb Completelis twith Reasons tbre checked', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(139, 'Marketing Dashboard (postings|Impression|comments)', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(140, 'Mass MAIL vs orders', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(141, 'Mass whatsapp vs orders', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(142, 'Non Moving Analysis-Aging/FBA', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(143, 'Reserve Inventory Dashboard', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(144, 'Tally vs Pts (order/debtors/creditors/inventory)', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(145, '12 Month graph for each individual marketing', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(146, 'Missing item|damage|refurb (catergory wise count)', NULL, NULL, 'Data Analyst', 'Snehal', 'data.analyst@3idea.i', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:06', '2026-05-15 11:44:06'),
(147, 'FIFO', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(148, 'Equipment to unload and dispatch (options from Akshay)', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(149, 'Brand wise/model wise inventory (weekly photograph)', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(150, 'Used Filament inventory', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(151, 'Missing Item inventory (list)', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(152, 'GRN report-daily report', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(153, 'Total Dispatch (% of agencies used)-weekly MIS', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(154, 'label printing report-(Duplicate Labelstb disallowed-alpesh)', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(155, 'PTS Vs Physical (Salable,Ref,Dam)', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(156, 'online returns resins', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(157, 'returns', NULL, NULL, 'Dispatch', 'Rakesh', 'dispatch@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(158, 'Rms review of Snehal', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(159, 'Rms review of Prajakta', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(160, 'airline miles latest', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(161, 'pending tasks rms', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(162, 'cgvist points', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(163, 'agvisit points', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(164, 'email clean', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(165, 'remote ac', NULL, NULL, 'Executive Assistant', 'Damini', 'eajmd@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(166, 'RIS%-(target50%)', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(167, 'Inventory Tracker (OOSL) PTS-FBA', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(168, 'FBA Shipment Tracker', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(169, 'Advertising Vs inventory', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(170, 'FBA stock overview (Location Wise)', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(171, 'PTS Vs Listing', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(172, 'Listing vs Coupons/A+/Video', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(173, 'Searchsur press', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(174, 'ACOS%(2-2.5%)', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(175, 'Competitor pricing', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(176, 'LQ DASHBOARD', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(177, 'IPI-Inventory Performance Index', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(178, 'Remove inventory Amz-365above-(181andabove)', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(179, 'Stranded Inventory', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(180, 'STEP inventory recommendations', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(181, 'Master MIS of refferal Fees', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(182, 'Inventory recommendations from AZ', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(183, 'HNB Flex', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(184, 'Reimbursement report (Amzflipmogjio)', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(185, 'Video reqired for products-List', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(186, 'Price diff betn amz A Evs India', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(187, 'FBA transit loss(discrepency fba)', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(188, 'Teamag visit', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(189, 'Installation video of Kobra 2neo', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(190, 'ONDC listings', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(191, 'Reliance Digital listing', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(192, 'Croma', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(193, 'Tatacliq listing', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(194, 'Update Catalogue monthly pricing by 2RS', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(195, '3idea high speed filament listings', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(196, 'Wrong product received', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(197, 'Transperancy code', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(198, 'Stock & Sale Update(for PTS &Stock requirement to Gaurav)', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(199, 'Amazon India PPC Budget & Bids Optimization', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(200, 'Amazon UAE PPC Budget & Bids Optimization', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(201, 'Amazon Ads Reportin Agenda', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(202, 'Cordination with Amazon Managers', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(203, 'FBA shipment plan based ons ales and stock file', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(204, 'Stock update on amazon flex,MFN and moglix', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(205, 'UAE STOCK & SHIPMENT PLAN', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(206, 'Maintainance of all order and F Corder record for one year', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(207, 'Maintainance of removal record created by usin excel sheet', NULL, NULL, 'Ecommerce', 'Gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(208, 'Amazon New Listing Creation', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(209, 'Amazon global listing mapping', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(210, 'Web site Pricing Update', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(211, 'Amazon Pricing Update', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:07', '2026-05-15 11:44:07'),
(212, 'Creating and updating A+ Content', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(213, 'HSN code review', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(214, 'SKU Duplicates list', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(215, 'USA comp pricing', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(216, 'Improving seller feedback', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(217, 'creating store front & advertising campaing n banner images', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(218, 'uploading store front images for In UAE USA', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(219, 'updating best selling,new arrival & hot selling products on website', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(220, 'Create case on amazon issues', NULL, NULL, 'Ecommerce', 'Vaishnavi', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(221, 'UAE Referral fee master file report', NULL, NULL, 'Ecommerce', 'Vaishnavi', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(222, 'Agingo fDXB products', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(223, 'Campaig file for DXB products', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(224, 'Competitor pricing for DXB', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(225, 'IPI excess inventory-revised pricing', NULL, NULL, 'Ecommerce', 'Mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(226, 'Fba inventory review', NULL, NULL, 'Ecommerce', 'gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(227, 'Azuae review(+inventory removed)', NULL, NULL, 'Ecommerce', 'gaurav', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(228, 'Reviews on amazon', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(229, '132 stranded inventory', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(230, 'Safety claims', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(231, 'Case logs 6 open', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(232, 'Coupon page review', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(233, '120 suggestion sales improvement way', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(234, 'Gst issue amazon', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(235, 'Blinkit review', NULL, NULL, 'Ecommerce', 'mayuri', 'ecommerce@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08');
INSERT INTO `task_tracker` (`id`, `title`, `description`, `category`, `department`, `assigned_to`, `user_mail`, `team_member`, `priority`, `start_date`, `due_date`, `completion_date`, `status`, `remarks`, `file_attachment`, `created_at`, `updated_at`) VALUES
(236, 'Count of people() + files +updated info', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(237, 'HRMS logins', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(238, 'Policies (leave + travel)', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(239, 'training', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(240, 'skill matrix', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(241, 'AG visit (monthly)', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(242, 'CFTM', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(243, 'Team Building activities', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(244, 'Govt policies for new technologybiz', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(245, 'admin issues', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(246, 'IT issues', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(247, 'mobile policies (payments)', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(248, 'salary structure', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(249, 'Increments', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(250, 'Incentives', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(251, 'PMS', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(252, 'ORG structure', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(253, 'SOP/JD/REPORTING/TEAMS', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(254, 'Openings/joinings', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(255, 'Cleanliness', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(256, 'Starter kit', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(257, 'Orientation', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(258, 'BIO METRICS (HRMS)', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(259, 'ID', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(260, 'Suggestion BOX', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(261, 'CFT', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(262, 'Dedicated Trouble shooting person', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(263, 'ads officer', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(264, 'open positions', NULL, NULL, 'HR', 'Kajal', 'Hr@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(265, 'Hosting of the domains', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(266, 'Systems Configuration', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(267, 'Maintainence', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(268, 'Shared folders with password', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(269, 'scanner reports|folders', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(270, 'IT daily print out reports', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(271, 'band width usage', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(272, 'antivirus', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(273, 'Computer system updates', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(274, 'Access policy', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(275, 'Employee id name', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(276, 'Backup system of all computer sandservers', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(277, 'archieve issue', NULL, NULL, 'IT', 'BalaSir', 'itho@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(278, 'PTS vs Listings-p', 'Rashi-IM,JD-Heena/Anushri', NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:08', '2026-05-15 11:44:08'),
(279, 'Calls report-Anushri & Heena', '40+calls-Target', NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(280, 'Calls report -Darshana & Ankita', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(281, 'Calls report -Vikash & Dhairya', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(282, 'Calls report-Rashi', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(283, 'Demos Calendar', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(284, 'Samples to Key Clients-with 3idea branding', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(285, 'Reseller Sample Printers-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(286, 'Customer reviews-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(287, 'Products inquiries-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(288, 'Training Calender-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(289, 'Marketing activity-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(290, 'Refurbished Stock-p', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(291, 'Reseller list vs sales MIS', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(292, 'scanner inquiry', NULL, NULL, 'Sales', 'Darshana', 'marketing2@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(293, 'Exhibitions review', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(294, 'In active Resellers review', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(295, 'quotation top 10 of each which did not materialze', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(296, 'customer reviews on social media platforms', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(297, 'erp zoho', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(298, '3d printing services review', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(299, 'wrong product dispatched mis', NULL, NULL, 'Sales', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(300, 'Authorisation Certificates & websitelinks', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(301, 'Creatives of all Brands (19)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(302, 'Red Report - DailyMail', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(303, 'Consumables Inventory', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(304, 'Influencers FOC Updates', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(305, 'FOC Tracker (OEM)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(306, 'Ecomm Inventory requisition', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(307, 'Reduction of Last Purchase price for all categories', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(308, 'Payments O EMMIS (Cumulative-April)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(309, 'Import pricing tracker of competitor', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(310, 'CCU ware house tracker', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(311, 'Electronic recycle certificate-(DPD+EPR)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(312, 'Sample stracker', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(313, 'Technical training calendar', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(314, 'STL files from manufacturers Shoes+Specialproducts', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(315, 'Deliver yagency MIS 12months', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(316, 'SOP for the team', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(317, 'AG warehouse updte-Imagesa Brandwise|modelwise|sellable|refurb|damage-Pics', 'Flooring|painting|sorting', NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(318, 'Cardboard spool rings-3idea', NULL, NULL, 'Supply Chain Management', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(319, 'Packing Listin PTS system (everyday) vs GRN', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(320, 'PL|Cifolder to be maintained(ImportTracker)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(321, 'Empty boxes for inventory', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(322, 'FOC tagging', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(323, 'State wise (city wise dispatches)', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(324, 'Delivery|BlueDart Maruti - dashboard review', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(325, 'Insurance claim review', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(326, 'RFID tags', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(327, 'FBA dispatches vendor used (Approval)', 'Excel sheet', NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(328, 'Aram exagency charges', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(329, 'Scrap MIS', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(330, 'Demo Printer list', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(331, 'Commercial sonpayu|delhivery|bluedartsoftware', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(332, 'Monthly review of courier charges (costanalysis)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(333, 'Hand over-Upcoming shipment Data', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(334, 'Daily meeting -online offline req-mayuri and jinal-Prasad (Redsheet)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(335, 'Charges return products-sheet', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(336, 'Local Purchase sheet (Procurement)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(337, 'Local Vendor Development data (NewVendors)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(338, 'Costreduction Data (LPPfromOEM)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(339, 'Delievery partners negotiations', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(340, '10% shipping costup', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(341, 'Insurance', NULL, NULL, 'Supply Chain Management', 'Muzzamil', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(342, 'Banglore inventory review', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:09', '2026-05-15 11:44:09'),
(343, 'Daily shipment tracker', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(344, 'flooringag warehouse', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(345, 'shipment mis review', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(346, 'Pending greypla', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(347, 'Red sheet', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(348, 'Negotiation tracker', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(349, '6 Spare Parts Tracker - (self-consumption) Acc/Summary', NULL, NULL, 'Supply Chain Management', 'Devendra', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(350, '7 Trouble shooting Tracker FOC/Spare part (same sheet as 6) (take from tech', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(351, '9LPP of all the printers/spare parts/consumables (x-10%) - Demo refurbish', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(352, 'Creatbot 160 - Sellable', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(353, 'Boxes for spare parts AG (12 Boxes) (ICS)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(354, 'Samples boxes - given (8+', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(355, 'Licenses - in process (DPD +au+ EPR)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(356, 'Brandwise | model wise | sellable | refurb | damage - Pics', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(357, '2T Suyog order (Aug Week 1)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(358, 'Landu Rings - Cardboard spool rings', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(359, 'Packing List PTS system (everyday) GRN - Review', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-09-01', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(360, 'Refurbished printers. AG - PTS', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(361, 'Samples with all shipments [demo/sample]', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(362, 'PLCI folder to be maintained by Yusuf & shared', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(363, 'Revised PL Creality', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(364, 'CCU', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(365, 'Samples', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(366, 'MOM of training (3D makerpro) Video Recording', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(367, 'State wise and city wise dispatch april-aug (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(368, 'Spare part storage (photos)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(369, 'NX to regular PLA', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(370, 'Landu', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(371, 'Delivery | BlueDart COD website', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(372, 'Paint of warehouse', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(373, 'Peg Board - ETA (Delivery Tomorrow) AG', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(374, 'PT', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(375, 'Damage returns', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(376, 'Insurance TAT | copy', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(377, 'COD bluedart', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(378, 'Integrate Tally & Delivery & BlueDart', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(379, 'RFID tags', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(380, 'L with all team | shared folder', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(381, 'Advances MIS', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(382, 'Bambukabs - Mon shipment', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(383, '(eSun) new order', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(384, 'Sadiq dispatch tool', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(385, 'Marketing collaterals for all under shipment', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(386, 'Creality and bambulabs inv every mon', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(387, 'Cod activation for bluedart (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(388, 'Rate comparative of all agencies (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(389, 'Issues (Debt note and status) (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(390, 'Business contribution pie chart (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(391, '1 day delivery (option) (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(392, 'Rate negotiation (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(393, 'Amazon FBA dispatch (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(394, 'Incoming shipments every month (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(395, 'Trucking agency from port to ag rate (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(396, 'DXB shipping agency (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(397, 'Incoming foc (Tracking MIS) and tenders dispatch (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(398, 'Shipping Calculator (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(399, 'costing software live', NULL, NULL, 'Costing', 'Sumit', 'tech@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(400, 'uae pricec on figuration in costing software', NULL, NULL, 'Costing', 'Sumit', 'tech@bwrl.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(401, 'Samples Tracebility & Sheet', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(402, 'Services MIS/Call sheet', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(403, 'Marketing presentation & case studies of services', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(404, 'Visit calendar', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(405, 'Sample prints calendar - duplicate point 1', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(406, 'Running printers MIS', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(407, 'Industry wise sample boxes', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(408, 'Inventory-Detailed list with labels', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(409, 'Target Vs Achievement', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(410, 'Software options-2D>3D', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:10', '2026-05-15 11:44:10'),
(411, 'Tools List inventory', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(412, 'Internal Samples tracker', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(413, '3idealo go backlit', NULL, NULL, 'Marketing', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(414, 'Samples of crome plating', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(415, 'Ag service station', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(416, 'Case study of each services', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(417, 'Flexible resin samples for shoes (resin&TPU)-suraj', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(418, 'Colorful bowl - transperant resin bowl', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(419, 'Daily printre port fororders', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(420, 'Investment casting sample', NULL, NULL, 'Services', 'Divya', 'divya@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(421, 'Chrome plating -Vendors', NULL, NULL, 'Services', 'Simran', 'services@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(422, 'Cod activation for bluedart (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(423, '1 day delievery (option) (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(424, 'amazon fb adispat chagency selector (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(425, 'Incoming shipment severy month MIS (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(426, 'trucking agency from porttoagrate (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(427, 'dxb shippingagency (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(428, 'Shipping Calculator (Shipping)', NULL, NULL, 'Supply Chain Management', 'Anushka', 'supplychain1@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(429, '24 hours deadline for reply', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(430, 'Pics/Video salong with visit report -tbsub mitted to HR', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(431, 'Reviews', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(432, 'Training calender (manufacturers)', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(433, 'Trainingcal ender Internal', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(434, 'Training video soft rouble shooting', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(435, 'Picand video sof damage & refurbished 100%', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(436, 'Scrap List', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(437, 'Inventory Required of spareparts', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(438, 'Tools inventory', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(439, 'Installation Calender', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(440, 'Demos Calender', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(441, 'Refurbished/Damaged Inventory vs physcial-Duplicate point7', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(442, 'Pending Issues', 'We Chatgroups with all the Brands', NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(443, '3D Printer Manufacture Project -Dev working proto type', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(444, 'MOM of training Video Recording', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(445, 'Pickup schedule by customer', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(446, 'Installation video - Hindi', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(447, 'Color laseren graving samples/pcb', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(448, 'daily meeting with Akshay - momtb', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(449, 'Sparepart stracking (self consumption)', NULL, NULL, 'Technical', 'Devendra', 'devendra.dolas@3idea.in', NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(450, 'Confirmed Orders', 'Confirmation Probability Sheet', NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(451, 'Rquirements', 'Coordination with Akshay', NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(452, 'EMD pbglist', 'Sheet to beshared', NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(453, 'All listingst brechecked for images and pricing', 'Gem Catalog Listing (6Printers Pending for listing)', NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(454, 'Visit calendar', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(455, 'Debtors-Detailed list with reasons tb prepared', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(456, 'Upcomming tenders/CPP & GEM Calendar', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(457, 'CPP Portal review-Username-tenders@3idea.inPW-Tenders@12345', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(458, 'GEMPortalreview-Username-Tenders123PW-2025@Tenders789', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(459, 'Lost tender analysis', NULL, NULL, 'Tender', 'AkshayS', 'tenders@3idea.in', 'tenders@3idea.in', 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(460, 'list where picis not there', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(461, 'pythonutility for images(today)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(462, 'Appleapp (tomorrow)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11');
INSERT INTO `task_tracker` (`id`, `title`, `description`, `category`, `department`, `assigned_to`, `user_mail`, `team_member`, `priority`, `start_date`, `due_date`, `completion_date`, `status`, `remarks`, `file_attachment`, `created_at`, `updated_at`) VALUES
(463, 'Zoho debtors to be made live(today)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(464, 'HRMS Data upload (tomorrow)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(465, 'zoho crm reports call vs actions (shrustitoday)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(466, 'Payment for Zoho done', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(467, 'Analytics issue -(Snehal)(inventory flow in analytics)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(468, 'Mayuri-Gaurav-zoho mapping (File)today', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(469, 'CRM-review(All activity tracking (%report)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(470, 'Aeging inventory', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(471, 'Cliq|chatbot|desk (today) (creality)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(472, 'Booking module(schedule)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(473, 'Sales inventory', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(474, 'Additional Payroll (hrms)(next7days)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(475, 'Diffin CRM sales numberand Books Sales Number', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(476, 'REF-Damage Inventory sorting and update (refurish+damage)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(477, 'PR-PO-GRN Clarity', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:11', '2026-05-15 11:44:11'),
(478, 'Procurement module -SCM', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(479, 'Ref & damage', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(480, 'Procurement', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(481, 'App son zoho', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(482, 'WhatsApp (technical|website)', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(483, 'Live inventory of amazon', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(484, 'Massemail (brevo) + massemail solution', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(485, 'Tenders 24thApril', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(486, 'Chat bot live', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(487, 'Delivery integration', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(488, 'Cleanup+live', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(489, 'Speed issues in zoho', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(490, 'Tracking is an issue', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(491, '505 error', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12'),
(492, 'Zoho social report of messages', NULL, NULL, 'Zoho', NULL, NULL, NULL, 'medium', '2026-04-01', '2026-04-24', NULL, 'pending', NULL, NULL, '2026-05-15 11:44:12', '2026-05-15 11:44:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_passkey` int(11) NOT NULL DEFAULT '0',
  `last_passkey_login_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `has_passkey`, `last_passkey_login_at`, `status`, `role`, `department`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Sumit Pal', 'Sumit', 'tech@bwrl.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'admin', 'Admin', NULL, '2026-04-27 12:16:49', '2026-05-15 11:05:45'),
(2, 'Aashta Hariyan', 'Aashta', 'return@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Marketing', NULL, '2026-04-27 12:33:14', '2026-04-27 12:33:14'),
(3, 'Aditi Khandare', 'Aditi', 'tenders@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Tender', NULL, '2026-04-27 12:35:51', '2026-04-27 12:35:51'),
(4, 'Ajay Yelmkar', 'Ajay', 'support@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 12:36:52', '2026-04-27 12:36:52'),
(5, 'Akash Kanojiya', 'Akash', 'Digitalmarketing@bwrl.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Marketing', NULL, '2026-04-27 12:37:48', '2026-04-27 12:37:48'),
(6, 'Anil Jangir', 'Anil', 'accounts@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Accounts', NULL, '2026-04-27 12:38:32', '2026-04-27 12:38:32'),
(7, 'Ankita Pawar', 'Ankita', 'promotion@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales', NULL, '2026-04-27 12:39:29', '2026-04-27 12:39:29'),
(8, 'Anushka Bandivadekar', 'Anushka', 'supplychain1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Supply Chain Management', NULL, '2026-04-27 12:43:17', '2026-04-27 12:43:17'),
(9, 'Anushri Devendra', 'Anushri', 'sales@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales', NULL, '2026-04-27 12:44:00', '2026-04-27 12:44:00'),
(10, 'Atharva Khadye', 'Atharva', 'info@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Services', NULL, '2026-04-27 12:44:46', '2026-04-27 12:44:46'),
(11, 'Bibhu Mohapatra', 'Bibhu', 'bibhu@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Management', NULL, '2026-04-27 12:45:30', '2026-04-27 12:45:30'),
(12, 'Chinmay Naik', 'Chinmay', 'support@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 12:46:10', '2026-04-27 12:46:10'),
(13, 'Chirayu Kamble', 'Chirayu', 'info@3dfilaments.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Digital Marketing', NULL, '2026-04-27 12:46:59', '2026-04-27 12:46:59'),
(14, 'Darryl Machado', 'Darryl', 'darryl.m@bwrl.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Marketing', NULL, '2026-04-27 12:47:47', '2026-04-27 12:47:47'),
(15, 'Darshana Maru', 'Darshana', 'marketing2@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales', NULL, '2026-04-27 12:48:31', '2026-04-27 12:48:31'),
(16, 'Devendra Dolas', 'Devendra', 'davendra.dolas@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 12:49:35', '2026-04-27 12:49:35'),
(17, 'Gaurav Shome', 'Gaurav Shome', 'ecommerce@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Ecommerce', NULL, '2026-04-27 12:52:35', '2026-04-27 12:52:35'),
(18, 'Gaurav Shelar', 'Gaurav.shelar', 'tenders@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Tender', NULL, '2026-04-27 12:53:47', '2026-04-27 12:53:47'),
(19, 'Gorakshanath Shinde', 'Gorakshanath', 'ecommerce@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Ecommerce', NULL, '2026-04-27 12:54:36', '2026-04-27 12:54:36'),
(20, 'Heena Shah', 'Heena', 'marketing3@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales', NULL, '2026-04-27 12:55:42', '2026-04-27 12:55:42'),
(21, 'Kanaiyalal Patel', 'Kanaiyalal', 'accounts@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Accounts', NULL, '2026-04-27 12:56:28', '2026-04-27 12:56:28'),
(22, 'Manali Pawar', 'Manali', 'marketing-2@gmail.com', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Digital Marketing', NULL, '2026-04-27 12:57:36', '2026-04-27 12:57:36'),
(23, 'Mayuri Sawant', 'Mayuri', 'ecommerce1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Ecommerce', NULL, '2026-04-27 12:58:19', '2026-04-27 12:58:19'),
(24, 'Muzammil Mapari', 'Muzammil', 'supplychain1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Supply Chain Management', NULL, '2026-04-27 12:59:18', '2026-04-27 12:59:18'),
(25, 'Nitesh Palsamkar', 'Nitesh', 'sales2@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Dispatch', NULL, '2026-04-27 13:00:08', '2026-04-27 13:00:08'),
(26, 'Omkar Chavan', 'Omkar', 'Services@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Design', NULL, '2026-04-27 13:01:00', '2026-04-27 13:01:00'),
(27, 'Pallavi Mohanty', 'Pallavi', 'data.analyst@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Data Analyst', NULL, '2026-04-27 13:01:39', '2026-04-27 13:01:39'),
(28, 'Pooja Yadav', 'Pooja Yadav', 'accounts@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Accounts', NULL, '2026-04-27 13:02:28', '2026-04-27 13:02:28'),
(29, 'Priyansha Shinde', 'Priyansha', 'productdesign_3idea@bwrl.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Design', NULL, '2026-04-27 13:04:08', '2026-04-27 13:04:08'),
(30, 'Rachana Maharana', 'Rachana', 'costing@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Costing', NULL, '2026-04-27 13:04:52', '2026-04-27 13:04:52'),
(31, 'Rashi Tiwari', 'Rashi', 'marketing1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales', NULL, '2026-04-27 13:08:57', '2026-04-27 13:08:57'),
(32, 'Ritesh Mhaskar', 'Ritesh', 'support@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Services', NULL, '2026-04-27 13:10:27', '2026-04-27 13:10:27'),
(33, 'Rohan Haider', 'Rohan', 'dispatch@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Dispatch', NULL, '2026-04-27 13:11:17', '2026-04-27 13:11:17'),
(34, 'Sadique Shuaib', 'Sadique', 'noreply@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'IT', NULL, '2026-04-27 13:13:59', '2026-04-27 13:13:59'),
(35, 'Saiprasad Patil', 'Saiprasad', 'Support@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 13:15:08', '2026-04-27 13:15:08'),
(36, 'Sanjeet Yadav', 'Sanjeet', 'sales2@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Sales & Marketing', NULL, '2026-04-27 13:17:30', '2026-04-27 13:17:30'),
(37, 'Shruti Naik', 'Shruti', 'tracking@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Marketing', NULL, '2026-04-27 13:18:16', '2026-04-27 13:18:16'),
(38, 'Siddhesh Pathak', 'Siddhesh', 'tracking@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Marketing', NULL, '2026-04-27 13:19:01', '2026-04-27 13:19:01'),
(39, 'Simran Kanojia', 'Simran', 'tracking@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Services', NULL, '2026-04-27 13:20:06', '2026-04-27 13:20:06'),
(40, 'Srushti Gaikwad', 'Srushti', 'data.analyst@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Business Intelligence', NULL, '2026-04-27 13:21:43', '2026-04-27 13:21:43'),
(41, 'Sumeet Sonawane', 'Sumeet', 'support@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 13:24:27', '2026-04-27 13:24:27'),
(42, 'Swapnil Salekar', 'Swapnil', 'info@3idea', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Technical', NULL, '2026-04-27 13:26:16', '2026-04-27 13:26:16'),
(43, 'Tanishka Adigoppula', 'Tanishka', 'accounts@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Accounts', NULL, '2026-04-27 13:27:19', '2026-04-27 13:27:19'),
(44, 'Vaishnavi Salunke', 'Vaishnavi', 'ecommerce1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Ecommerce', NULL, '2026-04-27 13:28:58', '2026-04-27 13:28:58'),
(45, 'Viraj Gore', 'Viraj', 'supplychain1@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Supply Chain Management', NULL, '2026-04-27 13:29:43', '2026-04-27 13:29:43'),
(46, 'Akshay Sontakke', 'Akshay', 'marketing@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'user', 'Tender', NULL, '2026-04-27 13:31:02', '2026-04-27 13:31:02'),
(47, 'Mayank Mittal', 'Mayank', 'mayank@3idea.in', NULL, '$2y$12$TeTTCZL/CRle6gWg8lvoR.CL15f7WEREmlKgb65e8pr3.EvZda1Ha', 0, NULL, 1, 'admin', 'Admin', NULL, '2026-04-28 14:00:03', '2026-04-28 14:00:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `import_logs`
--
ALTER TABLE `import_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `import_logs_source_unique` (`source`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `task_tracker`
--
ALTER TABLE `task_tracker`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `import_logs`
--
ALTER TABLE `import_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `task_tracker`
--
ALTER TABLE `task_tracker`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=493;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
