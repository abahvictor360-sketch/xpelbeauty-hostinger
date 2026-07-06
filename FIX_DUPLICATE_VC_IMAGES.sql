-- Fix: set correct images for Vitamin C products that now have dedicated photos
-- Run in Supabase → SQL Editor → New Query → Run

UPDATE products SET image = '/Img/Vitamin C Exfoliating Facial Scrub.png'
WHERE name = 'Vitamin C Exfoliating Facial Scrub';

UPDATE products SET image = '/Img/Vitamin C Salt Body Scrub.png'
WHERE name = 'Vitamin C Salt Body Scrub';

UPDATE products SET image = '/Img/Vitamin C Facial Wipes.png'
WHERE name = 'Vitamin C Facial Wipes';

-- Verify
SELECT name, image FROM products WHERE name ILIKE 'vitamin c%' ORDER BY name;
