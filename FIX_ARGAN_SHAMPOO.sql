-- Fix Argan Oil Shampoo image
UPDATE products SET image = '/Img/argan oil shampoo.webp'
WHERE name = 'Argan Oil Shampoo';

-- Verify
SELECT name, image FROM products WHERE name = 'Argan Oil Shampoo';
