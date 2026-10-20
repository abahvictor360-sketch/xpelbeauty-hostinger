-- Xpel Beauty NG (2026-10-20): Tea Tree Body Butter and Facial Scrub now use background-free PNGs. Safe to run more than once.
UPDATE `products` SET `image` = '/Img/tea-tree-body-butter-250ml.png' WHERE `id` = 360;
UPDATE `products` SET `image` = '/Img/tea-tree-facial-scrub-jar.png' WHERE `id` = 364;
