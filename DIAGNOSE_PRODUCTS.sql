-- ============================================================
-- DIAGNOSE: Check product image status
-- ============================================================

-- How many products exist?
SELECT COUNT(*) as total_products FROM products;

-- How many products have images set?
SELECT COUNT(*) as products_with_images FROM products WHERE image IS NOT NULL AND image != '';

-- Show first 10 products and their current image values
SELECT id, name, image FROM products LIMIT 10;

-- Show products that should have been updated but don't
SELECT id, name, image FROM products WHERE id <= 75 AND (image IS NULL OR image = '');
