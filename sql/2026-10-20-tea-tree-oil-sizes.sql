-- Xpel Beauty NG (Hostinger / MySQL). Run once in phpMyAdmin, after the other 2026-10-20 scripts.
UPDATE `products` SET `name` = 'Tea Tree Essential Oil (10ml)', `size` = '10ml', `image` = '/Img/tea-tree-essential-oil-10ml.jpg' WHERE `id` = 229;
INSERT INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`)
SELECT 400, 'Tea Tree Essential Oil (30ml)', `brand`, `category`, 0, `stock`, NULL, '/Img/tea-tree-essential-oil-30ml.jpg', '30ml',
 'Concentrated tea tree essential oil for skin, hair and home, in a larger 30ml bottle. Add a few drops to a carrier oil, your shampoo or a diffuser. Always dilute before it touches your skin.',
 'Pure tea tree essential oil\nFor skin, hair and home use\nLarger 30ml bottle\nA few drops go a long way', `how_to_use`, 1
FROM `products` WHERE `id` = 229;
