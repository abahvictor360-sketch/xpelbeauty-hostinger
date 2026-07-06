-- Fix: set correct images for Black Castor, Charcoal, Argan products
-- Also add 2 new Aloe Vera products
-- Run in Supabase → SQL Editor → New Query → Run

-- ── Black Castor Oil & Avocado ──
UPDATE products SET image = '/Img/Black Castor Oil & Avocado Leave-In Conditioner.png'
WHERE name = 'Black Castor Oil & Avocado Leave-In Conditioner';

UPDATE products SET image = '/Img/Black Castor Oil & Avocado Shampoo.png'
WHERE name = 'Black Castor Oil & Avocado Shampoo';

UPDATE products SET image = '/Img/Black Castor Oil & Avocado Heat Defence Spray.png'
WHERE name = 'Black Castor Oil & Avocado Heat Defence Spray';

UPDATE products SET image = '/Img/Black Castor Oil & Avocado Hair & Scalp Treatment.png'
WHERE name = 'Black Castor Oil & Avocado Hair & Scalp Treatment';

-- ── Charcoal ──
UPDATE products SET image = '/Img/Purifying Charcoal Cleansing Wipes.png'
WHERE name = 'Purifying Charcoal Cleansing Wipes';

UPDATE products SET image = '/Img/Cleansing Charcoal Face Scrub.jpg'
WHERE name = 'Cleansing Charcoal Face Scrub';

UPDATE products SET image = '/Img/Black Tissue Charcoal Detox Facial Mask.png'
WHERE name = 'Black Tissue Charcoal Detox Facial Mask';

UPDATE products SET image = '/Img/Activated Charcoal Whitening Mouthwash.png'
WHERE name = 'Activated Charcoal Whitening Mouthwash';

-- ── Argan Oil ──
UPDATE products SET image = '/Img/Argan Oil Hydrating Hair Mask.webp'
WHERE name = 'Argan Oil Hydrating Hair Mask';

-- ── New products: Aloe Vera Face Toner & Face and Body Wash ──
INSERT INTO products (name, brand, category, price, stock, sku, description, image, active)
VALUES
  ('Aloe Vera Face Toner',        'Xpel Body Care',   'Body & Beauty', 3000, 55, 'AV-TONE-200', 'Soothing aloe vera face toner — calms, hydrates and preps skin for moisture. Vegan. 200ml.', '/Img/Aloe Vera Face Toner.png',        true),
  ('Aloe Vera Face & Body Wash',  'Xpel Body Care',   'Body & Beauty', 3000, 60, 'AV-WASH-250', 'Gentle aloe vera face and body wash — cleanses, soothes and softens skin. Vegan. 250ml.',   '/Img/Aloe face and body wash.png',     true)
ON CONFLICT (sku) DO UPDATE SET image = EXCLUDED.image, active = true;

-- Verify
SELECT name, image FROM products
WHERE name ILIKE '%black castor%'
   OR name ILIKE '%charcoal%'
   OR name ILIKE '%argan oil hydrating%'
   OR name ILIKE '%aloe vera face%'
   OR name ILIKE '%aloe vera face & body%'
ORDER BY name;
