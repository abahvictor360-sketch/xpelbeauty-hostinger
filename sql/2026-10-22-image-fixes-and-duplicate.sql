-- Xpel Beauty NG (2026-10-22). Hostinger / MySQL. Safe to run more than once.
-- Cut-outs that had lost a white cap or lid, re-made with the cap/lid kept.
UPDATE `products` SET `image` = '/Img/xhc-tea-tree-leave-in-conditioner-v2.png' WHERE `id` = 423;
UPDATE `products` SET `image` = '/Img/medipure-hair-scalp-hair-mask-v2.png' WHERE `id` = 392;
-- XBC Aqueous Cream SLS Free was the same product as XBC Aqueous Cream (#335).
DELETE FROM `products` WHERE `id` = 336;
