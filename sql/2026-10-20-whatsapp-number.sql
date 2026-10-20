-- Xpel Beauty NG (2026-10-20): WhatsApp number is now +234 706 052 1947. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`, '$.whatsappNumber', '2347060521947') WHERE `id` = 1;
