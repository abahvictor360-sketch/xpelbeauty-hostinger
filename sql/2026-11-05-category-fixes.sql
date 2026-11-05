-- Xpel Beauty NG (2026-11-05): product range / category fixes for the MySQL database. Safe to re-run.
UPDATE products SET brand = 'Tea Tree' WHERE id IN (227, 228);      -- Tea Tree Cleansing Pads, Tea Tree Facial Toner
UPDATE products SET brand = 'So Fresh' WHERE id = 357;              -- So Fresh Watermelon Crush Facial Cleanser
UPDATE products SET category = 'Home' WHERE id IN (223, 320, 321, 322); -- hand washes sit with the other hand washes in Home
-- Run AFTER the site is redeployed (the file ships with the build):
-- UPDATE products SET image = '/Img/xbc-coconut-water-facial-wipes-twin-pack.webp' WHERE id = 344;
