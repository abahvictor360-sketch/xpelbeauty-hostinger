-- ============================================================
-- BULLETPROOF IMAGE MAP: Works regardless of product IDs
-- ============================================================
-- Uses ROW_NUMBER so it works even if IDs are not 1,2,3...
-- Run in Supabase SQL Editor

WITH image_list(rn, img) AS (
  VALUES
  (1, '/Img/WhatsApp%20Image%202026-01-23%20at%2013.48.16%20(1).jpeg'),
  (2, '/Img/WhatsApp%20Image%202026-01-23%20at%2013.48.16%20(2).jpeg'),
  (3, '/Img/WhatsApp%20Image%202026-01-23%20at%2013.48.16%20(3).jpeg'),
  (4, '/Img/WhatsApp%20Image%202026-01-23%20at%2013.48.16%20(4).jpeg'),
  (5, '/Img/WhatsApp%20Image%202026-01-23%20at%2013.48.16.jpeg'),
  (6, '/Img/WhatsApp%20Image%202026-02-16%20at%201.01.06%20PM%20(2).jpeg'),
  (7, '/Img/WhatsApp%20Image%202026-02-16%20at%201.01.07%20PM%20(1).jpeg'),
  (8, '/Img/WhatsApp%20Image%202026-02-16%20at%201.01.07%20PM.jpeg'),
  (9, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.40%20PM.jpeg'),
  (10, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.42%20PM.jpeg'),
  (11, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.43%20PM%20(1).jpeg'),
  (12, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.43%20PM%20(2).jpeg'),
  (13, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.43%20PM.jpeg'),
  (14, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.44%20PM.jpeg'),
  (15, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.45%20PM%20(1).jpeg'),
  (16, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.45%20PM%20(2).jpeg'),
  (17, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.45%20PM.jpeg'),
  (18, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.46%20PM%20(1).jpeg'),
  (19, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.46%20PM%20(2).jpeg'),
  (20, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.46%20PM.jpeg'),
  (21, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.47%20PM%20(1).jpeg'),
  (22, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.47%20PM.jpeg'),
  (23, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.48%20PM%20(1).jpeg'),
  (24, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.48%20PM%20(2).jpeg'),
  (25, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.48%20PM.jpeg'),
  (26, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.49%20PM%20(1).jpeg'),
  (27, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.49%20PM%20(2).jpeg'),
  (28, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.49%20PM.jpeg'),
  (29, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.50%20PM%20(1).jpeg'),
  (30, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.50%20PM%20(2).jpeg'),
  (31, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.50%20PM.jpeg'),
  (32, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.51%20PM%20(1).jpeg'),
  (33, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.51%20PM%20(2).jpeg'),
  (34, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.51%20PM.jpeg'),
  (35, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.52%20PM%20(1).jpeg'),
  (36, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.52%20PM.jpeg'),
  (37, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.53%20PM%20(1).jpeg'),
  (38, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.53%20PM%20(2).jpeg'),
  (39, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.53%20PM.jpeg'),
  (40, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.54%20PM%20(1).jpeg'),
  (41, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.54%20PM.jpeg'),
  (42, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.55%20PM%20(1).jpeg'),
  (43, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.55%20PM.jpeg'),
  (44, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.56%20PM%20(1).jpeg'),
  (45, '/Img/WhatsApp%20Image%202026-05-30%20at%201.03.56%20PM%20(2).jpeg')
),
ranked_products AS (
  SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS rn
  FROM products
)
UPDATE products
SET image = image_list.img
FROM ranked_products
JOIN image_list ON ranked_products.rn = image_list.rn
WHERE products.id = ranked_products.id;

-- Verify: show all products with their new images
SELECT id, name, image FROM products ORDER BY id;
