-- Xpel Beauty NG (Hostinger / MySQL). Run once in phpMyAdmin, after the other 2026-10-20 scripts.
-- New XBC cream photos
UPDATE `products` SET `image` = REPLACE(`image`, '.png', '.jpg')
 WHERE `id` BETWEEN 335 AND 340 AND `image` LIKE '/Img/xbc-%-500ml.png';
-- Duplicates: #358 repeats #260 (So Fresh sheet mask), #399 repeats #364 (Tea Tree Facial Scrub)
DELETE FROM `products` WHERE `id` IN (358, 399);
