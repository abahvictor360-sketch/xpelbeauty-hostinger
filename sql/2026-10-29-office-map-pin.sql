-- Xpel Beauty NG (2026-10-29): office map pin for the Contact page map and address links. Hostinger / MySQL. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.officeLat', 6.460998746759591, '$.officeLng', 3.2509487683946046) WHERE `id` = 1;
