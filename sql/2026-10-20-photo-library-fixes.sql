-- Xpel Beauty NG (Hostinger / MySQL). Run once in phpMyAdmin, after 2026-10-20-new-products.sql.
UPDATE `products` SET `image` = '/Img/tea-tree-peppermint-foot-pack.png' WHERE `id` = 222;
UPDATE `products` SET `image` = '/Img/xbc-bamboo-cotton-buds-300.jpg' WHERE `id` = 341;
INSERT INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`) VALUES
(396,'Dalton House Orchard Burst Fine Handwash (500ml)','Dalton House','Home',0,40,'DH-ORCH-500','/Img/dalton-house-orchard-burst-handwash-500ml.jpg','500ml','Dalton House England orchard burst fine handwash. 500ml pump bottle.','Orchard burst fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1);
