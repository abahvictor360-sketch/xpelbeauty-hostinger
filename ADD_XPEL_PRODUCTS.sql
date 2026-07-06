-- ============================================================
-- XPEL FULL PRODUCT CATALOGUE
-- Adds the real XPEL ranges and removes old generic duplicates.
-- Run in Supabase → SQL Editor → New Query → Run.
-- (Images: add each product's photo afterwards via
--  Admin → Products → Edit → Product Image upload.)
-- ============================================================

-- 1) Remove old generic/sample duplicates so the catalogue is clean
DELETE FROM products
WHERE name ILIKE '%tea tree%'
   OR name ILIKE '%aloe vera%'
   OR name ILIKE '%charcoal%'
   OR name ILIKE '%vitamin c%'
   OR name ILIKE '%argan%'
   OR name ILIKE '%castor%'
   OR name ILIKE '%rosemary%'
   OR name ILIKE '%watermelon%'
   OR name ILIKE '%shower gel%'
   OR sku IN (
     'ARG-001','IGG-001','XPL-001','XPL-002','OZ-001','THC-001',
     'TT-001','FS-001','MED-002'
   );

-- 2) Insert the real ranges
INSERT INTO products (name, brand, category, price, stock, sku, description, image, active) VALUES
-- ── Tea Tree (XBC / XHC) ──
('Tea Tree & Peppermint Deep Moisturising Foot Pack', 'Tea Tree', 'Body & Beauty', 2500, 60, 'TT-FOOT-30', 'Deep moisturising foot pack — leaves feet feeling soft and smooth. 1 treatment, 20 mins. 30ml.', '', true),
('Tea Tree Anti-Bacterial Handwash', 'Tea Tree', 'Body & Beauty', 2800, 80, 'TT-HAND-500', 'Anti-bacterial handwash for clean, healthy hands. 500ml.', '', true),
('Tea Tree Daily Cleansing Facial Wipes (Twin Pack)', 'Tea Tree', 'Body & Beauty', 3000, 70, 'TT-WIPE-25', 'Daily use cleansing facial wipes for clean healthy skin. 25 wipes, twin pack.', '', true),
('Tea Tree Foaming Face Wash', 'Tea Tree', 'Body & Beauty', 3500, 55, 'TT-FOAM-200', 'Daily cleansing foaming face wash for clean healthy skin. 200ml.', '', true),
('Tea Tree Moisturising Conditioner', 'Xpel Hair Care', 'Hair Care', 3500, 50, 'TT-COND-400', 'Moisturising conditioner for frequent use. 400ml.', '', true),
('Tea Tree Cleansing Pads', 'Xpel Beauty Care', 'Body & Beauty', 3200, 60, 'TT-PAD-60', 'Cleansing pads with natural tea tree oil — smooths and deeply cleanses. Dermatologically tested. 60 pads.', '', true),
('Tea Tree Facial Toner', 'Xpel Body Care', 'Body & Beauty', 3000, 55, 'TT-TONE-200', 'Facial toner — soothe, calm and cleanse your skin for a healthy glow. 200ml.', '', true),

-- ── Aloe Vera (XHC / XBC) ──
('Aloe Vera Conditioner', 'Xpel Hair Care', 'Hair Care', 3500, 50, 'AV-COND-250', 'Conditioner for smooth & shiny hair. 250ml.', '', true),
('Aloe Vera Heat Defence Spray', 'Xpel Hair Care', 'Hair Care', 4200, 45, 'AV-HEAT-150', 'Styling formula that helps hydrate and defend against heat-styling damage. With aloe vera extract. 150ml.', '', true),
('Aloe Vera Nourishing Leave-In Conditioner', 'Xpel Hair Care', 'Hair Care', 4000, 45, 'AV-LEAV-250', 'Leave-in conditioner with aloe vera and pro-vitamin B5 — leaves hair soft and silky. Vegan. 250ml.', '', true),
('Aloe Vera Cleansing Facial Wipes (Twin Pack)', 'Xpel Beauty Care', 'Body & Beauty', 3000, 60, 'AV-WIPE-25', 'Cleansing facial wipes with hydrating aloe vera. 25 wipes, twin pack.', '', true),
('Aloe Vera Nourishing Face Mask', 'Xpel Beauty Care', 'Body & Beauty', 2200, 70, 'AV-MASK-1', 'Nourishing face mask with aloe vera extract and hyaluronic acid. Vegan, plastic-free sheet.', '', true),

-- ── Black Castor Oil & Avocado (XHC) ──
('Black Castor Oil & Avocado Leave-In Conditioner', 'Xpel Hair Care', 'Hair Care', 4500, 40, 'BC-LEAV-250', 'Leave-in conditioner with black castor and avocado oil — detangles, adds moisture and nourishes locks. 250ml.', '', true),
('Black Castor Oil & Avocado Shampoo', 'Xpel Hair Care', 'Hair Care', 4500, 40, 'BC-SHMP-400', 'Shampoo with black castor and avocado oil — cleanses, nourishes and boosts shine. 400ml.', '', true),
('Black Castor Oil & Avocado Heat Defence Spray', 'Xpel Hair Care', 'Hair Care', 4500, 40, 'BC-HEAT-150', 'Heat defence styling spray with black castor oil and avocado extract. 150ml.', '', true),
('Black Castor Oil & Avocado Hair & Scalp Treatment', 'Xpel Hair Care', 'Hair Care', 4800, 35, 'BC-TRT-150', 'Hair & scalp treatment with hyaluronic acid to maintain moisture and condition the scalp. 150ml.', '', true),

-- ── Charcoal (XBC / XOC) ──
('Purifying Charcoal Cleansing Wipes', 'Xpel Body Care', 'Body & Beauty', 2800, 60, 'CH-WIPE-25', 'Daily use charcoal cleansing wipes — revitalising and purifying, remove build-up of oils and impurities. 25 wipes.', '', true),
('Cleansing Charcoal Face Scrub', 'Xpel Body Care', 'Body & Beauty', 3500, 50, 'CH-SCRB-250', 'Cleansing, revitalising and purifying charcoal face scrub. Paraben & sulfate free. 250ml.', '', true),
('Black Tissue Charcoal Detox Facial Mask', 'Xpel Body Care', 'Body & Beauty', 2200, 70, 'CH-MASK-1', 'Black tissue charcoal detox facial mask — anti-blemish, revitalising, purifying. With charcoal & hyaluronic acid.', '', true),
('Activated Charcoal Whitening Mouthwash', 'Xpel Oral Care', 'Travel & Health', 3200, 50, 'CH-MOUTH-500', 'Activated charcoal whitening mouthwash for deep stain removal — helps reduce stains, plaque and germs. 500ml.', '', true),
('Cleansing Charcoal Toothpaste (Free Toothbrush)', 'Xpel Oral Care', 'Travel & Health', 2500, 60, 'CH-PASTE-100', 'Cleansing charcoal toothpaste with free toothbrush. 100ml.', '', true),

-- ── Fresh Start Shower Gels ──
('Fresh Start Tea Tree & Lemon Shower Gel', 'Fresh Start', 'Body & Beauty', 2500, 70, 'FS-SG-TTL', 'Invigorating tea tree & lemon shower gel with essential oils.', '', true),
('Fresh Start Coconut & Lime Shower Gel', 'Fresh Start', 'Body & Beauty', 2500, 70, 'FS-SG-CL', 'Moisturising coconut & lime shower gel with essential oils.', '', true),
('Fresh Start Mint & Cucumber Shower Gel', 'Fresh Start', 'Body & Beauty', 2500, 70, 'FS-SG-MC', 'Refreshing mint & cucumber shower gel with essential oils.', '', true),

-- ── Vitamin C (XBC) ──
('Vitamin C Facial Wipes', 'Xpel Beauty Care', 'Body & Beauty', 3000, 60, 'VC-WIPE-25', 'Facial wipes with revitalizing vitamin C. Vegan friendly. 25 wipes.', '', true),
('Vitamin C Exfoliating Facial Scrub', 'Xpel Beauty Care', 'Body & Beauty', 3800, 50, 'VC-SCRB-250', 'Exfoliating facial scrub — gently exfoliates to reveal brighter skin. With vitamin C and niacinamide. 250ml.', '', true),
('Vitamin C Foaming Face Wash', 'Xpel Beauty Care', 'Body & Beauty', 3800, 50, 'VC-FOAM-200', 'Foaming face wash for daily use — clean, fresh skin. With vitamin C and niacinamide. Vegan. 200ml.', '', true),
('Vitamin C Face Serum', 'Xpel Beauty Care', 'Body & Beauty', 5500, 35, 'VC-SER-30', 'Face serum — helps boost skin''s natural radiance. With vitamin C and niacinamide.', '', true),
('Vitamin C Salt Body Scrub', 'Xpel Beauty Care', 'Body & Beauty', 4200, 45, 'VC-SALT-300', 'Salt body scrub — gently exfoliates to reveal brighter, smoother skin. With vitamin C and niacinamide. Vegan.', '', true),

-- ── So Fresh Watermelon Crush (XBC) ──
('So Fresh Watermelon Crush Pore-Tight Toner', 'Xpel Beauty Care', 'Body & Beauty', 3500, 50, 'SF-TONE-200', 'Pore-tight toner — calms, soothes and reduces the look of pores. Watermelon extract with vitamin C, E + aloe vera. 200ml.', '', true),
('So Fresh Watermelon Crush Gel Moisturiser', 'Xpel Beauty Care', 'Body & Beauty', 3800, 50, 'SF-GEL-50', 'Fast-absorbing gel moisturiser — leaves skin refreshed. Hydrating hyaluronic acid + watermelon extract.', '', true),
('So Fresh Watermelon Crush Daily Facial Scrub', 'Xpel Beauty Care', 'Body & Beauty', 3500, 50, 'SF-SCRB-100', 'Daily facial scrub — gently buffs away dead cells leaving skin brighter & refreshed. 100ml.', '', true),
('So Fresh Watermelon Crush Sheet Mask', 'Xpel Beauty Care', 'Body & Beauty', 2200, 70, 'SF-MASK-1', 'Plant-based hydrating sheet mask — moisturises, soothes & hydrates. Watermelon extract + vitamin B5.', '', true),

-- ── Rosemary & Mint (XHC) ──
('Rosemary & Mint Hair Oil', 'Xpel Hair Care', 'Hair Care', 4000, 45, 'RM-OIL-60', 'Hair oil with natural oils — daily use, helps smooth split ends and dry scalp. 60ml.', '', true),
('Rosemary & Mint Conditioner', 'Xpel Hair Care', 'Hair Care', 3800, 45, 'RM-COND-300', 'Conditioner with rosemary oil & mint — enhances natural shine and smooths split ends. Vegan. 300ml.', '', true),
('Rosemary & Mint Shampoo', 'Xpel Hair Care', 'Hair Care', 3800, 45, 'RM-SHMP-300', 'Shampoo with rosemary oil & mint — supports healthier hair, cleanses and refreshes the scalp. Vegan. 300ml.', '', true),

-- ── Argan Oil (XHC / XBC) ──
('Argan Oil Hair Treatment', 'Argan Oil', 'Hair Care', 4500, 45, 'AO-TRT-100', 'Hair treatment with Moroccan argan oil — adds shine, vitamin E, repairs. 100ml.', '', true),
('Argan Oil Conditioner', 'Argan Oil', 'Hair Care', 4000, 45, 'AO-COND-300', 'Conditioner with Moroccan argan oil — hydrates and leaves hair shiny & smooth. Vegan. 300ml.', '', true),
('Argan Oil Hydrating Hair Mask', 'Argan Oil', 'Hair Care', 4800, 40, 'AO-MASK-350', 'Hydrating hair mask with Moroccan argan oil — leaves hair shiny & smooth. Vegan. 350ml.', '', true),
('Argan Oil Heat Defence Leave-In Spray', 'Argan Oil', 'Hair Care', 4500, 40, 'AO-HEAT-150', 'Heat defence leave-in spray with Moroccan argan oil — conditions and defends against damage. 150ml.', '', true),
('Argan Oil Facial Wipes (Twin Pack)', 'Argan Oil', 'Body & Beauty', 3000, 60, 'AO-WIPE-25', 'Facial wipes with Moroccan argan oil extracts — cleansing & moisturising. 25 wipes, twin pack.', '', true);

-- 3) Verify
SELECT category, COUNT(*) FROM products GROUP BY category ORDER BY category;
SELECT COUNT(*) AS total_products FROM products;

-- ============================================================
-- 4) Attach real product photos (from /public/Img) — confirmed mappings
-- ============================================================
UPDATE products SET image='/Img/40155_HERO.webp'                       WHERE name='Tea Tree Anti-Bacterial Handwash';
UPDATE products SET image='/Img/40158_HERO.webp'                       WHERE name='Tea Tree Daily Cleansing Facial Wipes (Twin Pack)';
UPDATE products SET image='/Img/40322_HERO.webp'                       WHERE name='Tea Tree Moisturising Conditioner';
UPDATE products SET image='/Img/40862_HERO.webp'                       WHERE name='Tea Tree Cleansing Pads';
UPDATE products SET image='/Img/41440_HERO.webp'                       WHERE name='Tea Tree Facial Toner';
UPDATE products SET image='/Img/40167_HERO.webp'                       WHERE name='Argan Oil Hair Treatment';
UPDATE products SET image='/Img/40184_HERO.webp'                       WHERE name='Argan Oil Conditioner';
UPDATE products SET image='/Img/40198_HERO.webp'                       WHERE name='Argan Oil Heat Defence Leave-In Spray';
UPDATE products SET image='/Img/41541_HERO.webp'                       WHERE name='Argan Oil Facial Wipes (Twin Pack)';

-- New products that have an official photo but weren't in the catalogue yet
INSERT INTO products (name, brand, category, price, stock, sku, description, image, active) VALUES
('Tea Tree Essential Oil', 'Tea Tree', 'Body & Beauty', 3500, 50, 'TT-OIL-30', 'Pure tea tree essential oil for skin. Multipurpose, soothing and purifying.', '/Img/40145_HERO.webp', true),
('Tea Tree & Peppermint Deep Moisturising Hand Pack', 'Tea Tree', 'Body & Beauty', 2500, 60, 'TT-HAND-PK', 'Deep moisturising hand pack — deeply penetrates and moisturises to help repair dry hands. 1 treatment.', '/Img/40050_HERO-removebg-preview.png', true),
('Argan Oil Shampoo', 'Argan Oil', 'Hair Care', 4500, 45, 'AO-SHMP-300', 'Shampoo with Moroccan argan oil — nourishes and adds shine. 300ml.', '/images/product-40183.png', true),
('Aloe Vera Botanical Vegan Shampoo', 'Xpel Hair Care', 'Hair Care', 4000, 45, 'AV-SHMP-400', 'Botanical vegan shampoo with aloe vera — gentle cleansing for soft, shiny hair. 400ml.', '/Img/XHC-Botanical-Vegan-Shampoo-Aloe-Vera-400ml-No-Banner-removebg-preview.png', true)
ON CONFLICT (sku) DO UPDATE SET image = EXCLUDED.image;

SELECT name, image FROM products WHERE image LIKE '/Img/%' OR image LIKE '/images/%';
