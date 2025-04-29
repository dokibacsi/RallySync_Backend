-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Ápr 29. 12:14
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `versenyek`
--
CREATE DATABASE IF NOT EXISTS `versenyek` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `versenyek`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `brandtypes`
--
-- Létrehozva: 2025. Már 11. 15:41
--

DROP TABLE IF EXISTS `brandtypes`;
CREATE TABLE IF NOT EXISTS `brandtypes` (
  `bt_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `brandtype` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`bt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `brandtypes`:
--

--
-- A tábla adatainak kiíratása `brandtypes`
--

INSERT INTO `brandtypes` (`bt_id`, `brandtype`, `created_at`, `updated_at`) VALUES
(1, 'Skoda Fabia', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'Skoda Fabia RS', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'Citroen C3', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(4, 'Ford Puma', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(5, 'Peugeot 208', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(6, 'Hyundai i20 N', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(7, 'Ford Fiesta', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(8, 'Renault Clio', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(9, 'Volkswagen Polo', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(10, 'Toyota GR Yaris', '2025-03-27 12:20:19', '2025-03-27 12:20:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `cache`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache_locks`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `cache_locks`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cars`
--
-- Létrehozva: 2025. Már 11. 17:12
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `cid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `brandtype` bigint(20) UNSIGNED NOT NULL,
  `category` bigint(20) UNSIGNED NOT NULL,
  `status` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `cars_brandtype_foreign` (`brandtype`),
  KEY `cars_category_foreign` (`category`),
  KEY `cars_status_foreign` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `cars`:
--   `brandtype`
--       `brandtypes` -> `bt_id`
--   `category`
--       `categories` -> `categ_id`
--   `status`
--       `statuses` -> `stat_id`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `categories`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categ_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`categ_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `categories`:
--

--
-- A tábla adatainak kiíratása `categories`
--

INSERT INTO `categories` (`categ_id`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Rally1', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'Rally2', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'Rally3', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(4, 'Rally4', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(5, 'Rally5', '2025-03-27 12:20:19', '2025-03-27 12:20:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `compcategs`
--
-- Létrehozva: 2025. Már 17. 11:15
-- Utolsó frissítés: 2025. Ápr 29. 10:11
--

DROP TABLE IF EXISTS `compcategs`;
CREATE TABLE IF NOT EXISTS `compcategs` (
  `coca_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `competition` bigint(20) UNSIGNED NOT NULL,
  `category` bigint(20) UNSIGNED NOT NULL,
  `min_entry` int(11) NOT NULL,
  `max_entry` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`coca_id`),
  KEY `compcategs_competition_foreign` (`competition`),
  KEY `compcategs_category_foreign` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `compcategs`:
--   `category`
--       `categories` -> `categ_id`
--   `competition`
--       `competitions` -> `comp_id`
--

--
-- A tábla adatainak kiíratása `compcategs`
--

INSERT INTO `compcategs` (`coca_id`, `competition`, `category`, `min_entry`, `max_entry`, `created_at`, `updated_at`) VALUES
(21, 15, 1, 200, 1000, '2025-04-15 11:15:33', '2025-04-15 11:15:33'),
(22, 16, 1, 10, 20, '2025-04-29 07:50:03', '2025-04-29 07:50:03'),
(23, 16, 2, 10, 20, '2025-04-29 07:50:03', '2025-04-29 07:50:03'),
(24, 17, 2, 100, 200, '2025-04-29 07:56:56', '2025-04-29 07:56:56'),
(25, 18, 3, 50, 100, '2025-04-29 08:11:18', '2025-04-29 08:11:18'),
(26, 18, 4, 50, 100, '2025-04-29 08:11:18', '2025-04-29 08:11:18');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `compeets`
--
-- Létrehozva: 2025. Már 17. 11:15
--

DROP TABLE IF EXISTS `compeets`;
CREATE TABLE IF NOT EXISTS `compeets` (
  `cs_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `competitor` bigint(20) UNSIGNED NOT NULL,
  `competition` bigint(20) UNSIGNED NOT NULL,
  `car` bigint(20) UNSIGNED NOT NULL,
  `arrives_at` datetime NOT NULL,
  `start_date` datetime NOT NULL,
  `finish_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cs_id`),
  KEY `compeets_competition_foreign` (`competition`),
  KEY `compeets_competitor_foreign` (`competitor`),
  KEY `compeets_car_foreign` (`car`)
) ;

--
-- TÁBLA KAPCSOLATAI `compeets`:
--   `car`
--       `cars` -> `cid`
--   `competition`
--       `competitions` -> `comp_id`
--   `competitor`
--       `users` -> `id`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `competitions`
--
-- Létrehozva: 2025. Már 17. 11:15
-- Utolsó frissítés: 2025. Ápr 29. 10:11
--

DROP TABLE IF EXISTS `competitions`;
CREATE TABLE IF NOT EXISTS `competitions` (
  `comp_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `place` bigint(20) UNSIGNED NOT NULL,
  `organiser` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `headerimage` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  KEY `competitions_place_foreign` (`place`),
  KEY `competitions_organiser_foreign` (`organiser`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `competitions`:
--   `organiser`
--       `users` -> `id`
--   `place`
--       `places` -> `plac_id`
--

--
-- A tábla adatainak kiíratása `competitions`
--

INSERT INTO `competitions` (`comp_id`, `event_name`, `place`, `organiser`, `description`, `start_date`, `end_date`, `headerimage`, `created_at`, `updated_at`) VALUES
(15, '1. Lappantyószegi Város-Rally', 4, 3, 'Lappantyószeg legelső városi Rally versenye, amelyet a város központjában rendeznek. Legelső autó rajtja: 17:30', '2025-06-20', '2025-06-22', 'uploads/1744722933_481079513_996232359276122_8409194776869745066_n.jpg', '2025-04-15 11:15:33', '2025-04-29 07:47:20'),
(16, 'BALLD. 3. Boglyaszentmárton Rally', 7, 3, 'Rally1, Rally2 kategóriában indulhatnak Boglyaszentmárton harmadik versenyén', '2025-05-01', '2025-05-04', 'uploads/1745920203_26622336_012ea41973d03e9b2cec1e73fae39915_wm.jpg', '2025-04-29 07:50:03', '2025-04-29 07:50:03'),
(17, 'Csipkéspataki Gyorsasági', 12, 3, 'Gyipkéspatak mellett futó murvás szakaszokon először szervezik meg Rally2 kategóriában a Csipkéspataki Gyorsaságit versenyt, mely a hosszú egyenes utakról híresek.', '2025-06-12', '2025-06-15', 'uploads/1745920616_gravel-stage-in-the-forest.jpg', '2025-04-29 07:56:56', '2025-04-29 07:56:56'),
(18, 'Brekkeréti hatalmas-verseny', 6, 3, 'Brekkerét hegységében szervezik meg a hatalmas-versenyt 8 Rally szakasszal.', '2025-04-17', '2025-04-20', 'uploads/1745921478_a-gravel-road-by-the-mountain.jpg', '2025-04-29 08:11:18', '2025-04-29 08:11:18');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `failed_jobs`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `failed_jobs`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jobs`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `jobs`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `job_batches`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `job_batches`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `migrations`
--
-- Létrehozva: 2025. Már 02. 18:36
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `migrations`:
--

--
-- A tábla adatainak kiíratása `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2024_12_02_092857_create_personal_access_tokens_table', 1),
(4, '2025_03_10_153433_create_brand_types_table', 1),
(5, '2025_03_10_154211_create_statuses_table', 1),
(6, '2025_03_10_171212_create_categories_table', 1),
(7, '2025_03_11_152727_create_permissions_table', 1),
(8, '2025_03_11_153301_create_cars_table', 1),
(9, '2025_03_11_154800_create_places_table', 1),
(10, '2025_03_12_000000_create_users_table', 1),
(11, '2025_03_12_154523_create_competitions_table', 1),
(12, '2025_03_13_153541_create_comp_categs_table', 1),
(13, '2025_03_14_153717_create_compeets_table', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `password_reset_tokens`
--
-- Létrehozva: 2025. Már 17. 11:15
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `password_reset_tokens`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `permissions`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `perm_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `permissions`:
--

--
-- A tábla adatainak kiíratása `permissions`
--

INSERT INTO `permissions` (`perm_id`, `permission`, `created_at`, `updated_at`) VALUES
(1, 'versenyző', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'szervező', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'adminisztrátor', '2025-03-27 12:20:19', '2025-03-27 12:20:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `personal_access_tokens`
--
-- Létrehozva: 2025. Már 11. 15:40
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `personal_access_tokens`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `places`
--
-- Létrehozva: 2025. Már 11. 17:13
--

DROP TABLE IF EXISTS `places`;
CREATE TABLE IF NOT EXISTS `places` (
  `plac_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `place` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`plac_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `places`:
--

--
-- A tábla adatainak kiíratása `places`
--

INSERT INTO `places` (`plac_id`, `place`, `created_at`, `updated_at`) VALUES
(1, 'Bugyboréktő', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'Ködpallag', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'Zsindelyvár', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(4, 'Lappantyószeg', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(5, 'Löszlak', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(6, 'Brekkerét', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(7, 'Boglyaszentmárton', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(8, 'Zsupposberek', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(9, 'Kenderzug', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(10, 'Morgósrév', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(11, 'Lankásfölde', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(12, 'Csipkéspatak', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(13, 'Sárszokoly', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(14, 'Zúgóbérc', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(15, 'Fenyérlapos', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(16, 'Pörcsmalom', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(17, 'Ványadomb', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(18, 'Nyűvösfalu', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(19, 'Kátyaspuszta', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(20, 'Bőgőstanya', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(21, 'Dörgőháza', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(22, 'Görbedék', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(23, 'Vakvölgypatak', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(24, 'Rögzug', '2025-03-27 12:20:19', '2025-03-27 12:20:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sessions`
--
-- Létrehozva: 2025. Már 17. 11:15
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `sessions`:
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `statuses`
--
-- Létrehozva: 2025. Már 11. 15:43
--

DROP TABLE IF EXISTS `statuses`;
CREATE TABLE IF NOT EXISTS `statuses` (
  `stat_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `statsus` char(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `statuses`:
--

--
-- A tábla adatainak kiíratása `statuses`
--

INSERT INTO `statuses` (`stat_id`, `statsus`, `created_at`, `updated_at`) VALUES
(1, 'Szabad', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'Foglalt', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'Pályán', '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(4, 'Szervízelés alatt', '2025-03-27 12:20:19', '2025-03-27 12:20:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--
-- Létrehozva: 2025. Már 17. 11:15
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `permission` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_permission_foreign` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- TÁBLA KAPCSOLATAI `users`:
--   `permission`
--       `permissions` -> `perm_id`
--

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `permission`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@mamail.eu', NULL, 3, '$2y$12$oZeIjmXK47N8bRz6ayZasuWkHvl49leltU9iWXgMyZDFGvR3DUtvu', NULL, '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(2, 'felhasznalo', 'felh@mamail.eu', NULL, 1, '$2y$12$omSV0t/lNXIZXcg91ESDze50ofXTcnhImcSI1vK1IjgQV72oJWkKS', NULL, '2025-03-27 12:20:19', '2025-03-27 12:20:19'),
(3, 'szervezo', 'szerv@mamail.eu', NULL, 2, '$2y$12$wgRXb4dE.I3JIV/AWyGtYuAahWbos/7tvF8oFnhoeUwg2MFWiIlHi', NULL, '2025-03-27 12:20:20', '2025-03-27 12:20:20'),
(4, 'Tóth Lajos', 'tothlajcsi@mamail.eu', NULL, 1, 'tothlajos2000', 'tothlajos2000', NULL, NULL),
(5, 'Kiss Géza', 'kisgezuka@mamail.eu', NULL, 1, 'kisgezuka', NULL, NULL, NULL);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_brandtype_foreign` FOREIGN KEY (`brandtype`) REFERENCES `brandtypes` (`bt_id`),
  ADD CONSTRAINT `cars_category_foreign` FOREIGN KEY (`category`) REFERENCES `categories` (`categ_id`),
  ADD CONSTRAINT `cars_status_foreign` FOREIGN KEY (`status`) REFERENCES `statuses` (`stat_id`);

--
-- Megkötések a táblához `compcategs`
--
ALTER TABLE `compcategs`
  ADD CONSTRAINT `compcategs_category_foreign` FOREIGN KEY (`category`) REFERENCES `categories` (`categ_id`),
  ADD CONSTRAINT `compcategs_competition_foreign` FOREIGN KEY (`competition`) REFERENCES `competitions` (`comp_id`);

--
-- Megkötések a táblához `compeets`
--
ALTER TABLE `compeets`
  ADD CONSTRAINT `compeets_car_foreign` FOREIGN KEY (`car`) REFERENCES `cars` (`cid`),
  ADD CONSTRAINT `compeets_competition_foreign` FOREIGN KEY (`competition`) REFERENCES `competitions` (`comp_id`),
  ADD CONSTRAINT `compeets_competitor_foreign` FOREIGN KEY (`competitor`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `competitions`
--
ALTER TABLE `competitions`
  ADD CONSTRAINT `competitions_organiser_foreign` FOREIGN KEY (`organiser`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `competitions_place_foreign` FOREIGN KEY (`place`) REFERENCES `places` (`plac_id`);

--
-- Megkötések a táblához `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_permission_foreign` FOREIGN KEY (`permission`) REFERENCES `permissions` (`perm_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
