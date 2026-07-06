-- XpelBeauty NG — MySQL Schema for Hostinger
-- Run this in phpMyAdmin or via `mysql -u user -p dbname < database.sql`

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET time_zone = '+00:00';

-- ── Products ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `products` (
  `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`         VARCHAR(255) NOT NULL DEFAULT '',
  `brand`        VARCHAR(150) NOT NULL DEFAULT '',
  `category`     VARCHAR(100) NOT NULL DEFAULT '',
  `price`        DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `stock`        INT NOT NULL DEFAULT 0,
  `image`        TEXT,
  `description`  TEXT,
  `size`         VARCHAR(100) DEFAULT NULL,
  `key_benefits` TEXT DEFAULT NULL,
  `how_to_use`   TEXT DEFAULT NULL,
  `created_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_brand`    (`brand`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Blog Posts ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `blog_posts` (
  `id`             INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title`          VARCHAR(255) NOT NULL DEFAULT '',
  `slug`           VARCHAR(255) NOT NULL DEFAULT '',
  `content`        LONGTEXT,
  `excerpt`        TEXT,
  `featured_image` TEXT,
  `author`         VARCHAR(150) NOT NULL DEFAULT '',
  `published`      TINYINT(1) NOT NULL DEFAULT 0,
  `created_at`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_published` (`published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Stores ───────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `stores` (
  `id`        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`      VARCHAR(255) NOT NULL DEFAULT '',
  `address`   TEXT,
  `city`      VARCHAR(150) DEFAULT NULL,
  `state`     VARCHAR(150) DEFAULT NULL,
  `phone`     VARCHAR(50)  DEFAULT NULL,
  `email`     VARCHAR(255) DEFAULT NULL,
  `hours`     VARCHAR(255) DEFAULT NULL,
  `logo`      TEXT DEFAULT NULL,
  `latitude`  DOUBLE DEFAULT NULL,
  `longitude` DOUBLE DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Enquiries ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `enquiries` (
  `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type`         ENUM('contact','product') NOT NULL DEFAULT 'contact',
  `name`         VARCHAR(255) NOT NULL DEFAULT '',
  `email`        VARCHAR(255) NOT NULL DEFAULT '',
  `subject`      VARCHAR(500) DEFAULT NULL,
  `message`      TEXT,
  `product_id`   INT UNSIGNED DEFAULT NULL,
  `product_name` VARCHAR(255) DEFAULT NULL,
  `status`       ENUM('new','read','replied') NOT NULL DEFAULT 'new',
  `created_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_type`   (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Site Content ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `site_content` (
  `id`         INT UNSIGNED NOT NULL,
  `data`       LONGTEXT NOT NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed a placeholder row so upsert logic always finds id=1
INSERT IGNORE INTO `site_content` (`id`, `data`) VALUES (1, '{}');

SET FOREIGN_KEY_CHECKS = 1;
