-- Xpel Beauty NG (Hostinger / MySQL). Run once in phpMyAdmin, after the other 2026-10-20 scripts.
UPDATE `products` SET `image` = '/Img/tea-tree-body-butter-250ml.png' WHERE `id` = 360;
UPDATE `products` SET `image` = '/Img/tea-tree-facial-scrub-jar.png' WHERE `id` = 364;
-- XBC Banana Face and Body Scrub back, with its real photo (removed earlier because it showed the wrong picture)
INSERT INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`) VALUES
(379,'XBC Banana Face and Body Scrub (250ml)','Xpel Body Care','Body & Beauty',3800,40,'XBC-BANSCR-250','/Img/xbc-banana-face-body-scrub-250ml-tube.jpg','250ml','Exfoliating face and body scrub with banana - gently buffs away dull, dry skin. 250ml.','Banana extract gently buffs away dull, dry skin
Suitable for face and body
250ml - lasts through regular use
Leaves skin feeling smooth and refreshed','Apply to damp skin using circular motions.
Focus on face and body, avoiding the eye area.
Rinse thoroughly. Use 2-3 times a week.',1);
