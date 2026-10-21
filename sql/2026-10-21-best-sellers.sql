-- Xpel Beauty NG (2026-10-21): 9 homepage best sellers, mostly Tea Tree, in display order. Hostinger / MySQL. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.bestSellerIds', JSON_ARRAY(225, 398, 364, 228, 360, 229, 253, 216, 239)) WHERE `id` = 1;
