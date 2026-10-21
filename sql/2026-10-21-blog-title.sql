-- Xpel Beauty NG (2026-10-21): blog page heading. Hostinger / MySQL. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.blogTitle', 'Popular articles') WHERE `id` = 1;
