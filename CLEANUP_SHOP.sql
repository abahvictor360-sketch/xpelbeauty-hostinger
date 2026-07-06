-- ============================================================
-- SHOP CLEANUP — remove duplicate/wrong-image sample products
-- Run in Supabase → SQL Editor → New Query → Run.
-- ============================================================

-- 1) Take out completely: products that share the Caffeine Shampoo image
--    (image 1) and the "It's Giving GLAM" Wonder Coat spray image (image 2)
DELETE FROM products
WHERE image LIKE '%product-41696%'   -- Caffeine Shampoo photo
   OR image LIKE '%product-41639%';  -- GLAM Wonder Coat spray photo

-- 2) Shampoo on the Argan Oil photo (image 3): keep ONE, delete the rest.
--    Keeps the real "Argan Oil Shampoo", removes everything else using that photo
--    (Foot Care Balm, Wellness Vitamins, Scented Candle, etc.).
DELETE FROM products
WHERE image LIKE '%product-40183%'
  AND name <> 'Argan Oil Shampoo';

-- 3) Remove leftover generic sample products by name (in case any remain)
DELETE FROM products WHERE name IN (
  'Mosquito Spray','Travel Shampoo','Spa Gift Box',
  'Foot Care Balm','Wellness Vitamins','Scented Candle',
  'Plant Essence Caffeine Shampoo','Caffeine Shampoo','Nourishing Shampoo',
  'Wonder Coat Smoothing Spray','Hair Mask Treatment','Coconut Oil Serum',
  'Anti-Frizz Cream','Hair Growth Oil','Keratin Treatment',
  'Volumizing Conditioner','Scalp Detox Shampoo','Shea Butter Lotion',
  'Hyaluronic Acid Moisturizer','Retinol Night Cream','Sunscreen SPF 50',
  'Lip Balm Moisturizer','Eye Contour Cream','Hand & Nail Cream','Nasal Strips',
  'Aromatherapy Diffuser','Room Spray','Pillow Mist','Luxury Gift Set',
  'Starter Kit','Medipure Face Wash','Oh Fresh Body Wash','Vitamin C Serum',
  'Travel Shampoo Bar'
);

-- 4) Check what's left
SELECT id, name, category, image FROM products ORDER BY name;
