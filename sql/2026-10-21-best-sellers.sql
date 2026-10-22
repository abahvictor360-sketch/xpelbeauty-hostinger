-- Xpel Beauty NG (2026-10-21): 9 homepage best sellers in display order (3 Tea Tree, 2 Charcoal, 2 Argan Oil, 2 Vitamin C). Hostinger / MySQL. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.bestSellerIds', JSON_ARRAY(225, 398, 424, 242, 265, 253, 250, 213, 216)) WHERE `id` = 1;
