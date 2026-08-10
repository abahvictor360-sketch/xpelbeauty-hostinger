-- Adds/updates "Tea Tree Toothpaste (+ Free Bamboo Toothbrush)" with its real
-- individual product photo (previously only had the group family shot, or may
-- not exist yet in this database since it has never been synced with the
-- Supabase/xpel-react product catalogue).
--
-- Run this in Hostinger's phpMyAdmin / SQL tool against the xpel database.
-- Safe to run more than once — updates in place if the product already exists.

INSERT INTO products (name, brand, category, price, stock, image, description, size, key_benefits, how_to_use)
SELECT * FROM (SELECT
  'Tea Tree Toothpaste (+ Free Bamboo Toothbrush)' AS name,
  'Tea Tree' AS brand,
  'Body & Beauty' AS category,
  2800.00 AS price,
  45 AS stock,
  '/Img/xoc-tea-tree-toothpaste-100ml.png' AS image,
  'Tea tree toothpaste for gentle cleansing and fresh breath — includes free bamboo toothbrush.' AS description,
  NULL AS size,
  'Tea tree oil helps gently cleanse teeth and gums\nSupports fresh breath throughout the day\nComes complete with a free bamboo toothbrush\nEco-conscious packaging' AS key_benefits,
  'Brush teeth for two minutes, morning and night.\nUse the free bamboo toothbrush provided for best results.\nSpit and avoid rinsing immediately for maximum benefit.' AS how_to_use
) AS new_row
WHERE NOT EXISTS (
  SELECT 1 FROM products WHERE name = 'Tea Tree Toothpaste (+ Free Bamboo Toothbrush)'
);

UPDATE products
SET image = '/Img/xoc-tea-tree-toothpaste-100ml.png'
WHERE name = 'Tea Tree Toothpaste (+ Free Bamboo Toothbrush)';
