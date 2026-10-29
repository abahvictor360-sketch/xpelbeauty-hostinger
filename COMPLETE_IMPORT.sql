-- ============================================================
-- XpelBeauty NG -- COMPLETE MySQL Import (Hostinger)
-- Generated 2026-08-10 from live Supabase data.
-- Run ONCE in phpMyAdmin: Import -> choose this file -> Go.
-- Creates all tables (dropping any existing ones) and loads the
-- full, current product catalogue, blog posts, stockists list and
-- site content. This is the ONLY SQL file you need -- it replaces
-- every other .sql script previously in this repo.
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET NAMES utf8mb4;
SET time_zone = '+00:00';

-- ── DROP existing tables (clean slate) ─────────────────────────────────────
DROP TABLE IF EXISTS `enquiries`;
DROP TABLE IF EXISTS `blog_posts`;
DROP TABLE IF EXISTS `stores`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `site_content`;

-- ── Products ─────────────────────────────────────────────────────────────────
CREATE TABLE `products` (
  `id`           INT UNSIGNED NOT NULL,
  `name`         VARCHAR(255) NOT NULL DEFAULT '',
  `brand`        VARCHAR(150) NOT NULL DEFAULT '',
  `category`     VARCHAR(100) NOT NULL DEFAULT '',
  `price`        DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `stock`        INT NOT NULL DEFAULT 0,
  `sku`          VARCHAR(100) DEFAULT NULL,
  `image`        TEXT,
  `description`  TEXT,
  `size`         VARCHAR(100) DEFAULT NULL,
  `key_benefits` TEXT DEFAULT NULL,
  `how_to_use`   TEXT DEFAULT NULL,
  `active`       TINYINT(1) NOT NULL DEFAULT 1,
  `created_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sku` (`sku`),
  KEY `idx_category` (`category`),
  KEY `idx_brand`    (`brand`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Blog Posts ───────────────────────────────────────────────────────────────
CREATE TABLE `blog_posts` (
  `id`             INT UNSIGNED NOT NULL,
  `title`          VARCHAR(255) NOT NULL DEFAULT '',
  `slug`           VARCHAR(255) NOT NULL DEFAULT '',
  `content`        LONGTEXT,
  `excerpt`        TEXT,
  `featured_image` TEXT,
  `author`         VARCHAR(150) NOT NULL DEFAULT '',
  `category`       VARCHAR(100) DEFAULT NULL,
  `published`      TINYINT(1) NOT NULL DEFAULT 0,
  `created_at`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_slug` (`slug`),
  KEY `idx_published` (`published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Stores ───────────────────────────────────────────────────────────────────
CREATE TABLE `stores` (
  `id`        INT UNSIGNED NOT NULL,
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

-- ── Enquiries (starts empty -- runtime data) ────────────────────────────────
CREATE TABLE `enquiries` (
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
CREATE TABLE `site_content` (
  `id`         INT UNSIGNED NOT NULL,
  `data`       LONGTEXT NOT NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Products data (164 rows) ─────────────────────────────────────────────────
INSERT INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`description`,`size`,`key_benefits`,`how_to_use`,`active`,`created_at`,`updated_at`) VALUES
(213,'Vitamin C Face Serum','Vitamin C','Body & Beauty',5500.0,35,'5060120178862','/Img/Photoroom-20260610_083248_4.png','Brighten, smooth and revitalise your complexion with this powerful Vitamin C Face Serum. Enriched with a potent blend of Vitamin C and Niacinamide, it works to fade dark spots, even skin tone and boost radiance from within. Lightweight and fast-absorbing, it layers seamlessly under moisturiser or SPF for all-day glow. Suitable for all skin types, including sensitive skin. Vegan-friendly formula.',NULL,'Vitamin C helps boost skin''s natural radiance
Niacinamide supports an even, balanced tone
Lightweight, fast-absorbing serum texture
Suitable for daily morning and evening use','Cleanse skin and pat dry.
Dispense 2-3 drops onto fingertips and press gently into face and neck.
Follow with moisturiser. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(214,'Vitamin C Foaming Face Wash','Vitamin C','Body & Beauty',3800.0,50,'5060120178886','/Img/Photoroom-20260610_083248_5.png','Start every morning with a clean, glowing complexion using this Vitamin C Foaming Face Wash. The gentle yet effective formula pairs brightening Vitamin C with pore-refining Niacinamide to dissolve impurities, reduce dullness and leave skin feeling refreshed without stripping natural moisture. A rich, creamy foam rinses clean in seconds - making it the perfect daily skin-prep step. 200ml. Vegan.',NULL,'Vitamin C and niacinamide help boost radiance
Foaming formula lifts away dirt and oil
Vegan formulation
200ml - lasts through daily use','Wet face with warm water.
Massage a small amount into skin to work into a light foam.
Rinse thoroughly and pat dry. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(215,'Vitamin C Revitalising Face Mask','Vitamin C','Body & Beauty',2500.0,60,'5060120178671','/Img/Photoroom-20260610_083248_6.png','Treat your skin to an intensive radiance boost with this Vitamin C Revitalising Face Mask. The ultra-thin, plastic-free sheet is soaked in a concentrated serum of Vitamin C and Niacinamide that floods skin with antioxidant protection, visibly brightens dull areas and smoothes uneven texture in just 15 minutes. Perfect as a weekly treatment or before a special occasion. Suitable for all skin types. Vegan.',NULL,'Vitamin C and niacinamide help revitalise dull skin
Vegan, plastic-free sheet material
Intensive boost of radiance in one treatment
Ideal as a weekly skin pick-me-up','Cleanse skin and pat dry.
Unfold the mask and apply to face, smoothing out air bubbles.
Leave for 15-20 minutes, then remove and gently massage in any excess essence.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(216,'Vitamin C Exfoliating Facial Scrub','Vitamin C','Body & Beauty',3800.0,50,'5060120178824','/Img/Vitamin C Exfoliating Facial Scrub.png','Resurface and illuminate dull, uneven skin with this Vitamin C Exfoliating Facial Scrub. Micro-exfoliating particles combined with brightening Vitamin C work together to gently buff away dead skin cells, reduce the appearance of dark spots and reveal a smoother, more radiant complexion. The creamy, non-stripping formula rinses away easily and can be used 2–3 times a week for best results. 250ml.',NULL,'Vitamin C helps gently exfoliate and resurface skin
Reveals a smoother, more radiant complexion
250ml - several weeks of regular use
Helps skin feel refreshed and renewed','Apply to damp skin using circular motions, avoiding the eye area.
Focus on areas of congestion or uneven texture.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(217,'Vitamin C Salt Body Scrub','Vitamin C','Body & Beauty',4200.0,45,'5060120178848','/Img/Vitamin C Salt Body Scrub.png','Reveal softer, more radiant skin from head to toe with this Vitamin C Salt Body Scrub. Natural salt crystals provide thorough physical exfoliation while Vitamin C-enriched oil nourishes as it buffs, leaving skin visibly smoother, brighter and deeply moisturised. Perfect for use in the shower 2–3 times weekly - simply apply to damp skin, massage in circular motions and rinse. Vegan formula.',NULL,'Vitamin C-enriched salt scrub for brighter, smoother skin
Gently buffs away dry, dull skin
Vegan formulation
Leaves skin feeling soft from head to toe','Apply to damp skin in the shower.
Massage in circular motions over body, focusing on rough areas like elbows and knees.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(218,'Vitamin C Facial Wipes','Vitamin C','Body & Beauty',3000.0,60,'5060120175434','/Img/Vitamin C Facial Wipes.png','On-the-go radiance at your fingertips - these Vitamin C Facial Wipes remove makeup, excess oil and daily grime in a single swipe while delivering a burst of brightening Vitamin C directly to the skin. The generously sized, alcohol-free wipes are gentle enough for daily use and won''t leave residue or a sticky feeling. Perfect for travel, gym bags and desk drawers. 25 wipes per pack. Vegan.',NULL,'Vitamin C helps revitalise tired-looking skin
25 wipes - convenient for travel and on-the-go use
Vegan-friendly formula
Removes makeup and daily grime in one step','Remove a wipe and gently sweep across face and neck.
Focus on makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(219,'Papaya Cleansing Face Wash','Papaya','Body & Beauty',3500.0,50,'5060120175977','/Img/Photoroom-20260610_083249_61.png','Unlock a natural glow with this Papaya Cleansing Face Wash. Rich papaya fruit extract - a natural source of brightening enzymes - works alongside gentle cleansing agents to remove daily impurities, even skin tone and leave skin feeling refreshed and visibly healthier after every wash. The lightweight, lather-building formula is suitable for normal to oily skin and ideal for daily morning and evening use. 250ml.',NULL,'Papaya fruit extract helps cleanse and refresh skin
Supports a healthy, natural glow
250ml - gentle enough for daily use
Leaves skin feeling clean, never tight','Wet face with warm water.
Massage a small amount over face in circular motions.
Rinse thoroughly and pat dry. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(220,'Papaya Hydrating Face Mask','Papaya','Body & Beauty',2500.0,60,'5060120178701','/Img/Photoroom-20260610_083249_71.png','Drench your skin in hydration and luminosity with this Papaya Hydrating Face Mask. The plastic-free, vegan sheet is saturated with a rich serum combining papaya fruit extract with Hyaluronic Acid to deeply moisturise, plump fine lines and restore radiance in just 15–20 minutes. Leave on, relax and reveal noticeably softer, bouncy skin - ideal for use 1–2 times weekly as a replenishing skin treatment.',NULL,'Papaya extract and hyaluronic acid drench skin in hydration
Vegan, plastic-free sheet material
Boosts luminosity in one treatment
Ideal as a weekly hydration ritual','Cleanse skin and pat dry.
Unfold the mask and smooth over face, avoiding eyes and lips.
Leave for 15-20 minutes, then remove and massage in remaining essence.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(221,'Neem Oil Exfoliating Foaming Face Wash','Neem Oil','Body & Beauty',3800.0,45,'5060120180193','/Img/xbc-neem-oil-foaming-face-wash-200ml.png','Clear, purify and refine with this Neem Oil Exfoliating Foaming Face Wash. Cold-pressed neem oil is renowned for its anti-bacterial and anti-inflammatory properties, making this wash ideal for blemish-prone or congested skin types. The foaming exfoliant works to unclog pores, reduce breakouts and smooth the skin''s surface without over-drying. Use morning and evening as part of a complete blemish-care routine. 200ml.',NULL,'Neem oil helps reduce the appearance of blemishes
Gently exfoliates while cleansing
200ml - suitable for daily use
Leaves skin feeling clear and refreshed','Wet face with warm water.
Massage into skin using circular motions to work up a light foam.
Rinse thoroughly. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(222,'Tea Tree & Peppermint Deep Moisturising Foot Pack','Tea Tree','Body & Beauty',2500.0,60,'5060120163530','/Img/tea-tree-peppermint-foot-pack.png','Revive tired, rough feet with this intensive Tea Tree & Peppermint Deep Moisturising Foot Pack. Slip-on socks are saturated in a concentrated blend of anti-bacterial tea tree oil and cooling peppermint that deeply hydrates cracked heels, softens calluses and leaves feet feeling smooth and refreshed. A luxurious at-home pedicure treatment - simply wear for 20 minutes and rinse. 30ml per pair.',NULL,'Tea tree and peppermint help revive tired feet
Deeply moisturises rough, dry skin
Leaves feet feeling soft and refreshed
One 30ml treatment per use','Apply a generous layer to clean, dry feet.
Massage in thoroughly, focusing on heels and rough patches.
Leave for 20 minutes, then rinse or wipe away excess. Use weekly.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(223,'Tea Tree Anti-Bacterial Handwash','Tea Tree','Body & Beauty',2800.0,80,'5060120163257','/Img/40155_HERO.webp','Keep hands clean, healthy and protected with this Tea Tree Anti-Bacterial Handwash. Formulated with natural tea tree oil - a proven anti-bacterial botanical - it effectively eliminates 99.9% of germs while a conditioning base preserves the skin''s natural moisture barrier. Gentle enough for frequent use, it rinses cleanly without leaving a greasy residue. Suitable for the whole family. 500ml.',NULL,'Tea tree oil helps cleanse hands anti-bacterially
Gentle enough for frequent daily use
500ml - long-lasting supply
Leaves hands feeling clean, not stripped','Wet hands with water.
Apply a small amount and lather for 20-30 seconds, covering all surfaces of the hands.
Rinse thoroughly with water.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(224,'Tea Tree Daily Cleansing Facial Wipes (Twin Pack)','Tea Tree','Body & Beauty',3000.0,70,'5060120163387','/Img/40158_HERO.webp','Cleanse and care for your skin on the go with these Tea Tree Daily Cleansing Facial Wipes. Each wipe is infused with natural tea tree oil to gently remove makeup, excess oil and surface impurities while soothing and purifying the skin. Alcohol-free and kind to skin, they are ideal for daily morning cleansing or evening makeup removal. Twin pack - 2 × 25 wipes.',NULL,'Tea tree oil helps cleanse and purify skin
Twin pack, 25 wipes each - great value
Convenient for daily use or travel
Leaves skin feeling fresh and clean','Remove a wipe and gently sweep across face and neck.
Use to remove makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(225,'Tea Tree Foaming Face Wash','Tea Tree','Body & Beauty',3500.0,55,'5060120163424','/Img/Tea Tree Foaming Face Wash.webp','Give your skin a deep, purifying cleanse every day with this Tea Tree Foaming Face Wash. Natural tea tree oil''s powerful anti-bacterial properties help combat blemishes and prevent future breakouts, while a gentle surfactant base creates a rich, creamy lather that lifts away dirt, oil and impurities without disrupting the skin''s natural pH. Suitable for oily, combination and blemish-prone skin. 200ml.',NULL,'Natural tea tree oil helps combat blemishes
Rich, creamy lather lifts away dirt and oil
200ml - suitable for daily cleansing
Suitable for oily, combination and blemish-prone skin','Wet face with warm water.
Massage into skin to work up a rich, creamy lather.
Rinse thoroughly and pat dry. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(226,'Tea Tree Moisturising Conditioner','Xpel Hair Care','Hair Care',3500.0,50,'5060120166432','/Img/40322_HERO.webp','Quench dry, thirsty hair with this Tea Tree Moisturising Conditioner. Enriched with natural tea tree oil and provitamin B5, the formula deeply penetrates the hair shaft to restore moisture, detangle knots and add glossy shine from root to tip. Use after shampooing - apply from mid-lengths to ends, leave for 2–3 minutes and rinse thoroughly for noticeably softer, more manageable hair. 400ml.',NULL,'Tea tree oil helps moisturise dry, thirsty hair
Suitable for frequent, everyday use
400ml - long-lasting formula
Leaves hair soft and manageable','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(227,'Tea Tree Cleansing Pads','Xpel Hair Care','Body & Beauty',3200.0,60,'5060120171467','/Img/40862_HERO.webp','Experience the purifying power of natural tea tree oil in these gentle Tea Tree Cleansing Pads. Each round pad is pre-saturated in a soothing, anti-bacterial toning solution that sweeps away dead skin cells, excess sebum and clogged pores, leaving skin smooth, clarified and refreshed. Ideal as a second-step cleanse after face washing, or as a standalone morning toner. 60 pads per pack.',NULL,'Natural tea tree oil purifies and smooths skin''s surface
60 pads per jar
Deeply cleanses without over-drying
Dermatologically tested','Sweep a pad across face and neck after cleansing.
Use morning and evening as part of your skincare routine.
No rinsing required.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(228,'Tea Tree Facial Toner','Xpel Body Care','Body & Beauty',3000.0,55,'5060120174468','/Img/Tea tree facial toner.webp','Balance, brighten and clarify your skin with this Tea Tree Facial Toner. The lightweight, water-based formula combines natural tea tree oil with gentle botanical extracts to soothe redness, minimise the appearance of pores and prep skin to absorb your serum and moisturiser more effectively. Apply morning and evening with a cotton pad or fingertips after cleansing for visibly clearer, calmer skin. 200ml.',NULL,'Tea tree oil helps balance and clarify skin
Lightweight, non-greasy formula
200ml - suitable for daily use
Preps skin to better absorb moisturiser','After cleansing, sweep across face and neck using a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(229,'Tea Tree Essential Oil','Tea Tree','Body & Beauty',3500.0,50,'5060120168764','/Img/40145_HERO.webp','Harness the pure, concentrated benefits of nature''s most trusted anti-bacterial botanical with this Tea Tree Essential Oil. Steam-distilled for maximum potency, it can be diluted and applied to blemishes, mixed into your shampoo for scalp health, or added to a carrier oil for a soothing massage. Versatile and effective - a must-have in any natural beauty routine.',NULL,'Pure, concentrated tea tree oil - nature''s trusted purifier
Multipurpose: skin, hair and home use
Soothing and purifying properties
30ml concentrated bottle','Dilute a few drops in a carrier oil before applying to skin.
Can also be added to shampoo, face wash or a diffuser.
Patch test before first use.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(230,'Aloe Vera Conditioner','Aloe Vera','Hair Care',3500.0,50,'5060120170835','/Img/Photoroom-20260610_083250_80.png','Smooth, soften and shine with this Aloe Vera Conditioner. A nourishing blend of aloe vera gel and pro-vitamin B5 penetrates deep into the hair fibre to restore moisture balance, repair damage from heat and styling and add mirror-like shine. The lightweight, rinse-out formula won''t weigh hair down - leaving every strand feeling silky and manageable. Suitable for all hair types. 250ml.',NULL,'Aloe vera helps smooth and soften hair
Adds natural shine
250ml - suitable for frequent use
Leaves hair feeling silky and manageable','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(231,'Aloe Vera Nourishing Leave-In Conditioner','Aloe Vera','Hair Care',4000.0,45,'5060120178787','/Img/Photoroom-20260610_083250_81.png','Give your hair the moisture it craves throughout the day with this Aloe Vera Nourishing Leave-In Conditioner. The no-rinse formula blends moisturising aloe vera with pro-vitamin B5 to detangle, protect against humidity and add a light layer of shine without leaving hair greasy or heavy. Simply spray or apply to damp or dry hair and style as usual. Vegan. 250ml.',NULL,'Aloe vera and pro-vitamin B5 nourish hair all day
Leaves hair soft, silky and hydrated
No rinsing required - quick and easy
Vegan formula','Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse out.
Style as usual.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(232,'Aloe Vera Cooling Gel','Aloe Vera','Body & Beauty',2800.0,60,'5060120170873','/Img/Photoroom-20260610_083250_82.png','Soothe, hydrate and restore parched skin with this Aloe Vera Cooling Gel. The refreshing formula delivers an immediate burst of cooling moisture that calms sunburn, razor irritation and dry, tight skin while aloe vera''s natural healing properties work to restore the skin''s barrier. Lightweight and fast-absorbing, it can also be used as an after-sun treatment, daily moisturiser or soothing face mask. 250ml.',NULL,'Aloe vera helps soothe and cool skin
Moisturises and restores dry, exposed skin
Lightweight gel texture
250ml - great for after-sun or everyday use','Apply a generous layer to affected or sun-exposed skin.
Massage in gently until absorbed.
Reapply as needed throughout the day.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(233,'Aloe Vera Nourishing Face Mask','Aloe Vera','Body & Beauty',2200.0,70,'5060120178732','/Img/Photoroom-20260610_083250_83.png','Replenish dry or stressed skin with this Aloe Vera Nourishing Face Mask. The ultra-thin, plastic-free sheet delivers a concentrated serum of hydrating aloe vera extract and Hyaluronic Acid directly to the skin - locking in moisture, plumping fine lines and leaving a dewy, refreshed finish in just 15–20 minutes. Use 2–3 times per week for best results. Vegan-friendly.',NULL,'Aloe vera and hyaluronic acid help replenish dry skin
Vegan, plastic-free sheet material
Ideal as a weekly hydration treatment
Leaves skin feeling soothed and nourished','Cleanse skin and pat dry.
Unfold the mask and smooth over face, avoiding eyes and lips.
Leave for 15-20 minutes, then remove and massage in remaining essence.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(234,'Aloe Vera Heat Defence Spray','Aloe Vera','Hair Care',4200.0,45,'5060120177513','/Img/Aloe-Vera-Heat-Defence-Spray.png','Protect your hair from the damaging effects of heat styling with this Aloe Vera Heat Defence Spray. Enriched with moisturising aloe vera extract, it forms an invisible protective shield around each strand that guards against breakage, frizz and split ends caused by blow-drying and straightening - while adding a glossy, healthy shine. Apply to damp hair before styling. Suitable for all hair types. 150ml.',NULL,'Aloe vera helps hydrate hair before heat styling
Helps defend against heat-styling damage
150ml - lasts through regular styling routines
Leaves hair smoother after use','Apply to towel-dried hair before heat styling.
Distribute evenly through mid-lengths and ends.
Style with heated tools as usual.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(235,'Aloe Vera Cleansing Facial Wipes (Twin Pack)','Aloe Vera','Body & Beauty',3000.0,60,'5060120176356','/Img/xbc-aloe-vera-facial-wipes-twin-pack.png','Gently melt away makeup, sunscreen and daily impurities with these Aloe Vera Cleansing Facial Wipes. Each large, alcohol-free wipe is infused with soothing aloe vera to cleanse thoroughly while simultaneously calming and hydrating the skin - making them ideal for sensitive or dry skin types. Gentle enough for eye makeup removal too. Twin pack - 2 × 25 wipes.',NULL,'Hydrating aloe vera helps soothe skin while cleansing
Twin pack, 25 wipes each - great value
Convenient for daily use or travel
Leaves skin feeling fresh, not stripped','Remove a wipe and gently sweep across face and neck.
Use to remove makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(236,'Aloe Vera Botanical Vegan Shampoo','Aloe Vera','Hair Care',4000.0,45,'5060120176134','/Img/XHC-Botanical-Vegan-Shampoo-Aloe-Vera-400ml-No-Banner-removebg-preview.png','Cleanse and condition your hair naturally with this Aloe Vera Botanical Vegan Shampoo. Blending aloe vera with a gentle botanical surfactant system, it effectively removes product build-up and excess oil while infusing hair with moisture from root to tip - leaving it clean, soft and full of natural shine. Free from sulphates and parabens, it is suitable for colour-treated hair. 400ml. Vegan.',NULL,'Aloe vera gently cleanses without stripping hair
Vegan formula
Leaves hair soft and shiny
400ml - suitable for frequent use','Wet hair thoroughly.
Apply and massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(237,'Black Castor Oil & Avocado Leave-In Conditioner','Black Castor Oil & Avocado','Hair Care',4500.0,40,'5060120179425','/Img/Black Castor Oil & Avocado Leave-In Conditioner.png','Detangle, moisturise and strengthen hair between washes with this Black Castor Oil & Avocado Leave-In Conditioner. The rich, fast-absorbing formula combines the strengthening properties of black castor oil with deeply nourishing avocado extract and Hyaluronic Acid to smooth the cuticle, reduce breakage and maintain moisture all day long. Ideal for natural, relaxed or colour-treated hair. 250ml.',NULL,'Black castor and avocado oil help detangle hair
Adds lasting moisture between washes
No rinsing required
250ml - suitable for frequent use','Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse out.
Style as usual.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(238,'Black Castor Oil & Avocado Shampoo','Black Castor Oil & Avocado','Hair Care',4500.0,40,'5060120179401','/Img/Black Castor Oil & Avocado Shampoo.png','Cleanse, nourish and invigorate your hair and scalp with this Black Castor Oil & Avocado Shampoo. Rich in omega fatty acids, black castor oil penetrates deep into the hair shaft to strengthen from within, while avocado extract adds a protective layer of moisture - leaving hair visibly thicker, shinier and more resilient with every wash. Suitable for all hair types, particularly dry or damaged hair. 400ml.',NULL,'Black castor and avocado oil cleanse and nourish
Helps invigorate hair and scalp
400ml - suitable for frequent use
Boosts shine with every wash','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(239,'Black Castor Oil & Avocado Heat Defence Spray','Black Castor Oil & Avocado','Hair Care',4500.0,40,'5060120177537','/Img/Black Castor Oil & Avocado Heat Defence Spray.png','Defend your hair against heat damage without compromising on style with this Black Castor Oil & Avocado Heat Defence Spray. The lightweight, fast-drying mist forms an invisible heat-protective barrier that guards against temperatures up to 230°C, while black castor oil and avocado extract nourish and add a brilliant shine. Apply before blow-drying, straightening or curling for healthier, more resilient hair. 150ml.',NULL,'Black castor oil and avocado extract defend against heat damage
Helps preserve style without compromise
150ml - lasts through regular styling routines
Leaves hair feeling protected and smooth','Apply to towel-dried hair before heat styling.
Distribute evenly through mid-lengths and ends.
Style with heated tools as usual.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(240,'Black Castor Oil & Avocado Hair & Scalp Treatment','Black Castor Oil & Avocado','Hair Care',4800.0,35,'5060120179449','/Img/Black Castor Oil & Avocado Hair & Scalp Treatment.png','Restore balance to a dry, flaky or oily scalp with this Black Castor Oil & Avocado Hair & Scalp Treatment. The concentrated formula harnesses the anti-inflammatory and moisturising properties of black castor oil and avocado extract, enhanced with Hyaluronic Acid to deeply condition the scalp, reduce itchiness and promote a healthier environment for hair growth. Apply directly to the scalp, massage gently and leave in. 150ml.',NULL,'Hyaluronic acid helps maintain scalp moisture balance
Helps restore balance to dry, flaky or oily scalp
150ml treatment bottle
Suitable for regular use as part of a scalp routine','Apply directly to scalp, focusing on dry or oily areas.
Massage in gently with fingertips.
Leave in or rinse after 10 minutes, depending on preference.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(241,'Purifying Charcoal Cleansing Wipes','Xpel Body Care','Body & Beauty',2800.0,60,'5060120176370','/Img/Purifying Charcoal Cleansing Wipes.png','Purify and revitalise your skin on the move with these Purifying Charcoal Cleansing Wipes. Each large wipe is infused with activated charcoal - nature''s most powerful toxin-absorber - to draw out impurities, excess oil and environmental pollutants from deep within the pores, leaving skin visibly clearer and refreshed. Alcohol-free and gentle enough for daily use on normal to oily skin. 25 wipes.',NULL,'Activated charcoal helps purify and revitalise skin
25 wipes - convenient for daily use or travel
Removes impurities in one easy step
Leaves skin feeling clean and refreshed','Remove a wipe and gently sweep across face and neck.
Use to remove makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(242,'Cleansing Charcoal Face Scrub','Xpel Body Care','Body & Beauty',3500.0,50,'5060120167606','/Img/Cleansing Charcoal Face Scrub.png','Deep-clean and purify your skin with this Cleansing Charcoal Face Scrub. Activated charcoal acts like a magnet to draw out deep-seated impurities, excess sebum and environmental pollutants from clogged pores, while gentle exfoliating particles buff away dead skin cells to leave a smoother, clearer complexion. The paraben and sulphate-free formula is kind to skin and suitable for oily, combination and blemish-prone types. Use 2–3 times per week for best results. 250ml.',NULL,'Activated charcoal deep-cleans and purifies skin
Paraben and sulfate free
250ml - lasts through regular use
Leaves skin feeling revitalised','Apply to damp skin using circular motions, avoiding the eye area.
Focus on areas of congestion.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(243,'Black Tissue Charcoal Detox Facial Mask','Xpel Body Care','Body & Beauty',2200.0,70,'5060120167804','/Img/Black Tissue Charcoal Detox Facial Mask.png','Experience a professional-grade detox facial at home with this Black Tissue Charcoal Detox Facial Mask. The distinctive jet-black sheet is saturated with activated charcoal and revitalising botanical extracts that work together to draw out clogged pores, eliminate blemish-causing bacteria and reveal noticeably clearer, refined skin. Anti-blemish, revitalising and purifying - this mask is the ultimate weekly reset for oily or congested complexions.',NULL,'Activated charcoal draws out impurities for a deep detox
Anti-blemish, revitalising treatment
Professional-grade results at home
Ideal as a weekly skincare ritual','Cleanse skin and pat dry.
Unfold the mask and smooth over face, avoiding eyes and lips.
Leave for 15-20 minutes, then remove and massage in remaining essence.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(244,'Cleansing Charcoal Toothpaste (Free Toothbrush)','Xpel Oral Care','Body & Beauty',2500.0,60,'5060120168115','/Img/xoc-cleansing-charcoal-toothpaste-100ml.png','Transform your smile with this Cleansing Charcoal Toothpaste, complete with a free toothbrush. Activated charcoal''s natural adsorption properties bind to surface stains, plaque and bacteria - gently polishing teeth whiter while freshening breath without harsh chemicals. The mild, low-abrasion formula is safe for daily use and suitable for sensitive teeth. A natural alternative to conventional whitening toothpastes. 100ml.',NULL,'Activated charcoal helps naturally whiten teeth
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing
Leaves mouth feeling clean and fresh','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(245,'Rosemary & Mint Hair Oil','Xpel Hair Care','Hair Care',4000.0,45,'5060120177452','/Img/Photoroom-20260610_083249_63.png','Nourish, strengthen and revitalise your hair with this Rosemary & Mint Hair Oil. A blend of cold-pressed natural oils enhanced with stimulating rosemary and cooling mint work together to smooth the cuticle, eliminate dryness from the scalp and add a glossy, healthy shine from root to tip. Can be used as a pre-shampoo treatment, leave-in finisher or scalp massage oil for maximum benefit. 60ml.',NULL,'Rosemary and mint help nourish and strengthen hair
Helps smooth dry, split ends
60ml - a little goes a long way
Leaves hair feeling revitalised','Apply a few drops to palms and work through mid-lengths and ends.
Can be used on damp or dry hair.
Do not rinse out. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(246,'Rosemary & Mint Conditioner','Xpel Hair Care','Hair Care',3800.0,45,'5060120177865','/Img/Photoroom-20260610_083249_64.png','Enhance your hair''s natural shine and smooth away split ends with this Rosemary & Mint Conditioner. Rosemary oil stimulates the scalp while peppermint extract refreshes and invigorates, and a rich conditioning base deeply nourishes every strand to leave hair feeling silky, manageable and visibly healthier. Apply after shampooing, leave for 2–3 minutes and rinse for lustrous, frizz-free hair. Vegan. 300ml.',NULL,'Rosemary oil and mint enhance natural shine
Helps smooth away split ends
Vegan formula
300ml - suitable for frequent use','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(247,'Rosemary & Mint Shampoo','Xpel Hair Care','Hair Care',3800.0,45,'5060120177841','/Img/Photoroom-20260610_083249_68.png','Support stronger, healthier-looking hair from the very first wash with this Rosemary & Mint Shampoo. Clinically-regarded rosemary oil works at the scalp to improve circulation and strengthen the hair follicle, while invigorating peppermint cleanses thoroughly and leaves a refreshing, long-lasting tingle. The sulphate-free formula is colour-safe and suitable for all hair types, including fine or thinning hair. Vegan. 300ml.',NULL,'Rosemary oil and mint support healthier-looking hair
Cleanses and refreshes the scalp
Vegan formula
300ml - suitable for frequent use','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(248,'Argan Oil Hair Treatment','Argan Oil','Hair Care',4500.0,45,'5060120164714','/Img/40167_HERO.webp','Restore your hair''s natural brilliance with this Argan Oil Hair Treatment. Liquid gold from Morocco - pure Argan oil enriched with Vitamin E - penetrates deep into the hair shaft to repair damage, reduce frizz and deliver an intense burst of moisture that leaves hair visibly smoother, shinier and more resilient. Suitable for all hair types; particularly effective on colour-treated, heat-damaged or dry hair. 100ml.',NULL,'Moroccan argan oil restores natural brilliance
Adds shine and vitamin E
Helps repair the look of damaged hair
100ml - a little goes a long way','Apply to towel-dried hair from mid-lengths to ends.
Do not rinse out.
Style as usual, or use before heat styling.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(249,'Argan Oil Conditioner','Argan Oil','Hair Care',4000.0,45,'5060120164087','/Img/40184_HERO.webp','Hydrate, soften and add brilliant shine with this Argan Oil Conditioner. Premium Moroccan argan oil provides intense moisturisation, repairing the hair''s cuticle and restoring its natural smoothness and elasticity - while a lightweight conditioning base ensures easy detangling and a silky-smooth finish without weighing hair down. Ideal for daily use on normal to dry or damaged hair. Vegan. 300ml.',NULL,'Moroccan argan oil hydrates and softens hair
Leaves hair shiny and smooth
Vegan formula
300ml - suitable for frequent use','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(250,'Argan Oil Hydrating Hair Mask','Argan Oil','Hair Care',4800.0,40,'5060120164131','/Img/Argan Oil Hydrating Hair Mask.webp','Treat your hair to a deep conditioning experience with this Argan Oil Hydrating Hair Mask. The rich, indulgent formula floods every strand with the restorative power of Moroccan argan oil - repairing split ends, taming frizz and restoring softness and luminosity that lasts for days. For best results, apply generously after shampooing, leave for 5–10 minutes and rinse for salon-quality shine at home. Vegan. 350ml.',NULL,'Moroccan argan oil provides deep conditioning
Leaves hair shiny and smooth
Vegan formula
350ml - ideal for a weekly hair treatment','Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes for a deeper treatment.
Rinse thoroughly. Use weekly.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(251,'Argan Oil Heat Defence Leave-In Spray','Argan Oil','Hair Care',4500.0,40,'5060120164346','/Img/40198_HERO.webp','Shield your hair from heat damage while adding luxury hydration with this Argan Oil Heat Defence Leave-In Spray. A fine mist of Moroccan argan oil and conditioning agents forms a protective barrier against temperatures up to 230°C, reducing breakage and maintaining your style''s integrity - while leaving hair with a glossy, frizz-free finish. Spray onto damp or dry hair before heat styling. 150ml.',NULL,'Moroccan argan oil conditions while defending against heat
Helps protect against styling damage
150ml - lasts through regular styling routines
Leaves hair feeling luxuriously soft','Apply to towel-dried hair before heat styling.
Distribute evenly through mid-lengths and ends.
Style with heated tools as usual.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(252,'Argan Oil Facial Wipes (Twin Pack)','Argan Oil','Body & Beauty',3000.0,60,'5060120176332','/Img/41541_HERO.webp','Cleanse and nourish your skin in one effortless step with these Argan Oil Facial Wipes. Infused with pure Moroccan argan oil and gentle cleansing agents, they remove makeup, sunscreen and daily impurities while delivering a dose of deep moisturisation that leaves skin feeling supple and hydrated - never tight or dry. Ideal for dry or mature skin. Twin pack - 2 × 25 wipes.',NULL,'Moroccan argan oil extracts cleanse and nourish
Twin pack, 25 wipes each - great value
Convenient for daily use or travel
Leaves skin feeling soft','Remove a wipe and gently sweep across face and neck.
Use to remove makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(253,'Argan Oil Shampoo','Argan Oil','Hair Care',4500.0,45,'5060120164063','/Img/argan oil shampoo.webp','Nourish, strengthen and add brilliant shine with this Argan Oil Shampoo. Enriched with premium Moroccan argan oil, each wash floods the hair shaft with essential fatty acids and antioxidants that restore vitality to dull, damaged or over-processed hair. The gentle, sulphate-free lather cleanses the scalp without stripping the hair''s natural oils - perfect for daily use on all hair types. 300ml.',NULL,'Moroccan argan oil nourishes and strengthens hair
Adds brilliant shine with every wash
300ml - suitable for frequent use
Leaves hair feeling silky smooth','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(254,'Fresh Start Tea Tree & Lemon Shower Gel','Fresh Start','Body & Beauty',2500.0,70,'5060120163301','/Img/Photoroom-20260610_083249_62.png','Kickstart your day with this invigorating Tea Tree & Lemon Shower Gel. A zesty blend of essential tea tree oil and fresh lemon extract creates a rich, creamy lather that deeply cleanses the body, eliminates odour-causing bacteria and awakens the senses with an uplifting citrus burst. The moisturising formula is gentle on skin, leaving it feeling clean, refreshed and lightly scented all morning long.',NULL,'Tea tree and lemon essential oils invigorate the senses
Cleanses without drying out skin
400ml - lasts for weeks of daily use
A zesty start to any morning','Apply to wet skin in the shower.
Massage into a rich lather all over the body.
Rinse thoroughly. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(255,'Fresh Start Mint & Cucumber Shower Gel','Fresh Start','Body & Beauty',2500.0,70,'5060120163325','/Img/Photoroom-20260610_083249_65.png','Refresh, revive and recharge with this Mint & Cucumber Shower Gel. The cooling, tingly formula combines menthol-rich mint with hydrating cucumber extract to cleanse the skin thoroughly while delivering an immediate sensation of freshness and vitality. Perfect as an evening shower to unwind after a long day or as a morning wake-up. Gentle enough for daily use on all skin types.',NULL,'Mint and cucumber essential oils refresh and revive
Cooling, invigorating sensation
400ml - lasts for weeks of daily use
Leaves skin feeling clean and recharged','Apply to wet skin in the shower.
Massage into a rich lather all over the body.
Rinse thoroughly. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(256,'Fresh Start Coconut & Lime Shower Gel','Fresh Start','Body & Beauty',2500.0,70,'5060120163318','/Img/xbc-fresh-start-coconut-lime-shower-gel.png','Indulge in a tropical cleansing experience with this Coconut & Lime Shower Gel. The rich, creamy lather bursts with the sweet, exotic fragrance of coconut and zesty lime while nourishing fatty acids from coconut oil leave the skin feeling deeply moisturised and irresistibly soft. A little goes a long way - and the long-lasting tropical scent lingers beautifully on the skin throughout the day.',NULL,'Coconut and lime essential oils create a tropical escape
Moisturising formula with essential oils
400ml - lasts for weeks of daily use
Leaves skin soft and lightly scented','Apply to wet skin in the shower.
Massage into a rich lather all over the body.
Rinse thoroughly. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(257,'So Fresh Watermelon Crush Pore-Tight Toner','So Fresh','Body & Beauty',3500.0,50,'5060120176844','/Img/Photoroom-20260610_083250_72.png','Minimise pores and balance your skin with this So Fresh Watermelon Crush Pore-Tight Toner. A powerful yet gentle blend of watermelon extract, Hyaluronic Acid and Vitamin C calms post-cleanse redness, visibly tightens enlarged pores and primes skin to absorb the next steps in your routine more effectively. Apply morning and evening after cleansing for a smoother, more refined complexion over time. 200ml.',NULL,'Watermelon extract helps calm and soothe skin
Helps minimise the look of pores
200ml - suitable for daily use
Preps skin to better absorb moisturiser','After cleansing, sweep across face using a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(258,'So Fresh Watermelon Crush Gel Moisturiser','So Fresh','Body & Beauty',3800.0,50,'5060120176868','/Img/Photoroom-20260610_083250_73.png','Quench thirsty skin and lock in lasting moisture with this So Fresh Watermelon Crush Gel Moisturiser. The feather-light, water-gel texture absorbs instantly without greasiness - delivering a potent blend of Hyaluronic Acid, watermelon extract and Vitamin E deep into the skin for plump, hydrated, radiant-looking skin that lasts all day. Suitable for oily, combination and normal skin. Use morning and evening.',NULL,'Hyaluronic acid and watermelon extract quench thirsty skin
Fast-absorbing gel texture
Locks in lasting moisture
50ml - suitable for daily use','Apply a small amount to cleansed face and neck.
Massage in gently until absorbed.
Use morning and evening as the final step of your routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(259,'So Fresh Watermelon Crush Daily Facial Scrub','So Fresh','Body & Beauty',3500.0,50,'5060120176820','/Img/Photoroom-20260610_083250_74.png','Refresh, brighten and smooth your skin with this So Fresh Watermelon Crush Daily Facial Scrub. Gentle exfoliating microspheres lift away dead skin cells and surface impurities while watermelon extract - packed with antioxidants and amino acids - replenishes and revitalises the newly revealed skin beneath. The non-abrasive formula is suitable for daily use and won''t cause sensitivity or micro-tears. 100ml.',NULL,'Watermelon extract gently buffs away dead skin cells
Brightens and smooths in one step
100ml - suitable for daily use
Leaves skin feeling refreshed','Apply to damp skin using circular motions, avoiding the eye area.
Focus on areas of congestion or dullness.
Rinse thoroughly. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(260,'So Fresh Watermelon Crush Sheet Mask','So Fresh','Body & Beauty',2200.0,70,'5060120176882','/Img/Photoroom-20260610_083250_77.png','Hydrate, soothe and glow with this So Fresh Watermelon Crush Sheet Mask. The ultra-thin, plant-based sheet is soaked in an intensive serum of watermelon extract, Hyaluronic Acid and Vitamin B5 that floods the skin with moisture, calms irritation and restores a dewy, plumped luminosity in just 15–20 minutes. Perfect as a weekly treatment, pre-event prep or post-sun soother. Vegan.',NULL,'Watermelon extract and vitamin B5 hydrate and soothe
Plant-based, hydrating sheet material
Ideal as a weekly skincare treat
Leaves skin glowing and refreshed','Cleanse skin and pat dry.
Unfold the mask and smooth over face, avoiding eyes and lips.
Leave for 15-20 minutes, then remove and massage in remaining essence.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(261,'Purple Whitening Toothpaste (Free Bamboo Toothbrush)','Xpel Oral Care','Body & Beauty',3500.0,50,'5060120177292','/Img/Photoroom-20260610_083249_66.png','Achieve visibly whiter teeth with this colour-correction Purple Whitening Toothpaste with free Bamboo Toothbrush. The unique purple dye neutralises yellow tones through optical colour science - the same principle used in hair toners - while a polishing formula gently lifts surface stains for a noticeably brighter smile. Free from harsh bleaching agents; safe for daily use and sensitive teeth. 100ml.',NULL,'Purple colour-correction technology helps counteract yellow stains
Polishing formula helps whiten teeth
Comes complete with a free bamboo toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free bamboo toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(262,'Purple Whitening Mouthwash','Xpel Oral Care','Body & Beauty',3200.0,50,'5060120177742','/Img/Photoroom-20260610_083249_69.png','Brighten, freshen and protect your smile with this Purple Whitening Mouthwash. The advanced colour-correction formula uses purple pigments to neutralise yellowing and optically whiten teeth with every rinse, while antibacterial agents fight bad breath, reduce plaque and strengthen gum health. Use after brushing for a complete oral care routine with a visibly whiter result over time. 500ml.',NULL,'Purple whitening technology helps prevent new stains
Freshens breath and reduces plaque
500ml - lasts for weeks of daily use
Part of the Purple Whitening system','Use 10-15ml undiluted after brushing.
Swish around the mouth for 30 seconds.
Spit out - do not swallow or rinse with water afterwards.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(263,'Purple Polishing Tooth Powder','Xpel Oral Care','Body & Beauty',2800.0,60,'5060120177780','/Img/Photoroom-20260610_083249_70.png','Polish away stains and reveal a brighter smile with this Purple Polishing Tooth Powder. The unique colour-correcting formula combines fine polishing agents with purple optical brighteners to neutralise yellow tones and lift surface stains caused by coffee, tea and food - leaving teeth visibly whiter and enamel feeling smooth. Simply dip a damp toothbrush, brush for 2 minutes and rinse.',NULL,'Purple colour-correction technology for whiter teeth
Polishing formula lifts surface stains
A unique alternative to traditional toothpaste
Compact, travel-friendly format','Dip a damp toothbrush into the powder.
Brush teeth gently for two minutes.
Rinse thoroughly. Use daily in place of, or alongside, toothpaste.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(264,'Neem Oil & Mint Toothpaste (Free Toothbrush)','Neem Oil','Body & Beauty',2800.0,60,'5060120180056','/Img/xoc-neem-oil-mint-toothpaste-100ml.png','Cleanse, protect and freshen your breath naturally with this Neem Oil & Mint Toothpaste, complete with a free toothbrush. Neem oil is a traditional Ayurvedic ingredient prized for its powerful anti-bacterial and anti-plaque properties - combined with refreshing mint, it effectively combats bad breath, reduces cavity-causing bacteria and promotes healthier gums with daily use. 100ml.',NULL,'Neem oil has naturally anti-bacterial properties
Mint helps combat bad breath
Helps support healthy teeth and gums
Comes complete with a free toothbrush','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(265,'Activated Charcoal Whitening Mouthwash','Xpel Oral Care','Body & Beauty',3200.0,50,'5060120168214','/Img/Activated Charcoal Whitening Mouthwash.png','Whiten and detoxify your smile with this Activated Charcoal Whitening Mouthwash. Activated charcoal''s extraordinary adsorption capacity binds to stain-causing compounds from coffee, tea and food, removing them from tooth enamel for a brighter, whiter smile over time. Antibacterial agents simultaneously freshen breath and protect gum health - making this the ultimate two-in-one oral detox rinse. 500ml.',NULL,'Activated charcoal helps whiten and remove deep stains
Supports a fresher, brighter smile
500ml - lasts for weeks of daily use
Helps detoxify the mouth','Use 10-15ml undiluted after brushing.
Swish around the mouth for 30 seconds.
Spit out - do not swallow or rinse with water afterwards.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(266,'TrueSmile Tartar Defence Toothpaste & Toothbrush','TrueSmile','Body & Beauty',2800.0,60,'5061015257068','/Img/Photoroom-20260610_083248_1.png','Defend against tartar build-up and enjoy a noticeably cleaner, whiter smile with TrueSmile Tartar Defence Toothpaste, complete with a free toothbrush. The fluoride-enriched formula prevents tartar hardening on the enamel, fights cavity-causing bacteria and leaves a clean, fresh mint sensation that lasts for hours. A complete daily oral care solution for the whole family. 100ml.',NULL,'Fluoride formula helps defend against tartar build-up
Supports a noticeably cleaner, whiter smile
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(267,'TrueSmile Triple Protect Toothpaste & Toothbrush','TrueSmile','Body & Beauty',2800.0,60,'5061015256955','/Img/truesmile-triple-protect-toothpaste-100ml.png','Get total mouth protection in a single brush with TrueSmile Triple Protect Toothpaste and free toothbrush. The advanced triple-action formula combines cavity protection, gum strengthening and breath freshening in one effective toothpaste - fighting bacteria, reducing inflammation and leaving your entire mouth feeling clean and revitalised after every use. 100ml.',NULL,'Triple protection for gums, teeth and breath
Total daily mouth care in one tube
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(268,'TrueSmile ProPurple Toothpaste & Toothbrush','TrueSmile','Body & Beauty',3200.0,50,'5061015256977','/Img/truesmile-propurple-toothpaste-100ml.png','Reveal a whiter smile with every brush using TrueSmile ProPurple Toothpaste with free toothbrush. The innovative purple colour-correcting formula neutralises yellow tones through optical science, reducing the appearance of staining without the use of harsh bleaching agents. Gentle on enamel and safe for daily use - perfect for those who want a brighter smile without sensitivity. 100ml.',NULL,'Colour-correcting purple formula for a whiter-looking smile
Reveals brighter teeth with regular use
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(269,'Sensio Enamel Restore Toothpaste','TrueSmile','Body & Beauty',3000.0,50,'5061015255972','/Img/sensio-enamel-restore-toothpaste-75ml.png','Protect and rebuild vulnerable tooth enamel with Sensio Enamel Restore Toothpaste. The advanced fluoride formula remineralises weakened enamel, helping to restore its hardness and natural whiteness while providing long-lasting sensitivity relief. Fresh cool mint flavour ensures a clean, pleasant brushing experience that leaves teeth and gums feeling strengthened. Ideal for those with enamel erosion, sensitivity or a high-acid diet. 75ml.',NULL,'Formulated to help protect and rebuild vulnerable enamel
Cool mint flavour
Suitable for daily use
75ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use in place of your regular toothpaste.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(270,'Sensio Gentle Whitening Toothpaste','TrueSmile','Body & Beauty',3000.0,50,'5061015256009','/Img/Photoroom-20260610_083248_8.png','Gently restore your smile''s natural whiteness with Sensio Gentle Whitening Toothpaste. Unlike harsh chemical whiteners, this carefully balanced formula uses optical brighteners and mild polishing agents to lift surface stains and improve brightness without causing enamel damage or sensitivity. Fluoride protection strengthens teeth with every brush, while cool mint delivers a refreshing, long-lasting clean. 75ml.',NULL,'Gently helps restore teeth''s natural whiteness
Cool mint flavour
Suitable for sensitive teeth
75ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use in place of your regular toothpaste.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(271,'Sensio Instant Relief Toothpaste','TrueSmile','Body & Beauty',3000.0,50,'5061015255989','/Img/Photoroom-20260610_083248_9.png','Get fast, targeted relief from tooth sensitivity with Sensio Instant Relief Toothpaste. The clinically-considered formula creates a protective barrier over exposed dentine, blocking pain signals from reaching the nerve and providing immediate comfort when eating or drinking hot, cold or sweet items. Use twice daily for best results - noticeable sensitivity reduction within 2 weeks of regular use. Fresh mint. 75ml.',NULL,'Fast, targeted relief from tooth sensitivity
Fresh mint flavour
Suitable for daily use
75ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use in place of your regular toothpaste.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(272,'Sensio Sensitivity + Gum Twin Pack','TrueSmile','Body & Beauty',5500.0,35,'5061015255996','/Img/Photoroom-20260610_083248_10.png','A comprehensive sensitivity and gum care solution - this Sensio Sensitivity + Gum Twin Pack provides double the formula at outstanding value. Each tube delivers fluoride-enriched protection that soothes sensitivity while anti-bacterial agents reduce gum inflammation and protect against gingivitis. Perfect for those who experience both sensitivity and gum discomfort. Twin pack - 2 × 75ml.',NULL,'Comprehensive sensitivity and gum care in one twin pack
Helps soothe and strengthen gums
Two 75ml tubes - great value
Suitable for daily use','Brush teeth for two minutes, morning and night.
Use one tube for sensitivity, the other for gum care, as needed.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(273,'TrueSmile Monster Kids Bubble Gum Toothpaste','TrueSmile','Body & Beauty',2500.0,70,'5061015253732','/Img/Photoroom-20260610_083248_11.png','Make brushing a fun daily adventure with TrueSmile Monster Kids Bubble Gum Toothpaste and free toothbrush. The mild, kids-safe fluoride formula gently cleans little teeth, fights cavities and keeps breath fresh - all in a sweet, irresistible bubble gum flavour that children actually enjoy. The fun monster character packaging makes brushing time something to look forward to. Suitable for children 3+.',NULL,'Fun bubble gum flavour makes brushing something to look forward to
Contains fluoride for cavity protection
Comes complete with a free toothbrush
100ml - sized for little brushers','Brush teeth for two minutes, morning and night, with adult supervision.
Use the free toothbrush provided.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(274,'TrueSmile Charcoal Natural Whitening Toothpaste','TrueSmile','Body & Beauty',3200.0,50,'5061015250953','/Img/Photoroom-20260610_083248_12.png','Whiten naturally and remove deep stains with TrueSmile Charcoal Natural Whitening Toothpaste and free toothbrush. Activated carbon microspheres bind to coffee, tea and tobacco stains, gently lifting them from the enamel surface to reveal whiter, brighter teeth over time. The fluoride formula simultaneously strengthens enamel and freshens breath - a natural approach to a dazzling smile. 100ml.',NULL,'Activated charcoal helps naturally whiten teeth
Removes deep-set stains
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(275,'TrueSmile Baking Soda Whitening Toothpaste','TrueSmile','Body & Beauty',2800.0,60,'5061015253725','/Img/Photoroom-20260610_083248_13.png','Harness the proven whitening power of baking soda with TrueSmile Baking Soda Whitening Toothpaste and free toothbrush. Sodium bicarbonate gently polishes surface stains from tea, coffee and food while neutralising acid in the mouth to create a healthier oral environment that prevents new stain formation. Fluoride protection strengthens teeth against cavities. A daily whitening ritual for brighter, healthier teeth. 100ml.',NULL,'Baking soda helps lift and prevent stains
Extra-whitening formula
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(276,'TrueSmile Monster Kids Strawberry Toothpaste','TrueSmile','Body & Beauty',2500.0,70,'5061015253749','/Img/Photoroom-20260610_083248_14.png','Turn brushing into something kids actually want to do with TrueSmile Monster Kids Strawberry Toothpaste and free toothbrush. The mild, child-friendly fluoride formula keeps young teeth clean and cavity-free in a sweet strawberry flavour that little ones adore. Packed with cavity-fighting fluoride and gentle enough for sensitive milk teeth. The playful monster packaging makes oral hygiene a daily delight. Suitable for children 3+.',NULL,'Fun strawberry flavour makes brushing something to look forward to
Contains fluoride for cavity protection
Comes complete with a free toothbrush
100ml - sized for little brushers','Brush teeth for two minutes, morning and night, with adult supervision.
Use the free toothbrush provided.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(277,'TrueSmile ProClean Toothpaste & Toothbrush','TrueSmile','Body & Beauty',3000.0,50,'5061015250557','/Img/Photoroom-20260610_083248_15.png','Get an extreme clean with every brush using TrueSmile ProClean Toothpaste and free toothbrush. Cooling crystal microspheres release a surge of freshness as you brush - penetrating between teeth and along the gum line to remove plaque, dislodge food particles and leave your entire mouth feeling deeply cleaned and invigorated. Fluoride formula protects against cavities and enamel erosion. 100ml.',NULL,'Cooling crystals deliver an extreme clean feeling
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing
Leaves mouth feeling intensely fresh','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(278,'TrueSmile ProCare Toothpaste & Toothbrush','TrueSmile','Body & Beauty',3000.0,50,'5061015250571','/Img/Photoroom-20260610_083248_16.png','Comprehensive daily oral care in one tube - TrueSmile ProCare Toothpaste with free toothbrush combines cavity prevention, enamel strengthening and breath freshening in a complete care formula suitable for the whole family. The advanced fluoride system creates a protective shield around each tooth after every brush, defending against decay, sensitivity and staining long after you''ve rinsed. 100ml.',NULL,'Complete daily care formula for teeth and gums
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing
Suitable for everyday use','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(279,'TrueSmile ProWhite Toothpaste & Toothbrush','TrueSmile','Body & Beauty',3200.0,50,'5061015250564','/Img/Photoroom-20260610_083248_17.png','Achieve a noticeably whiter smile with the advanced science of TrueSmile ProWhite Toothpaste and free toothbrush. Sodium phytate - a natural compound derived from plant seeds - inhibits the formation of new stains while gently lifting existing discolouration, helping enamel maintain its natural brightness. Fluoride protection guards against cavities, and a crisp mint finish leaves your mouth feeling impeccably clean. 100ml.',NULL,'Sodium phytate technology supports advanced whitening
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing
Helps reveal a visibly whiter smile','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(280,'Intimelle Aloe Vera Daily Feminine Wash','Intimelle','Body & Beauty',3500.0,50,'5061015256412','/Img/Photoroom-20260610_083248_18.png','Care for your most intimate skin with this Intimelle Aloe Vera Daily Feminine Wash. Specially formulated with a gentle, soap-free pH-balanced formula, it cleanses the intimate area without disrupting the skin''s natural flora or causing irritation. Enriched with soothing aloe vera, it leaves skin feeling fresh, comfortable and protected throughout the day. Dermatologist-tested and hypo-allergenic - suitable for daily use. 250ml.',NULL,'Aloe vera helps soothe sensitive skin
Soap-free, pH-balanced formula
Hypo-allergenic and gentle
250ml - suitable for daily use','Use daily during bathing or showering.
Apply a small amount to the intimate area and rinse thoroughly with water.
Pat dry gently.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(281,'Hot Rose Lip Butter Cherry Pie','Hot Rose','Body & Beauty',2500.0,60,'HR-LBCP-15','/Img/Photoroom-20260610_083248_21.png','Indulge your lips in rich, fruity nourishment with Hot Rose Lip Butter in Cherry Pie. The velvety, creamy texture glides on effortlessly to deeply moisturise dry or chapped lips - delivering a combination of conditioning butters and oils that restore softness, smooth cracks and leave a luscious, cherry-kissed scent and a beautiful subtle tint. Wear alone or under lipstick for all-day comfortable hydration. 15ml.',NULL,'Rich, nourishing formula conditions lips
Cherry Pie flavour
15ml - pocket-sized for on-the-go touch-ups
Leaves lips soft and hydrated','Apply directly to lips as needed throughout the day.
Reapply after eating or drinking.
Use alone or under lipstick.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(282,'Hot Rose Lip Butter Peach Macaron','Hot Rose','Body & Beauty',2500.0,60,'HR-LBPM-15','/Img/Photoroom-20260610_083249_60.png','Treat your lips to the ultimate indulgence with Hot Rose Lip Butter in Peach Macaron. The luxuriously rich formula blends conditioning shea butter and nourishing plant oils with an irresistible peach macaron fragrance that makes every application a sensory delight. Deeply hydrating, it repairs cracked lips, enhances natural colour and leaves a silky-smooth, kissable finish. Perfect for daily wear or as an overnight lip mask. 15ml.',NULL,'Rich, nourishing formula conditions lips
Peach Macaron flavour
15ml - pocket-sized for on-the-go touch-ups
Leaves lips soft and hydrated','Apply directly to lips as needed throughout the day.
Reapply after eating or drinking.
Use alone or under lipstick.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(283,'Hot Rose Fixt Vit C Setting Spray','Hot Rose','Body & Beauty',4500.0,40,'5061015258379','/Img/Photoroom-20260610_083248_20.png','Lock in your makeup and energise your skin with Hot Rose Fixt Vitamin C Setting Spray. This invigorating mist fuses a luminous, makeup-setting formula with the brightening power of Vitamin C and the uplifting scent of Tuscan Cypress and Mandarin essential oils. A fine, even spray sets foundation, reduces powder fallout and adds a radiant, healthy glow - keeping your makeup flawless all day. Vegan.',NULL,'Vitamin C helps energise and brighten skin
Tuscan Cypress and Mandarin scent
Locks in makeup all day
Setting spray with skincare benefits','After completing makeup, hold bottle 20-30cm from face.
Close eyes and mist evenly across face.
Allow to air dry - do not rub.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(284,'Hot Rose Fixt Dewy Setting Spray','Hot Rose','Body & Beauty',4500.0,40,'5061015258355','/Img/Photoroom-20260610_083248_22.png','Achieve a glowing, dewy complexion that lasts all day with Hot Rose Fixt Dewy Setting Spray. The ultra-fine mist melts into makeup seamlessly, setting it in place while infusing the skin with a burst of hydration from lychee water and Damask Rose Hydrosol - leaving a luminous, lit-from-within finish. Perfect for dry or normal skin types wanting a glassy, glass-skin effect that lasts. Vegan.',NULL,'Lychee and Damask Rose Hydrosol give an ultra-glow finish
Locks in makeup with a dewy finish
Setting spray with skincare benefits
Refreshing floral scent','After completing makeup, hold bottle 20-30cm from face.
Close eyes and mist evenly across face.
Allow to air dry - do not rub.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(285,'Hot Rose Fixt Matte Setting Spray','Hot Rose','Body & Beauty',4500.0,40,'5061015258362','/Img/Photoroom-20260610_083248_25.png','Set your makeup for a flawless, all-night matte finish with Hot Rose Fixt Matte Setting Spray. The weightless formula locks colour in place and minimises excess oil production, while Vetiver Root and Squalane keep skin balanced and comfortable without drying it out. The ultra-fine mist evens the appearance of pores and extends the wear of your makeup from morning to midnight. Vegan.',NULL,'Vetiver Root and Squalane deliver a long-lasting matte finish
Locks in makeup all night long
Setting spray with skincare benefits
Controls shine without feeling drying','After completing makeup, hold bottle 20-30cm from face.
Close eyes and mist evenly across face.
Allow to air dry - do not rub.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(286,'Hot Rose Hyaluronic Acid Skin Capsule Serum','Hot Rose','Body & Beauty',5500.0,35,'5061015259840','/Img/Photoroom-20260610_083249_34.png','Plump, hydrate and smooth your skin in one step with Hot Rose Hyaluronic Acid Skin Capsule Serum. Each biodegradable capsule dissolves on contact with skin, releasing a concentrated multi-molecular weight Hyaluronic Acid serum that penetrates multiple skin layers simultaneously - attracting and retaining moisture for an immediate plumping effect and a long-lasting hydrated glow. Use morning or evening before moisturiser.',NULL,'Multi-molecular hyaluronic acid plumps and hydrates
Smooths the appearance of fine lines
Single-use capsules - no preservatives needed
Ideal for an extra hydration boost','Twist and snap open one capsule.
Massage the contents into cleansed face and neck.
Follow with moisturiser. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(287,'Hot Rose Vitamin C Glow Skin Capsule Serum','Hot Rose','Body & Beauty',5500.0,35,'5061015259833','/Img/Photoroom-20260610_083249_35.png','Brighten, even and protect your complexion with Hot Rose Vitamin C Glow Skin Capsule Serum. Each precisely dosed capsule delivers a potent, freshly-activated concentration of stabilised Vitamin C directly onto the skin - fading dark spots, evening skin tone and boosting natural radiance. The single-use format preserves the Vitamin C''s efficacy to the last capsule, ensuring maximum brightening results every time.',NULL,'Vitamin C helps boost radiance and even tone
Brightens the look of dull, tired skin
Single-use capsules - no preservatives needed
Ideal for an extra glow boost','Twist and snap open one capsule.
Massage the contents into cleansed face and neck.
Follow with moisturiser. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(288,'Hot Rose Vitamin E Antioxidant Skin Capsule Serum','Hot Rose','Body & Beauty',5500.0,35,'5061015259857','/Img/Photoroom-20260610_083249_37.png','Restore and protect your skin''s barrier with Hot Rose Vitamin E Antioxidant Skin Capsule Serum. Each capsule delivers a pure concentration of Vitamin E - one of nature''s most powerful antioxidants - that neutralises free radical damage, calms inflammation and deeply nourishes dehydrated or stressed skin. Single-use capsules preserve freshness and potency, ensuring every application is as effective as the last.',NULL,'Vitamin E helps repair and protect skin''s barrier
Calming, antioxidant-rich formula
Single-use capsules - no preservatives needed
Ideal for stressed or sensitised skin','Twist and snap open one capsule.
Massage the contents into cleansed face and neck.
Follow with moisturiser. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(289,'Hot Rose Niacinamide Clarifying Skin Capsule Serum','Hot Rose','Body & Beauty',5500.0,35,'5061015259864','/Img/Photoroom-20260610_083249_39.png','Refine pores and control oil with Hot Rose Niacinamide Clarifying Skin Capsule Serum. Each capsule releases a concentrated, freshly-activated dose of Niacinamide - clinically proven to minimise pores, regulate sebum production, reduce blemishes and improve uneven skin tone. The innovative bead format allows you to massage the formula into specific problem areas for a precisely targeted, high-potency treatment.',NULL,'Niacinamide helps refine the look of pores
Oil-control beads help clarify skin
Single-use capsules - no preservatives needed
Ideal for oily or congested skin','Twist and snap open one capsule.
Massage the contents into cleansed face and neck.
Follow with moisturiser. Use daily or as needed.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(290,'Hot Rose Mixt Duo Makeup Remover Lychee & Rosewater','Hot Rose','Body & Beauty',3800.0,45,'5061015259239','/Img/Photoroom-20260610_083249_56.png','Gently and thoroughly remove even the most stubborn makeup with Hot Rose Mixt Duo Makeup Remover in Lychee & Rosewater. The bi-phase formula - shake to activate - combines a micellar water layer with a conditioning oil layer to dissolve mascara, foundation and lip colour in one swipe while Vitamin C brightens and lychee water refreshes. Suitable for all skin types, including sensitive. Vegan.',NULL,'Lychee and rosewater dissolve stubborn makeup gently
Vitamin C-enriched formula
Removes makeup in one easy step
Suitable for daily use','Saturate a cotton pad with product.
Sweep gently over face to dissolve makeup, including eye makeup.
No rinsing required - follow with your usual skincare routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(291,'Hot Rose Mixt Duo Makeup Remover Cucumber & Mint','Hot Rose','Body & Beauty',3800.0,45,'5061015259253','/Img/Photoroom-20260610_083249_58.png','Experience the refreshing sensation of Hot Rose Mixt Duo Makeup Remover in Cucumber & Mint. The bi-phase formula combines cooling cucumber extract with wild mint and Vitamin E to efficiently dissolve full-face makeup - including waterproof products - while simultaneously toning and refreshing the skin. Simply shake, apply to a cotton pad and wipe away for impeccably clean, soothed skin. Vegan.',NULL,'Cucumber and wild mint refresh while removing makeup
Vitamin E-enriched formula
Gentle, cooling sensation
Suitable for daily use','Saturate a cotton pad with product.
Sweep gently over face to dissolve makeup, including eye makeup.
No rinsing required - follow with your usual skincare routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(292,'Hot Rose Mixt Duo Makeup Remover Neroli & Mandarin','Hot Rose','Body & Beauty',3800.0,45,'5061015259246','/Img/Photoroom-20260610_083249_59.png','Dissolve makeup and invigorate skin with Hot Rose Mixt Duo Makeup Remover in Neroli & Mandarin. The luxurious bi-phase formula blends delicate neroli flower water with brightening Vitamin C and mandarin oil to remove all traces of makeup and impurities while leaving skin visibly more radiant and delicately perfumed. Perfect for an indulgent end-of-day cleansing ritual. Shake well before use. Vegan.',NULL,'Neroli and mandarin invigorate while removing makeup
Vitamin C-enriched, brightening formula
Dissolves makeup gently and effectively
Suitable for daily use','Saturate a cotton pad with product.
Sweep gently over face to dissolve makeup, including eye makeup.
No rinsing required - follow with your usual skincare routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(293,'Hot Rose Serena Serum Deodorant Twilight Dream','Hot Rose','Body & Beauty',4000.0,45,'5061015259918','/Img/Photoroom-20260610_083249_46.png','Elevate your daily routine with Hot Rose Serena Serum Deodorant in Twilight Dream. This innovative aluminium-free formula features +5% AHA (glycolic acid) to gently exfoliate underarm skin over time, reducing pigmentation and leaving skin smoother and more even-toned with regular use. The Santal and Cedarwood scent lingers warmly throughout the day with up to 72 hours of odour protection. Vegan.',NULL,'+5% AHA gently exfoliates underarm skin
Santal and Cedarwood scent
Aluminium-free formula
Serum texture absorbs quickly','Apply to clean, dry underarms.
Allow to absorb fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(294,'Hot Rose Serena Serum Deodorant Tropical Green','Hot Rose','Body & Beauty',4000.0,45,'5061015259925','/Img/Photoroom-20260610_083249_47.png','Stay fresh and confident all day with Hot Rose Serena Serum Deodorant in Tropical Green. The aluminium-free, AHA-enriched serum formula provides effective odour protection while gently exfoliating and brightening underarm skin. A vibrant blend of Bergamot and Green Fig creates an uplifting, fresh tropical scent that lasts from morning to evening. Gentle enough for sensitive underarm skin. Vegan.',NULL,'+5% AHA gently exfoliates underarm skin
Bergamot and Green Fig scent
Aluminium-free formula
Serum texture absorbs quickly','Apply to clean, dry underarms.
Allow to absorb fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(295,'Hot Rose Serena Serum Deodorant Blue Shell','Hot Rose','Body & Beauty',4000.0,45,'5061015259901','/Img/Photoroom-20260610_083249_49.png','Feel ocean-fresh all day with Hot Rose Serena Serum Deodorant in Blue Shell. The innovative aluminium-free serum is enriched with +5% AHA to gradually improve underarm skin tone and texture while delivering up to 72-hour odour protection. A clean, aquatic blend of Seasalt and Driftwood creates a crisp, refreshing scent that keeps you feeling confident from morning to night. Vegan.',NULL,'+5% AHA gently exfoliates underarm skin
Seasalt and Driftwood scent
Aluminium-free formula
Serum texture absorbs quickly','Apply to clean, dry underarms.
Allow to absorb fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(296,'Hot Rose Serena Serum Deodorant First Bloom','Hot Rose','Body & Beauty',4000.0,45,'5061015259895','/Img/Photoroom-20260610_083249_50.png','Wrap yourself in warmth and freshness with Hot Rose Serena Serum Deodorant in First Bloom. The gentle aluminium-free formula combines the skin-smoothing benefits of +5% AHA with lasting odour protection - gradually brightening underarm skin with regular use. The delicate, comforting blend of Vanilla and Almond creates a sweet, alluring scent that evolves beautifully throughout the day. Vegan.',NULL,'+5% AHA gently exfoliates underarm skin
Vanilla and Almond scent
Aluminium-free formula
Serum texture absorbs quickly','Apply to clean, dry underarms.
Allow to absorb fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(297,'Nulab Feelin Bliss Roll-On Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015255804','/Img/Photoroom-20260610_083248_23.png','Feel fresh and feminine all day with Nulab Feelin Bliss Roll-On Deodorant. The 48-hour anti-perspirant formula effectively controls sweat and odour, leaving the underarm area feeling dry and comfortable throughout the day. Enriched with a delicate pomegranate and lotus fragrance, it provides long-lasting freshness without alcohol, allowing it to be applied safely immediately after shaving. 50ml.',NULL,'48-hour anti-perspirant protection
Pomegranate & Lotus fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(298,'Nulab Feelin Bliss Stick Deodorant','Nulab','Body & Beauty',3500.0,50,'5061015253640','/Img/Photoroom-20260610_083248_26.png','Stay dry and confidently fresh with Nulab Feelin Bliss Stick Deodorant. The smooth-glide, alcohol-free stick delivers 48 hours of reliable anti-perspirant protection while the delightful pomegranate and lotus fragrance evolves throughout the day. The compact format is easy to apply, quick-drying and suitable for sensitive underarm skin. Perfect for everyday use and travel. 64g.',NULL,'48-hour anti-perspirant protection
Pomegranate & Lotus fragrance
0% alcohol formula
Smooth, easy-glide stick application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(299,'Nulab Feelin Bliss Mist Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015256368','/Img/Photoroom-20260610_083249_52.png','Refresh your senses and stay fresh all day with Nulab Feelin Bliss Mist Deodorant. The ultra-fine mist delivers a burst of pomegranate and lotus fragrance with a 24-hour deodorant formula that neutralises odour-causing bacteria without blocking the body''s natural perspiration. Free from alcohol, parabens and phthalates - gentle enough for sensitive skin and safe to use immediately after shaving. 150ml.',NULL,'24-hour deodorant protection
Pomegranate & Lotus fragrance
0% alcohol, parabens and phthalates
Lightweight mist application','Shake well before use.
Hold 15cm from underarms and spray.
Allow to dry before dressing. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(300,'Nulab Feelin Fresh Roll-On Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015255798','/Img/Photoroom-20260610_083248_24.png','Experience light, clean freshness all day with Nulab Feelin Fresh Roll-On Deodorant. The alcohol-free, 48-hour anti-perspirant roll-on delivers effective sweat and odour protection while a refreshing cucumber and jasmine fragrance keeps you feeling invigorated and confident. The lightweight formula absorbs quickly without leaving white residue on skin or clothing. 50ml.',NULL,'48-hour anti-perspirant protection
Cucumber & Jasmine fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(301,'Nulab Feelin Fresh Mist Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015256351','/Img/Photoroom-20260610_083249_51.png','A light, refreshing spritz of confidence - Nulab Feelin Fresh Mist Deodorant combines a crisp cucumber and jasmine fragrance with a 24-hour deodorant formula that effectively neutralises body odour throughout the day. Free from alcohol, parabens and phthalates, this gentle mist is safe for sensitive skin and can be reapplied throughout the day for a continuous feeling of freshness. 150ml.',NULL,'24-hour deodorant protection
Cucumber & Jasmine fragrance
0% alcohol, parabens and phthalates
Lightweight mist application','Shake well before use.
Hold 15cm from underarms and spray.
Allow to dry before dressing. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(302,'Nulab Feelin Zesty Roll-On Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015255811','/Img/Photoroom-20260610_083249_27.png','Energise your morning routine with Nulab Feelin Zesty Roll-On Deodorant. The zesty lemon fragrance provides an instant burst of freshness, while the 48-hour anti-perspirant formula keeps sweat and odour under control all day long. The alcohol-free, quick-drying formula glides on smoothly without irritating freshly shaved skin, making it the ideal start to every day. 50ml.',NULL,'48-hour anti-perspirant protection
Lemon fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(303,'Nulab Feelin Zesty Stick Deodorant','Nulab','Body & Beauty',3500.0,50,'5061015253657','/Img/Photoroom-20260610_083249_29.png','Maintain freshness and confidence all day with Nulab Feelin Zesty Stick Deodorant. Packed with a vibrant lemon fragrance, this smooth-glide 48-hour anti-perspirant stick delivers effective, long-lasting odour and sweat protection without alcohol. Easy to apply and quick-drying, it leaves no white marks on clothing and is gentle enough for sensitive underarm skin. 64g.',NULL,'48-hour anti-perspirant protection
Lemon fragrance
0% alcohol formula
Smooth, easy-glide stick application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(304,'Nulab Feelin Zesty Mist Deodorant','Nulab','Body & Beauty',3000.0,60,'5061015256375','/Img/Photoroom-20260610_083249_53.png','Experience a revitalising burst of freshness with Nulab Feelin Zesty Mist Deodorant. The citrus-burst formula combines lively grapefruit and lemon zest to awaken the senses while a 24-hour deodorant base neutralises odour-causing bacteria and keeps you feeling fresh throughout the day. Free from alcohol, parabens and phthalates - ideal for sensitive skin and daily reapplication. 150ml.',NULL,'24-hour deodorant protection
Grapefruit & Lemon Zest fragrance
0% alcohol, parabens and phthalates
Lightweight mist application','Shake well before use.
Hold 15cm from underarms and spray.
Allow to dry before dressing. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(305,'Nulab Men Protect Adventure Roll-On','Nulab','Body & Beauty',3200.0,55,'5061015255835','/Img/Photoroom-20260610_083249_28.png','Take on the day with confidence - Nulab Men Protect Adventure Roll-On Deodorant delivers 48-hour anti-sweat protection in an alcohol-free formula that glides on smoothly and dries quickly. The bold, energising Adventure fragrance keeps you smelling great from morning to evening without irritating sensitive skin or leaving white marks. Specially formulated for active men who demand reliable all-day freshness. 50ml.',NULL,'48-hour anti-perspirant protection
Adventure fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(306,'Nulab Men Protect Adventure Stick','Nulab','Body & Beauty',3500.0,50,'5061015253671','/Img/Photoroom-20260610_083249_30.png','Stay active and odour-free all day with Nulab Men Protect Adventure Stick Deodorant. The smooth-application stick delivers 48 hours of powerful anti-perspirant protection in an alcohol-free formula that won''t stain clothing or irritate the skin. The bold Adventure scent adds a confident, masculine freshness that lasts all day. Compact, travel-friendly and reliable. 64g.',NULL,'48-hour anti-perspirant protection
Adventure fragrance
0% alcohol formula
Smooth, easy-glide stick application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(307,'Nulab Men Protect Extreme Dry Roll-On','Nulab','Body & Beauty',3200.0,55,'5061015255842','/Img/Photoroom-20260610_083249_31.png','Stay perfectly dry in any situation with Nulab Men Protect Extreme Dry Roll-On Deodorant. Engineered for maximum sweat control, the 48-hour anti-perspirant formula significantly reduces perspiration while the alcohol-free base keeps underarm skin comfortable and irritation-free. Quick-drying and clear on application, it won''t leave white residue - ideal for active lifestyles and high-pressure days. 50ml.',NULL,'48-hour anti-perspirant protection
Extreme Dry fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(308,'Nulab Men Protect Extreme Dry Stick','Nulab','Body & Beauty',3500.0,50,'5061015253688','/Img/Photoroom-20260610_083249_32.png','Maximum protection, all-day confidence - Nulab Men Protect Extreme Dry Stick Deodorant delivers 48 hours of intense anti-sweat performance in an alcohol-free format. The smooth, fast-drying stick applies easily, leaves no white marks and provides long-lasting freshness even in demanding conditions. Formulated to keep men at their best, no matter how active the day gets. 64g.',NULL,'48-hour anti-perspirant protection
Extreme Dry fragrance
0% alcohol formula
Smooth, easy-glide stick application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(309,'Nulab Men Protect Sport Cool Stick','Nulab','Body & Beauty',3500.0,50,'5061015253664','/Img/Photoroom-20260610_083249_33.png','Power through your workout and beyond with Nulab Men Protect Sport Cool Stick Deodorant. The 48-hour anti-perspirant formula is designed for high-activity lifestyles - providing maximum sweat and odour control while a cool, energising Sport scent keeps you refreshed from the gym to the boardroom. The smooth, alcohol-free stick is gentle on sensitive skin and leaves no residue. 64g.',NULL,'48-hour anti-perspirant protection
Sport Cool fragrance
0% alcohol formula
Smooth, easy-glide stick application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(310,'Nulab Men Protect Sport Cool Roll-On','Nulab','Body & Beauty',3200.0,55,'5061015255828','/Img/Photoroom-20260610_083249_36.png','Perform at your best with Nulab Men Protect Sport Cool Roll-On Deodorant. The 48-hour anti-perspirant roll-on is designed for active men - it delivers superior sweat and odour protection while the invigorating Sport Cool fragrance keeps you feeling energised and fresh throughout even the most demanding physical activities. Alcohol-free and quick-drying, it''s ideal for pre-gym application. 50ml.',NULL,'48-hour anti-perspirant protection
Sport Cool fragrance
0% alcohol formula
Smooth roll-on application','Apply to clean, dry underarms.
Allow to dry fully before dressing.
Use daily for best results.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(311,'Nulab Whole Body Cream Cocoa Butter','Nulab','Body & Beauty',4500.0,45,'5061015257532','/Img/Photoroom-20260610_083249_38.png','Deeply nourish and soften your skin with Nulab Whole Body Cream in Cocoa Butter. The rich, enveloping formula combines luxurious cocoa butter with a 48-hour moisturising complex to soften rough, dry patches, restore elasticity and leave skin feeling beautifully smooth and supple from head to toe. Non-greasy, fast-absorbing and with a warm, indulgent cocoa scent that lingers for hours. 500ml.',NULL,'48-hour moisturisation with cocoa butter
Softens and relieves rough, dry skin
500ml - long-lasting supply
Rich, non-greasy formula','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(312,'Nulab Whole Body Cream Vitamin C','Nulab','Body & Beauty',4500.0,45,'5061015257556','/Img/Photoroom-20260610_083249_41.png','Brighten and nourish your skin with Nulab Whole Body Cream in Vitamin C. The advanced formula pairs brightening Vitamin C with a 48-hour moisturising complex to visibly improve the skin''s radiance and evenness over time - while deeply hydrating even the driest areas such as elbows, knees and heels. Apply daily after bathing for noticeably softer, more luminous skin. 500ml.',NULL,'48-hour moisturisation with vitamin C
Softens and relieves rough, dry skin
500ml - long-lasting supply
Rich, non-greasy formula','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(313,'Nulab Whole Body Cream Olive Oil','Nulab','Body & Beauty',4500.0,45,'5061015257563','/Img/Photoroom-20260610_083249_42.png','Deeply moisturise and soften your skin with Nulab Whole Body Cream in Olive Oil. Rich in natural fatty acids and antioxidants, extra-virgin olive oil works within the formula''s 48-hour moisturising complex to nourish dry or rough skin, restore suppleness and leave a protective, moisture-locking layer that keeps skin hydrated and comfortable all day and night. 500ml.',NULL,'48-hour moisturisation with olive oil
Softens and relieves rough, dry skin
500ml - long-lasting supply
Rich, non-greasy formula','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(314,'Nulab Whole Body Cream Vitamin E','Nulab','Body & Beauty',4500.0,45,'5061015257549','/Img/Photoroom-20260610_083250_79.png','Soothe and deeply nourish dry, sensitive skin with Nulab Whole Body Cream in Vitamin E. The calming, antioxidant-rich formula pairs Vitamin E with a 48-hour moisturising complex to protect the skin''s barrier, reduce the appearance of stretch marks and dry patches, and leave skin feeling velvety-soft and supple. Ideal for everyday use after bathing for long-lasting whole-body hydration. 500ml.',NULL,'48-hour moisturisation with vitamin E
Softens and relieves rough, dry skin
500ml - long-lasting supply
Rich, non-greasy formula','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(315,'Nulab Feelin Silky Skin Drenching Moisturising Cream','Nulab','Body & Beauty',3800.0,50,'5061015255576','/Img/Photoroom-20260610_083249_48.png','Drench your skin in all-day hydration with Nulab Feelin Silky Skin Drenching Moisturising Cream. The feather-light, whipped texture absorbs instantly - delivering a nourishing blend of jojoba oil and Vitamin E deep into the skin to soften, smooth and protect against moisture loss throughout the day. Non-greasy and fast-absorbing, it leaves skin feeling velvety, silky and conditioned from the very first application. 200ml.',NULL,'Jojoba oil and vitamin E drench skin in moisture
All-day hydration
200ml - suitable for daily use
Silky, fast-absorbing texture','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(316,'Nulab Q10 Radiance Night Cream','Nulab','Body & Beauty',5500.0,35,'5061015256771','/Img/Photoroom-20260610_083249_40.png','Repair, firm and wake up to luminous skin with Nulab Q10 Radiance Night Cream. This advanced anti-ageing formula harnesses 100% natural Coenzyme Q10, a peptide complex and 24-hour moisture technology to support skin''s natural regeneration cycle overnight - reducing the appearance of fine lines, firming the contour and restoring a radiant, youthful glow by morning. Apply nightly to the face and neck. 50ml.',NULL,'100% natural Q10 supports firming and anti-ageing
24-hour moisture with peptide complex
50ml - a little goes a long way
Wake up to more radiant-looking skin','Apply to cleansed face and neck in the evening.
Massage in gently using upward motions.
Use nightly as the last step of your routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(317,'Nulab Q10 Radiance Day Cream','Nulab','Body & Beauty',5500.0,35,'5061015256764','/Img/Photoroom-20260610_083249_43.png','Turn back the clock on visible ageing with Nulab Q10 Radiance Day Cream. The advanced formula combines 100% natural Coenzyme Q10 with a peptide complex and 24-hour moisture technology to visibly firm and plump the skin, smooth fine lines and restore the natural luminosity that diminishes with age. Wear alone or under makeup for a fresh, youthful complexion that improves with every use. 50ml.',NULL,'100% natural Q10 supports firming and anti-ageing
24-hour moisture with peptide complex
50ml - a little goes a long way
Helps turn back the clock on visible ageing','Apply to cleansed face and neck in the morning.
Massage in gently using upward motions.
Follow with SPF. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(318,'Nulab DreamLift Firming Anti-Wrinkle Night Cream','Nulab','Body & Beauty',6500.0,30,'5061015256818','/Img/Photoroom-20260610_083249_44.png','Target the signs of ageing while you sleep with Nulab DreamLift Firming Anti-Wrinkle Night Cream. The luxurious, scientifically advanced formula works during the skin''s natural nighttime repair cycle to visibly firm sagging areas, redefine facial contours and smooth deep wrinkles. Active peptides, restructuring agents and rich emollients replenish lost collagen and hydration, so you wake up to noticeably lifted, more youthful-looking skin.',NULL,'Helps restore skin structure and define contours
Targets fine lines while you sleep
Firming, anti-wrinkle formula
50ml - a little goes a long way','Apply to cleansed face and neck in the evening.
Massage in gently using upward motions.
Use nightly as the last step of your routine.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(319,'Nulab DreamLift Firming Anti-Wrinkle Day Cream','Nulab','Body & Beauty',6500.0,30,'5061015256801','/Img/Photoroom-20260610_083249_45.png','Lift, firm and protect your skin throughout the day with Nulab DreamLift Firming Anti-Wrinkle Day Cream. The concentrated anti-ageing formula features structural peptides and skin-restoring actives that visibly improve skin firmness, redefine facial contours and smooth expression lines with continued use. Lightweight enough to wear under makeup, with a subtle radiance-boosting effect. Apply every morning to the face and neck.',NULL,'Helps restore skin structure and define contours
Lifts, firms and protects throughout the day
Firming, anti-wrinkle formula
50ml - a little goes a long way','Apply to cleansed face and neck in the morning.
Massage in gently using upward motions.
Follow with SPF. Use daily.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(320,'Hygie Advanced Protection Citrus Handwash','Hygie','Body & Beauty',2800.0,70,'5061015257334','/Img/Photoroom-20260610_083249_54.png','Cleanse, care and protect your hands with Hygie Advanced Protection Citrus Handwash. The antibacterial formula eliminates 99.9% of germs while a conditioning base preserves the skin''s natural moisture, preventing dryness and irritation with frequent use. The invigorating citrus fragrance leaves hands smelling fresh and clean long after rinsing. Family-safe and dermatologist-tested. 500ml.',NULL,'Anti-bacterial protection with citrus
Cleans, cares and protects in one wash
500ml - long-lasting supply
Suitable for frequent daily use','Wet hands with water.
Apply a small amount and lather for 20-30 seconds, covering all surfaces of the hands.
Rinse thoroughly with water.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(321,'Hygie Advanced Protection Aloe Vera Handwash','Hygie','Body & Beauty',2800.0,70,'5061015257327','/Img/Photoroom-20260610_083249_55.png','Clean, moisturise and protect in one wash with Hygie Advanced Protection Aloe Vera Handwash. The antibacterial formula combines germ-eliminating power with soothing aloe vera extract that conditions the skin as it cleanses - keeping hands soft, smooth and comfortable even with repeated daily use. Gentle enough for the whole family, including children. 500ml.',NULL,'Anti-bacterial protection with aloe vera
Cleans, cares and protects in one wash
500ml - long-lasting supply
Suitable for frequent daily use','Wet hands with water.
Apply a small amount and lather for 20-30 seconds, covering all surfaces of the hands.
Rinse thoroughly with water.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(322,'Hygie Advanced Protection Original Handwash','Hygie','Body & Beauty',2800.0,70,'5061015257310','/Img/Photoroom-20260610_083249_57.png','Keep hands clean, protected and fresh with Hygie Advanced Protection Original Handwash. The trusted antibacterial formula eliminates 99.9% of bacteria and viruses on contact, while a dermatologist-tested moisturising base ensures that hands remain soft and comfortable even with frequent washing. The clean, classic fragrance leaves a pleasant, lasting freshness. 500ml.',NULL,'Anti-bacterial protection with a fresh, original scent
Cleans, cares and protects in one wash
500ml - long-lasting supply
Suitable for frequent daily use','Wet hands with water.
Apply a small amount and lather for 20-30 seconds, covering all surfaces of the hands.
Rinse thoroughly with water.',1,'2026-06-10T08:08:03.107039','2026-06-10T08:08:03.107039'),
(323,'Aloe Vera Face Toner','Aloe Vera','Body & Beauty',3000.0,55,'5060120175670','/Img/Aloe Vera Face Toner.png','Calm, hydrate and balance your skin with this Aloe Vera Face Toner. The lightweight, alcohol-free formula combines soothing aloe vera with gentle botanical extracts to reduce post-cleanse redness, minimise pore appearance and prep the skin to absorb serums and moisturisers more effectively. Suitable for all skin types including sensitive and dry - apply morning and evening after cleansing for a visibly clearer, more balanced complexion. Vegan. 200ml.',NULL,'Aloe vera helps calm and hydrate skin
Preps skin to better absorb moisturiser
Vegan formula
200ml - suitable for daily use','After cleansing, sweep across face and neck using a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.',1,'2026-06-10T08:54:32.207509','2026-06-10T08:54:32.207509'),
(324,'Aloe Vera Body Wash (250ml)','Aloe Vera','Body & Beauty',3000.0,60,'AV-WASH-250','/Img/aloe-vera-body-wash-250ml.jpg','Cleanse and soothe your face and body with this gentle Aloe Vera Face & Body Wash. Pure aloe vera gel forms the heart of this multitasking cleanser - it clears impurities and excess oil while simultaneously calming and nourishing the skin with every wash. The fragrance-free, soap-free formula is ideal for sensitive or reactive skin and can be used from head to toe as a daily cleanser. Vegan. 250ml.',NULL,'Aloe vera helps cleanse and soothe skin
Gentle enough for face and body
250ml - versatile everyday wash
Leaves skin feeling soft, not stripped','Wet face and body with warm water.
Massage a small amount over skin.
Rinse thoroughly. Use daily.',1,'2026-06-10T08:54:32.207509','2026-06-10T08:54:32.207509'),
(325,'Odour Control Foot Spray','Xpel Foot Care','Body & Beauty',2500.0,50,'5060120176646','/Img/Photoroom-20260611_090635_1.png','Banish foot odour instantly with this fast-acting Odour Control Foot Spray from Xpel Foot Care. The lightweight, quick-drying formula neutralises odour-causing bacteria and leaves feet feeling fresh and comfortable throughout the day. Suitable for daily use. 150ml.','150ml','Fast-acting formula neutralises odour-causing bacteria
Lightweight, quick-drying spray
150ml - suitable for daily use
Leaves feet feeling fresh and comfortable','Shake well before use.
Spray directly onto clean, dry feet.
Allow to dry before putting on socks or shoes.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(326,'Shoe Refresher Spray','Xpel Foot Care','Body & Beauty',2500.0,50,'5060120176660','/Img/Photoroom-20260611_090635_2.png','Keep your shoes smelling fresh and odour-free with this Shoe Refresher Spray from Xpel Foot Care. The powerful deodorising formula eliminates unpleasant odours from inside shoes, leaving them smelling clean and pleasant. Ideal for trainers, work shoes and everyday footwear. 150ml.','150ml','Keeps shoes smelling fresh between wears
Eliminates unpleasant odours from footwear
150ml - suitable for regular use
Ideal for trainers, work shoes and everyday footwear','Shake well before use.
Spray the inside of shoes or trainers.
Allow to dry fully before wearing.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(327,'Nail Polish Remover Vegan (150ml)','Xpel Nail Care','Body & Beauty',2000.0,50,NULL,'/Img/Photoroom-20260611_090635_3.png','Remove nail polish gently and effectively with this vegan-friendly Nail Polish Remover from Xpel Nail Care. Specially formulated to cleanse and remove nail polish without over-drying, leaving nails clean and ready for your next colour. Vegan certified. 150ml.','150ml','Vegan-friendly formulation
Effective on most nail polish formulas
Suitable for regular use
Convenient bottle format','Saturate a cotton pad with the product.
Press onto the nail and hold for a few seconds.
Wipe away polish, working from the base of the nail outward.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(328,'Nail Polish Remover 80% Acetone (150ml)','Xpel Nail Care','Body & Beauty',2000.0,50,NULL,'/Img/Photoroom-20260611_090635_4.png','Fast and effective nail polish removal with this high-strength 80% Acetone Nail Polish Remover from Xpel Nail Care. Features an easy-use dosing cap to control the amount dispensed, minimising waste. Removes even glitter and gel-effect polishes quickly. 150ml.','150ml','High-strength 80% acetone for fast removal
Effective on most nail polish formulas
Suitable for regular use
Convenient bottle format','Saturate a cotton pad with the product.
Press onto the nail and hold for a few seconds.
Wipe away polish, working from the base of the nail outward.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(329,'Nail Polish Remover (250ml)','Xpel Nail Care','Body & Beauty',2800.0,50,NULL,'/Img/Photoroom-20260611_090635_5.png','A generous 250ml bottle of Nail Polish Remover from Xpel Nail Care. Specially formulated to cleanse and remove nail polish thoroughly, leaving nails smooth and clean. Perfect for home use. 250ml.','250ml','Generous 250ml size for regular use
Effective on most nail polish formulas
Suitable for regular use
Convenient bottle format','Saturate a cotton pad with the product.
Press onto the nail and hold for a few seconds.
Wipe away polish, working from the base of the nail outward.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(330,'Nail Polish Remover Acetone Free (250ml)','Xpel Nail Care','Body & Beauty',2800.0,50,'5060120166791','/Img/Photoroom-20260611_090635_6.png','A gentle acetone-free Nail Polish Remover from Xpel Nail Care. Specially formulated to remove nail polish without harsh chemicals, making it ideal for sensitive or dry nails. Leaves nails feeling clean and conditioned. 250ml.','250ml','Acetone-free - gentle on nails
Effective on most nail polish formulas
Suitable for regular use
Convenient bottle format','Saturate a cotton pad with the product.
Press onto the nail and hold for a few seconds.
Wipe away polish, working from the base of the nail outward.',1,'2026-06-11T08:11:41.177651','2026-06-11T08:11:41.177651'),
(332,'Neem Oil Facial Scrub','Neem Oil','Body & Beauty',0.0,0,'5060120180179','/Img/neem-oil-facial-scrub.png','Reveal smoother, clearer skin with this Neem Oil Facial Scrub. Cold-pressed neem oil combines with gentle exfoliating particles to buff away dead skin cells, unclog pores and reduce the appearance of blemishes. Anti-bacterial and anti-inflammatory neem deeply purifies while leaving skin feeling refreshed and balanced. Suitable for blemish-prone and combination skin types.',NULL,'Cold-pressed neem oil helps purify and clarify skin
Gently exfoliates to unclog pores
Anti-bacterial and anti-inflammatory properties
Suitable for blemish-prone and combination skin','Apply to damp skin using gentle circular motions.
Focus on the face, avoiding the eye area.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-06-12T15:25:11.34938','2026-06-12T15:25:11.34938'),
(333,'XNC Super Strength Nail & Tip Remover — 99% Acetone','Xpel Nail Care','Body & Beauty',2000.0,50,'XNC-SS99-1','/Img/xnc-super-strength-nail-tip-remover.png','99% acetone remover specially formulated to remove artificial nails, tips and gel polish. Super fast nail polish removal.',NULL,'99% acetone for stubborn or artificial nails
Removes gel polish and acrylic tips
Super-fast nail polish removal
Contains Bitrex to help protect children','Saturate a cotton pad with the product.
Press onto the nail or artificial tip and hold briefly.
Wipe away, working from the base outward. Use in a well-ventilated area.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(334,'XNC Nail Polish Remover Dip Pot (150ml)','Xpel Nail Care','Body & Beauty',1800.0,50,'XNC-DIP-150','/Img/xnc-nail-polish-remover-dip-pot-150ml.png','Acetone-free dip-pot nail polish remover - no cotton pads needed, suitable for acrylic nails.',NULL,'Acetone-free dip-pot format - no cotton pads needed
Suitable for use on acrylic nails
Mess-free, no-spill application
150ml - plenty for regular use','Dip the nail into the pot and hold for a few seconds.
Twist gently and lift the nail out - no cotton pad needed.
Wipe away any residue with a tissue.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(335,'XBC Aqueous Cream 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-AQCR-500','/Img/xbc-aqueous-cream-500ml.jpg','Aqueous cream - a gentle daily moisturiser and soap substitute for dry, sensitive skin. 500ml.',NULL,'Aqueous formula helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute, fragrance and lanolin free
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(336,'XBC Aqueous Cream SLS Free 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-AQSF-500','/Img/xbc-aqueous-cream-sls-free-500ml.jpg','SLS-free aqueous cream - gentle moisturiser and soap substitute for sensitive skin. 500ml.',NULL,'SLS-free aqueous formula helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute, fragrance and lanolin free
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(337,'XBC Aloe Vera Cream 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-ALCR-500','/Img/xbc-aloe-vera-cream-500ml.jpg','Aloe vera cream - soothing daily moisturiser for soft, hydrated skin. 500ml.',NULL,'Aloe vera helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(338,'XBC Olive Oil Cream 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-OLCR-500','/Img/xbc-olive-oil-cream-500ml.jpg','Olive oil cream - deeply moisturises and hydrates skin. 500ml.',NULL,'Olive oil helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(339,'XBC Cocoa Butter Cream 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-COCR-500','/Img/xbc-cocoa-butter-cream-500ml.jpg','Cocoa butter cream - nourishes and softens dry skin. 500ml.',NULL,'Cocoa butter helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(340,'XBC Vitamin E Cream 500ml','Xpel Body Care','Body & Beauty',3800.0,50,'XBC-VECR-500','/Img/xbc-vitamin-e-cream-500ml.jpg','Vitamin E cream - deeply moisturises and soothes skin. 500ml.',NULL,'Vitamin E helps relieve and soften dry skin
500ml - long-lasting daily moisturiser
Can be used as a soap substitute
Suitable for the whole family','Apply generously to clean, dry skin.
Massage in until fully absorbed.
Use daily, or as often as needed for dry skin.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(341,'XBC Bamboo Cotton Buds (300 buds)','Xpel Body Care','Body & Beauty',1800.0,70,'XBC-BUD-300','/Img/xbc-bamboo-cotton-buds-300.jpg','Biodegradable bamboo-stem cotton buds - 100% pure cotton tips, kind and gentle. 300 buds.',NULL,'Biodegradable bamboo stem - better for the planet
100% pure cotton tips
300 buds - long-lasting supply
Kind and gentle on skin','Use one bud at a time for ear, nail or make-up care.
Dispose of responsibly after single use.
Keep out of reach of young children.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(342,'XBC Coconut Water Deep Moisturising Foot Pack (30ml)','Xpel Body Care','Body & Beauty',2200.0,45,'XBC-CWFP-30','/Img/xbc-coconut-water-deep-moisturising-foot-pack-30ml.png','Deep moisturising foot pack with coconut water - one treatment leaves feet soft and smooth. 30ml.',NULL,'Coconut water helps deeply moisturise feet
Helps reduce callus build-up
Repairs and softens cracked, split heels
One 30ml treatment per use','Apply a generous layer to clean, dry feet.
Massage in thoroughly, focusing on heels and rough patches.
Leave for 20 minutes, then rinse or wipe away excess.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(343,'XBC Coconut Water Hydrating Shower Crème (300ml)','Xpel Body Care','Body & Beauty',3800.0,45,'XBC-CWSC-300','/Img/xbc-coconut-water-hydrating-shower-creme-300ml.png','Hydrating shower crème with coconut water - cleanses and moisturises in one step. 300ml.',NULL,'Coconut water invigorates and revitalises skin
Cleanses and moisturises in one step
Re-hydrating properties
300ml - lasts for weeks of daily use','Apply to wet skin in the shower.
Massage into a light lather all over the body.
Rinse thoroughly. Use daily.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(344,'XBC Coconut Water Hydrating Facial Wipes (Twin Pack)','Xpel Body Care','Body & Beauty',3000.0,55,'XBC-CWWP-25','/Img/xbc-coconut-water-facial-wipes-twin-pack.png','Hydrating facial wipes with coconut water - twin pack for daily cleansing on the go.',NULL,'Coconut water tones, cleanses and moisturises
Twin pack - great value
Convenient for daily use or travel
Leaves skin feeling soft and rehydrated','Remove a wipe and gently sweep across face and neck.
Use to remove makeup, dirt and daily impurities.
No rinsing required - follow with moisturiser.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(345,'XHC Avocado & Almond Heat Defence Spray (150ml)','Xpel Hair Care','Hair Care',4200.0,45,'XHC-AVHT-150','/Img/xhc-avocado-almond-heat-defence-spray-150ml.png','Heat defence styling spray with avocado and almond oil - helps hydrate and protect against heat styling. 150ml.',NULL,'Avocado and almond extract hydrate before styling
Helps defend against heat-styling damage
150ml - lasts through regular styling routines
Leaves hair feeling protected and smooth','Apply to towel-dried hair before heat styling.
Distribute evenly through mid-lengths and ends.
Style with heated tools as usual.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(348,'XOC Dual Action Mint Mouthwash (500ml)','Xpel Oral Care','Body & Beauty',3200.0,55,'XOC-MMW-500','/Img/xoc-dual-action-mint-mouthwash-500ml.png','Dual action mint mouthwash - freshens breath and helps protect against plaque. 500ml.',NULL,'Dual action mint formula freshens breath
Helps keep mouth clean
Alcohol-free formula
500ml - lasts for weeks of daily use','Shake well before use.
Use 10-15ml undiluted after brushing.
Swish for 30 seconds and spit out - do not rinse with water afterwards.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(349,'XOC Dual Action Clove Mouthwash (500ml)','Xpel Oral Care','Body & Beauty',3200.0,55,'XOC-CMW-500','/Img/xoc-dual-action-clove-mouthwash-500ml.png','Dual action clove mouthwash - freshens breath and helps protect against plaque. 500ml.',NULL,'Dual action clove formula freshens breath
Helps keep mouth clean
Alcohol-free formula
500ml - lasts for weeks of daily use','Shake well before use.
Use 10-15ml undiluted after brushing.
Swish for 30 seconds and spit out - do not rinse with water afterwards.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(350,'XOC Hemp Toothpaste (100ml + Free Toothbrush)','Xpel Oral Care','Body & Beauty',2800.0,50,'XOC-HTP-100','/Img/xoc-hemp-toothpaste-100ml.png','Hemp toothpaste with natural hemp oil for gentle cleansing and fresh breath. Includes free toothbrush. Vegan. 100ml.',NULL,'Natural hemp oil supports gentle daily cleansing
Vegan formula
Comes complete with a free toothbrush
100ml - lasts for weeks of daily brushing','Brush teeth for two minutes, morning and night.
Use the free toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(351,'XOC Hemp Mouthwash (500ml)','Xpel Oral Care','Body & Beauty',3200.0,50,'XOC-HMW-500','/Img/xoc-hemp-mouthwash-500ml.png','Hemp mouthwash with a combination of natural compounds for daily teeth and gum care. 500ml.',NULL,'Natural compounds support daily teeth and gum care
Lasting freshness with every use
500ml - lasts for weeks of daily use
Part of a complete oral care routine','Use 10-15ml undiluted after brushing.
Swish around the mouth for 30 seconds.
Spit out - do not swallow or rinse with water afterwards.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(352,'XHC Keratin Classic Shampoo (300ml)','Xpel Hair Care','Hair Care',3800.0,45,'XHC-KCSH-300','/Img/xhc-keratin-classic-shampoo-300ml.png','Keratin Classic shampoo - smooths, nourishes and adds shine, helps reduce frizz. 300ml.',NULL,'Keratin helps smooth and nourish hair
Helps reduce the look of frizz
Adds noticeable shine
300ml - suitable for frequent use','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(353,'XHC Keratin Classic Conditioner (300ml)','Xpel Hair Care','Hair Care',3800.0,45,'XHC-KCCD-300','/Img/xhc-keratin-classic-conditioner-300ml.png','Keratin Classic conditioner - leaves hair soft, silky-smooth and shining. 300ml.',NULL,'Keratin leaves hair soft and silky-smooth
Enhances shine with every wash
300ml - suitable for frequent use
Complements the Keratin Classic Shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(354,'XHC Biotin & Collagen Shampoo (300ml)','Xpel Hair Care','Hair Care',3800.0,45,'XHC-BCSH-300','/Img/xhc-biotin-collagen-shampoo-300ml.png','Biotin & Collagen shampoo - a superfood for hair, creates the appearance of thicker, fuller hair. 300ml.',NULL,'Biotin and collagen create the appearance of thicker hair
A superfood formula for hair
300ml - suitable for frequent use
Cleanses while supporting fuller-looking hair','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(355,'XHC Biotin & Collagen Conditioner (300ml)','Xpel Hair Care','Hair Care',3800.0,45,'XHC-BCCD-300','/Img/xhc-biotin-collagen-conditioner-300ml.png','Biotin & Collagen conditioner - strengthens, thickens and adds shine. 300ml.',NULL,'Biotin and collagen strengthen and thicken hair
Adds noticeable shine
300ml - suitable for frequent use
Complements the Biotin & Collagen Shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(356,'XHC Biotin & Collagen Hair Treatment (50ml)','Xpel Hair Care','Hair Care',3500.0,40,'XHC-BCTR-50','/Img/xhc-biotin-collagen-hair-treatment-50ml.png','Hydrating, nourishing hair treatment with biotin & collagen - leaves hair looking shiny and smooth. 50ml.',NULL,'Biotin and collagen deeply hydrate and nourish
Leaves hair looking shiny and smooth
50ml - ideal for a weekly treatment
Targets dry, weakened hair','Apply to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes for best results.
Rinse thoroughly. Use 1-2 times a week.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(357,'So Fresh Watermelon Crush Facial Cleanser (100ml)','Xpel Body Care','Body & Beauty',3200.0,45,'SFW-CLN-100','/Img/so-fresh-watermelon-crush-facial-cleanser-100ml.png','Watermelon crush facial cleanser - fresh, fruity daily cleanse. 100ml.',NULL,'Watermelon crush extract freshens skin daily
Fruity, uplifting daily cleanse
100ml - suitable for everyday use
Leaves skin feeling clean and refreshed','Wet face with warm water.
Massage a small amount over face in circular motions.
Rinse thoroughly and pat dry. Use morning and evening.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(359,'Tea Tree Body Scrub','Tea Tree','Body & Beauty',4000.0,40,'TT-SCRB-1','/Img/tea-tree-body-scrub.png','Exfoliating body scrub with natural tea tree oil - smooths and refreshes skin.',NULL,'Natural tea tree oil helps exfoliate and refresh skin
Smooths rough, uneven texture
Leaves skin feeling purified and renewed
Suitable for regular use','Apply to damp skin in the shower or bath.
Massage in circular motions over body, avoiding broken skin.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(360,'Tea Tree Body Butter','Tea Tree','Body & Beauty',4500.0,40,'TT-BUTR-1','/Img/tea-tree-body-butter-250ml.png','Rich body butter with natural tea tree oil - deeply moisturises and nourishes skin.',NULL,'Tea tree oil helps deeply moisturise and nourish skin
Rich, indulgent butter texture
Leaves skin soft without feeling greasy
Ideal for daily use, especially on dry patches','Scoop a small amount and warm between palms.
Massage into skin all over the body, focusing on dry areas.
Use daily after showering for best results.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(361,'Tea Tree Moisturising Sheet Mask','Tea Tree','Body & Beauty',2000.0,50,'TT-MASK-1','/Img/tea-tree-moisturising-sheet-mask.png','Moisturising sheet mask with natural tea tree oil for clean, healthy-looking skin.',NULL,'Tea tree oil helps clean, healthy-looking skin
Moisturising, purifying treatment
Ideal as a weekly skincare boost
Leaves skin feeling calm and refreshed','Cleanse skin and pat dry.
Unfold the mask and smooth over face, avoiding eyes and lips.
Leave for 15-20 minutes, then remove and massage in remaining essence.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(362,'Tea Tree Mouthwash','Tea Tree','Body & Beauty',3200.0,45,'TT-MWSH-500','/Img/xoc-tea-tree-mouthwash-500ml.png','Tea tree mouthwash for lasting freshness and daily plaque protection.',NULL,'Tea tree oil helps freshen breath for longer
Supports daily plaque protection
Alcohol-free formula
500ml - lasts for weeks of daily use','Use 10-15ml undiluted after brushing.
Swish around the mouth for 30 seconds.
Spit out - do not swallow or rinse with water afterwards.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(363,'Tea Tree Toothpaste (+ Free Bamboo Toothbrush)','Tea Tree','Body & Beauty',2800.0,45,'TT-TPST-100','/Img/xoc-tea-tree-toothpaste-100ml.png','Tea tree toothpaste for gentle cleansing and fresh breath - includes free bamboo toothbrush.',NULL,'Tea tree oil helps gently cleanse teeth and gums
Supports fresh breath throughout the day
Comes complete with a free bamboo toothbrush
Eco-conscious packaging','Brush teeth for two minutes, morning and night.
Use the free bamboo toothbrush provided for best results.
Spit and avoid rinsing immediately for maximum benefit.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(364,'Tea Tree Facial Scrub','Tea Tree','Body & Beauty',3500.0,40,'TT-FSCR-1','/Img/tea-tree-facial-scrub-jar.png','Exfoliating facial scrub with natural tea tree oil - reveals brighter, refreshed skin.',NULL,'Natural tea tree oil helps reveal brighter skin
Gently exfoliates away dullness
Leaves skin feeling refreshed and renewed
Suitable for regular use','Apply to damp skin using gentle circular motions.
Focus on the face, avoiding the eye area.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(365,'XHC Botanical Vegan Conditioner — Aloe Vera (300ml)','Xpel Hair Care','Hair Care',4000.0,40,'XHC-BOTVC-300','/Img/xhc-botanical-vegan-conditioner-aloe-vera-300ml.png','Botanical vegan conditioner with aloe vera - gentle conditioning for soft, shiny hair. 300ml.',NULL,'Aloe vera gently conditions hair
Vegan formula
Leaves hair soft and shiny
300ml - suitable for frequent use','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(366,'XHC Botanical Aloe Vera Hair Mask','Xpel Hair Care','Hair Care',4200.0,35,'XHC-BOTHM-1','/Img/xhc-botanical-aloe-vera-hair-mask.png','Botanical hair mask with aloe vera - deeply conditions and restores shine.',NULL,'Aloe vera deeply conditions hair
Helps restore shine and softness
Ideal as a weekly intensive treatment
Vegan formula','Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes for a deeper treatment.
Rinse thoroughly. Use weekly.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(367,'XHC Banana Shampoo (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-BANSH-400','/Img/xhc-banana-shampoo-400ml.png','Fruit Fusion banana shampoo - cleanses and nourishes for soft, healthy-looking hair. 400ml.',NULL,'Banana extract cleanses and nourishes hair
Leaves hair soft and healthy-looking
400ml - suitable for frequent use
Leaves hair smelling naturally fruity','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(368,'XHC Banana Conditioner (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-BANCD-400','/Img/xhc-banana-conditioner-400ml.png','Fruit Fusion banana conditioner - smooths and softens hair. 400ml.',NULL,'Banana extract smooths and softens hair
Adds lasting softness
400ml - suitable for frequent use
Complements the matching Fruit Fusion shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(369,'XHC Ginger Anti-Dandruff Shampoo (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-GINSH-400','/Img/xhc-ginger-anti-dandruff-shampoo-400ml.png','Fruit Fusion ginger anti-dandruff shampoo - cleanses scalp and helps control dandruff. 400ml.',NULL,'Ginger extract cleanses and nourishes hair
Helps control dandruff and cleanse the scalp
400ml - suitable for frequent use
Leaves hair smelling naturally fruity','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(371,'XHC Coconut Hydrating Shampoo (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-COCSH-400','/Img/xhc-coconut-hydrating-shampoo-400ml.png','Fruit Fusion coconut hydrating shampoo - cleanses and deeply hydrates hair. 400ml.',NULL,'Coconut extract cleanses and nourishes hair
Deeply hydrates hair as it cleanses
400ml - suitable for frequent use
Leaves hair smelling naturally fruity','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(372,'XHC Coconut Hydrating Conditioner (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-COCCD-400','/Img/xhc-coconut-hydrating-conditioner-400ml.png','Fruit Fusion coconut hydrating conditioner - softens and moisturises hair. 400ml.',NULL,'Coconut extract smooths and softens hair
Softens and deeply moisturises hair
400ml - suitable for frequent use
Complements the matching Fruit Fusion shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(373,'XHC Strawberry Shampoo (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-STRSH-400','/Img/xhc-strawberry-shampoo-400ml.png','Fruit Fusion strawberry shampoo - cleanses and refreshes hair with a fruity finish. 400ml.',NULL,'Strawberry extract cleanses and nourishes hair
Refreshes hair with a fruity finish
400ml - suitable for frequent use
Leaves hair smelling naturally fruity','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(374,'XHC Strawberry Conditioner (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-STRCD-400','/Img/xhc-strawberry-conditioner-400ml.png','Fruit Fusion strawberry conditioner - smooths hair for a soft, healthy shine. 400ml.',NULL,'Strawberry extract smooths and softens hair
Leaves hair with a soft, healthy shine
400ml - suitable for frequent use
Complements the matching Fruit Fusion shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(375,'XHC Green Tea Shampoo (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-GRTSH-400','/Img/xhc-green-tea-shampoo-400ml.png','Fruit Fusion green tea shampoo - cleanses and refreshes with antioxidant-rich green tea. 400ml.',NULL,'Green tea extract cleanses and nourishes hair
Antioxidant-rich formula refreshes hair
400ml - suitable for frequent use
Leaves hair smelling naturally fruity','Wet hair thoroughly.
Massage into scalp and hair, working into a lather.
Rinse thoroughly. Follow with conditioner.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(376,'XHC Green Tea Conditioner (400ml)','Xpel Hair Care','Hair Care',3800.0,40,'FF-GRTCD-400','/Img/xhc-green-tea-conditioner-400ml.png','Fruit Fusion green tea conditioner - nourishes hair with antioxidant-rich green tea. 400ml.',NULL,'Green tea extract smooths and softens hair
Nourishes hair with antioxidants
400ml - suitable for frequent use
Complements the matching Fruit Fusion shampoo','After shampooing, apply through mid-lengths and ends of damp hair.
Leave for 2-3 minutes.
Rinse thoroughly. Use with every wash.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(377,'XBC Banana Body Yogurt (Deep Moisturising)','Xpel Body Care','Body & Beauty',4000.0,40,'XBC-BANYOG-1','/Img/xbc-banana-body-yogurt.png','Deep moisturising body yogurt with banana - leaves skin soft and nourished.',NULL,'Banana extract deeply moisturises skin
Lightweight, fast-absorbing yogurt texture
Leaves skin soft and nourished
400ml - lasts for weeks of daily use','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(378,'XBC Strawberry Body Yogurt (Deep Moisturising)','Xpel Body Care','Body & Beauty',4000.0,40,'XBC-STRYOG-1','/Img/xbc-strawberry-body-yogurt.png','Deep moisturising body yogurt with strawberry - leaves skin soft and nourished.',NULL,'Strawberry extract deeply moisturises skin
Lightweight, fast-absorbing yogurt texture
Leaves skin soft and nourished
400ml - lasts for weeks of daily use','Apply generously to clean, dry skin all over the body.
Massage in until fully absorbed.
Use daily, ideally after showering.',1,'2026-07-28T08:06:44.298049','2026-07-28T08:06:44.298049'),
(382,'Aloe Vera Shampoo (250ml)','Aloe Vera','Hair Care',0.0,40,'AV-SHMP-250','/Img/aloe-vera-shampoo-250ml.jpg','Aloe vera shampoo for smooth and shiny hair. 250ml.','250ml','Enriched with aloe vera
Leaves hair smooth and shiny
Gentle enough for regular use','Massage into wet hair and scalp.
Rinse thoroughly.
Follow with conditioner.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(383,'XBC Aloe Vera Face & Body Scrub','Xpel Body Care','Body & Beauty',0.0,40,'XBC-AVSCR-JAR','/Img/xbc-aloe-vera-face-body-scrub.jpg','Aloe vera face and body scrub with aloe vera extracts - gently exfoliates for visibly brighter skin.',NULL,'With aloe vera extracts
Gently exfoliates
For visibly brighter skin','Apply to damp skin using circular motions.
Avoid the eye area.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(384,'Medex Aloe Vera Antibacterial Handwash (650ml)','Medex','Home',0.0,40,'MDX-AVHW-650','/Img/medex-aloe-vera-antibacterial-handwash-650ml.jpg','Medex clean and hygienic aloe vera antibacterial handwash. 650ml pump bottle with 30% extra free.','650ml','Antibacterial formula
With aloe vera
650ml - 30% extra free','Pump onto wet hands and lather.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(385,'Mediguard Antiseptic Disinfectant (1L)','Mediguard','Home',0.0,40,'MDG-ANTI-1L','/Img/mediguard-antiseptic-disinfectant-1l.png','Mediguard antiseptic disinfectant - kills 99.9% of bacteria. Tested to EN protocols (EN1276). 1 litre.','1L','Kills 99.9% of bacteria
Tested to EN protocols (EN1276)
Made in the UK','Follow the dilution and usage directions on the bottle.
Keep out of reach of children.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(386,'Mucky Pup Flea Repellent Dog Shampoo','Mucky Pup','Home',0.0,40,'MP-FLEA-SHMP','/Img/mucky-pup-flea-repellent-shampoo.jpg','Mucky Pup flea repellent shampoo for dogs - naturally repels fleas, removes dirt and helps reduce tangles for a healthy, shiny coat.',NULL,'Naturally repels fleas
Removes dirt and helps reduce tangles
Leaves a healthy, shiny coat','Wet your dog''s coat thoroughly.
Massage in the shampoo, avoiding the eyes.
Rinse well.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(387,'Dr Magic Double Action Foamer','Dr Magic','Home',0.0,40,'DRM-DAF','/Img/dr-magic-double-action-foamer.jpg','Dr Magic double action drain foamer - clears build up and removes blockages. For kitchen and bathroom use.',NULL,'Clears build up
Removes blockages
Kitchen and bathroom use','Follow the directions on the bottle.
Not for use in standing water.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(388,'Dr Magic Oven & Grill Cleaner','Dr Magic','Home',0.0,40,'DRM-OVEN','/Img/dr-magic-oven-grill-cleaner.png','Dr Magic oven and grill cleaner - heavy duty cleaning action for ovens and grills.',NULL,'Heavy duty cleaning action
For ovens and grills','Follow the directions on the can.
Use in a well-ventilated area.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(389,'Dr Magic Snatch A Dye (20 Sheets)','Dr Magic','Home',0.0,40,'DRM-SAD-20','/Img/dr-magic-snatch-a-dye-20-sheets.png','Dr Magic Snatch A Dye colour catcher sheets - avoids colour runs in mixed washes. 20 sheets.','20 sheets','Avoids colour runs in mixed washes
20 sheets per box','Add one sheet to the drum with your mixed wash.
Discard after use.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(390,'Medipure Hair & Scalp Scalp Treatment','Medipure','Hair Care',0.0,40,'MPU-HS-TRT','/Img/medipure-hair-scalp-treatment.png','Medipure Hair & Scalp scalp treatment - helps to fight against dandruff with quenching hydration for dry scalp. With hyaluronic acid, aloe vera and vitamin E.',NULL,'Helps to fight against dandruff
Quenching hydration for dry scalp
With hyaluronic acid, aloe vera and vitamin E','Apply directly to the scalp using the nozzle.
Massage in gently.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(391,'Medipure Hair & Scalp Conditioner','Medipure','Hair Care',0.0,40,'MPU-HS-COND','/Img/medipure-hair-scalp-conditioner.jpg','Medipure Hair & Scalp conditioner - helps to fight against dandruff with quenching hydration for dry scalp. With aloe vera, coconut oil and vitamin E.',NULL,'Helps to fight against dandruff
Quenching hydration for dry scalp
With aloe vera, coconut oil and vitamin E','After shampooing, apply through hair.
Leave for 2-3 minutes.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(392,'Medipure Hair & Scalp Hair Mask','Medipure','Hair Care',0.0,40,'MPU-HS-MASK','/Img/medipure-hair-scalp-hair-mask.png','Medipure Hair & Scalp hair mask for dry scalp - helps to fight against dandruff. With aloe vera, coconut oil and vitamin E.',NULL,'Helps to fight against dandruff
For dry scalp
With aloe vera, coconut oil and vitamin E','Apply to clean, damp hair and scalp.
Leave for a few minutes.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(393,'Medipure Hair & Scalp Anti-Dandruff Shampoo','Medipure','Hair Care',0.0,40,'MPU-HS-SHMP','/Img/medipure-hair-scalp-shampoo.png','Medipure Hair & Scalp shampoo with anti-dandruff properties - effective treatment for dandruff. For frequent use.',NULL,'Anti-dandruff properties
Improves hair and scalp
For frequent use','Massage into wet hair and scalp.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(394,'Dalton House Sweet Rose Fine Handwash (500ml)','Dalton House','Home',0.0,40,'DH-ROSE-500','/Img/dalton-house-sweet-rose-handwash-500ml.jpg','Dalton House England sweet rose fine handwash. 500ml pump bottle.','500ml','Sweet rose fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(395,'Dalton House Sea Breeze Fine Handwash (500ml)','Dalton House','Home',0.0,40,'DH-SEAB-500','/Img/dalton-house-sea-breeze-handwash-500ml.jpg','Dalton House England sea breeze fine handwash. 500ml pump bottle.','500ml','Sea breeze fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(396,'Dalton House Orchard Burst Fine Handwash (500ml)','Dalton House','Home',0.0,40,'DH-ORCH-500','/Img/dalton-house-orchard-burst-handwash-500ml.jpg','Dalton House England orchard burst fine handwash. 500ml pump bottle.','500ml','Orchard burst fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(397,'Tea Tree & Peppermint Deep Moisturising Hand Pack','Tea Tree','Body & Beauty',0.0,40,'TT-HPACK-1','/Img/tea-tree-peppermint-hand-pack.jpg','Tea tree and peppermint deep moisturising hand pack - deeply penetrates and moisturises to help repair dry hands.',NULL,'Tea tree and peppermint
Deep moisturising
Helps repair dry hands','Slip hands into the gloves.
Leave for the time shown on the pack.
Massage any remaining product into the skin.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(398,'XHC Tea Tree Moisturising Shampoo (400ml)','Xpel Hair Care','Hair Care',0.0,40,'XHC-TT-SHMP-400','/Img/xhc-tea-tree-moisturising-shampoo-400ml.jpg','XHC tea tree moisturising shampoo for frequent use - cleanses and refreshes hair and scalp. 400ml.','400ml','With tea tree oil
Moisturising formula
For frequent use','Massage into wet hair and scalp.
Rinse thoroughly.
Follow with Tea Tree Moisturising Conditioner.',1,'2026-10-20T00:00:00','2026-10-20T00:00:00'),
(379,'XBC Banana Face and Body Scrub (250ml)','Xpel Body Care','Body & Beauty',3800.0,40,'XBC-BANSCR-250','/Img/xbc-banana-face-body-scrub-250ml-tube.jpg','Exfoliating face and body scrub with banana - gently buffs away dull, dry skin. 250ml.','250ml','Banana extract gently buffs away dull, dry skin
Suitable for face and body
250ml - lasts through regular use
Leaves skin feeling smooth and refreshed','Apply to damp skin using circular motions.
Focus on face and body, avoiding the eye area.
Rinse thoroughly. Use 2-3 times a week.',1,'2026-07-28T08:06:44','2026-10-20T00:00:00');

-- ── Blog posts data (5 rows) ───────────────────────────────────────────────
INSERT INTO `blog_posts` (`id`,`title`,`slug`,`content`,`excerpt`,`featured_image`,`author`,`category`,`published`,`created_at`,`updated_at`) VALUES
(1,'Hair Care Secrets','hair-care-secrets','<h2>5 Must-Have Hair Care Secrets</h2><p>Discover the essential secrets to maintaining beautiful, healthy hair...</p>','Learn expert tips for your best hair','/banner/Product-Shampoo.webp','Beauty Expert','Hair Care',1,'2026-06-04T08:48:23.127823','2026-06-04T08:48:23.127823'),
(2,'Winter Skincare Tips','winter-skincare-tips','<h2>Winter Skincare for Nigerian Climate</h2><p>Combat harsh harmattan winds with expert skincare...</p>','Keep skin glowing in dry season','/banner/Product-Face-Care.webp','Skincare Specialist','Skincare',1,'2026-06-04T08:48:23.127823','2026-06-04T08:48:23.127823'),
(3,'Gifting Ideas','gifting-ideas','<h2>Best Gifting Ideas for All Occasions</h2><p>Find thoughtful gifts for everyone...</p>','Discover gift ideas for every occasion','/banner/Product-Body-Care.webp','Gift Curator','Gifting',1,'2026-06-04T08:48:23.127823','2026-06-04T08:48:23.127823'),
(4,'Product Review','argan-oil-review','<h2>Argan Oil Benefits Review</h2><p>Read our comprehensive review of Argan Oil Shampoo...</p>','Real benefits, real results','/banner/Brand_Argan_Oil_V3.webp','Product Tester','Product Reviews',1,'2026-06-04T08:48:23.127823','2026-06-04T08:48:23.127823'),
(5,'Wellness Guide','wellness-self-care','<h2>Importance of Self-Care Routine</h2><p>Learn to build a wellness routine...</p>','Invest in yourself with self-care','/banner/Product-Body-Care-1.webp','Wellness Coach','Wellness',1,'2026-06-04T08:48:23.127823','2026-06-04T08:48:23.127823');

-- ── Stores data (600 rows) ───────────────────────────────────────────────────
INSERT INTO `stores` (`id`,`name`,`address`,`city`,`state`,`phone`,`email`,`hours`,`logo`,`created_at`) VALUES
(20,'Market Square Aba',NULL,'Aba','Abia',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(21,'Market square Aba 2',NULL,'Aba','Abia',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(22,'Jovit Mart, Umuahia',NULL,'Umuahia','Abia',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(23,'Market Square Umuahia',NULL,'Umuahia','Abia',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(24,'247 Supermarket, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(25,'All time Supermarket 3, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(26,'All Time Supermarket, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(27,'Christ the King Supermarket Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(28,'De Samic, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(29,'Down Town Shopping Complex, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(30,'Efg Mart Supermarket, Uyo 1',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(31,'Efg Mart Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(32,'Hangers Supermarket, Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(33,'Jane & Juliet Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(34,'Judel Supermarket',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(35,'Market Square Ikot Epene',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(36,'Market Square Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(37,'Nteps Supermarket Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(38,'Rich Way Supermarket Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(39,'Value Plus Supermarket Uyo',NULL,'Uyo','Akwa Ibom',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(40,'Everyday Supermarket Awka E12',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(41,'Market Square Awka',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(42,'Radopin Supermarket 1 Ziks Avenue Awka',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(43,'Radopin Supermarket 2 Aroma Junction Awka',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(44,'Radopin Supermarket 3 Kwata Junction Awka',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(45,'Zara Stores, Awka',NULL,'Awka','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(46,'Obinna Onitsha',NULL,'Onitsha','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(47,'Paxs Pharmacy Onitsha',NULL,'Onitsha','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(48,'Shoprite Sr Onitsha mall 64769',NULL,'Onitsha','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(49,'Zara Stores, Onitsha',NULL,'Onitsha','Anambra',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(50,'Assorted Super Centre, Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(51,'De Royal Mall, Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(52,'General Supermarket Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(53,'Joepal Supermarket Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(54,'Lozzy Supermarket Yenogua',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(55,'Market Square Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(56,'Oasis Mart, Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(57,'Sureplus Supermarket Yenogoa',NULL,'Yenagoa','Bayelsa',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(58,'Market Square Gsm Market Maiduguri, Borno',NULL,'Maiduguri','Borno',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(59,'Enumex Cosmetics Calabar',NULL,'Calabar','Cross River',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(60,'Spar Calabar Mall, Calabar',NULL,'Calabar','Cross River',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(61,'Safari Hypermarket, Warri',NULL,'','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(62,'Amaka Stores, Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(63,'Annies Market Place, Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(64,'Centrus Mall, Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(65,'Corner Mart, Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(66,'Everyday Supermarket Summit Asaba E10',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(67,'Market Square Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(68,'Market Square Asaba Mall, Okpanam Road',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(69,'Pukka Supermarket, Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(70,'Shoprite Sr Asaba 85923',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(71,'Townsquare Asaba',NULL,'Asaba','Delta',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(72,'Everyday Supermarket Abakaliki E13',NULL,'Abakaliki','Ebonyi',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(73,'Alpha Pet, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(74,'Amambraco Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(75,'Awari Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(76,'Coka Pharmacy & Stores, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(77,'Coka Pharmacy & Stores, Off Sapele RD',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(78,'Elixir Supermarket Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(79,'Enascolin Ventures, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(80,'Ford Mart Benin City',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(81,'Ford Mart Supermarket Adolor, Benin City',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(82,'Ford Mart Supermarket Supermarket, Isikolor Road, Benin City',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(83,'GPS Shopping Mall, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(84,'Hexcel Supermarket, Benin City',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(85,'IK Pharmacy and Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(86,'Jara Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(87,'Jara Edlp Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(88,'Kevs Departmental Stores, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(89,'LMSN Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(90,'Mankind Pharmacy and Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(91,'Market Square Aduwawa Benin 2',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(92,'Market Square Airport Road, Benin 3',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(93,'Market Square Benin Sapele Road',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(94,'MM2 Ekosodine, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(95,'MM2 Isihor, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(96,'Nick supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(97,'Phil Hallmark Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(98,'Phil Hallmark Benin 2',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(99,'Prime Mart By Morzi',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(100,'Real Care Pharmacy and Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(101,'Shoprite Benin Mall',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(102,'Stop 2 Shop Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(103,'Vintage Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(104,'Wonder Supermarket, Benin',NULL,'Benin City','Edo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(105,'Ceci Supermarket, Ado-Ekiti',NULL,'Ado-Ekiti','Ekiti',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(106,'Jara Ekiti',NULL,'Ado-Ekiti','Ekiti',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(107,'Nao Supermarket, Ado Ekiti',NULL,'Ado-Ekiti','Ekiti',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(108,'Staleg Mall, Ado-Ekiti',NULL,'Ado-Ekiti','Ekiti',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(109,'Best Choice Enugu',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(110,'Freshshop Supermarket Transekulu, Enugu',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(111,'Market Square Enugu',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(112,'Marvel Nissi Store',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(113,'Roban Stores Enugu',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(114,'Shopper Gate Enugu',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(115,'Shoprite SR Enugu 56247',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(116,'Spar Enugu Mall',NULL,'Enugu','Enugu',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(117,'2k Supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(118,'Arinze, Wuse Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(119,'Azores Supermarket Kuje, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(120,'Babbo Supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(121,'Best Buy Supermarket, Kuje',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(122,'Bless Shop Supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(123,'Blessed Victoria Supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(124,'Bright Cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(125,'Callys Venture Beauty Store, Wuse Market',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(126,'CH Cosmetics Wuse Market, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(127,'Chidivac Pharmacy & Stores, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(128,'Chimex Stores, Wuse Market',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(129,'China sky supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(130,'Cost Cutters SUpermarket Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(131,'CyMarc International Limited, Wuse Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(132,'De petex Cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(133,'DFD Pharmacy & Superstore, Lugbe',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(134,'Eagle Success cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(135,'Ebeano Supermarket Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(136,'Eden Cosmetics Wuse Market, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(137,'El- Roi super stores, Auja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(138,'Family Wellness Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(139,'Faxx Stores & Trading Ltd, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(140,'Goshen Stores, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(141,'Grand Product Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(142,'H-medix Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(143,'I C World Supermarket Gwarinpa, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(144,'IK P supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(145,'James Beauty Cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(146,'Lead Gate Supermarket Jabi Lake, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(147,'Market Square Apo 2 Mall, Apo Round About, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(148,'Market Square Dawaki District, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(149,'Market Square Gateway Mall, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(150,'Market Square Gwarinpa Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(151,'Market Square Karu, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(152,'Market Square Kuje, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(153,'Mesdon Int''l Ltd, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(154,'Mostel Cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(155,'Mr. ugoo ABJ',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(156,'Multimac cosmetic store, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(157,'ND Stores, Kuje',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(158,'Oliva Twist Supermarket, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(159,'Onyeze Cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(160,'Open Door Supermarket Wuse',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(161,'Organic beauty cosmetics, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(162,'Prince Ebeano Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(163,'Prince Ebeano Supermarket, Gudu Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(164,'Sahad Cosmetics Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(165,'Shoprite Sr Abuja Gateway 96663',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(166,'Spar Central Business District, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(167,'Spar Gwarinpa, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(168,'Spar Wuse II, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(169,'Spar Wuse Zone 5, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(170,'Tobeklen Pharmacy & Stores, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(171,'Top Outlet Stores, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(172,'Tosco Cosmetics Wuse Martket',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(173,'Trolley Supermarket Wuse II, Abuja',NULL,'Abuja','FCT Abuja',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(174,'AT Cosmetics, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(175,'Destiny Supermarket Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(176,'Everyday Supermarket 4040 Owerri E11',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(177,'Everyday Supermarket Ikenegbu Owerri E4',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(178,'Everyday Supermarket Imsu Owerri E8',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(179,'Everyday Supermarket Mcc Owerri E7',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(180,'Everyday Supermarket World Bank Owerri E5',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(181,'Family Mart',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(182,'Gain More Supermarket',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(183,'Glorisco Supermarket Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(184,'Leedel Super Store',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(185,'Leedel Superstore Ikenegbu, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(186,'Lython Cosmetics Ekeonuwa, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(187,'Market Square Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(188,'Market Square Owerri Mall',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(189,'Priceless Stores Okigwe Rd, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(190,'Priceless Stores Orlu Raod, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(191,'Priceless Stores Youth center layout, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(192,'Promall, Owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(193,'Save More Market Place',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(194,'shoprite owerri',NULL,'Owerri','Imo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(195,'Market Square Kaduna',NULL,'Kaduna','Kaduna',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(196,'Shoprite Sr Kaduna Mall 9663',NULL,'Kaduna','Kaduna',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(197,'Grand Products Kano',NULL,'Kano','Kano',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(198,'Ify Fabulous Cosmetics, Ilorin',NULL,'Ilorin','Kwara',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(199,'SIsters Lounge, Ilorin',NULL,'Ilorin','Kwara',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(200,'Adivia Stores, Lekki County Home',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(201,'Bag It supermarket Admiralty Way, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(202,'Better Mart Badore',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(203,'Blenco Addo',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(204,'Blenco Ilasan Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(205,'Blenco Supermarket Ajiwe, Ajah',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(206,'Blenco Supermarket, Eputu ibeju Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(207,'Blenco Supermarket, Sangotedo',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(208,'Careforte Pharm VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(209,'CEC Drug n more pharmacy and beauty, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(210,'Ceo''s Mart',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(211,'Compra Mart',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(212,'Compra Mart, Orchid',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(213,'Day Toner People''s Pharmacy, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(214,'Daytoner Aja',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(215,'Delis VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(216,'Delux Supermarket Sangotedo',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(217,'Ebeano Supermarket Agungi Branch',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(218,'Ebeano Supermarket Chevron Branch',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(219,'Ebeano Supermarket Eleganza',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(220,'Ebeano Supermarket Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(221,'Ebeano SUpermarket Oniru',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(222,'Ebeano Supermarket, Jakande',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(223,'Enej Supermarket, Orchid Rd',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(224,'Ever Bright Store',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(225,'Feebees Retail Services, Oniru',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(226,'Foodco Ikoyi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(227,'Foodco Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(228,'Freedom Mart Supermarket, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(229,'Grand Products VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(230,'Greeneil Supermarket Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(231,'Greeneil Supermarket Osapa London',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(232,'Hartley Supermarket Ikoyi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(233,'Hartleys Supermarket VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(234,'Jendol Super Store, Ajah Lagos',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(235,'Justrite Superstore Ikate Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(236,'Kls supermarket, Ikeja',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(237,'Lapas Mall Ajah',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(238,'Lapaz Mall Limited',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(239,'Limitless Mart, Eputu',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(240,'Market Square Lekki, Lagos',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(241,'Market Square Sangotedo, Lagos',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(242,'Max Ambi supermarket, Ibeju Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(243,'MC Awesome Supermarket, Ajah',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(244,'Medplus Pharm',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(245,'Mega Plaza',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(246,'Mega Plaza VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(247,'Mitch & Good Supermarket, Ikoyi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(248,'Mopheth Pharmacy, Vi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(249,'Multikers Supermarket VI',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(250,'My Groceries 2go',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(251,'My Mart, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(252,'Naija Medix Pharmacy, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(253,'Okoli Supermarket Ikoyi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(254,'Ozzy Stores Eti Osa',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(255,'Ozzy Stores Ilaje',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(256,'Ozzy Stores Osapa London',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(257,'Palais de beaute cosmetics',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(258,'Palais De Beaute Cosmetics, Big Shop',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(259,'Palais De Beaute Cosmetics, Shop 1',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(260,'Palais De Beaute Cosmetics, Shop 2',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(261,'Palais De Beaute Cosmetics, Shop 3',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(262,'Phylmart, Agungi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(263,'Pick n Pay Glover',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(264,'Pick N Pay Vi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(265,'Quick Point Supermarket, Sangotedo',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(266,'Replenish Supermarket Badore',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(267,'Roinuj Supermarket, Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(268,'Shoprite SR Lekki Mall 64751',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(269,'SkyMart',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(270,'Sorfis Supermarket, Sangotedo',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(271,'Spar Ikate Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(272,'Spinneys Supermarket Addo RD',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(273,'St David Pharmacy Warehouse',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(274,'SuperSaver Supermarket Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(275,'Supersaver Supermarket, Lenox Mall Lekki',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(276,'T & M Supermarket, Agungi',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(277,'Temple Hill Ajah',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(278,'Twins Faja Supermarket, Ajah',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(279,'U B A Supermarket, Ogidan',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(280,'U B A Supermarket, Orchid',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(281,'Zetile Supermarket',NULL,'Lagos Island / Lekki','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(282,'3D Radiance Pharmacy, Gbagada',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(283,'6 to 9 Supermarket',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(284,'Alpha Pharmacy and Stores, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(285,'Bedrock Mart Bucknor Isolo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(286,'Blenco Supermarket Abule Egba',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(287,'Blenco Supermarket Egbeda',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(288,'Blenco Supermarket, Amadiya',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(289,'D, Emperor Grand Mall',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(290,'DBANI Supermarket, Bariga',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(291,'Dee Kam Market Place, Ota',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(292,'Destiny Arikpo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(293,'DFK Super Store, Palm Groove',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(294,'Edichart Shoping Mall',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(295,'Emmatos Super Store, Aboru',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(296,'Emmatos Super Store, Alagbado',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(297,'Emmatos Super Store, Ishashi 3',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(298,'Essentials by Grandview',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(299,'Et Al Farms Superstores, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(300,'Foodco Ikotun',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(301,'Globus Ago',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(302,'Globus supermarket Ajao Estate Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(303,'Go Trading Enterprises Apapa, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(304,'Goodies Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(305,'Grand Products Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(306,'Healthrite Pharmacy 2',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(307,'Healthrite Pharmacy Randle',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(308,'Healthrite Pharmacy Tejuosho',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(309,'J Lush Supermarket, Ojota',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(310,'Jara Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(311,'Jendol Abule Egba',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(312,'Jendol Central Warehouse, Egbeda',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(313,'Jendol Odonguyan, Ikorodu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(314,'Jendol Supermarket Alakuko',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(315,'Jendol Supermarket Igando 2',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(316,'Jendol Supermarket Ikorodu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(317,'Jendol Supermarket Isheri',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(318,'Jendol SUpermarket Isolo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(319,'Jendol Supermarket Ojodu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(320,'Jendol Superstore Egbeda',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(321,'Jendol Superstore Oju Ore',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(322,'Jendol Superstores Ibafo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(323,'Jendol Superstores Ijede, Ikorodu 3',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(324,'Jendol Superstores Magidun, Ikorodu 4',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(325,'Jendol Superstores, Ipaja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(326,'Jendol Superstores, Onibukun',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(327,'Joeddy Supermarket, Anthony Village',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(328,'Justcom Stores, Ogudu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(329,'Justrite Central Warehouse Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(330,'Justrite Supermarktet Sango Otta',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(331,'Justrite Superstore Abule Egba',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(332,'Justrite SuperStore Akowonjo Egbeda',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(333,'Justrite Superstore Ayobo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(334,'Justrite Superstore Casso, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(335,'Justrite Superstore Dopemu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(336,'Justrite Superstore Igando, Lagos State',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(337,'Justrite Superstore Iju',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(338,'Justrite Superstore Ikorodu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(339,'Justrite Superstore Ikorodu 2',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(340,'Justrite Superstore Isolo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(341,'Justrite Superstore Iyana Ipaja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(342,'Justrite Superstore Odonguyan, Ikorodu 3',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(343,'Justrite Superstore Ojodu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(344,'Justrite Superstore Owode',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(345,'Justrite Superstore, Omole',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(346,'Justrite Superstores Alakuko',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(347,'Justrite Superstores Bariga',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(348,'Justrite Superstores Ekoro, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(349,'Justrite Superstores Gowon Estate',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(350,'Justrite Superstores Ibafo Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(351,'Justrite Superstores, Ogba Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(352,'Katta Supermarket',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(353,'Li-m Supermarket, Ota',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(354,'Macmannie Supermarket, Ogba',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(355,'Mama Tega, Tejuosho Market',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(356,'Market Square Festac',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(357,'Market square Maryland, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(358,'Market Square Okota',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(359,'Market Square Owode Idiroko Road, Ogun State',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(360,'Market Square, Gbagada',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(361,'Maxland Shopping Center',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(362,'Mostan Super Stores, Gbagada',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(363,'Old English Abule Egba',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(364,'Old english Omole Phase',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(365,'Old English Stores GRA',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(366,'Old English Superstores, Ibadan',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(367,'Old English Surulere',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(368,'Omezera Supermarket, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(369,'One Source Mart, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(370,'Pay Day Supermarket Oworoshoki, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(371,'Penafort Supermarket Festac',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(372,'Pharma Care Pharmacy, Festac',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(373,'Prestige Superstores Ajuwon, Akute',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(374,'Prestige Superstores Akesan, Igando',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(375,'Prestige Superstores Ishashi',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(376,'Prestige Superstores Iyana Paja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(377,'Prime Mart Superstores Cement',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(378,'Prime Mart Superstores Ifo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(379,'Prime Mart SuperStores Iyana Ishasgi RD Ojo, Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(380,'Prime Mart Superstores LASU Idimu IBa Rd AKesan Lagos',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(381,'Prime Mart Superstores Singer',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(382,'Prime Mart Superstores, Agbara',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(383,'Prime Mart Superstores, Okoko',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(384,'Prince Ebeano Supermarket Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(385,'Q Mart Supermarket, Bariga',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(386,'Qwik Supermarket, Anthony',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(387,'Reno Supermarket Iyana School B/S 3',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(388,'Reno Supermarket, Ejigbo 2',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(389,'Reno Supermarket, Ikotun',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(390,'Reno Supermarket, Isheri 4',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(391,'Reno Superstore, Isuti Road',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(392,'Royal Prince Supermarket Berger',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(393,'Royal Prince Supermarket Gbagada',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(394,'Shoprite SR Ikeja City Mall 53443',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(395,'Simon''s Superstores, Agbara',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(396,'Smartiemart Mega Stores',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(397,'Spar Afprint Compound Surulere',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(398,'Spar Ilupeju, Mushin',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(399,'Spar Opebi Road, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(400,'SuperSaver Ajao Estate',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(401,'Supersaver Alapere',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(402,'Supersaver Central Warehouse',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(403,'Supersaver Ikosi',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(404,'Supersaver Shangishan Magodo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(405,'Temple Hill Festac',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(406,'Temple hill Isolo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(407,'The Label Store',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(408,'The Label Store, Kilo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(409,'Udeme Supermarket, Ikeja',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(410,'Value Exchange Superstores, CMD',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(411,'Value Exchange Superstores, Magodo',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(412,'Valuemart Stores, Ekoro',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(413,'Veritas Value Village Ventures, Ogudu',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(414,'Victory City Supermarket, Anthony',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(415,'Westgate Cosmetics',NULL,'Lagos Mainland','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(416,'A.A Best',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(417,'A.G Cosmetics',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(418,'A.S Philips',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(419,'Abuchi',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(420,'Acalvien',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(421,'Amaka Tic',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(422,'Andrew (ayt Commercial Ent.)',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(423,'Beauty Affairs',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(424,'Ben Tradefair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(425,'Bismid',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(426,'C Smart',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(427,'C-Nature',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(428,'chinedu',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(429,'Chineye',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(430,'Chioma (abf Opp.borno Plaza',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(431,'chioma (Vizora)',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(432,'Chogwu',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(433,'Chybike',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(434,'Cibson Investment',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(435,'Contender',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(436,'D Chuks Global',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(437,'Destined',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(438,'Divine Mercy',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(439,'Ebuka T.f',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(440,'Efe',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(441,'Ejis Ocean',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(442,'Ekene',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(443,'Ella',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(444,'Elsim',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(445,'Emmanuel Ejemba',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(446,'Fine Look',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(447,'Genesis',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(448,'Globus Relativity Stores Trade Fair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(449,'Jbo',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(450,'Jude V Tradefair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(451,'jykesweb',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(452,'Kanof',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(453,'Kodis',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(454,'Mac-visco Ltd',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(455,'Madam Charles',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(456,'Madam Chinenye',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(457,'Madam Chinwe (ethel N Ella Beauty)',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(458,'Madam Donella',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(459,'Madam Grace',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(460,'Madam Oluchi',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(461,'Madam UC',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(462,'Mark Choice',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(463,'Mmiri Tradefair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(464,'N.K',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(465,'Nomsky',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(466,'Obinna Tradefair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(467,'oga chucks',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(468,'Oga Emeka',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(469,'Oga Frank',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(470,'Oga O.C',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(471,'Oga Onyeka',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(472,'Oga Tony',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(473,'Oga Vicky (Righteous Gate) Trade fair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(474,'Olivia',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(475,'Oluchi',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(476,'Onyeka Tradefair',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(477,'oramore',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(478,'Ozeh',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(479,'P.tom',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(480,'Penaforte Supermarket, Village Bus Stop',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(481,'Solex Cosmetics (umeh)',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(482,'Speedyon',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(483,'Stand By',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(484,'Stanley',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(485,'Tagbo',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(486,'Trade fair cash sales',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(487,'Uk Daji',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(488,'Valmac Ice Nig Ltd',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(489,'VINOFF (Joy)',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(490,'Wendy',NULL,'Trade Fair Complex','Lagos',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(491,'Justrite Superstore Funaab, Ogun State',NULL,'','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(492,'Sino Mart Superstore, Ota',NULL,'','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(493,'Foodco Abeokuta',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(494,'Foodco Akinolugbade, Abeokuta',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(495,'Foodco Asero, Abeokuta',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(496,'Justrite Superstore Abeokuta',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(497,'Justrite Superstore Kemta, Ogun State',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(498,'Justrite Superstore Lafenwa, Ogun Satet',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(499,'Justrite Superstore Obantoko',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(500,'Shalom Mega Stores',NULL,'Abeokuta','Ogun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(501,'Ceci Mega Plaza, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(502,'First Vigeo Supermarket, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(503,'Nao Supermarket, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(504,'O.u.k Supermarket, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(505,'Ojajamore Supermarket, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(506,'Olukem Supermarket, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(507,'Shoprite SR Akure Mall 93144',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(508,'Staleg Mall, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(509,'Tush Mart Limited, Akure',NULL,'Akure','Ondo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(510,'Justrite Superstores Ilesha',NULL,'Ilesha','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(511,'City Star Mart, Oshogbo',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(512,'Justrite Superstore Ile- Ife, Osun State',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(513,'Justrite Superstore Oshogbo',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(514,'Lead Supermarket Warehouse, Oshogbo',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(515,'Ojaja More Oshogbo',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(516,'Ojajamore Supermarket Ile-Ife',NULL,'Osogbo','Osun',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(517,'Better Days',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(518,'Bmc Cosmetics',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(519,'Bright Links Cosmetics Hub',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(520,'Ceebeco',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(521,'Chuppet',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(522,'Coach Supermarket',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(526,'Katta Supermarket, AIT Branch',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(527,'Legend Supermarket (opposite House On The Rock)',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(528,'Madina Lifestyle & Supermarket, Somolu',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(529,'Maldora supermarket , Ifako',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(530,'Market Square Delta Mall',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(532,'Obireal',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(533,'Obum Tradefair',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(534,'Patcargo (nonso)',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(535,'Penny Express Ago',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(537,'Shoprite SR Abia Mall 35300',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(538,'Shoprite Sr Adeniran 57617',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(539,'Shoprite Sr Circle Mall 64808',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(540,'Shoprite Sr Cocoa Mall 37726',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(541,'Shoprite SR Delta Mall 64785',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(542,'Shoprite SR Festival Mall 64777',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(543,'shoprite SR GRAND TOWER',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(544,'Shoprite Sr Jabi Lake 64793',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(545,'Shoprite SR Kwara Mall 56221',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(546,'Shoprite Sr Otta Gateway 83311',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(547,'Shoprite SR Park Lane 37734',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(548,'Shoprite Sr Silverbird 38073',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(549,'Shoprite Sr the Palms 44917',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(550,'Spar Adeola Odeku, VI',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(551,'The Brands Superstores, Pedro',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(552,'Twins Faja Supermarket, Ijanikin',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(553,'Twins Faja Supermarket, Ipaye B/S',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(554,'U B A Supermarket Awoyaya Bus Stop',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(555,'Unique Superstore, Ede',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(556,'Value Exchange Superstores, Arepo',NULL,'','Others',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(557,'Ace Mall Bodija, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(558,'Brent Mall Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(559,'Buy and Save Bodija, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(560,'Danax Cosmetics, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(561,'Finrel Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(562,'Foodco Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(563,'Foodco Jericho Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(564,'Foodco Monatan Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(565,'Foodco Ologuneru Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(566,'Foodco Ring Road Warehouse, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(567,'Foodies Supermarket Jericho, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(568,'Jara Oyo',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(569,'Justrite Supermarket Eleyele, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(570,'Justrite Superstore Akobo, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(571,'Justrite Superstore Ring Road, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(572,'Market Square Gbagi, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(573,'More Mart Alakia, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(574,'More Mart Olorunsogo, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(575,'More Mart Olunde, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(576,'Mosh Pharmacy and Supermarket Bodija, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(577,'SFY Superstores, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(578,'Shokem Supermarket Ibadan, UI Branch',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(579,'Shokem Supermarket, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(580,'Shoprite Sr Ibadan Mall 56255',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(581,'Staleg Mall, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(582,'Sunrise Supermarket, Ibadan',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(583,'Vanguard Pharmacy, Akobo',NULL,'Ibadan','Oyo',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(584,'Amechi PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(585,'Buyplus Mall D Line, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(586,'Emilo Super Market',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(587,'Essence Needz Eneka PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(588,'Essence Needz PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(589,'Everyday Supermarket Choba Ph E6',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(590,'Everyday Supermarket Gra Ph E2',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(591,'Everyday Supermarket Mgbuoba Ph E9',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(592,'Everyday Supermarket Peter Odili',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(593,'Everyday Supermarket Rumuibekwe E3 Ph',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(594,'Everyday Supermarket Rumuola E1 Ph',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(595,'Exotica Ph',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(596,'Hepzibah Supermarket, Eket',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(597,'HyperCity Ogunabali Port Harcourt',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(598,'Hypercity Retail Ltd Ikoku, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(599,'HyperCity Retail ltd Tombia Road New GRA PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(600,'Hypercity Retail Ltd, Trans-Amadi Rd, Port Harcourt',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(601,'Market Square Ada George PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(602,'Market Square Agip Road, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(603,'Market Square Choba',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(604,'Market Square Eket',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(605,'Market Square Elelenwo Ph',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(606,'Market Square Eleme, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(607,'Market Square GRA Phase 3 PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(608,'Market Square Iwofe Road',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(609,'Market square Mile 3, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(610,'Market Square Nzimiro, Port Harcourt',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(611,'Market square Okporo Rumudara Ph',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(612,'Market Square Onne PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(613,'Market Square Peter Odili PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(614,'Market Square Rukpokwu AIrport RD PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(615,'Market Square Rumuibekwe PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(616,'Next Cash & Carry PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(617,'Shoprite SR Garden City Mall PH 79380',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(618,'Spar Port Harcourt',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(619,'Super City Supermarket, PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(620,'The Prince Mega Cosmetics',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(621,'Welcome U Supermarket',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(622,'Wide Choice Ada George',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(623,'Wide Choice Choba PH',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648'),
(624,'Wide Choice Iwofe',NULL,'Port Harcourt','Rivers',NULL,NULL,NULL,NULL,'2026-07-21T09:43:51.957648');

-- ── Site content (single JSON blob row) ─────────────────────────────────────
INSERT INTO `site_content` (`id`, `data`) VALUES (1, '{"seo": {"pages": {"blog": {"title": "Beauty Journal - Hair & Skin Care Tips for Nigeria", "robots": "index, follow", "ogImage": "", "keywords": "beauty tips nigeria, skin care guide nigeria, hair care tips lagos, natural beauty routine nigeria, xpel beauty blog", "description": "Hair care tips, skincare routines and beauty guides tailored to the Nigerian climate - expert advice from the Xpel Beauty NG team for every skin and hair type."}, "home": {"title": "Hair Care, Skin Care & Body Care Products in Nigeria", "robots": "index, follow", "ogImage": "", "keywords": "xpel beauty nigeria, best skincare brand lagos, hair care products nigeria, buy beauty products online nigeria, skin care products abuja, body care nigeria, argan oil nigeria, tea tree products nigeria, aloe vera skincare nigeria, beauty store lagos", "description": "Shop Xpel Beauty Care - Nigeria''s trusted hair care, skin care, oral care and body care brand. Nature-infused formulas that deliver real results, delivered to Lagos, Abuja, Port Harcourt and nationwide."}, "shop": {"title": "Shop All Beauty Products Online in Nigeria", "robots": "index, follow", "ogImage": "", "keywords": "buy beauty products online nigeria, shop hair care products nigeria, shop skin care lagos, body care products abuja, xpel beauty shop, best beauty store nigeria", "description": "Browse the full Xpel Beauty Care range online - shampoos, conditioners, face washes, serums, body lotions, oral care and more. Nature-infused beauty delivered across Lagos, Abuja, Port Harcourt and all of Nigeria."}, "about": {"title": "About Us - Nigeria''s Nature-Infused Beauty Brand", "robots": "index, follow", "ogImage": "", "keywords": "about xpel beauty nigeria, xpel beauty care story, nigerian beauty brand, best beauty brand nigeria, natural beauty brand lagos", "description": "Learn the story behind Xpel Beauty NG - exceptional, nature-infused hair, skin, oral and body care, trusted by customers across Lagos, Abuja, Port Harcourt and beyond."}, "stores": {"title": "Find Xpel Beauty Stockists Near You in Nigeria", "robots": "index, follow", "ogImage": "", "keywords": "xpel beauty stockists nigeria, where to buy xpel beauty care lagos, beauty store near me nigeria, xpel store locations abuja", "description": "Locate Xpel Beauty Care stockists across Nigeria - find a trusted retail store near you in Lagos, Abuja, Port Harcourt and other major cities."}, "contact": {"title": "Contact Us - Orders & Enquiries", "robots": "index, follow", "ogImage": "", "keywords": "contact xpel beauty nigeria, order xpel beauty products, xpel beauty trade enquiry lagos, buy xpel products nigeria", "description": "Get in touch with Xpel Beauty NG for product orders, trade enquiries or support - serving customers across Lagos, Abuja, Port Harcourt and nationwide Nigeria."}}, "siteTitle": "Xpel Beauty NG", "twitterHandle": "", "defaultOgImage": "/banner/Brand_Argan_Oil_V3.webp", "titleSeparator": " | ", "defaultDescription": "Shop Xpel Beauty Care products in Nigeria - premium hair care, skin care, oral care and body care essentials. Nature-infused formulas at unbeatable prices, available nationwide.", "googleVerification": ""}, "logo": "/images/logo-xpel-beauty-ng.png", "banner": "", "slides": [], "banners": {"blog": {"cta": "", "href": "", "text": "Tips, guides and stories from Xpel Beauty Care.", "image": "/banner/Brand_Argan_Oil_V3.webp", "title": "The Beauty Journal"}, "shop": {"cta": "Discover more", "href": "/about", "text": "Nourish, repair and shine with Moroccan argan oil.", "image": "/banner/Brand_Argan_Oil_V3.webp", "title": "The Argan Oil Collection"}, "stores": {"cta": "", "href": "", "text": "Available at trusted retailers nationwide.", "image": "/banner/Brand-Tea-Tree.webp", "title": "Find Xpel Beauty Care near you"}, "contact": {"cta": "", "href": "", "text": "Questions, orders or trade enquiries - get in touch.", "image": "/banner/Product-Face-Care.webp", "title": "We''d love to hear from you"}, "shopHero": {"cta": "", "href": "", "text": "exceptional products. unbeatable value.", "image": "/banner/Product-Body-Care.webp", "title": "shop our range", "kicker": "our products & brands"}}, "ctaText": "ready to reveal the beauty within yourself?", "ctaImage": "/banner/Product-Face-Care.webp", "megaMenu": {"feature": null, "categories": [{"slug": "hair-care", "label": "Hair Care"}, {"slug": "body-beauty", "label": "Body & Beauty"}, {"slug": "home", "label": "Home"}, {"slug": "gifting", "label": "Gifting"}], "brandGroups": [{"group": "Xpel Ranges", "items": [{"href": "/collection/xpel-body-care", "name": "Xpel Body Care"}, {"href": "/collection/xpel-hair-care", "name": "Xpel Hair Care"}, {"href": "/collection/xpel-oral-care", "name": "Xpel Oral Care"}, {"href": "/collection/xpel-foot-care", "name": "Xpel Foot Care"}, {"href": "/collection/xpel-nail-care", "name": "Xpel Nail Care"}]}, {"group": "Specialist Ranges", "items": [{"href": "/collection/black-castor-oil", "name": "Black Castor Oil & Avocado"}, {"href": "/collection/so-fresh", "name": "So Fresh"}, {"href": "/collection/intimelle", "name": "Intimelle"}, {"href": "/collection/truesmile", "name": "Truesmile"}, {"href": "/collection/nulab", "name": "Nulab"}, {"href": "/collection/hot-rose", "name": "Hot Rose"}, {"href": "/collection/men-grooming", "name": "Men Grooming Products"}]}, {"group": "Natural Ranges", "items": [{"href": "/collection/aloe-vera", "name": "Aloe Vera"}, {"href": "/collection/vitamin-c", "name": "Vitamin C"}, {"href": "/collection/papaya", "name": "Papaya"}, {"href": "/collection/tea-tree", "name": "Tea Tree"}, {"href": "/collection/neem-oil", "name": "Neem Oil"}, {"href": "/collection/argan-oil", "name": "Argan Oil"}]}, {"group": "Shop by Type", "items": [{"href": "/collection/facial-toner", "name": "Facial Toner"}, {"href": "/collection/facial-wipes", "name": "Facial Wipes"}, {"href": "/collection/scrubs", "name": "Facial & Body Scrubs"}, {"href": "/collection/shampoo", "name": "Shampoo"}, {"href": "/collection/conditioner", "name": "Conditioner"}, {"href": "/collection/toothpaste", "name": "Toothpaste"}, {"href": "/collection/mouthwash", "name": "Mouthwash"}]}]}, "aboutLead": "You deserve to look and feel your best every single day - without harsh chemicals, confusing labels or premium price tags. That''s exactly why we exist.", "blogIntro": "Tips, guides and stories from the world of Xpel Beauty Care.", "blogTitle": "beauty journal", "catImages": ["/banner/Product-Face-Care.webp", "/banner/Brand_Argan_Oil_V3.webp", "/banner/Brand-Tea-Tree.webp", "/banner/Product-Body-Care.webp", "/banner/Product-Hand-Care.webp"], "feat1Href": "/collection/aloe-vera", "feat1Text": "Soothe, hydrate and refresh with botanically-derived aloe - 100% safe, gentle and made to calm skin after every day.", "feat2Href": "/collection/tea-tree", "feat2Text": "Foaming face wash, anti-dandruff shampoo and more - purifying tea tree formulas that cleanse, clarify and balance naturally.", "feat3Href": "/collection/argan-oil", "feat3Text": "Argan hair mask and body butter rich in nourishing oils to restore softness, shine and manageability - repair that shows.", "heroLine1": "Reveal the beauty", "heroLine2": "within yourself", "quoteText": "True beauty begins with self-care - caring for yourself should feel effortless and empowering.", "shopTitle": "shop our range", "step1Desc": "Tell us your concern - skin, hair, oral, nail or foot. We have a collection for each.", "step2Desc": "Pick products powered by botanicals you can actually pronounce and trust.", "step3Desc": "Make it part of your routine and feel the difference look back at you.", "themeNavy": "#1B2A3B", "aboutTitle": "Reveal the beauty within yourself", "adminUsers": [{"id": "1781259942427", "name": "Samuel", "role": "Admin", "email": "sammieakozor@gmail.com", "username": "samx", "password_hash": "9473c6cc0314b242ca64e25791bc479c16522f32cd9089bd32f00a23dccc2ac6"}], "feat1Title": "Aloe Vera Cooling Gel", "feat2Title": "Tea Tree Collection", "feat3Title": "Argan Nourishing Range", "heroSlides": [{"ctaBg": "#1B6B2E", "image": "/banner/banner 1.webp", "ctaHref": "/collection/tea-tree", "benefits": ["Anti-bacterial tea tree oil formula", "Moisturising shampoo & conditioner", "Gentle enough for everyday use"], "ctaColor": "#FFFFFF", "ctaLabel": "explore tea tree", "subLabel": "tea tree", "vegaBadge": "", "descriptor": "Anti-Bacterial Tea Tree Haircare Collection", "brandLockup": "xhc®  |  xpel hair care", "vegaBadgeBg": "rgba(255,255,255,.18)", "overlayColor": "rgba(78, 108, 28, 0.88)", "headlineColor": "#E8F5D0", "headlineLine1": "Purify", "headlineLine2": "& Protect", "vegaBadgeColor": "#fff"}, {"ctaBg": "#C8860A", "image": "/banner/banner 2.webp", "ctaHref": "/collection/argan-oil", "benefits": ["Repairs & strengthens damaged hair", "Adds brilliant shine & softness", "Rich body butter, mask & serum range"], "ctaColor": "#FFFFFF", "ctaLabel": "shop argan oil", "subLabel": "argan oil", "vegaBadge": "", "descriptor": "Premium Moroccan Argan Oil Collection", "brandLockup": "xbc® xhc®  |  argan oil", "vegaBadgeBg": "rgba(255,255,255,.18)", "overlayColor": "rgba(65, 38, 4, 0.90)", "headlineColor": "#FFD166", "headlineLine1": "Nourish", "headlineLine2": "& Repair", "vegaBadgeColor": "#fff"}, {"ctaBg": "#D4620A", "image": "/banner/banner3.png", "ctaHref": "/collection/black-castor-oil", "benefits": ["Strengthens & nourishes every strand", "Boosts shine for healthier-looking hair", "With Hyaluronic Acid to maintain moisture"], "ctaColor": "#FFFFFF", "ctaLabel": "shop the collection", "subLabel": "black castor oil", "vegaBadge": "", "descriptor": "Black Castor Oil & Avocado Hair Collection", "brandLockup": "xhc®  |  xpel hair care", "vegaBadgeBg": "rgba(255,255,255,.18)", "overlayColor": "rgba(30, 10, 2, 0.92)", "headlineColor": "#F5A623", "headlineLine1": "Strengthen", "headlineLine2": "& Grow", "vegaBadgeColor": "#fff"}, {"ctaBg": "#F72585", "image": "/banner/banner4.png", "ctaHref": "/collection/so-fresh", "benefits": ["Deeply hydrates with Hyaluronic Acid", "Brightens with Vitamin C + Vitamin E", "Soothes with Watermelon Extract & Aloe Vera"], "ctaColor": "#FFFFFF", "ctaLabel": "discover the range", "subLabel": "so fresh", "vegaBadge": "Natural Vegan Ingredients", "descriptor": "Complete Hydrating Skincare Collection", "brandLockup": "xbc®  |  xpel beauty care", "vegaBadgeBg": "#4DAA00", "overlayColor": "rgba(185, 50, 55, 0.88)", "headlineColor": "#FFE8E8", "headlineLine1": "Watermelon", "headlineLine2": "Crush", "vegaBadgeColor": "#FFFFFF"}], "quoteImage": "/banner/BRAND_ARGAN_FOOTER-1.webp", "step1Title": "Discover your range", "step2Title": "Choose nature-infused care", "step3Title": "Glow, every single day", "aboutKicker": "about xpel beauty ng", "aboutValue1": "Nature-infused, botanically-derived formulas", "aboutValue2": "Ingredient transparency you can trust", "aboutValue3": "Targeted solutions for real concerns", "aboutValue4": "Exceptional quality at unbeatable value", "aboutValue5": "Trusted across health, beauty & home", "aboutVision": "To become the preferred brand in personal care and household essentials by consistently delivering dependable, affordable and innovative solutions that enhance daily living.", "collections": [{"name": "Xpel Body Care", "slug": "xpel-body-care", "subtitle": "Premium Body Care Essentials", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "brand", "accentColor": "#ca7c29", "description": "Discover our complete range of body care products - from shower gels and body lotions to scrubs and moisturisers, crafted for everyday nourishment.", "filterValue": "Xpel Body Care", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Xpel Hair Care", "slug": "xpel-hair-care", "subtitle": "The Complete Hair Care Range", "heroImage": "/banner/Product-Shampoo.webp", "filterType": "brand", "accentColor": "#ca7c29", "description": "Shampoos, conditioners, masks and treatments - our full hair care collection for every hair type and concern.", "filterValue": "Xpel Hair Care", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Xpel Oral Care", "slug": "xpel-oral-care", "subtitle": "Confident Smile, Every Day", "heroImage": "/banner/Product-Oral-Care.webp", "filterType": "brand", "accentColor": "#ca7c29", "description": "Toothpastes, mouthwashes and oral care essentials for a brighter, fresher smile every morning.", "filterValue": "Xpel Oral Care", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Xpel Foot Care", "slug": "xpel-foot-care", "subtitle": "Happy Feet, Every Step", "heroImage": "/banner/Product-Foot-Care.webp", "filterType": "brand", "accentColor": "#ca7c29", "description": "Foot creams, soaks and treatments to keep your feet soft, smooth and refreshed every day.", "filterValue": "Xpel Foot Care", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Xpel Nail Care", "slug": "xpel-nail-care", "subtitle": "Beautiful Nails, Naturally", "heroImage": "/banner/Product-Nail-Care.webp", "filterType": "brand", "accentColor": "#ca7c29", "description": "Nail treatments, strengtheners and nail care essentials for healthy, beautiful nails.", "filterValue": "Xpel Nail Care", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Tea Tree", "slug": "tea-tree", "subtitle": "Purify & Protect", "heroImage": "/banner/Brand-Tea-Tree.webp", "filterType": "brand", "accentColor": "#1B6B2E", "description": "Anti-bacterial tea tree oil formulas for hair and skin - clarifying, cleansing and balancing for a fresh, healthy glow every day.", "filterValue": "Tea Tree", "overlayColor": "rgba(78, 108, 28, 0.82)"}, {"name": "Argan Oil", "slug": "argan-oil", "subtitle": "Nourish & Repair", "heroImage": "/banner/Brand_Argan_Oil_V3.webp", "filterType": "brand", "accentColor": "#C8860A", "description": "Premium Moroccan argan oil collection - repairs and strengthens damaged hair while adding brilliant shine and softness to every strand.", "filterValue": "Argan Oil", "overlayColor": "rgba(65, 38, 4, 0.86)"}, {"name": "Black Castor Oil & Avocado", "slug": "black-castor-oil", "subtitle": "Strengthen & Grow", "heroImage": "/banner/banner3.png", "filterType": "brand", "accentColor": "#D4620A", "description": "Black castor oil and avocado hair collection - strengthens, nourishes every strand, and boosts shine for healthier-looking hair.", "filterValue": "Black Castor Oil", "overlayColor": "rgba(30, 10, 2, 0.88)"}, {"name": "So Fresh", "slug": "so-fresh", "subtitle": "Hydrate & Glow", "heroImage": "/banner/banner4.png", "filterType": "brand", "accentColor": "#F72585", "description": "Complete hydrating skincare collection - deeply hydrates with Hyaluronic Acid, brightens with Vitamin C & E, and soothes with Watermelon Extract.", "filterValue": "So Fresh", "overlayColor": "rgba(185, 50, 55, 0.82)"}, {"name": "Neem Oil", "slug": "neem-oil", "subtitle": "Nature''s Purifier", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "brand", "accentColor": "#3A7D1E", "description": "Neem oil-infused hair and skin care - naturally antibacterial and packed with nutrients for healthier, stronger hair and skin.", "filterValue": "Neem Oil", "overlayColor": "rgba(40, 75, 20, 0.82)"}, {"name": "Fresh Start", "slug": "fresh-start", "subtitle": "Start Fresh Every Day", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "brand", "accentColor": "#4D7CF6", "description": "Daily essentials for a clean, fresh routine - effective, affordable formulas to start every day feeling your very best.", "filterValue": "Fresh Start", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Intimelle", "slug": "intimelle", "subtitle": "Gentle Intimate Care", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "brand", "accentColor": "#C0235A", "description": "Specially formulated intimate care products - gentle, pH-balanced and dermatologist-tested for everyday confidence.", "filterValue": "Intimelle", "overlayColor": "rgba(140, 30, 70, 0.82)"}, {"name": "Truesmile", "slug": "truesmile", "subtitle": "Confident Smile Every Day", "heroImage": "/banner/Product-Oral-Care.webp", "filterType": "brand", "accentColor": "#0A6EBD", "description": "Truesmile oral care range - effective, refreshing formulas for a brighter, healthier smile every day.", "filterValue": "Truesmile", "overlayColor": "rgba(0, 80, 140, 0.82)"}, {"name": "Nulab", "slug": "nulab", "subtitle": "Advanced Personal Care", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "brand", "accentColor": "#5B3FC8", "description": "Nulab personal care collection - innovative formulas crafted for everyday performance and lasting freshness.", "filterValue": "Nulab", "overlayColor": "rgba(26, 31, 58, 0.82)"}, {"name": "Hot Rose", "slug": "hot-rose", "subtitle": "Luxurious Rose-Infused Care", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "brand", "accentColor": "#D4195C", "description": "Hot Rose collection - indulgent rose-infused beauty essentials for a luxurious self-care routine.", "filterValue": "Hot Rose", "overlayColor": "rgba(160, 20, 60, 0.82)"}, {"name": "Aloe Vera", "slug": "aloe-vera", "subtitle": "Cool, Soothe & Hydrate", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "ids", "accentColor": "#1A7A4A", "description": "Nature-infused aloe vera collection - from botanical vegan shampoo and leave-in conditioner to face toner and cooling gel.", "filterValue": "236,230,231,234,232,323,324,233,235", "overlayColor": "rgba(14, 80, 50, 0.82)"}, {"name": "Vitamin C", "slug": "vitamin-c", "subtitle": "Brighten & Revitalise", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "ids", "accentColor": "#D96A00", "description": "Vitamin C enriched skincare - face serum, foaming wash, revitalising mask and more for a brighter, more radiant complexion.", "filterValue": "213,214,215,216,217,218", "overlayColor": "rgba(180, 80, 0, 0.82)"}, {"name": "Papaya", "slug": "papaya", "subtitle": "Glow from Within", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "ids", "accentColor": "#E06020", "description": "Papaya enzyme skincare - naturally exfoliating and brightening formulas for a fresh, glowing complexion.", "filterValue": "219,220", "overlayColor": "rgba(150, 50, 0, 0.82)"}, {"name": "Facial Toner", "slug": "facial-toner", "subtitle": "Balance & Refresh", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "name", "accentColor": "#D96A00", "description": "Every facial toner across our range, in one place - balances, soothes and preps skin for moisture.", "filterValue": "toner", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Facial Wipes", "slug": "facial-wipes", "subtitle": "Cleanse On The Go", "heroImage": "/banner/Product-Face-Care.webp", "filterType": "name", "accentColor": "#3A7D1E", "description": "Every facial and cleansing wipe pack across our range - quick, effective cleansing wherever you are.", "filterValue": "wipes", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Facial & Body Scrubs", "slug": "scrubs", "subtitle": "Exfoliate & Renew", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "name", "accentColor": "#C0235A", "description": "Every exfoliating facial and body scrub across our range - buffs away dullness for brighter, smoother skin.", "filterValue": "scrub", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Shampoo", "slug": "shampoo", "subtitle": "Cleanse & Nourish", "heroImage": "/banner/Product-Shampoo.webp", "filterType": "name", "accentColor": "#0A6EBD", "description": "Every shampoo across our hair care range, in one place - find the formula for your hair type.", "filterValue": "shampoo", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Conditioner", "slug": "conditioner", "subtitle": "Soften & Smooth", "heroImage": "/banner/Product-Shampoo.webp", "filterType": "name", "accentColor": "#5B3FC8", "description": "Every conditioner across our hair care range - leaves hair soft, smooth and manageable.", "filterValue": "conditioner", "overlayColor": "rgba(26, 31, 58, 0.80)"}, {"name": "Toothpaste", "slug": "toothpaste", "subtitle": "Confident Smile, Every Day", "heroImage": "/banner/Product-Oral-Care.webp", "filterType": "name", "accentColor": "#0A6EBD", "description": "Every toothpaste across our oral care range - whitening, sensitivity, kids'' and everyday formulas.", "filterValue": "toothpaste", "overlayColor": "rgba(0, 80, 140, 0.82)"}, {"name": "Mouthwash", "slug": "mouthwash", "subtitle": "Fresh Breath, All Day", "heroImage": "/banner/Product-Oral-Care.webp", "filterType": "name", "accentColor": "#0A6EBD", "description": "Every mouthwash across our oral care range - freshens breath and helps protect against plaque.", "filterValue": "mouthwash", "overlayColor": "rgba(0, 80, 140, 0.82)"}, {"name": "Men Grooming Products", "slug": "men-grooming", "subtitle": "Built For The Everyday Grind", "heroImage": "/banner/Product-Body-Care.webp", "filterType": "name", "accentColor": "#1B2A3B", "description": "48-hour protection built for men - deodorants and grooming essentials from the Nulab Men Protect range.", "filterValue": "Men Protect", "overlayColor": "rgba(20, 42, 59, 0.85)"}], "feat1Kicker": "Nature-Infused Care", "feat2Kicker": "Purifying Botanicals", "feat3Kicker": "Nourish & Repair", "footerEmail": "info@xpelbeauty.com", "pillar1Desc": "Botanically-derived, planet-conscious ingredients that are gentle on you and the earth.", "pillar2Desc": "100% cruelty-free. Never tested on animals - because beauty should never come at a cost.", "pillar3Desc": "Clinically considered, skin-first formulations you can trust for your entire family.", "pillar4Desc": "Available at trusted retail partners across every state in Nigeria - always within reach.", "storesIntro": "Discover Xpel Beauty Care products at trusted retailers near you.", "storesTitle": "find us in store", "themeAccent": "#ca7c29", "themeBarMid": "#6f3716", "aboutCtaText": "Imagine a routine you actually look forward to - skin that glows, hair that shines, and the quiet confidence that comes from caring for yourself well. Start today.", "aboutMission": "We believe that true beauty begins with self-care. Our mission is to provide high-quality, affordable and effective products that nurture your skin, hair, body and overall confidence - because caring for yourself should feel effortless and empowering.", "announcement": "exceptional products. unbeatable value.", "contactEmail": "info@xpelbeauty.com", "contactIntro": "Interested in our products? Contact us to place an order or for any inquiries about our beauty and wellness range.", "contactPhone": "08034883603", "contactTitle": "Get in touch", "exploreLabel": "our products & brands", "exploreTitle": "explore our range", "footerPhone1": "08149073539", "footerPhone2": "09069678095", "freeShipping": "25000", "pillar1Title": "Eco-Friendly Formula", "pillar2Title": "Consciously Crafted", "pillar3Title": "Dermatologist Recommended", "pillar4Title": "Nationwide Availability", "sellersTitle": "best sellers", "shopSubtitle": "Browse our full range of health, beauty, home & gifting products.", "themeBarFrom": "#ca7c29", "aboutCtaImage": "/banner/banner4.png", "aboutCtaTitle": "Your best self is waiting", "bestSellerIds": [225, 228, 265, 253, 239, 216], "featureImages": ["/Img/XHC-Botanical-Vegan-Shampoo-Aloe-Vera-400ml-No-Banner-removebg-preview.png", "/Img/40322_HERO.webp", "/Img/40167_HERO.webp"], "footerAddress": "Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos", "footerCompany": "Xpel Beauty NG", "footerTagline": "exceptional products. unbeatable value.", "aboutCatImages": ["/banner/Product-Face-Care.webp", "/banner/Product-Body-Care.webp", "/banner/Product-Shampoo.webp", "/banner/Product-Hand-Care.webp", "/banner/Product-Foot-Care.webp", "/banner/Product-Oral-Care.webp", "/banner/Product-Nail-Care.webp"], "contactAddress": "Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos", "whatsappNumber": "2348149073539", "aboutStoryBody1": "Xpel Beauty Care is a trusted global name in personal care, health, beauty and household products. Our mission is simple: safe, effective and affordable products that genuinely enhance the quality of everyday life.", "aboutStoryBody2": "We understand the frustration of products that overpromise and underdeliver - so we built collections rooted in nature, transparent about what''s inside, and designed to solve real concerns. Quality should be accessible to everyone, everywhere.", "aboutStoryTitle": "We''re here to make it simple", "whatsappEnabled": true}');

SET FOREIGN_KEY_CHECKS = 1;

-- Done. 164 products, 5 blog posts, 600 stores, site content imported.

-- 2026-10-20 copy rewrite (same as sql/2026-10-20-copy-rewrite.sql)
-- Xpel Beauty NG copy rewrite (2026-10-20), Hostinger / MySQL. Run once in phpMyAdmin, after the other 2026-10-20 scripts.
-- Product names, sizes and copy
START TRANSACTION;
UPDATE `products` SET `name`='Vitamin C Face Serum', `size`=NULL, `description`='A lightweight face serum with vitamin C and niacinamide for skin that looks dull or uneven. It sinks in fast, so you can follow straight away with moisturiser or sunscreen, morning and night. Vegan.', `key_benefits`='Vitamin C for a brighter-looking complexion
Niacinamide for a more even-looking tone
Light texture that absorbs quickly
Made for twice-daily use', `how_to_use`='Cleanse and pat your face dry.
Press 2-3 drops into your face and neck.
Follow with moisturiser. Use morning and evening.' WHERE `id`=213;
UPDATE `products` SET `name`='Vitamin C Foaming Face Wash', `size`='200ml', `description`='A vitamin C and niacinamide face wash that turns into a soft foam and lifts off dirt and oil, leaving skin fresh rather than tight. A good first step for your morning routine. Vegan, 200ml.', `key_benefits`='Foams up to lift away dirt and excess oil
Vitamin C and niacinamide in every wash
Vegan formula
200ml bottle for daily use', `how_to_use`='Wet your face with warm water.
Massage a small amount into your skin until it foams.
Rinse well and pat dry. Use daily.' WHERE `id`=214;
UPDATE `products` SET `name`='Vitamin C Revitalising Face Mask', `size`=NULL, `description`='A sheet mask soaked in a vitamin C and niacinamide serum. Fifteen minutes is enough to leave tired skin looking fresher, which makes it a handy treat before an event or once a week. Vegan, with a plastic-free sheet.', `key_benefits`='Vitamin C and niacinamide serum
Plastic-free, vegan sheet
One-use mask, ready in 15-20 minutes
Easy weekly skin treat', `how_to_use`='Cleanse and pat your face dry.
Unfold the mask and smooth it on, pressing out air bubbles.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=215;
UPDATE `products` SET `name`='Vitamin C Exfoliating Facial Scrub', `size`='250ml', `description`='A creamy facial scrub with vitamin C that buffs away dry, flaky skin so your face feels smoother. Use it two or three times a week on damp skin and rinse clean. 250ml.', `key_benefits`='Fine scrub particles smooth rough patches
Vitamin C in a creamy base
Rinses off easily
250ml tube', `how_to_use`='Massage onto damp skin in small circles, avoiding the eyes.
Spend a little longer on rough or congested areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=216;
UPDATE `products` SET `name`='Vitamin C Salt Body Scrub', `size`=NULL, `description`='A vitamin C salt scrub for the whole body. The salt crystals polish away dry skin on elbows, knees and heels while the oils in the scrub leave skin soft after you rinse. Vegan.', `key_benefits`='Salt crystals for a thorough body polish
Leaves skin soft and smooth
Vegan formula
Made for use in the shower', `how_to_use`='Scoop a little onto damp skin in the shower.
Massage in circles, focusing on elbows, knees and heels.
Rinse well. Use 2-3 times a week.' WHERE `id`=217;
UPDATE `products` SET `name`='Vitamin C Facial Wipes', `size`=NULL, `description`='Vitamin C facial wipes that take off makeup, oil and the day''s grime in a few swipes. Keep a pack in your bag, gym kit or desk drawer for a quick clean face anywhere. 25 wipes. Vegan.', `key_benefits`='Removes makeup and daily grime
25 wipes per pack
Vegan formula
No water or rinsing needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use a fresh side for makeup.
No need to rinse. Follow with moisturiser.' WHERE `id`=218;
UPDATE `products` SET `name`='Papaya Cleansing Face Wash', `size`='250ml', `description`='A papaya face wash that builds a light lather and leaves skin feeling clean and fresh, never tight. Gentle enough for morning and evening, and a good match for normal to oily skin. 250ml.', `key_benefits`='Papaya fruit extract
Light lather for a fresh, clean feel
Gentle enough for twice-daily use
250ml tube', `how_to_use`='Wet your face with warm water.
Massage a small amount over your face in circles.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=219;
UPDATE `products` SET `name`='Papaya Hydrating Face Mask', `size`=NULL, `description`='A sheet mask soaked in papaya extract and hyaluronic acid for skin that feels dry. Leave it on for 15-20 minutes and your skin feels softer and looks more rested. Vegan, with a plastic-free sheet.', `key_benefits`='Papaya extract and hyaluronic acid
Helps dry skin feel soft and hydrated
Plastic-free, vegan sheet
Ideal once or twice a week', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=220;
UPDATE `products` SET `name`='Neem Oil Exfoliating Foaming Face Wash', `size`='200ml', `description`='A neem oil face wash that foams and gently exfoliates in one step, a good pick for oily skin or skin prone to spots. It cleans pores without leaving your face dry. 200ml.', `key_benefits`='Neem oil cleanser for oily or spot-prone skin
Gently exfoliates as it cleans
Foaming pump for easy use
200ml bottle', `how_to_use`='Wet your face with warm water.
Massage in circles until it foams.
Rinse well. Use morning and evening.' WHERE `id`=221;
UPDATE `products` SET `name`='Tea Tree & Peppermint Deep Moisturising Foot Pack', `size`='30ml', `description`='A foot pack with tea tree and peppermint for rough, dry feet. Wear it for 20 minutes like an at-home pedicure and your feet feel softer, smoother and fresher. 30ml per treatment.', `key_benefits`='Tea tree and peppermint for a cool, fresh feel
Softens rough, dry skin and heels
At-home pedicure in 20 minutes
One 30ml treatment', `how_to_use`='Put the pack on clean, dry feet.
Leave for 20 minutes.
Remove and massage any leftover product into your feet. Use weekly.' WHERE `id`=222;
UPDATE `products` SET `name`='Tea Tree Anti-Bacterial Handwash', `size`='500ml', `description`='An anti-bacterial tea tree handwash that rinses clean without a greasy feel. Gentle enough for the whole family to use many times a day. 500ml pump bottle.', `key_benefits`='Anti-bacterial tea tree formula
Rinses clean, no greasy residue
Gentle for frequent use
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=223;
UPDATE `products` SET `name`='Tea Tree Daily Cleansing Facial Wipes (Twin Pack)', `size`=NULL, `description`='Tea tree facial wipes for a quick daily clean. They take off makeup, oil and dirt and leave skin feeling fresh, at home or on the go. Twin pack, 2 x 25 wipes.', `key_benefits`='Tea tree oil wipes for a fresh, clean face
Removes makeup, oil and dirt
Twin pack of 2 x 25 wipes
Good for travel', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=224;
UPDATE `products` SET `name`='Tea Tree Foaming Face Wash', `size`='200ml', `description`='A tea tree foaming face wash for oily, combination and spot-prone skin. The rich foam lifts away dirt and oil, and your face feels clean and fresh after every wash. 200ml.', `key_benefits`='Tea tree oil for oily and spot-prone skin
Rich foam lifts dirt and oil
For morning and evening use
200ml pump bottle', `how_to_use`='Wet your face with warm water.
Massage in until it foams.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=225;
UPDATE `products` SET `name`='Tea Tree Moisturising Conditioner', `size`='400ml', `description`='A tea tree conditioner for dry hair. It softens, helps comb out knots and adds shine, and it is gentle enough to use after every wash. Pairs with XHC Tea Tree Moisturising Shampoo. 400ml.', `key_benefits`='Tea tree oil for dry hair
Softens and helps detangle
Adds shine
400ml, for frequent use', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=226;
UPDATE `products` SET `name`='Tea Tree Cleansing Pads', `size`=NULL, `description`='Tea tree cleansing pads, ready-soaked so you can wipe away leftover oil and dirt in one sweep. Use them after your face wash or on their own in the morning. 60 pads per jar. Dermatologically tested.', `key_benefits`='60 ready-soaked pads per jar
Contains natural tea tree oil
Cleans without over-drying
Dermatologically tested', `how_to_use`='After cleansing, sweep a pad over your face and neck.
Use morning and evening.
No need to rinse.' WHERE `id`=227;
UPDATE `products` SET `name`='Tea Tree Facial Toner', `size`='200ml', `description`='A light tea tree toner that refreshes skin after cleansing and gets it ready for your moisturiser. Non-greasy, for morning and evening. 200ml.', `key_benefits`='Tea tree oil toner
Light and non-greasy
Preps skin for moisturiser
200ml bottle', `how_to_use`='After cleansing, sweep over your face and neck with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=228;
UPDATE `products` SET `name`='Tea Tree Essential Oil', `size`='10ml', `description`='Concentrated tea tree essential oil for skin, hair and home. Add a few drops to a carrier oil, your shampoo or a diffuser. Always dilute before it touches your skin. 10ml.', `key_benefits`='Pure tea tree essential oil
For skin, hair and home use
A few drops go a long way
10ml bottle', `how_to_use`='Mix a few drops into a carrier oil before applying to skin.
Or add to shampoo, face wash or a diffuser.
Do a patch test before first use.' WHERE `id`=229;
UPDATE `products` SET `name`='Aloe Vera Conditioner', `size`='250ml', `description`='An aloe vera conditioner that leaves hair soft, smooth and shiny without weighing it down. Light enough for every wash and every hair type. 250ml.', `key_benefits`='Aloe vera for soft, smooth hair
Adds shine
Light, rinse-out formula
250ml, for every wash', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=230;
UPDATE `products` SET `name`='Aloe Vera Nourishing Leave-In Conditioner', `size`='250ml', `description`='An aloe vera leave-in conditioner with pro-vitamin B5 that keeps hair soft and hydrated through the day. Apply to damp or dry hair and style as normal, no rinsing. Vegan. 250ml.', `key_benefits`='Aloe vera and pro-vitamin B5
Keeps hair soft and hydrated all day
No rinsing needed
Vegan formula', `how_to_use`='Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse.
Style as usual.' WHERE `id`=231;
UPDATE `products` SET `name`='Aloe Vera Cooling Gel', `size`='250ml', `description`='A cooling aloe vera gel that soothes dry or sun-exposed skin and moisturises it. Use it after sun, after shaving or any time skin feels tight. Light and fast-absorbing. 250ml.', `key_benefits`='Cools and soothes dry, sun-exposed skin
Moisturises without feeling heavy
Fast-absorbing gel
250ml', `how_to_use`='Apply a generous layer to the skin.
Massage in gently until absorbed.
Reapply whenever your skin needs it.' WHERE `id`=232;
UPDATE `products` SET `name`='Aloe Vera Nourishing Face Mask', `size`=NULL, `description`='An aloe vera sheet mask with hyaluronic acid for dry or stressed skin. After 15-20 minutes your skin feels soothed and soft. Vegan, with a plastic-free sheet.', `key_benefits`='Aloe vera and hyaluronic acid
Soothes and softens dry skin
Plastic-free, vegan sheet
Ideal as a weekly treatment', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=233;
UPDATE `products` SET `name`='Aloe Vera Heat Defence Spray', `size`='150ml', `description`='An aloe vera heat defence spray to use before blow-drying or straightening. It helps protect hair from heat styling and leaves it smoother afterwards. 150ml.', `key_benefits`='Helps protect hair from heat styling
Aloe vera for hydration
Leaves hair smoother
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=234;
UPDATE `products` SET `name`='Aloe Vera Cleansing Facial Wipes (Twin Pack)', `size`=NULL, `description`='Aloe vera cleansing wipes that remove makeup and daily grime while leaving skin feeling soft, not stripped. Good for dry or sensitive skin. Twin pack, 2 x 25 wipes.', `key_benefits`='Hydrating aloe vera wipes
Removes makeup and dirt
Twin pack of 2 x 25 wipes
Vegan', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=235;
UPDATE `products` SET `name`='Aloe Vera Botanical Vegan Shampoo', `size`='400ml', `description`='A vegan aloe vera shampoo from the XHC Botanical range. It cleans away build-up and oil and leaves hair soft and shiny. 400ml.', `key_benefits`='Aloe vera botanical shampoo
Cleans without stripping hair
Leaves hair soft and shiny
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=236;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Leave-In Conditioner', `size`='250ml', `description`='A black castor oil and avocado leave-in conditioner with hyaluronic acid. It helps detangle and keeps hair moisturised between washes. Good for natural and relaxed hair. 250ml.', `key_benefits`='Black castor oil and avocado
Hyaluronic acid to keep moisture in
Helps detangle between washes
No rinsing needed', `how_to_use`='Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse.
Style as usual.' WHERE `id`=237;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Shampoo', `size`='400ml', `description`='A black castor oil and avocado shampoo that cleans hair and scalp and leaves hair looking shiny and healthy. Especially good for dry hair. 400ml.', `key_benefits`='Black castor oil and avocado
Cleans hair and scalp
Adds shine
400ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=238;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Heat Defence Spray', `size`='150ml', `description`='A black castor oil and avocado heat defence spray to use before blow-drying, straightening or curling. It helps protect hair from heat and adds shine. 150ml.', `key_benefits`='Helps protect hair from heat styling
Black castor oil and avocado
Adds shine
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=239;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Hair & Scalp Treatment', `size`='150ml', `description`='A black castor oil and avocado scalp treatment with hyaluronic acid for a dry or flaky scalp. Massage it in with your fingertips and leave it in or rinse it out. 150ml.', `key_benefits`='For a dry or flaky scalp
Hyaluronic acid to keep the scalp moisturised
Nozzle applies it straight to the scalp
150ml', `how_to_use`='Apply directly to the scalp, focusing on dry areas.
Massage in gently with your fingertips.
Leave in, or rinse after 10 minutes.' WHERE `id`=240;
UPDATE `products` SET `name`='Purifying Charcoal Cleansing Wipes', `size`=NULL, `description`='Charcoal cleansing wipes that take off makeup, oil and the day''s grime in one easy step. Good for normal to oily skin and handy for travel. 25 wipes.', `key_benefits`='Charcoal wipes for a deep-clean feel
Removes makeup, oil and dirt
25 wipes per pack
No water needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=241;
UPDATE `products` SET `name`='Cleansing Charcoal Face Scrub', `size`='250ml', `description`='A charcoal face scrub that buffs away dead skin and leaves your face feeling clean and smooth. Paraben and sulphate free. Good for oily and combination skin. 250ml.', `key_benefits`='Charcoal scrub for a deep-clean feel
Smooths rough skin
Paraben and sulphate free
250ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Focus on oily or congested areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=242;
UPDATE `products` SET `name`='Black Tissue Charcoal Detox Facial Mask', `size`=NULL, `description`='A black sheet mask with charcoal and hyaluronic acid for oily or congested skin. Leave it on for 15-20 minutes for a weekly deep-clean feel. The pack is marked anti-blemish, revitalising and purifying.', `key_benefits`='Charcoal and hyaluronic acid
Anti-blemish, revitalising and purifying
Good for oily or congested skin
Single-use sheet mask', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=243;
UPDATE `products` SET `name`='Cleansing Charcoal Toothpaste (Free Toothbrush)', `size`='100ml', `description`='A charcoal toothpaste that polishes away surface stains and leaves your mouth feeling clean and fresh. Comes with a free toothbrush. 100ml.', `key_benefits`='Charcoal formula for a cleaner-looking smile
Helps lift surface stains
Free toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=244;
UPDATE `products` SET `name`='Rosemary & Mint Hair Oil', `size`='60ml', `description`='A rosemary and mint hair oil for dry ends and a dry scalp. Smooth a few drops through damp or dry hair, or massage into the scalp before you wash. 60ml.', `key_benefits`='Rosemary and mint
Smooths dry ends
Use on hair or as a scalp massage oil
60ml, a few drops per use', `how_to_use`='Rub a few drops between your palms.
Work through the mid-lengths and ends, or massage into the scalp.
No need to rinse. Use daily or as needed.' WHERE `id`=245;
UPDATE `products` SET `name`='Rosemary & Mint Conditioner', `size`='300ml', `description`='A rosemary and mint conditioner that leaves hair soft, smooth and shiny, with a fresh minty feel on the scalp. Pairs with the Rosemary & Mint Shampoo. Vegan. 300ml.', `key_benefits`='Rosemary and mint
Leaves hair soft and shiny
Vegan formula
300ml, for every wash', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=246;
UPDATE `products` SET `name`='Rosemary & Mint Shampoo', `size`='300ml', `description`='A rosemary and mint shampoo that cleans and refreshes the scalp and leaves a cool, minty tingle. Use it with the matching conditioner. Vegan. 300ml.', `key_benefits`='Rosemary and mint
Cleans and refreshes the scalp
Vegan formula
300ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=247;
UPDATE `products` SET `name`='Argan Oil Hair Treatment', `size`='100ml', `description`='An argan oil hair treatment with Moroccan argan oil. A few drops tame frizz and leave dry or heat-styled hair smoother and shinier. No rinsing. 100ml.', `key_benefits`='Moroccan argan oil
Tames frizz and adds shine
Leave-in, no rinsing
100ml, a few drops per use', `how_to_use`='Smooth through towel-dried hair from mid-lengths to ends.
Do not rinse.
Style as usual, or use before heat styling.' WHERE `id`=248;
UPDATE `products` SET `name`='Argan Oil Conditioner', `size`='300ml', `description`='An argan oil conditioner that softens hair, helps it comb out easily and leaves a smooth, shiny finish without weighing it down. Good for normal to dry hair. Vegan. 300ml.', `key_benefits`='Moroccan argan oil
Soft, smooth, easy-to-comb hair
Adds shine
Vegan, 300ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=249;
UPDATE `products` SET `name`='Argan Oil Hydrating Hair Mask', `size`='350ml', `description`='A rich argan oil hair mask for a weekly deep condition. Leave it on for 5-10 minutes and dry hair feels softer, smoother and shinier. Vegan. 350ml jar.', `key_benefits`='Moroccan argan oil deep conditioner
Softer, smoother, shinier hair
Vegan formula
350ml jar for weekly use', `how_to_use`='Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use once a week.' WHERE `id`=250;
UPDATE `products` SET `name`='Argan Oil Heat Defence Leave-In Spray', `size`='150ml', `description`='An argan oil leave-in spray to use before heat styling. It helps protect hair from heat and leaves it soft, glossy and less frizzy. 150ml.', `key_benefits`='Helps protect hair from heat styling
Moroccan argan oil
Soft, glossy finish
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=251;
UPDATE `products` SET `name`='Argan Oil Facial Wipes (Twin Pack)', `size`=NULL, `description`='Argan oil facial wipes that remove makeup and daily grime and leave skin feeling soft, not tight. A good pick for dry skin. Twin pack, 2 x 25 wipes.', `key_benefits`='Moroccan argan oil extract
Removes makeup and dirt
Leaves skin feeling soft
Twin pack of 2 x 25 wipes', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=252;
UPDATE `products` SET `name`='Argan Oil Shampoo', `size`='300ml', `description`='An argan oil shampoo that cleans hair gently and leaves it soft and shiny. Use it with the Argan Oil Conditioner for the full routine. 300ml.', `key_benefits`='Moroccan argan oil
Gentle, everyday clean
Leaves hair soft and shiny
300ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=253;
UPDATE `products` SET `name`='Fresh Start Tea Tree & Lemon Shower Gel', `size`='400ml', `description`='A tea tree and lemon shower gel with essential oils. The zesty scent wakes you up in the morning and the rich lather leaves skin clean and fresh. 400ml.', `key_benefits`='Tea tree and lemon with essential oils
Rich lather for a fresh clean
Zesty, wake-up scent
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=254;
UPDATE `products` SET `name`='Fresh Start Mint & Cucumber Shower Gel', `size`='400ml', `description`='A mint and cucumber shower gel with essential oils and a cool, refreshing feel. Use it to wake up in the morning or cool down after a long day. 400ml.', `key_benefits`='Mint and cucumber with essential oils
Cool, refreshing feel
Gentle for daily use
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=255;
UPDATE `products` SET `name`='Fresh Start Coconut & Lime Shower Gel', `size`='400ml', `description`='A coconut and lime shower gel with essential oils. The creamy lather moisturises and leaves skin soft with a light tropical scent. 400ml.', `key_benefits`='Coconut and lime with essential oils
Moisturising lather
Leaves a light tropical scent
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=256;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Pore-Tight Toner', `size`='200ml', `description`='A watermelon toner with hyaluronic acid, vitamin C and aloe vera. Swipe it on after cleansing to refresh skin and help pores look smaller before your moisturiser. Natural vegan ingredients. 200ml.', `key_benefits`='Watermelon extract, hyaluronic acid and vitamin C
Helps pores look smaller
Refreshes skin after cleansing
200ml', `how_to_use`='After cleansing, sweep over your face with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=257;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Gel Moisturiser', `size`='50ml', `description`='A watermelon gel moisturiser with hyaluronic acid and vitamins C and E. It absorbs fast with no greasy feel, so it works well for oily, combination and normal skin. Natural vegan ingredients. 50ml jar.', `key_benefits`='Hyaluronic acid, watermelon and vitamins C and E
Fast-absorbing, non-greasy gel
Good for oily and combination skin
50ml jar', `how_to_use`='Apply a small amount to clean face and neck.
Massage in until absorbed.
Use morning and evening as your last step.' WHERE `id`=258;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Daily Facial Scrub', `size`='100ml', `description`='A daily watermelon facial scrub with hyaluronic acid and vitamins C and E. Gentle enough for every day, it smooths skin and leaves it feeling fresh. 100ml.', `key_benefits`='Gentle enough for daily use
Watermelon, hyaluronic acid and vitamins C and E
Smooths and refreshes skin
100ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use daily or as needed.' WHERE `id`=259;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Sheet Mask', `size`=NULL, `description`='A plant-based watermelon sheet mask with hyaluronic acid and vitamin B5. Fifteen to twenty minutes leaves skin hydrated, soothed and glowing. Great before an event. Vegan.', `key_benefits`='Watermelon, hyaluronic acid and vitamin B5
Hydrates and soothes skin
Plant-based sheet
Vegan', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=260;
UPDATE `products` SET `name`='Purple Whitening Toothpaste (Free Bamboo Toothbrush)', `size`='100ml', `description`='A purple colour-correcting toothpaste that helps cancel out yellow tones for a whiter-looking smile, plus a polishing formula for surface stains. Enamel safe. Comes with a free bamboo toothbrush. 100ml.', `key_benefits`='Purple colour correction for a whiter-looking smile
Polishing formula for surface stains
Enamel safe
Free bamboo toothbrush', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=261;
UPDATE `products` SET `name`='Purple Whitening Mouthwash', `size`='500ml', `description`='A purple whitening mouthwash that freshens breath and helps your smile look whiter. Use it after brushing with the Purple Whitening Toothpaste. 500ml.', `key_benefits`='Purple formula for a whiter-looking smile
Freshens breath
Pairs with the Purple Whitening Toothpaste
500ml', `how_to_use`='After brushing, pour 10-15ml.
Swish around your mouth for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=262;
UPDATE `products` SET `name`='Purple Polishing Tooth Powder', `size`=NULL, `description`='A purple polishing tooth powder for whiter-looking teeth. Dip a damp brush, brush for two minutes and rinse. Use it in place of toothpaste or alongside it.', `key_benefits`='Purple colour correction for a whiter-looking smile
Polishes away surface stains
Use instead of or with toothpaste
Compact pot, easy to travel with', `how_to_use`='Dip a damp toothbrush into the powder.
Brush gently for two minutes.
Rinse well. Use daily.' WHERE `id`=263;
UPDATE `products` SET `name`='Neem Oil & Mint Toothpaste (Free Toothbrush)', `size`='100ml', `description`='A neem oil and mint toothpaste that cleans teeth and leaves your breath fresh. Comes with a free toothbrush. 100ml.', `key_benefits`='Neem oil and mint
Fresh breath after brushing
Free toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=264;
UPDATE `products` SET `name`='Activated Charcoal Whitening Mouthwash', `size`='500ml', `description`='An activated charcoal whitening mouthwash made for deep stain removal. Rinse after brushing for fresher breath and a cleaner-looking smile. 500ml.', `key_benefits`='Activated charcoal whitening rinse
Helps remove stains
Freshens breath
500ml', `how_to_use`='After brushing, pour 10-15ml.
Swish around your mouth for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=265;
UPDATE `products` SET `name`='TrueSmile Tartar Defence Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile Tartar Defence toothpaste for everyday brushing. It helps prevent tartar build-up and leaves your teeth feeling clean. Comes with a toothbrush. 100ml.', `key_benefits`='Helps prevent tartar build-up
Cleaner-feeling teeth
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=266;
UPDATE `products` SET `name`='TrueSmile Triple Protect Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile Triple Protect toothpaste for all-round daily care of teeth, gums and breath. Comes with a toothbrush. 100ml.', `key_benefits`='All-round care for teeth, gums and breath
For the whole family''s daily brushing
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=267;
UPDATE `products` SET `name`='TrueSmile ProPurple Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProPurple toothpaste with a purple colour corrector that helps teeth look whiter as you brush. Comes with a toothbrush. 100ml.', `key_benefits`='Purple colour corrector for a whiter-looking smile
Visible effect from the first brush
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=268;
UPDATE `products` SET `name`='Sensio Enamel Restore Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Enamel Restore toothpaste with fluoride, made to help protect enamel that has worn down. Cool mint flavour. 75ml.', `key_benefits`='Helps protect worn enamel
Fluoride toothpaste
Cool mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=269;
UPDATE `products` SET `name`='Sensio Gentle Whitening Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Gentle Whitening toothpaste for sensitive teeth. It whitens gently, so you can brighten your smile without the sting. Cool mint. 75ml.', `key_benefits`='Gentle whitening
Made for sensitive teeth
Cool mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=270;
UPDATE `products` SET `name`='Sensio Instant Relief Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Instant Relief toothpaste for teeth that react to hot, cold or sweet food. Use it twice a day in place of your usual toothpaste. Fresh mint. 75ml.', `key_benefits`='Made for sensitive teeth
For everyday brushing
Fresh mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=271;
UPDATE `products` SET `name`='Sensio Sensitivity + Gum Twin Pack', `size`='2 x 75ml', `description`='A twin pack of TrueSmile Sensio Sensitivity + Gum toothpaste, made for sensitive teeth and gum care. Two 75ml tubes, so you stay stocked up.', `key_benefits`='For sensitive teeth and gum care
Two 75ml tubes
Good value twin pack
For everyday brushing', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=272;
UPDATE `products` SET `name`='TrueSmile Monster Kids Bubble Gum Toothpaste', `size`=NULL, `description`='TrueSmile Monster Kids toothpaste in bubble gum flavour, with a fun monster box that makes brushing more fun for little ones. Comes with a kids'' toothbrush. For children aged 3 and up, with an adult watching.', `key_benefits`='Bubble gum flavour kids like
Monster packaging for fun brushing time
Kids'' toothbrush in the box
For children aged 3+', `how_to_use`='Brush for two minutes, morning and night, with an adult watching.
Use a pea-sized amount.
Spit out after brushing.' WHERE `id`=273;
UPDATE `products` SET `name`='TrueSmile Charcoal Natural Whitening Toothpaste', `size`='100ml', `description`='TrueSmile Charcoal toothpaste with activated carbon for natural-style whitening. It helps lift stains from tea and coffee for a brighter smile. Comes with a toothbrush. 100ml.', `key_benefits`='Activated carbon whitening
Helps lift tea and coffee stains
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=274;
UPDATE `products` SET `name`='TrueSmile Baking Soda Whitening Toothpaste', `size`='100ml', `description`='TrueSmile Baking Soda toothpaste for extra whitening. Baking soda helps polish away surface stains for a brighter smile. Comes with a toothbrush. 100ml.', `key_benefits`='Baking soda extra whitening
Helps polish away surface stains
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=275;
UPDATE `products` SET `name`='TrueSmile Monster Kids Strawberry Toothpaste', `size`=NULL, `description`='TrueSmile Monster Kids toothpaste in strawberry flavour, with a monster box that turns brushing into a game. Comes with a kids'' toothbrush. For children aged 3 and up, with an adult watching.', `key_benefits`='Strawberry flavour kids like
Monster packaging for fun brushing time
Kids'' toothbrush in the box
For children aged 3+', `how_to_use`='Brush for two minutes, morning and night, with an adult watching.
Use a pea-sized amount.
Spit out after brushing.' WHERE `id`=276;
UPDATE `products` SET `name`='TrueSmile ProClean Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProClean toothpaste with cooling crystals for an extreme clean, fresh feel every time you brush. Comes with a toothbrush. 100ml.', `key_benefits`='Cooling crystals for an extreme clean feel
Leaves your mouth fresh
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=277;
UPDATE `products` SET `name`='TrueSmile ProCare Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProCare toothpaste for complete everyday care of teeth and gums, with cavity protection. A good family toothpaste. Comes with a toothbrush. 100ml.', `key_benefits`='Complete daily care for teeth and gums
With cavity protection
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=278;
UPDATE `products` SET `name`='TrueSmile ProWhite Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProWhite toothpaste with sodium phytate for advanced whitening. It helps keep new stains from building up so your smile stays brighter. Comes with a toothbrush. 100ml.', `key_benefits`='Advanced whitening with sodium phytate
Helps keep new stains away
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=279;
UPDATE `products` SET `name`='Intimelle Aloe Vera Daily Feminine Wash', `size`='250ml', `description`='Intimelle daily feminine wash with aloe vera. It is soap free, pH balanced and hypo-allergenic, so it cleans gently and leaves you feeling fresh. 250ml.', `key_benefits`='Soap free and pH balanced
Hypo-allergenic
With soothing aloe vera
250ml, for daily use', `how_to_use`='Use daily in the bath or shower.
Apply a small amount to the intimate area and rinse well with water.
Pat dry gently.' WHERE `id`=280;
UPDATE `products` SET `name`='Hot Rose Lip Butter Cherry Pie', `size`='15ml', `description`='Hot Rose Lip Butter in Cherry Pie. A creamy balm that softens dry lips, with a sweet cherry scent and a hint of tint. Wear it alone or under lipstick. 15ml.', `key_benefits`='Creamy lip butter for dry lips
Cherry Pie scent
Wear alone or under lipstick
15ml, fits in any bag', `how_to_use`='Apply to your lips whenever they feel dry.
Reapply after eating or drinking.
Wear alone or under lipstick.' WHERE `id`=281;
UPDATE `products` SET `name`='Hot Rose Lip Butter Peach Macaron', `size`='15ml', `description`='Hot Rose Lip Butter in Peach Macaron. A rich balm that keeps lips soft and smooth, with a sweet peach scent. Wear it in the day or as an overnight lip mask. 15ml.', `key_benefits`='Rich lip butter for soft, smooth lips
Peach Macaron scent
Day wear or overnight lip mask
15ml, fits in any bag', `how_to_use`='Apply to your lips whenever they feel dry.
Reapply after eating or drinking.
Use a thicker layer at night.' WHERE `id`=282;
UPDATE `products` SET `name`='Hot Rose Fixt Vit C Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Vit C setting spray. A fine mist that sets your makeup and gives skin a fresh glow, with a Tuscan cypress and mandarin scent. Vegan.', `key_benefits`='Sets makeup in place
Vitamin C for a fresh glow
Tuscan cypress and mandarin scent
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=283;
UPDATE `products` SET `name`='Hot Rose Fixt Dewy Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Dewy setting spray with lychee water and damask rose. It sets your makeup with a glowing, dewy finish. Best for normal to dry skin. Vegan.', `key_benefits`='Sets makeup with a dewy finish
Lychee water and damask rose
Good for normal to dry skin
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=284;
UPDATE `products` SET `name`='Hot Rose Fixt Matte Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Matte setting spray with vetiver root and squalane. It sets your makeup with a matte finish that lasts all night and keeps shine down. Vegan.', `key_benefits`='Sets makeup with a matte finish
Made to last all night
Vetiver root and squalane
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=285;
UPDATE `products` SET `name`='Hot Rose Hyaluronic Acid Skin Capsule Serum', `size`=NULL, `description`='Hot Rose hyaluronic acid serum in a capsule bottle, for skin that feels dry or tight. Massage it in before moisturiser for an extra drink of hydration.', `key_benefits`='Hyaluronic acid serum
Extra hydration for dry skin
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=286;
UPDATE `products` SET `name`='Hot Rose Vitamin C Glow Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Vitamin C Glow serum in a capsule bottle, for skin that looks dull or tired. Use it before moisturiser for a brighter, fresher look.', `key_benefits`='Vitamin C serum
For a brighter-looking complexion
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=287;
UPDATE `products` SET `name`='Hot Rose Vitamin E Antioxidant Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Vitamin E antioxidant serum in a capsule bottle, for skin that feels dry or stressed. Use it before moisturiser to keep skin soft and comfortable.', `key_benefits`='Vitamin E antioxidant serum
For dry or stressed skin
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=288;
UPDATE `products` SET `name`='Hot Rose Niacinamide Clarifying Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Niacinamide clarifying serum in a capsule bottle, for oily or congested skin. Use it before moisturiser to help pores look smaller and skin look clearer.', `key_benefits`='Niacinamide clarifying serum
Helps pores look smaller
Good for oily or congested skin
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=289;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Lychee & Rosewater', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in lychee and rosewater. Shake to mix the two layers, then wipe away makeup, eye makeup included, with a cotton pad. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Lychee and rosewater
Takes off eye and face makeup
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=290;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Cucumber & Mint', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in cucumber and wild mint, with vitamin E. Shake, soak a cotton pad and wipe away full-face makeup with a cool, fresh feel. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Cucumber, wild mint and vitamin E
Cool, fresh feel
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=291;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Neroli & Mandarin', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in neroli and mandarin, with vitamin C. Shake, soak a cotton pad and wipe away makeup at the end of the day. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Neroli, mandarin and vitamin C
Removes face and eye makeup
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=292;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Twilight Dream', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Twilight Dream, a warm santal and cedarwood scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Santal and cedarwood scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=293;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Tropical Green', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Tropical Green, a fresh bergamot and green fig scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Bergamot and green fig scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=294;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Blue Shell', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Blue Shell, a clean sea salt and driftwood scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Sea salt and driftwood scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=295;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant First Bloom', `size`=NULL, `description`='Hot Rose Serena serum deodorant in First Bloom, a soft vanilla and almond scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Vanilla and almond scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=296;
UPDATE `products` SET `name`='Nulab Feelin Bliss Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Bliss roll-on anti-perspirant with 48-hour protection and a pomegranate and lotus scent. Alcohol free, so it stays comfortable on your skin. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Pomegranate and lotus scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=297;
UPDATE `products` SET `name`='Nulab Feelin Bliss Stick Deodorant', `size`='64g', `description`='Nulab Feelin Bliss anti-perspirant stick with 48-hour protection and a pomegranate and lotus scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-perspirant protection
Pomegranate and lotus scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=298;
UPDATE `products` SET `name`='Nulab Feelin Bliss Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Bliss deodorant mist with a pomegranate and lotus scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Pomegranate and lotus scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=299;
UPDATE `products` SET `name`='Nulab Feelin Fresh Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Fresh roll-on anti-perspirant with 48-hour protection and a cucumber and jasmine scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Cucumber and jasmine scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=300;
UPDATE `products` SET `name`='Nulab Feelin Fresh Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Fresh deodorant mist with a cucumber and jasmine scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Cucumber and jasmine scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=301;
UPDATE `products` SET `name`='Nulab Feelin Zesty Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Zesty roll-on anti-perspirant with 48-hour protection and a bright lemon scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Lemon scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=302;
UPDATE `products` SET `name`='Nulab Feelin Zesty Stick Deodorant', `size`='64g', `description`='Nulab Feelin Zesty anti-perspirant stick with 48-hour protection and a bright lemon scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-perspirant protection
Lemon scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=303;
UPDATE `products` SET `name`='Nulab Feelin Zesty Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Zesty deodorant mist with a grapefruit and lemon zest scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Grapefruit and lemon zest scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=304;
UPDATE `products` SET `name`='Nulab Men Protect Adventure Roll-On', `size`='50ml', `description`='Nulab Men Protect Adventure roll-on with 48-hour anti-sweat protection and a bold, fresh scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Adventure scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=305;
UPDATE `products` SET `name`='Nulab Men Protect Adventure Stick', `size`='64g', `description`='Nulab Men Protect Adventure stick with 48-hour anti-sweat protection and a bold, fresh scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-sweat protection
Adventure scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=306;
UPDATE `products` SET `name`='Nulab Men Protect Extreme Dry Roll-On', `size`='50ml', `description`='Nulab Men Protect Extreme Dry roll-on with 48-hour anti-sweat protection for long, hot days. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Extreme Dry formula
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=307;
UPDATE `products` SET `name`='Nulab Men Protect Extreme Dry Stick', `size`='64g', `description`='Nulab Men Protect Extreme Dry stick with 48-hour anti-sweat protection for long, hot days. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-sweat protection
Extreme Dry formula
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=308;
UPDATE `products` SET `name`='Nulab Men Protect Sport Cool Stick', `size`='64g', `description`='Nulab Men Protect Sport Cool stick with 48-hour anti-sweat protection and a cool sporty scent, good for gym days. Alcohol free. 64g.', `key_benefits`='48-hour anti-sweat protection
Sport Cool scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=309;
UPDATE `products` SET `name`='Nulab Men Protect Sport Cool Roll-On', `size`='50ml', `description`='Nulab Men Protect Sport Cool roll-on with 48-hour anti-sweat protection and a cool sporty scent, good for gym days. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Sport Cool scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=310;
UPDATE `products` SET `name`='Nulab Whole Body Cream Cocoa Butter', `size`='500ml', `description`='Nulab Whole Body Cream with cocoa butter. It gives 48 hours of moisture and softens rough, dry skin from head to toe. 500ml tub.', `key_benefits`='48-hour moisture
Cocoa butter for rough, dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=311;
UPDATE `products` SET `name`='Nulab Whole Body Cream Vitamin C', `size`='500ml', `description`='Nulab Whole Body Cream with vitamin C. It gives 48 hours of moisture and keeps dry areas like elbows, knees and heels soft. 500ml tub.', `key_benefits`='48-hour moisture
With vitamin C
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=312;
UPDATE `products` SET `name`='Nulab Whole Body Cream Olive Oil', `size`='500ml', `description`='Nulab Whole Body Cream with olive oil. It gives 48 hours of moisture and keeps dry or rough skin soft and comfortable. 500ml tub.', `key_benefits`='48-hour moisture
Olive oil for dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=313;
UPDATE `products` SET `name`='Nulab Whole Body Cream Vitamin E', `size`='500ml', `description`='Nulab Whole Body Cream with vitamin E. It gives 48 hours of moisture and soothes dry skin so it feels soft and smooth. 500ml tub.', `key_benefits`='48-hour moisture
Vitamin E to soothe dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=314;
UPDATE `products` SET `name`='Nulab Feelin Silky Skin Drenching Moisturising Cream', `size`='200ml', `description`='Nulab Feelin Silky, a skin-drenching moisturising cream with jojoba oil and vitamin E. Light, fast-absorbing and silky on the skin. 200ml tube.', `key_benefits`='Jojoba oil and vitamin E
Light, fast-absorbing cream
Leaves skin silky
200ml tube', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=315;
UPDATE `products` SET `name`='Nulab Q10 Radiance Night Cream', `size`='50ml', `description`='Nulab Q10 Radiance night cream with natural Q10 and a peptide complex. It moisturises while you sleep so your skin looks firmer and fresher in the morning. 50ml.', `key_benefits`='Natural Q10 and peptide complex
24-hour moisture
Firming, anti-ageing night care
50ml jar', `how_to_use`='Apply to clean face and neck in the evening.
Massage in with upward strokes.
Use nightly as your last step.' WHERE `id`=316;
UPDATE `products` SET `name`='Nulab Q10 Radiance Day Cream', `size`='50ml', `description`='Nulab Q10 Radiance day cream with natural Q10 and a peptide complex. It moisturises and helps skin look firmer, and it sits well under makeup. 50ml.', `key_benefits`='Natural Q10 and peptide complex
24-hour moisture
Firming, anti-ageing day care
50ml jar', `how_to_use`='Apply to clean face and neck in the morning.
Massage in with upward strokes.
Follow with sunscreen. Use daily.' WHERE `id`=317;
UPDATE `products` SET `name`='Nulab DreamLift Firming Anti-Wrinkle Night Cream', `size`='50ml', `description`='Nulab DreamLift firming anti-wrinkle night cream. It works while you sleep to help skin look firmer and smoother. 50ml.', `key_benefits`='Firming, anti-wrinkle formula
Night-time care
Helps skin look firmer and smoother
50ml jar', `how_to_use`='Apply to clean face and neck in the evening.
Massage in with upward strokes.
Use nightly as your last step.' WHERE `id`=318;
UPDATE `products` SET `name`='Nulab DreamLift Firming Anti-Wrinkle Day Cream', `size`='50ml', `description`='Nulab DreamLift firming anti-wrinkle day cream. A light cream that helps skin look firmer and smoother, and it wears well under makeup. 50ml.', `key_benefits`='Firming, anti-wrinkle formula
Light enough for under makeup
Helps skin look firmer and smoother
50ml jar', `how_to_use`='Apply to clean face and neck in the morning.
Massage in with upward strokes.
Follow with sunscreen. Use daily.' WHERE `id`=319;
UPDATE `products` SET `name`='Hygie Advanced Protection Citrus Handwash', `size`='500ml', `description`='Hygie Advanced Protection handwash with a fresh citrus scent. An anti-bacterial wash that keeps hands clean and soft, even with frequent washing. 500ml pump.', `key_benefits`='Anti-bacterial handwash
Fresh citrus scent
Gentle for frequent washing
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=320;
UPDATE `products` SET `name`='Hygie Advanced Protection Aloe Vera Handwash', `size`='500ml', `description`='Hygie Advanced Protection handwash with aloe vera. An anti-bacterial wash that keeps hands clean, soft and comfortable. Gentle for the whole family. 500ml pump.', `key_benefits`='Anti-bacterial handwash
With aloe vera
Gentle for the whole family
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=321;
UPDATE `products` SET `name`='Hygie Advanced Protection Original Handwash', `size`='500ml', `description`='Hygie Advanced Protection Original handwash with a clean, classic scent. An anti-bacterial wash that leaves hands clean and soft. 500ml pump.', `key_benefits`='Anti-bacterial handwash
Clean, classic scent
Gentle for frequent washing
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=322;
UPDATE `products` SET `name`='Aloe Vera Face Toner', `size`='200ml', `description`='A hydrating aloe vera face toner that refreshes skin after cleansing and gets it ready for moisturiser. Gentle enough for dry and sensitive skin. Vegan. 200ml.', `key_benefits`='Hydrating aloe vera toner
Preps skin for moisturiser
Gentle for dry and sensitive skin
Vegan, 200ml', `how_to_use`='After cleansing, sweep over your face and neck with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=323;
UPDATE `products` SET `name`='Aloe Vera Body Wash (250ml)', `size`='250ml', `description`='An aloe vera body wash that cleans, soothes and helps restore skin, and leaves you feeling fresh. 250ml.', `key_benefits`='Cleansing, soothing and restoring
With aloe vera
For daily showers
250ml', `how_to_use`='Squeeze onto wet skin or a sponge.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=324;
UPDATE `products` SET `name`='Odour Control Foot Spray', `size`='150ml', `description`='Xpel Foot Care odour control foot spray. A quick-drying spray that keeps feet fresh through the day. 150ml.', `key_benefits`='Controls foot odour
Quick-drying spray
Keeps feet fresh all day
150ml', `how_to_use`='Shake well.
Spray onto clean, dry feet.
Let it dry before putting on socks or shoes.' WHERE `id`=325;
UPDATE `products` SET `name`='Shoe Refresher Spray', `size`='150ml', `description`='Xpel Foot Care shoe refresher spray. Spray inside trainers, work shoes or any everyday pair to keep them smelling fresh between wears. 150ml.', `key_benefits`='Keeps shoes smelling fresh
For trainers and everyday shoes
Quick-drying spray
150ml', `how_to_use`='Shake well.
Spray inside your shoes.
Let them dry before wearing.' WHERE `id`=326;
UPDATE `products` SET `name`='Nail Polish Remover Vegan (150ml)', `size`='150ml', `description`='Xpel Nail Care vegan nail polish remover. It takes off nail polish cleanly and leaves your nails ready for the next colour. 150ml.', `key_benefits`='Vegan formula
Removes everyday nail polish
For regular use
150ml bottle', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=327;
UPDATE `products` SET `name`='Nail Polish Remover 80% Acetone (150ml)', `size`='150ml', `description`='Xpel Nail Care 80% acetone nail polish remover for fast removal, even glitter polish. The easy-use dosing cap helps you use less and waste less. 150ml.', `key_benefits`='80% acetone for fast removal
Easy-use dosing cap
Works on glitter polish
150ml bottle', `how_to_use`='Press the cotton pad onto the dosing cap to soak it.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=328;
UPDATE `products` SET `name`='Nail Polish Remover (250ml)', `size`='250ml', `description`='Xpel Nail Care nail polish remover in a large 250ml bottle, so it lasts for many manicures at home.', `key_benefits`='Large 250ml bottle
Removes everyday nail polish
For regular home use
Good value size', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=329;
UPDATE `products` SET `name`='Nail Polish Remover Acetone Free (250ml)', `size`='250ml', `description`='Xpel Nail Care acetone-free nail polish remover, a gentler choice for dry or weak nails. 250ml.', `key_benefits`='Acetone free
Gentler on dry or weak nails
Removes everyday nail polish
250ml bottle', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=330;
UPDATE `products` SET `name`='Neem Oil Facial Scrub', `size`=NULL, `description`='An XBC neem oil facial scrub that buffs away dead skin and leaves your face feeling clean and smooth. A good weekly step for oily, combination or spot-prone skin.', `key_benefits`='Neem oil scrub
Buffs away dead skin
Good for oily or spot-prone skin
Use 2-3 times a week', `how_to_use`='Massage onto damp skin in gentle circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=332;
UPDATE `products` SET `name`='XNC Super Strength Nail & Tip Remover (99% Acetone)', `size`=NULL, `description`='XNC Super Strength 99% acetone remover for artificial nails, tips and gel polish. Super fast removal. Use in a well-ventilated room.', `key_benefits`='99% acetone
Removes artificial nails, tips and gel polish
Super fast removal
Contains Bitrex to help protect children', `how_to_use`='Soak a cotton pad.
Press it on the nail or tip and hold.
Wipe from the base outwards. Use in a well-ventilated room.' WHERE `id`=333;
UPDATE `products` SET `name`='XNC Nail Polish Remover Dip Pot (150ml)', `size`='150ml', `description`='XNC acetone-free nail polish remover in a dip pot. Dip your nail in, twist and lift out clean. No cotton pads needed, and it is suitable for acrylic nails. 150ml.', `key_benefits`='Dip pot, no cotton pads needed
Acetone free
Suitable for acrylic nails
150ml pot', `how_to_use`='Dip one nail into the pot and hold for a few seconds.
Twist gently and lift out.
Wipe off any residue with a tissue.' WHERE `id`=334;
UPDATE `products` SET `name`='XBC Aqueous Cream 500ml', `size`='500ml', `description`='XBC Aqueous Cream for relief of dry skin. It soothes, softens and moisturises, and it is fragrance free and lanolin free, so the whole family can use it. 500ml tub.', `key_benefits`='Relief of dry skin
Soothes, softens and moisturises
Fragrance free and lanolin free
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, or as often as your skin needs.' WHERE `id`=335;
UPDATE `products` SET `name`='XBC Aqueous Cream SLS Free 500ml', `size`='500ml', `description`='XBC Aqueous Cream SLS Free, for relief of dry skin without SLS. It soothes, softens and moisturises, and it is fragrance free and lanolin free. 500ml tub.', `key_benefits`='SLS free
Relief of dry skin
Fragrance free and lanolin free
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, or as often as your skin needs.' WHERE `id`=336;
UPDATE `products` SET `name`='XBC Aloe Vera Cream 500ml', `size`='500ml', `description`='XBC Aloe Vera Cream that soothes, softens and moisturises skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With aloe vera
Soothes, softens and moisturises
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=337;
UPDATE `products` SET `name`='XBC Olive Oil Cream 500ml', `size`='500ml', `description`='XBC Olive Oil Cream that deeply moisturises and hydrates skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With olive oil
Deeply moisturises and hydrates
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=338;
UPDATE `products` SET `name`='XBC Cocoa Butter Cream 500ml', `size`='500ml', `description`='XBC Cocoa Butter Cream that nourishes and softens dry skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With cocoa butter
Nourishes and softens dry skin
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=339;
UPDATE `products` SET `name`='XBC Vitamin E Cream 500ml', `size`='500ml', `description`='XBC Vitamin E Cream that deeply moisturises and soothes skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With vitamin E
Deeply moisturises and soothes
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=340;
UPDATE `products` SET `name`='XBC Bamboo Cotton Buds (300 buds)', `size`='300 buds', `description`='XBC bamboo cotton buds with biodegradable bamboo stems and 100% pure cotton tips. Kind and gentle for makeup touch-ups, nail care and everyday use. 300 buds.', `key_benefits`='Biodegradable bamboo stems
100% pure cotton tips
Kind and gentle
300 buds per pot', `how_to_use`='Use one bud at a time.
Do not insert into the ear canal.
Keep out of reach of young children.' WHERE `id`=341;
UPDATE `products` SET `name`='XBC Coconut Water Deep Moisturising Foot Pack (30ml)', `size`='30ml', `description`='XBC Coconut Water deep moisturising foot pack. One 20-minute treatment leaves rough, dry feet softer and smoother. 30ml.', `key_benefits`='Coconut water
Deep moisturising for dry feet
20-minute treatment
One 30ml pack', `how_to_use`='Put the pack on clean, dry feet.
Leave for 20 minutes.
Remove and massage any leftover product into your feet.' WHERE `id`=342;
UPDATE `products` SET `name`='XBC Coconut Water Hydrating Shower Crème (300ml)', `size`='300ml', `description`='XBC Coconut Water hydrating shower creme that cleans and moisturises in one step, so skin feels soft after you rinse. 300ml.', `key_benefits`='Coconut water
Cleans and moisturises in one step
Creamy lather
300ml tube', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=343;
UPDATE `products` SET `name`='XBC Coconut Water Hydrating Facial Wipes (Twin Pack)', `size`=NULL, `description`='XBC Coconut Water facial wipes that cleanse, tone and moisturise in one wipe. Twin pack, so you can keep one at home and one in your bag.', `key_benefits`='Coconut water wipes
Cleanse, tone and moisturise
Twin pack
No water needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=344;
UPDATE `products` SET `name`='XHC Avocado & Almond Heat Defence Spray (150ml)', `size`='150ml', `description`='XHC avocado and almond heat defence spray. Use it before heat styling to help protect hair and keep it smooth and hydrated. 150ml.', `key_benefits`='Helps protect hair from heat styling
Avocado and almond
Keeps hair smooth
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=345;
UPDATE `products` SET `name`='XOC Dual Action Mint Mouthwash (500ml)', `size`='500ml', `description`='XOC Dual Action mint mouthwash that helps freshen breath and keep your mouth clean. Alcohol free. Shake to activate. 500ml.', `key_benefits`='Dual action mint formula
Freshens breath and keeps your mouth clean
Alcohol free
500ml', `how_to_use`='Shake to activate.
After brushing, swish 10-15ml for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=348;
UPDATE `products` SET `name`='XOC Dual Action Clove Mouthwash (500ml)', `size`='500ml', `description`='XOC Dual Action clove mouthwash that helps freshen breath and keep your mouth clean. Alcohol free. Shake to activate. 500ml.', `key_benefits`='Dual action clove formula
Freshens breath and keeps your mouth clean
Alcohol free
500ml', `how_to_use`='Shake to activate.
After brushing, swish 10-15ml for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=349;
UPDATE `products` SET `name`='XOC Hemp Toothpaste (100ml + Free Toothbrush)', `size`='100ml', `description`='XOC Hemp toothpaste with hemp oil for a gentle clean and fresh breath. Comes with a free toothbrush. Vegan. 100ml.', `key_benefits`='Hemp oil toothpaste
Gentle clean and fresh breath
Free toothbrush in the box
Vegan, 100ml', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=350;
UPDATE `products` SET `name`='XOC Hemp Mouthwash (500ml)', `size`='500ml', `description`='XOC Hemp mouthwash for everyday care of teeth and gums and lasting fresh breath. Pairs with the XOC Hemp Toothpaste. 500ml.', `key_benefits`='Hemp mouthwash
For teeth and gum care
Lasting fresh breath
500ml', `how_to_use`='After brushing, swish 10-15ml for 30 seconds.
Spit out.
Do not swallow.' WHERE `id`=351;
UPDATE `products` SET `name`='XHC Keratin Classic Shampoo (300ml)', `size`='300ml', `description`='XHC Keratin Classic shampoo that smooths, nourishes and adds shine, and helps keep frizz down. Use it with the Keratin Classic Conditioner. 300ml.', `key_benefits`='With keratin
Smooths, nourishes and adds shine
Helps tame frizz
300ml tube', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=352;
UPDATE `products` SET `name`='XHC Keratin Classic Conditioner (300ml)', `size`='300ml', `description`='XHC Keratin Classic conditioner that leaves hair soft, silky and shining. Pairs with the Keratin Classic Shampoo. 300ml.', `key_benefits`='With keratin
Soft, silky, shiny hair
Pairs with Keratin Classic Shampoo
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=353;
UPDATE `products` SET `name`='XHC Biotin & Collagen Shampoo (300ml)', `size`='300ml', `description`='XHC Biotin & Collagen shampoo that helps hair look thicker and fuller. Pairs with the Biotin & Collagen Conditioner. 300ml.', `key_benefits`='Biotin and collagen
For thicker, fuller-looking hair
Pairs with the matching conditioner
300ml tube', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=354;
UPDATE `products` SET `name`='XHC Biotin & Collagen Conditioner (300ml)', `size`='300ml', `description`='XHC Biotin & Collagen conditioner that strengthens, thickens and adds shine. Pairs with the Biotin & Collagen Shampoo. 300ml.', `key_benefits`='Biotin and collagen
Strengthens, thickens and adds shine
Pairs with the matching shampoo
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=355;
UPDATE `products` SET `name`='XHC Biotin & Collagen Hair Treatment (50ml)', `size`='50ml', `description`='XHC Biotin & Collagen hair treatment that hydrates, nourishes and adds shine. Use it once or twice a week for smoother-looking hair. 50ml.', `key_benefits`='Biotin and collagen
Hydrates, nourishes and adds shine
Weekly treatment
50ml', `how_to_use`='Apply to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use 1-2 times a week.' WHERE `id`=356;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Facial Cleanser (100ml)', `size`='100ml', `description`='So Fresh Watermelon Crush facial cleanser with hyaluronic acid and vitamins C and E. A fresh, fruity daily wash that leaves skin clean and hydrated. 100ml.', `key_benefits`='Watermelon, hyaluronic acid and vitamins C and E
Fresh, fruity daily cleanse
Hydrating
100ml tube', `how_to_use`='Wet your face with warm water.
Massage a small amount over your face in circles.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=357;
UPDATE `products` SET `name`='Tea Tree Body Scrub', `size`=NULL, `description`='An XBC tea tree body scrub that buffs away dry skin and leaves your body feeling smooth and fresh. Good for elbows, knees and heels.', `key_benefits`='Tea tree body scrub
Smooths rough, dry skin
Fresh, clean feel
For use 2-3 times a week', `how_to_use`='Massage onto damp skin in the shower, avoiding broken skin.
Focus on rough areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=359;
UPDATE `products` SET `name`='Tea Tree Body Butter', `size`='250ml', `description`='An XBC tea tree body butter that nourishes and hydrates, leaving skin smooth and healthy. Rich enough for dry patches. 250ml tub.', `key_benefits`='Tea tree body butter
Nourishes and hydrates
Rich texture for dry patches
250ml tub', `how_to_use`='Warm a little between your palms.
Massage into skin, focusing on dry areas.
Use daily after a shower.' WHERE `id`=360;
UPDATE `products` SET `name`='Tea Tree Moisturising Sheet Mask', `size`=NULL, `description`='An XBC tea tree moisturising sheet mask with tea tree oil and pro-vitamin B5. It leaves skin looking revitalised and hydrated. Ready in 15-20 minutes.', `key_benefits`='Tea tree oil and pro-vitamin B5
Leaves skin revitalised and hydrated
Single-use sheet mask
A quick weekly treat', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=361;
UPDATE `products` SET `name`='Tea Tree Mouthwash', `size`='500ml', `description`='An XOC tea tree mouthwash that freshens breath after brushing and keeps your mouth feeling clean. 500ml.', `key_benefits`='Tea tree mouthwash
Freshens breath
Keeps your mouth feeling clean
500ml', `how_to_use`='After brushing, swish 10-15ml for 30 seconds.
Spit out.
Do not swallow.' WHERE `id`=362;
UPDATE `products` SET `name`='Tea Tree Toothpaste (+ Free Bamboo Toothbrush)', `size`=NULL, `description`='An XOC tea tree toothpaste for a gentle clean and fresh breath. Comes with a free bamboo toothbrush.', `key_benefits`='Tea tree toothpaste
Gentle clean and fresh breath
Free bamboo toothbrush
For everyday brushing', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=363;
UPDATE `products` SET `name`='Tea Tree Facial Scrub', `size`=NULL, `description`='An XBC tea tree facial scrub in a jar. It buffs away dullness so your face feels smoother and fresher. Use two or three times a week.', `key_benefits`='Tea tree facial scrub
Buffs away dullness
Smoother, fresher-feeling skin
For use 2-3 times a week', `how_to_use`='Massage onto damp skin in gentle circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=364;
UPDATE `products` SET `name`='XHC Botanical Vegan Conditioner, Aloe Vera (300ml)', `size`='300ml', `description`='An XHC Botanical vegan conditioner with aloe vera. It conditions gently and leaves hair soft and shiny. Pairs with the Aloe Vera Botanical Vegan Shampoo. 300ml.', `key_benefits`='Aloe vera botanical conditioner
Leaves hair soft and shiny
Vegan
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=365;
UPDATE `products` SET `name`='XHC Botanical Aloe Vera Hair Mask', `size`=NULL, `description`='An XHC Botanical aloe vera hair mask for a weekly deep condition. Leave it on for 5-10 minutes for softer, shinier hair. Vegan.', `key_benefits`='Aloe vera deep conditioner
Softer, shinier hair
Weekly treatment
Vegan', `how_to_use`='Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use once a week.' WHERE `id`=366;
UPDATE `products` SET `name`='XHC Banana Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion banana shampoo that cleans and nourishes, leaving hair soft with a sweet banana scent. Pairs with the Banana Conditioner. Vegan. 400ml.', `key_benefits`='Banana Fruit Fusion shampoo
Cleans and nourishes
Soft hair with a fruity scent
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=367;
UPDATE `products` SET `name`='XHC Banana Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion banana conditioner that leaves hair sleek, shiny and smooth. Pairs with the Banana Shampoo. Vegan. 400ml.', `key_benefits`='Banana Fruit Fusion conditioner
Sleek, shiny, smooth hair
Pairs with Banana Shampoo
Vegan, 400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=368;
UPDATE `products` SET `name`='XHC Ginger Anti-Dandruff Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion ginger anti-dandruff shampoo. It cleans the scalp, helps keep dandruff away and leaves hair sleek and shiny. 400ml.', `key_benefits`='Anti-dandruff shampoo
Ginger Fruit Fusion formula
Cleans the scalp
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=369;
UPDATE `products` SET `name`='XHC Coconut Hydrating Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion coconut hydrating shampoo with coconut water. It cleans and helps add moisture so hair feels soft and shiny. 400ml.', `key_benefits`='Coconut water hydrating shampoo
Cleans and adds moisture
Soft, shiny hair
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=371;
UPDATE `products` SET `name`='XHC Coconut Hydrating Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion coconut hydrating conditioner with coconut water. It helps add moisture and leaves hair soft, sleek and shiny. 400ml.', `key_benefits`='Coconut water hydrating conditioner
Soft, sleek, shiny hair
Pairs with Coconut Hydrating Shampoo
400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=372;
UPDATE `products` SET `name`='XHC Strawberry Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion strawberry shampoo that cleans and leaves hair sleek and shiny with a fresh strawberry scent. Vegan. 400ml.', `key_benefits`='Strawberry Fruit Fusion shampoo
Sleek, shiny hair
Fresh strawberry scent
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=373;
UPDATE `products` SET `name`='XHC Strawberry Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion strawberry conditioner that leaves hair soft, sleek and shiny. Pairs with the Strawberry Shampoo. Vegan. 400ml.', `key_benefits`='Strawberry Fruit Fusion conditioner
Soft, sleek, shiny hair
Pairs with Strawberry Shampoo
Vegan, 400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=374;
UPDATE `products` SET `name`='XHC Green Tea Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion green tea shampoo that cleans and refreshes, leaving hair sleek and shiny. Pairs with the Green Tea Conditioner. Vegan. 400ml.', `key_benefits`='Green tea Fruit Fusion shampoo
Cleans and refreshes
Sleek, shiny hair
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=375;
UPDATE `products` SET `name`='XHC Green Tea Conditioner (400ml)', `size`='400ml', `description`='XHC green tea conditioner that leaves hair soft, sleek and shiny. Paraben free and dermatologically tested. Pairs with the Green Tea Shampoo. 400ml.', `key_benefits`='Green tea conditioner
Soft, sleek, shiny hair
Paraben free, dermatologically tested
400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=376;
UPDATE `products` SET `name`='XBC Strawberry Body Yogurt (Deep Moisturising)', `size`=NULL, `description`='XBC Strawberry Body Yogurt, a deep moisturising body cream with a light, whipped feel and a sweet strawberry scent. It sinks in fast and leaves skin soft.', `key_benefits`='Deep moisturising body yogurt
Light, fast-absorbing texture
Sweet strawberry scent
For the whole body', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=378;
UPDATE `products` SET `name`='XBC Banana Face and Body Scrub (250ml)', `size`='250ml', `description`='XBC Banana face and body scrub with banana extracts. It gently exfoliates for visibly brighter skin, on your face and all over your body. 250ml.', `key_benefits`='Banana extracts
Gently exfoliates for brighter-looking skin
For face and body
250ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=379;
UPDATE `products` SET `name`='Nulab Cocoa Glow Radiance+ Body Gel Oil', `size`='200ml', `description`='Nulab Cocoa Glow Radiance+ body gel oil with cocoa butter. The gel melts into skin, leaves a healthy glow and does not feel greasy. 200ml.', `key_benefits`='Cocoa butter body gel oil
Leaves a healthy glow
Non-greasy, fast-absorbing
200ml', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily after a shower.' WHERE `id`=380;
UPDATE `products` SET `name`='Nulab Coconut Renew Radiance+ Body Gel Oil', `size`='200ml', `description`='Nulab Coconut Renew Radiance+ body gel oil with coconut oil. A light gel that moisturises and leaves skin soft and smooth without a greasy feel. 200ml.', `key_benefits`='Coconut oil body gel oil
Moisturises and softens
Non-greasy, fast-absorbing
200ml', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily after a shower.' WHERE `id`=381;
UPDATE `products` SET `name`='Aloe Vera Shampoo (250ml)', `size`='250ml', `description`='An aloe vera shampoo for smooth and shiny hair, in the classic leaf-shaped bottle. Gentle enough for regular washing. 250ml.', `key_benefits`='Aloe vera shampoo
Smooth, shiny hair
Gentle for regular use
250ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=382;
UPDATE `products` SET `name`='XBC Aloe Vera Face & Body Scrub', `size`=NULL, `description`='An XBC aloe vera face and body scrub with aloe vera extracts. It gently exfoliates for visibly brighter skin on your face and body. Jar.', `key_benefits`='Aloe vera extracts
Gently exfoliates for brighter-looking skin
For face and body
Easy-scoop jar', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=383;
UPDATE `products` SET `name`='Medex Aloe Vera Antibacterial Handwash (650ml)', `size`='650ml', `description`='Medex Clean & Hygienic aloe vera antibacterial handwash in a big 650ml pump bottle, with 30% extra free. Good value for a busy home.', `key_benefits`='Antibacterial handwash
With aloe vera
30% extra free
650ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds.
Rinse well.' WHERE `id`=384;
UPDATE `products` SET `name`='Mediguard Antiseptic Disinfectant (1L)', `size`='1L', `description`='Mediguard antiseptic disinfectant that kills 99.9% of bacteria, tested to EN protocols (EN1276). Made in the UK. 1 litre.', `key_benefits`='Kills 99.9% of bacteria
Tested to EN1276
Made in the UK
1 litre', `how_to_use`='Follow the dilution and usage directions on the bottle.
Keep out of reach of children.' WHERE `id`=385;
UPDATE `products` SET `name`='Mucky Pup Flea Repellent Dog Shampoo', `size`=NULL, `description`='Mucky Pup flea repellent shampoo for dogs. It naturally repels fleas, removes dirt and helps reduce tangles, leaving your dog with a healthy, shiny coat.', `key_benefits`='Naturally repels fleas
Removes dirt and helps reduce tangles
Healthy, shiny coat
For dogs', `how_to_use`='Wet your dog''s coat well.
Massage in the shampoo, avoiding the eyes.
Rinse thoroughly.' WHERE `id`=386;
UPDATE `products` SET `name`='Dr Magic Double Action Foamer', `size`=NULL, `description`='Dr Magic Double Action Foamer for kitchen and bathroom drains. It clears build-up and removes blockages. Not for use in standing water.', `key_benefits`='Clears build-up
Removes blockages
Kitchen and bathroom drains
Double action foam', `how_to_use`='Follow the directions on the bottle.
Not for use in standing water.
Keep out of reach of children.' WHERE `id`=387;
UPDATE `products` SET `name`='Dr Magic Oven & Grill Cleaner', `size`=NULL, `description`='Dr Magic oven and grill cleaner with heavy-duty cleaning action for burnt-on grease. Use in a well-ventilated room.', `key_benefits`='Heavy-duty cleaning action
For ovens and grills
Aerosol spray
Cuts through grease', `how_to_use`='Follow the directions on the can.
Use in a well-ventilated room.
Keep out of reach of children.' WHERE `id`=388;
UPDATE `products` SET `name`='Dr Magic Snatch A Dye (20 Sheets)', `size`='20 sheets', `description`='Dr Magic Snatch A Dye colour catcher sheets. Drop one in with a mixed wash to avoid colour runs. 20 sheets.', `key_benefits`='Avoids colour runs in mixed washes
One sheet per wash
20 sheets per box
For washing machines', `how_to_use`='Put one sheet in the drum with your mixed wash.
Wash as normal.
Throw the sheet away after use.' WHERE `id`=389;
UPDATE `products` SET `name`='Medipure Hair & Scalp Scalp Treatment', `size`=NULL, `description`='Medipure Hair & Scalp scalp treatment that helps fight dandruff and gives a dry scalp a drink of moisture. With hyaluronic acid, aloe vera and vitamin E.', `key_benefits`='Helps fight dandruff
Hydrates a dry scalp
Hyaluronic acid, aloe vera and vitamin E
Nozzle for easy scalp application', `how_to_use`='Part your hair and apply directly to the scalp with the nozzle.
Massage in gently.
Use as directed on the pack.' WHERE `id`=390;
UPDATE `products` SET `name`='Medipure Hair & Scalp Conditioner', `size`=NULL, `description`='Medipure Hair & Scalp conditioner that helps fight dandruff and hydrates a dry scalp. With aloe vera, coconut oil and vitamin E.', `key_benefits`='Helps fight dandruff
Hydrates a dry scalp
Aloe vera, coconut oil and vitamin E
Pairs with the Hair & Scalp shampoo', `how_to_use`='After shampooing, apply through your hair.
Leave for 2-3 minutes.
Rinse well.' WHERE `id`=391;
UPDATE `products` SET `name`='Medipure Hair & Scalp Hair Mask', `size`=NULL, `description`='Medipure Hair & Scalp hair mask for a dry scalp that helps fight dandruff. With aloe vera, coconut oil and vitamin E.', `key_benefits`='Helps fight dandruff
For a dry scalp
Aloe vera, coconut oil and vitamin E
Rich hair mask', `how_to_use`='Apply to clean, damp hair and scalp.
Leave for a few minutes.
Rinse well.' WHERE `id`=392;
UPDATE `products` SET `name`='Medipure Hair & Scalp Anti-Dandruff Shampoo', `size`=NULL, `description`='Medipure Hair & Scalp shampoo with anti-dandruff properties, an effective treatment for dandruff that is gentle enough for frequent use. Improved formula.', `key_benefits`='Anti-dandruff properties
Improves hair and scalp
For frequent use
Improved formula', `how_to_use`='Massage into wet hair and scalp.
Rinse well.
Use as often as needed.' WHERE `id`=393;
UPDATE `products` SET `name`='Dalton House Sweet Rose Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House sweet rose fine handwash, a rich purple handwash with a soft rose scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Sweet rose scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=394;
UPDATE `products` SET `name`='Dalton House Sea Breeze Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House sea breeze fine handwash, a clear blue handwash with a fresh, clean scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Sea breeze scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=395;
UPDATE `products` SET `name`='Dalton House Orchard Burst Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House orchard burst fine handwash, an olive green handwash with a fresh, fruity scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Orchard burst scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=396;
UPDATE `products` SET `name`='Tea Tree & Peppermint Deep Moisturising Hand Pack', `size`=NULL, `description`='A tea tree and peppermint deep moisturising hand pack. It moisturises deeply and helps dry hands feel soft again. A simple at-home hand treatment.', `key_benefits`='Tea tree and peppermint
Deep moisturising
For dry hands
At-home treatment', `how_to_use`='Slip your hands into the gloves.
Leave for the time shown on the pack.
Massage any leftover product into your skin.' WHERE `id`=397;
UPDATE `products` SET `name`='XHC Tea Tree Moisturising Shampoo (400ml)', `size`='400ml', `description`='XHC tea tree moisturising shampoo for frequent use. It cleans and refreshes hair and scalp. Pairs with the Tea Tree Moisturising Conditioner. 400ml.', `key_benefits`='Tea tree oil
Moisturising formula
For frequent use
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with Tea Tree Moisturising Conditioner.' WHERE `id`=398;

-- Site text (only the fields that changed; your other settings are kept)
UPDATE `site_content` SET `data` = JSON_SET(`data`,
  '$.heroLine1', 'Hair, skin and home care',
  '$.heroLine2', 'at 600+ stores in Nigeria',
  '$.exploreLabel', '180 products across 20+ ranges',
  '$.ctaText', 'Find your favourites at a store near you.',
  '$.quoteText', 'Caring for yourself should be simple, and it should not cost a fortune.',
  '$.shopSubtitle', 'Hair care, skin and body care, oral care, nail and foot care, and home essentials.',
  '$.feat1Text', 'A cooling aloe vera gel for dry or sun-exposed skin. Use it after sun, after shaving or any time your skin feels tight.',
  '$.feat2Text', 'Face wash, wipes, toner, shampoo and more, all with tea tree oil for a fresh, clean feel on oily and spot-prone skin.',
  '$.feat3Text', 'Argan oil shampoo, conditioner, hair mask and treatment oil that tame frizz and leave dry hair soft and shiny.',
  '$.pillar1Title', 'Ingredients you know',
  '$.pillar1Desc', 'Each range is built around one key ingredient, like aloe vera, tea tree, argan oil, vitamin C, neem or coconut, named right on the pack.',
  '$.pillar2Title', 'Vegan options',
  '$.pillar2Desc', 'Many of our ranges carry a vegan mark, including So Fresh, Aloe Vera, Argan Oil and XHC Fruit Fusion. Check the pack for the logo.',
  '$.pillar3Title', 'Made for everyday use',
  '$.pillar3Desc', 'Washes, creams and toothpastes for the whole family to use every day, with options for sensitive skin and sensitive teeth.',
  '$.pillar4Title', 'Nationwide availability',
  '$.pillar4Desc', 'Sold at more than 600 stores in 22 states, from Lagos and Abuja to Port Harcourt, Benin and Ibadan.',
  '$.step1Title', 'Pick your concern',
  '$.step1Desc', 'Skin, hair, teeth, nails, feet or home. Each has its own range in our catalogue.',
  '$.step2Title', 'Choose your products',
  '$.step2Desc', 'Every product page says what it does, the size and how to use it. Ask us on WhatsApp if you are not sure.',
  '$.step3Title', 'Get it near you',
  '$.step3Desc', 'Buy at one of our 600+ stockists across Nigeria, or send us an enquiry and we will help you order.',
  '$.aboutLead', 'Good hair, skin and home care should be easy to find and easy to afford. We bring Xpel Beauty Care to shops across Nigeria, so you can pick it up close to home.',
  '$.aboutStoryBody1', 'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria.',
  '$.aboutStoryBody2', 'Each range is built around one key ingredient, like tea tree, aloe vera or argan oil, and every pack says what the product is for. We supply more than 600 shops in 22 states, so most people can find our products close to home.',
  '$.aboutValue1', 'Ranges built around one key ingredient',
  '$.aboutValue2', 'Clear labels that say what each product does',
  '$.aboutValue3', 'Care for hair, skin, teeth, nails, feet and home',
  '$.aboutValue4', 'Good quality at prices that fit a family budget',
  '$.aboutValue5', 'Sold at 600+ stores across Nigeria',
  '$.aboutMission', 'To make good, affordable personal care and home products easy to find for every household in Nigeria.',
  '$.aboutVision', 'To be the first name Nigerian families think of for personal care and household essentials.',
  '$.aboutCtaTitle', 'Find your routine',
  '$.aboutCtaText', 'Browse the catalogue, choose what suits you, then pick it up at a store near you or send us an enquiry.',
  '$.contactIntro', 'Want to order, stock our products in your shop or ask about a product? Send us a message and we will get back to you.',
  '$.storesIntro', 'Find Xpel Beauty Care at more than 600 stores across Nigeria.',
  '$.seo.defaultDescription', 'Shop Xpel Beauty Care in Nigeria: hair care, skin and body care, oral care, nail and foot care and home essentials, sold at 600+ stores nationwide.',
  '$.seo.pages.home.description', 'Xpel Beauty Care hair, skin, body, oral and home care in Nigeria. 180 products, sold at 600+ stores in Lagos, Abuja, Port Harcourt and across 22 states.',
  '$.seo.pages.shop.description', 'Browse the full Xpel Beauty Care range: shampoos, conditioners, face washes, serums, body creams, toothpastes and home essentials. Find them at 600+ stores in Nigeria.',
  '$.seo.pages.about.description', 'Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria, supplying more than 600 stores in 22 states.',
  '$.seo.pages.contact.description', 'Contact Xpel Beauty NG to order, stock our products in your shop or ask about a product. We serve customers across Nigeria.',
  '$.seo.pages.stores.description', 'Find an Xpel Beauty Care stockist near you. More than 600 stores in Lagos, Abuja, Port Harcourt and 19 more states.',
  '$.banners.stores.text', 'Sold at more than 600 stores in 22 states.',
  '$.heroSlides[0].descriptor', 'Tea Tree Hair & Skin Collection',
  '$.heroSlides[0].benefits', JSON_ARRAY('Tea tree oil for a fresh, clean feel', 'Shampoo, conditioner, face wash and more', 'Gentle enough for everyday use'),
  '$.heroSlides[1].descriptor', 'Moroccan Argan Oil Collection',
  '$.heroSlides[1].benefits', JSON_ARRAY('Tames frizz and softens dry hair', 'Adds shine you can see', 'Shampoo, conditioner, mask and oil'),
  '$.heroSlides[2].descriptor', 'Black Castor Oil & Avocado Hair Collection',
  '$.heroSlides[2].headlineLine1', 'Nourish',
  '$.heroSlides[2].headlineLine2', '& Shine',
  '$.heroSlides[2].benefits', JSON_ARRAY('Black castor oil and avocado', 'Adds shine to dry hair', 'With hyaluronic acid to hold in moisture'),
  '$.heroSlides[3].descriptor', 'Hydrating Watermelon Skincare',
  '$.heroSlides[3].benefits', JSON_ARRAY('Hydrates with hyaluronic acid', 'With vitamins C and E', 'Watermelon extract and aloe vera')) WHERE `id` = 1;
COMMIT;

-- 2026-10-21 photo library products (same as sql/2026-10-21-photo-library-products.sql)
-- Xpel Beauty NG (2026-10-21): products found in the photo library that were not on the site. Hostinger / MySQL.
-- Run once in phpMyAdmin, after the 2026-10-20 scripts. Prices are 0 until real prices are set.
INSERT IGNORE INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`) VALUES
(401, 'Hot Rose Lip Butter Chocolate Cake', 'Hot Rose', 'Body & Beauty', 0, 50, NULL, '/Img/hot-rose-lip-butter-chocolate-cake.jpg', '15ml', 'Hot Rose Lip Butter in Chocolate Cake. A rich balm that keeps lips soft and smooth, with a sweet chocolate scent. Wear it in the day or as an overnight lip mask. 15ml.', 'Rich lip butter for soft, smooth lips\nChocolate Cake scent\nDay wear or overnight lip mask\n15ml, fits in any bag', 'Apply to your lips whenever they feel dry.\nReapply after eating or drinking.\nUse a thicker layer at night.', 1),
(402, 'Nulab Feelin Fresh Stick Deodorant', 'Nulab', 'Body & Beauty', 0, 50, NULL, '/Img/nulab-feelin-fresh-stick-deodorant.jpg', '64g', 'Nulab Feelin Fresh anti-perspirant stick with a fresh cucumber scent. Glides on clear and gives 48-hour protection, so you stay fresh all day.', '48-hour anti-perspirant protection\nFresh cucumber scent\nEasy-glide stick\n64g', 'Twist up a little of the stick.\nApply to clean, dry underarms.\nLet it dry before dressing.', 1),
(403, 'Nulab Feelin Silky Skin Drenching Moisturising Cream (Jar)', 'Nulab', 'Body & Beauty', 0, 50, NULL, '/Img/nulab-feelin-silky-moisturising-cream-jar.jpg', NULL, 'Nulab Feelin Silky skin drenching moisturising cream in a jar. Made with jojoba oil and vitamin E for all-day moisture on dry skin.', 'Skin drenching moisture\nWith jojoba oil and vitamin E\nFor all-day softness\nHandy jar', 'Smooth over clean skin.\nUse daily, especially after a bath or shower.\nReapply on very dry areas.', 1),
(404, 'Aloe Vera Refreshing Face Wash', 'Aloe Vera', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-aloe-vera-refreshing-face-wash-250ml.png', '250ml', 'XBC Aloe Vera refreshing face wash with aloe vera extracts. It cleanses and refreshes your skin for a healthy glow. 250ml.', 'Cleanses and refreshes skin\nWith aloe vera extracts\nFor daily use\n250ml tube', 'Wet your face.\nMassage a small amount over skin.\nRinse well with water.', 1),
(405, 'Aloe Vera Face & Body Scrub (Tube)', 'Aloe Vera', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-aloe-vera-face-body-scrub-tube-250ml.png', '250ml', 'XBC Aloe Vera face and body scrub in a 250ml tube. It gently exfoliates for visibly brighter skin, with aloe vera extracts.', 'Gently exfoliates\nFor visibly brighter skin\nFace and body\n250ml tube', 'Apply to wet skin.\nMassage in small circles.\nRinse well. Use two or three times a week.', 1),
(406, 'Argan Oil Night Repair Serum (50ml)', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-night-repair-serum-50ml.png', '50ml', 'Argan Oil night repair serum with Moroccan argan oil extracts. An intensive revitalising formula that helps repair and rejuvenate overnight, leaving skin smooth and healthy. 50ml dropper bottle.', 'With Moroccan argan oil extracts\nIntensive revitalising formula\nWorks overnight\n50ml dropper bottle', 'Cleanse your face at night.\nPress a few drops into face and neck.\nLeave on overnight.', 1),
(407, 'Argan Oil Night Repair Serum (30ml)', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-night-repair-serum-30ml.png', '30ml', 'Argan Oil night repair serum with Moroccan argan oil extracts, in a 30ml dropper bottle. Helps repair and rejuvenate overnight, leaving skin smooth and healthy.', 'With Moroccan argan oil extracts\nIntensive revitalising formula\nWorks overnight\n30ml dropper bottle', 'Cleanse your face at night.\nPress a few drops into face and neck.\nLeave on overnight.', 1),
(408, 'Argan Oil Hair Treatment (50ml)', 'Argan Oil', 'Hair Care', 0, 50, NULL, '/Img/argan-oil-hair-treatment-50ml.png', '50ml', 'XHC Argan Oil hair treatment with Moroccan argan oil, in a 50ml bottle. Adds shine and smooths dry, frizzy hair.', 'With Moroccan argan oil\nAdds shine\nSmooths frizz\n50ml size', 'Warm a few drops in your palms.\nWork through damp or dry hair, focusing on the ends.\nStyle as usual.', 1),
(409, 'Argan Oil Deep Moisturising Foot Pack', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-deep-moisturising-foot-pack.png', NULL, 'XBC Argan Oil deep moisturising foot pack with Moroccan argan oil extracts. Socks soaked in a rich formula that softens dry, rough feet.', 'Deep moisturising\nWith Moroccan argan oil extracts\nFor dry, rough feet\nAt-home treatment', 'Slip your feet into the socks.\nLeave for the time shown on the pack.\nMassage any leftover product into your skin.', 1),
(410, 'Argan Oil Moisturising Hand & Body Wash', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-hand-body-wash.png', NULL, 'XBC Argan Oil moisturising hand and body wash with Moroccan argan oil. Cleanses while it helps keep skin soft.', 'Moisturising wash\nWith Moroccan argan oil\nFor hands and body\nPump bottle', 'Pump onto wet hands or a sponge.\nLather over skin.\nRinse well.', 1),
(411, 'Argan Oil Body Butter', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-body-butter.png', NULL, 'XBC Argan Oil body butter with Moroccan argan oil. A rich cream that softens and nourishes dry skin.', 'Rich body butter\nWith Moroccan argan oil\nFor dry skin\nLarge tub', 'Smooth over clean, dry skin.\nMassage in until absorbed.\nUse daily on dry areas.', 1),
(412, 'Argan Oil Hand & Nail Cream', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-hand-nail-cream.png', NULL, 'XBC Argan Oil hand and nail cream with Moroccan argan oil. Softens dry hands and cuticles.', 'For hands and nails\nWith Moroccan argan oil\nSoftens dry skin and cuticles\nHandy tube', 'Massage into hands and nails.\nUse whenever hands feel dry.\nReapply after washing.', 1),
(413, 'Argan Oil Smoothing Spray', 'Argan Oil', 'Hair Care', 0, 50, NULL, '/Img/argan-oil-smoothing-spray.png', NULL, 'XHC Argan Oil smoothing spray with Moroccan argan oil. Tames frizz and leaves hair smooth and shiny.', 'Smooths and tames frizz\nWith Moroccan argan oil\nAdds shine\nSpray bottle', 'Spray onto damp or dry hair.\nComb through.\nStyle as usual.', 1),
(414, 'Argan Oil Shower Cream', 'Argan Oil', 'Body & Beauty', 0, 50, NULL, '/Img/argan-oil-shower-cream.jpg', NULL, 'XHC Argan Oil shower cream with Moroccan argan oil. A creamy wash that cleanses and leaves skin feeling soft.', 'Creamy shower wash\nWith Moroccan argan oil\nLeaves skin soft\nSqueeze tube', 'Apply to wet skin or a sponge.\nLather and massage.\nRinse well.', 1),
(415, 'Argan Oil Leave-In Conditioner', 'Argan Oil', 'Hair Care', 0, 50, NULL, '/Img/argan-oil-leave-in-conditioner.png', NULL, 'XHC Argan Oil leave-in conditioner with Moroccan argan oil. Softens, detangles and adds shine without rinsing.', 'No-rinse conditioner\nWith Moroccan argan oil\nSoftens and detangles\nAdds shine', 'Apply to clean, towel-dried hair.\nComb through from root to tip.\nDo not rinse. Style as usual.', 1),
(416, 'Papaya Face & Body Scrub', 'Papaya', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-papaya-face-body-scrub-250ml.png', '250ml', 'XBC Papaya face and body scrub with papaya extracts. It gently exfoliates for visibly brighter skin. 250ml.', 'Gently exfoliates\nWith papaya extracts\nFor visibly brighter skin\n250ml tube', 'Apply to wet skin.\nMassage in small circles.\nRinse well. Use two or three times a week.', 1),
(417, 'Papaya Pore Refining Face Toner', 'Papaya', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-papaya-pore-refining-face-toner-200ml.jpg', '200ml', 'XBC Papaya pore refining face toner with papaya extracts. It soothes, calms and cleanses your skin for a healthy glow. 200ml.', 'Pore refining toner\nWith papaya extracts\nSoothes, calms and cleanses\n200ml', 'After cleansing, apply to a cotton pad.\nSweep over face and neck.\nFollow with moisturiser.', 1),
(418, 'Rosemary & Mint Nourishing Leave-In Conditioner', 'Xpel Hair Care', 'Hair Care', 0, 50, NULL, '/Img/xhc-rosemary-mint-leave-in-conditioner.jpg', NULL, 'XHC Rosemary & Mint nourishing leave-in conditioner. Softens and nourishes hair without rinsing, with the same fresh scent as the rest of the range.', 'No-rinse conditioner\nRosemary and mint\nNourishes and softens\nMatches the Rosemary & Mint range', 'Apply to clean, towel-dried hair.\nComb through from root to tip.\nDo not rinse. Style as usual.', 1),
(419, 'XBC Hemp Face Mask', 'Xpel Body Care', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-hemp-face-mask.jpg', NULL, 'XBC Hemp sheet face mask made with natural organic ingredients. A 20-minute treatment for a calm, refreshed look.', 'Hemp sheet mask\nNatural organic ingredients\n20-minute treatment\nSingle use', 'Cleanse and dry your face.\nSmooth the mask on and leave for 20 minutes.\nRemove and massage in any leftover serum.', 1),
(420, 'XBC Hemp Hand Lotion', 'Xpel Body Care', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-hemp-hand-lotion.jpg', NULL, 'XBC Hemp hand lotion for soft and silky smooth hands.', 'Hemp hand lotion\nFor soft, silky hands\nFor everyday use\nBoxed bottle', 'Pump a little onto your hands.\nMassage in until absorbed.\nReapply after washing.', 1),
(421, 'XBC Banana Body Yogurt (Deep Moisturising)', 'Xpel Body Care', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-banana-body-yogurt.jpg', NULL, 'XBC Banana body yogurt. A light, deep moisturising cream with a sweet banana scent that leaves skin soft.', 'Deep moisturising\nLight yogurt texture\nSweet banana scent\nLarge tub', 'Smooth over clean skin.\nMassage in until absorbed.\nUse daily.', 1),
(422, 'Medipure Hair & Scalp 2-in-1 Shampoo & Conditioner', 'Medipure', 'Hair Care', 0, 50, NULL, '/Img/medipure-hair-scalp-2in1-shampoo-conditioner.jpg', NULL, 'Medipure Hair & Scalp 2-in-1 shampoo and conditioner for frequent use. Cleanses and conditions in one step.', 'Shampoo and conditioner in one\nFor frequent use\nHair & Scalp range\nSaves a step', 'Massage into wet hair and scalp.\nLeave for a minute.\nRinse well.', 1),
(423, 'XHC Tea Tree Leave-In Conditioner', 'Xpel Hair Care', 'Hair Care', 0, 50, NULL, '/Img/xhc-tea-tree-leave-in-conditioner.jpg', NULL, 'XHC Tea Tree leave-in conditioner. Leaves hair soft and silky without rinsing, with a fresh tea tree scent.', 'No-rinse conditioner\nLeaves hair soft and silky\nFresh tea tree scent\nMatches the Tea Tree range', 'Apply to clean, towel-dried hair.\nComb through from root to tip.\nDo not rinse. Style as usual.', 1),
(424, 'Tea Tree Daily Cleansing Facial Scrub (250ml)', 'Tea Tree', 'Body & Beauty', 0, 50, NULL, '/Img/tea-tree-daily-cleansing-facial-scrub-250ml.png', '250ml', 'XBC Tea Tree daily use cleansing facial scrub in a 250ml tube, for clean, healthy-looking skin. Suitable for all skin types.', 'Daily use cleansing scrub\nWith tea tree\nSuitable for all skin types\n250ml tube', 'Apply to wet skin.\nMassage gently in small circles.\nRinse well.', 1),
(425, 'XHC Botanical Aloe Vera Vegan Hair Serum', 'Xpel Hair Care', 'Hair Care', 0, 50, NULL, '/Img/xhc-botanical-aloe-vera-vegan-hair-serum.jpg', '100ml', 'XHC Botanical moisturising vegan hair serum with aloe vera. Helps add moisture to leave hair nourished and hydrated. 100ml spray.', 'Moisturising vegan serum\nWith aloe vera\nLeaves hair nourished and hydrated\n100ml spray', 'Spray onto damp or dry hair.\nFocus on the lengths and ends.\nStyle as usual.', 1),
(426, 'XBC Cleansing Charcoal Handwash', 'Xpel Body Care', 'Home', 0, 50, NULL, '/Img/xbc-cleansing-charcoal-handwash.jpg', NULL, 'XBC Cleansing Charcoal handwash with activated charcoal. Cleanses hands naturally.', 'With activated charcoal\nCleanses naturally\nPump bottle\nFor everyday handwashing', 'Pump onto wet hands.\nLather for 20 seconds.\nRinse and dry.', 1),
(427, 'XHC Cleansing Charcoal Conditioner', 'Xpel Hair Care', 'Hair Care', 0, 50, NULL, '/Img/xhc-cleansing-charcoal-conditioner.jpg', NULL, 'XHC Cleansing Charcoal conditioner. A cleansing, revitalising and purifying conditioner from the Charcoal range.', 'With charcoal\nCleansing and revitalising\nPurifying\nMatches the Charcoal range', 'After shampooing, apply to wet hair.\nLeave for a minute or two.\nRinse well.', 1),
(428, 'Cleansing Charcoal Face & Body Scrub', 'Xpel Body Care', 'Body & Beauty', 0, 50, NULL, '/Img/xbc-cleansing-charcoal-face-body-scrub.jpg', NULL, 'XBC Cleansing Charcoal face and body scrub. Cleansing, revitalising and purifying for face and body.', 'For face and body\nWith charcoal\nCleansing and purifying\nSqueeze tube', 'Apply to wet skin.\nMassage in small circles.\nRinse well. Use two or three times a week.', 1);

-- 2026-10-21 Osiris recovery oil (same as sql/2026-10-21-osiris-recovery-oil.sql)
-- Xpel Beauty NG (2026-10-21): Osiris Avisé Recovery Oil. Hostinger / MySQL. Run once, after the other 2026-10-21 script.
INSERT IGNORE INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`) VALUES
(429, 'Osiris Avisé Recovery Oil', 'Osiris Avisé', 'Body & Beauty', 0, 50, NULL, '/Img/osiris-avise-recovery-oil.jpg', NULL, 'A recovery skin oil that helps the appearance of scars and stretch marks. It also improves skin tone and re-hydrates dry skin.', 'Helps the appearance of scars and stretch marks\nImproves skin tone\nRe-hydrating\nSkin oil for daily use', 'Massage a few drops into clean skin.\nFocus on scars, stretch marks or dry areas.\nUse daily.', 1);

-- 2026-10-21 background cutouts (same as sql/2026-10-21-background-cutouts.sql)
-- Xpel Beauty NG (2026-10-21): product photos cut out of their studio backgrounds. Hostinger / MySQL. Safe to run more than once.
UPDATE `products` SET `image` = '/Img/tea-tree-peppermint-foot-pack-cutout.png' WHERE `id` = 222;
UPDATE `products` SET `image` = '/Img/aloe-vera-body-wash-250ml-cutout.png' WHERE `id` = 324;
UPDATE `products` SET `image` = '/Img/xbc-bamboo-cotton-buds-300-cutout.png' WHERE `id` = 341;
UPDATE `products` SET `image` = '/Img/xbc-banana-face-body-scrub-250ml-tube-cutout.png' WHERE `id` = 379;
UPDATE `products` SET `image` = '/Img/aloe-vera-shampoo-250ml-cutout.png' WHERE `id` = 382;
UPDATE `products` SET `image` = '/Img/xbc-aloe-vera-face-body-scrub-cutout.png' WHERE `id` = 383;
UPDATE `products` SET `image` = '/Img/medex-aloe-vera-antibacterial-handwash-650ml-cutout.png' WHERE `id` = 384;
UPDATE `products` SET `image` = '/Img/mucky-pup-flea-repellent-shampoo-cutout.png' WHERE `id` = 386;
UPDATE `products` SET `image` = '/Img/dr-magic-double-action-foamer-cutout.png' WHERE `id` = 387;
UPDATE `products` SET `image` = '/Img/dr-magic-oven-grill-cleaner-cutout.png' WHERE `id` = 388;
UPDATE `products` SET `image` = '/Img/dr-magic-snatch-a-dye-20-sheets-cutout.png' WHERE `id` = 389;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-treatment-cutout.png' WHERE `id` = 390;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-conditioner-cutout.png' WHERE `id` = 391;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-hair-mask-cutout.png' WHERE `id` = 392;
UPDATE `products` SET `image` = '/Img/xhc-tea-tree-moisturising-shampoo-400ml-cutout.png' WHERE `id` = 398;
UPDATE `products` SET `image` = '/Img/argan-oil-shower-cream-cutout.png' WHERE `id` = 414;
UPDATE `products` SET `image` = '/Img/xbc-papaya-pore-refining-face-toner-200ml-cutout.png' WHERE `id` = 417;
UPDATE `products` SET `image` = '/Img/xhc-rosemary-mint-leave-in-conditioner-cutout.png' WHERE `id` = 418;
UPDATE `products` SET `image` = '/Img/xbc-hemp-face-mask-cutout.png' WHERE `id` = 419;
UPDATE `products` SET `image` = '/Img/xbc-hemp-hand-lotion-cutout.png' WHERE `id` = 420;
UPDATE `products` SET `image` = '/Img/xbc-banana-body-yogurt-cutout.png' WHERE `id` = 421;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-2in1-shampoo-conditioner-cutout.png' WHERE `id` = 422;
UPDATE `products` SET `image` = '/Img/xhc-tea-tree-leave-in-conditioner-cutout.png' WHERE `id` = 423;
UPDATE `products` SET `image` = '/Img/xbc-cleansing-charcoal-handwash-cutout.png' WHERE `id` = 426;
UPDATE `products` SET `image` = '/Img/xbc-cleansing-charcoal-face-body-scrub-cutout.png' WHERE `id` = 428;

-- 2026-10-22 image fixes and duplicate (same as sql/2026-10-22-image-fixes-and-duplicate.sql)
-- Xpel Beauty NG (2026-10-22). Hostinger / MySQL. Safe to run more than once.
-- Cut-outs that had lost a white cap or lid, re-made with the cap/lid kept.
UPDATE `products` SET `image` = '/Img/xhc-tea-tree-leave-in-conditioner-v2.png' WHERE `id` = 423;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-hair-mask-v2.png' WHERE `id` = 392;
-- XBC Aqueous Cream SLS Free was the same product as XBC Aqueous Cream (#335).
DELETE FROM `products` WHERE `id` = 336;

-- 2026-10-22 rebrand hero slides (same as sql/2026-10-22-rebrand-hero-slides.sql)
-- Xpel Beauty NG (2026-10-22): three "new look" rebrand banners at the front of the hero slider. Hostinger / MySQL.
-- Run once. The slides already on the site move along to positions 4 onwards.
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[0]', CAST('{"image": "/banner/rebrand-argan-body-butter.webp", "overlayColor": "rgba(40, 22, 6, 0.86)", "brandLockup": "xbc®  |  xpel body care", "subLabel": "argan oil · new look", "headlineLine1": "Same Butter.", "headlineLine2": "New Gold Jar.", "headlineColor": "#F7E3B0", "descriptor": "Argan oil body butter, new look", "benefits": ["Same body butter with Moroccan argan oil", "Old and new jars are the same product", "Look for the new jar in stores"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "see argan body butter", "ctaHref": "/product/411", "ctaBg": "#C8960A", "ctaColor": "#1B1205"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/rebrand-argan-body-butter.webp') IS NULL;
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[0]', CAST('{"image": "/banner/rebrand-cocoa-butter.webp", "overlayColor": "rgba(72, 40, 20, 0.86)", "brandLockup": "xbc®  |  xpel body care", "subLabel": "cocoa butter · new look", "headlineLine1": "Same Cream.", "headlineLine2": "New Jar.", "headlineColor": "#F6E7D6", "descriptor": "Cocoa butter body cream, 500ml", "benefits": ["Same rich cream for dry skin", "Old and new jars are the same product", "Look for the new jar in stores"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "see cocoa butter cream", "ctaHref": "/product/339", "ctaBg": "#6B3A1F", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/rebrand-cocoa-butter.webp') IS NULL;
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[0]', CAST('{"image": "/banner/rebrand-tea-tree.webp", "overlayColor": "rgba(16, 62, 28, 0.86)", "brandLockup": "xbc®  |  xpel beauty care", "subLabel": "tea tree · new look", "headlineLine1": "Same Tea Tree.", "headlineLine2": "New Pack.", "headlineColor": "#EAF7D6", "descriptor": "Face wash & facial scrub, newly packed", "benefits": ["Same tea tree formula as before", "Old and new packs are the same product", "Look for the new pack in stores"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "shop the face wash", "ctaHref": "/product/225", "ctaBg": "#1B6B2E", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/rebrand-tea-tree.webp') IS NULL;

-- 2026-10-22 tea tree new packs (same as sql/2026-10-22-tea-tree-new-packs.sql)
-- Xpel Beauty NG (2026-10-22): Tea Tree Foaming Face Wash and Facial Scrub in the new XBC pack. Hostinger / MySQL. Safe to run more than once.
UPDATE `products` SET `image` = '/Img/xbc-tea-tree-foaming-face-wash-new.png',
  `description` = 'A tea tree foaming face wash made with tea tree and peppermint oils. The rich foam cleanses and refreshes skin, so your face feels clean and fresh after every wash. 200ml.',
  `key_benefits` = 'With tea tree and peppermint oils\nCleanses and refreshes skin\nRich foam lifts dirt and oil\n200ml pump bottle'
WHERE `id` = 225;
UPDATE `products` SET `image` = '/Img/xbc-tea-tree-facial-scrub-250ml-new.png', `name` = 'Tea Tree Facial Scrub (250ml)',
  `description` = 'XBC Tea Tree facial scrub in a 250ml tube. It cleanses pores and gently exfoliates for fresher, smoother skin.',
  `key_benefits` = 'Cleanses pores\nGently exfoliates\nFor fresher, smoother skin\n250ml tube'
WHERE `id` = 424;

-- 2026-10-23 range hero slides (same as sql/2026-10-23-range-hero-slides.sql)
-- Xpel Beauty NG (2026-10-23): four range banners after the "new look" slides. Hostinger / MySQL.
-- Run after sql/2026-10-22-rebrand-hero-slides.sql. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[3]', CAST('{"image": "/banner/range-charcoal.webp", "overlayColor": "rgba(18, 18, 22, 0.88)", "brandLockup": "xbc®  xoc®  |  charcoal", "subLabel": "charcoal", "headlineLine1": "Deep Clean", "headlineLine2": "Charcoal", "headlineColor": "#FFFFFF", "descriptor": "Mask, scrub, wipes & oral care", "benefits": ["Cleansing, revitalising, purifying", "Detox face mask, scrub and cleansing wipes", "Charcoal toothpaste and whitening mouthwash"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "shop charcoal", "ctaHref": "/shop?q=charcoal", "ctaBg": "#E6007E", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/range-charcoal.webp') IS NULL;
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[3]', CAST('{"image": "/banner/range-vitamin-c.webp", "overlayColor": "rgba(170, 70, 0, 0.84)", "brandLockup": "xbc®  |  xpel beauty care", "subLabel": "vitamin c", "headlineLine1": "Vitamin C", "headlineLine2": "Radiance", "headlineColor": "#FFF1DC", "descriptor": "Serum, face wash, scrubs, mask & wipes", "benefits": ["With vitamin C and niacinamide", "Serum helps boost skin''s natural radiance", "Vegan face wash, body scrub and mask"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "shop vitamin c", "ctaHref": "/collection/vitamin-c", "ctaBg": "#E86A00", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/range-vitamin-c.webp') IS NULL;
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[3]', CAST('{"image": "/banner/range-xbc-creams.webp", "overlayColor": "rgba(28, 48, 104, 0.86)", "brandLockup": "xbc®  |  xpel body care", "subLabel": "body creams", "headlineLine1": "Everyday", "headlineLine2": "Body Creams", "headlineColor": "#E6EEFF", "descriptor": "Five creams, 500ml tubs", "benefits": ["Aloe Vera, Olive Oil and Cocoa Butter", "Aqueous Cream for relief of dry skin", "Vitamin E to moisturise and soothe"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "shop body creams", "ctaHref": "/shop?q=Cream%20500ml", "ctaBg": "#1E4FB8", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/range-xbc-creams.webp') IS NULL;
UPDATE `site_content` SET `data` = JSON_ARRAY_INSERT(`data`, '$.heroSlides[3]', CAST('{"image": "/banner/range-papaya.webp", "overlayColor": "rgba(150, 70, 20, 0.86)", "brandLockup": "xbc®  |  xpel beauty care", "subLabel": "papaya", "headlineLine1": "Papaya", "headlineLine2": "Glow Routine", "headlineColor": "#FFE9D2", "descriptor": "Face wash, toner, scrub & mask", "benefits": ["Cleansing face wash and pore refining toner", "Face & body scrub for visibly brighter skin", "Vegan hydrating sheet mask"], "vegaBadge": "", "vegaBadgeBg": "rgba(255,255,255,.18)", "vegaBadgeColor": "#fff", "ctaLabel": "shop papaya", "ctaHref": "/collection/papaya", "ctaBg": "#E8761E", "ctaColor": "#FFFFFF"}' AS JSON)) WHERE `id` = 1 AND JSON_SEARCH(`data`, 'one', '/banner/range-papaya.webp') IS NULL;

-- 2026-10-29 b2b positioning (same as sql/2026-10-29-b2b-positioning.sql)
-- Xpel Beauty NG (2026-10-29): B2B positioning. We sell to distributors and trade buyers. Hostinger / MySQL.
-- Updates site text, banners and SEO; your other settings are kept. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`,
  '$.announcement', 'wholesale supply to distributors across nigeria. trade enquiries welcome.',
  '$.footerTagline', 'exclusive nigerian distributor of xpel beauty care. wholesale supply to distributors and retailers.',
  '$.aboutLead', 'Xpel Beauty NG is a B2B business. We supply Xpel Beauty Care in bulk to distributors, wholesalers and retailers across Nigeria, and our trade partners put it on the shelves of more than 600 stores.',
  '$.aboutStoryBody1', 'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria. We sell to distributors and trade buyers, not directly to shoppers.',
  '$.aboutMission', 'To get good, affordable personal care and home products onto shelves across Nigeria through a strong network of distributors and retailers.',
  '$.aboutVision', 'To be the first name Nigerian distributors and retailers think of for personal care and household essentials.',
  '$.aboutValue4', 'Good quality at prices that work for trade buyers and shoppers',
  '$.aboutValue5', 'Supplied through distributors to 600+ stores',
  '$.aboutCtaTitle', 'Become a distributor',
  '$.aboutCtaText', 'Want to stock or distribute Xpel Beauty Care? Send us a trade enquiry and our sales team will get back to you.',
  '$.contactTitle', 'Trade & distributor enquiries',
  '$.contactIntro', 'We sell in bulk to distributors, wholesalers and retailers. Tell us your business name, location and the products you want to stock, and our sales team will get back to you. Shoppers can buy our products at any of our 600+ stockists.',
  '$.step1Title', 'Browse the range',
  '$.step1Desc', 'Hair, skin, oral, nail, foot and home care. See every product in the shop or the printable catalogue.',
  '$.step2Title', 'Send a trade enquiry',
  '$.step2Desc', 'Tell us your business, your location and the products you want to stock, by form or WhatsApp.',
  '$.step3Title', 'Get supplied',
  '$.step3Desc', 'Our sales team confirms your order and how we will supply you. Shoppers can buy at our 600+ stockists.',
  '$.pillar4Title', 'Nationwide distribution',
  '$.pillar4Desc', 'We supply distributors and retailers in 22 states, from Lagos and Abuja to Port Harcourt, Benin and Ibadan.',
  '$.ctaText', 'Stock Xpel Beauty Care in your business, or find it at a store near you.',
  '$.banners.contact.title', 'Become a distributor',
  '$.banners.contact.text', 'Distributor, wholesale and trade enquiries welcome.',
  '$.banners.shopHero.text', 'wholesale supply to distributors and retailers across nigeria.',
  '$.seo.defaultDescription', 'Xpel Beauty NG is the exclusive Nigerian distributor of Xpel Beauty Care, supplying hair, skin, oral and home care products in bulk to distributors and retailers in 22 states.',
  '$.seo.pages.home.title', 'Wholesale Hair, Skin & Body Care Distributor in Nigeria',
  '$.seo.pages.home.description', 'Exclusive Nigerian distributor of Xpel Beauty Care. We supply 180+ hair, skin, body, oral and home care products in bulk to distributors and retailers in 22 states.',
  '$.seo.pages.home.keywords', 'xpel beauty distributor nigeria, wholesale beauty products nigeria, wholesale cosmetics lagos, beauty products distributor nigeria, bulk hair care products nigeria, wholesale skin care nigeria, personal care wholesaler lagos, xpel beauty care nigeria, tea tree products wholesale, argan oil products wholesale nigeria',
  '$.seo.pages.shop.title', 'Product Range for Distributors & Retailers in Nigeria',
  '$.seo.pages.shop.description', 'Browse the full Xpel Beauty Care range available wholesale: shampoos, conditioners, face washes, serums, body creams, toothpastes and home essentials. Trade enquiries welcome.',
  '$.seo.pages.shop.keywords', 'wholesale beauty products nigeria, xpel beauty product range, bulk hair care nigeria, wholesale skin care lagos, beauty products for retailers nigeria, cosmetics wholesale nigeria',
  '$.seo.pages.about.title', 'About Us - Exclusive Xpel Beauty Care Distributor in Nigeria',
  '$.seo.pages.about.description', 'Xpel Beauty NG is a B2B business and the exclusive distributor of Xpel Beauty Care in Nigeria. We sell to distributors and retailers, supplying 600+ stores in 22 states.',
  '$.seo.pages.about.keywords', 'about xpel beauty ng, xpel beauty care distributor nigeria, b2b beauty distributor nigeria, wholesale beauty company lagos, exclusive distributor nigeria',
  '$.seo.pages.contact.title', 'Distributor & Wholesale Enquiries',
  '$.seo.pages.contact.description', 'Become an Xpel Beauty Care distributor or stockist in Nigeria. Send a wholesale or trade enquiry to Xpel Beauty NG, Trade Fair International Market, Lagos.',
  '$.seo.pages.contact.keywords', 'become a distributor nigeria, xpel beauty wholesale enquiry, beauty products distributor lagos, trade enquiry xpel beauty, stock xpel beauty care',
  '$.seo.pages.stores.description', 'Find a store that stocks Xpel Beauty Care. More than 600 stores in Lagos, Abuja, Port Harcourt and 19 more states, supplied by our distributors.') WHERE `id` = 1;

-- 2026-10-29 shopper enquiries (same as sql/2026-10-29-shopper-enquiries.sql)
-- Xpel Beauty NG (2026-10-29): Shoppers can ask about products and where to buy, alongside trade enquiries. Hostinger / MySQL.
-- Updates site text, banners and SEO; your other settings are kept. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`,
  '$.aboutStoryBody1', 'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria. We sell in bulk to distributors and retailers, and shoppers buy our products in their stores. Anyone can ask us about a product or where to find it.',
  '$.contactIntro', 'We sell in bulk to distributors, wholesalers and retailers. Tell us your business name, location and the products you want to stock, and our sales team will get back to you. Shoppers are welcome too: ask us about any product or where to buy it near you.',
  '$.storesIntro', 'Find a store near you that sells Xpel Beauty Care. Can''t see your area? Message us on WhatsApp and we will point you to the nearest stockist.',
  '$.banners.contact.text', 'Trade enquiries, product questions and where to buy.',
  '$.seo.defaultDescription', 'Exclusive Nigerian distributor of Xpel Beauty Care. We supply distributors and retailers in 22 states, and shoppers can buy our products at 600+ stores.',
  '$.seo.pages.home.description', 'Exclusive Nigerian distributor of Xpel Beauty Care. We supply 180+ hair, skin, body and home care products to distributors and retailers. Shoppers can buy at 600+ stores.',
  '$.seo.pages.home.keywords', 'xpel beauty distributor nigeria, wholesale beauty products nigeria, beauty products distributor nigeria, wholesale cosmetics lagos, bulk hair care products nigeria, where to buy xpel beauty care, xpel beauty near me, xpel beauty care nigeria, tea tree products nigeria, argan oil products nigeria',
  '$.seo.pages.stores.title', 'Where to Buy Xpel Beauty Care Near You in Nigeria',
  '$.seo.pages.stores.description', 'Find a store near you that sells Xpel Beauty Care. More than 600 supermarkets, pharmacies and beauty stores in Lagos, Abuja, Port Harcourt and 19 more states.',
  '$.seo.pages.stores.keywords', 'where to buy xpel beauty care, xpel beauty near me, xpel beauty stockists nigeria, xpel beauty care lagos store, xpel beauty abuja, buy xpel tea tree face wash, xpel beauty port harcourt',
  '$.seo.pages.contact.description', 'Contact Xpel Beauty NG in Lagos. Distributor and wholesale enquiries, product questions, and help finding a store that sells Xpel Beauty Care near you.',
  '$.seo.pages.contact.keywords', 'contact xpel beauty nigeria, become a distributor nigeria, xpel beauty wholesale enquiry, xpel beauty product question, where to buy xpel beauty care, xpel beauty customer care') WHERE `id` = 1;

-- 2026-10-29 office map pin (same as sql/2026-10-29-office-map-pin.sql)
-- Xpel Beauty NG (2026-10-29): office map pin for the Contact page map and address links. Hostinger / MySQL. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.officeLat', 6.460998746759591, '$.officeLng', 3.2509487683946046) WHERE `id` = 1;
