-- ============================================================
-- COMPLETE CATALOGUE: All products with correct images
-- Run in Supabase SQL Editor — clears everything and rebuilds
-- ============================================================

DELETE FROM products;

INSERT INTO products (name, brand, category, price, stock, sku, description, image, active) VALUES

-- ── XBC VITAMIN C ──
('Vitamin C Face Serum',                              'Xpel Beauty Care', 'Body & Beauty',  5500, 35, 'VC-SER-30',    'Face serum — helps boost skin natural radiance. With vitamin C and niacinamide.',                                   '/Img/Photoroom-20260610_083248_4.png',  true),
('Vitamin C Foaming Face Wash',                       'Xpel Beauty Care', 'Body & Beauty',  3800, 50, 'VC-FOAM-200',  'Foaming face wash for daily use — clean, fresh skin. With vitamin C and niacinamide. Vegan. 200ml.',                '/Img/Photoroom-20260610_083248_5.png',  true),
('Vitamin C Revitalising Face Mask',                  'Xpel Beauty Care', 'Body & Beauty',  2500, 60, 'VC-MASK-1',    'Revitalising face mask with vitamin C and niacinamide. Vegan, plastic-free sheet.',                              '/Img/Photoroom-20260610_083248_6.png',  true),
('Vitamin C Exfoliating Facial Scrub',                'Xpel Beauty Care', 'Body & Beauty',  3800, 50, 'VC-SCRB-250',  'Exfoliating facial scrub — gently exfoliates to reveal brighter skin. 250ml.',                                  '/Img/Vitamin C Exfoliating Facial Scrub.png', true),
('Vitamin C Salt Body Scrub',                         'Xpel Beauty Care', 'Body & Beauty',  4200, 45, 'VC-SALT-300',  'Salt body scrub — gently exfoliates for brighter, smoother skin. With vitamin C. Vegan.',                        '/Img/Vitamin C Salt Body Scrub.png',          true),
('Vitamin C Facial Wipes',                            'Xpel Beauty Care', 'Body & Beauty',  3000, 60, 'VC-WIPE-25',   'Facial wipes with revitalizing vitamin C. Vegan friendly. 25 wipes.',                                           '/Img/Vitamin C Facial Wipes.png',             true),

-- ── XBC PAPAYA ──
('Papaya Cleansing Face Wash',                        'Xpel Body Care',   'Body & Beauty',  3500, 50, 'PP-WASH-250',  'Cleansing face wash with papaya extracts — cleanses and refreshes skin for a healthy glow. 250ml.',              '/Img/Photoroom-20260610_083249_61.png', true),
('Papaya Hydrating Face Mask',                        'Xpel Beauty Care', 'Body & Beauty',  2500, 60, 'PP-MASK-1',    'Hydrating face mask with papaya fruit extract and hyaluronic acid. Vegan, plastic-free sheet.',                  '/Img/Photoroom-20260610_083249_71.png', true),

-- ── XBC NEEM OIL ──
('Neem Oil Exfoliating Foaming Face Wash',            'Xpel Body Care',   'Body & Beauty',  3800, 45, 'NM-FOAM-200',  'Exfoliating foaming face wash with neem oil — transforms skin, reduces blemishes. 200ml.',                      '/Img/Photoroom-20260610_083250_75.png', true),

-- ── TEA TREE (XPEL) ──
('Tea Tree & Peppermint Deep Moisturising Foot Pack', 'Tea Tree',         'Body & Beauty',  2500, 60, 'TT-FOOT-30',   'Deep moisturising foot pack — leaves feet feeling soft and smooth. 30ml.',                                     '/Img/40050_HERO-removebg-preview.png',  true),
('Tea Tree Anti-Bacterial Handwash',                  'Tea Tree',         'Body & Beauty',  2800, 80, 'TT-HAND-500',  'Anti-bacterial handwash for clean, healthy hands. 500ml.',                                                     '/Img/40155_HERO.webp',                  true),
('Tea Tree Daily Cleansing Facial Wipes (Twin Pack)', 'Tea Tree',         'Body & Beauty',  3000, 70, 'TT-WIPE-25',   'Daily use cleansing facial wipes for clean healthy skin. 25 wipes, twin pack.',                               '/Img/40158_HERO.webp',                  true),
('Tea Tree Foaming Face Wash',                        'Tea Tree',         'Body & Beauty',  3500, 55, 'TT-FOAM-200',  'Daily cleansing foaming face wash for clean healthy skin. 200ml.',                                             '/Img/40862_HERO.webp',                  true),
('Tea Tree Moisturising Conditioner',                 'Xpel Hair Care',   'Hair Care',      3500, 50, 'TT-COND-400',  'Moisturising conditioner for frequent use. 400ml.',                                                            '/Img/40322_HERO.webp',                  true),
('Tea Tree Cleansing Pads',                           'Xpel Hair Care',   'Body & Beauty',  3200, 60, 'TT-PAD-60',    'Cleansing pads with natural tea tree oil — smooths and deeply cleanses. 60 pads.',                             '/Img/40862_HERO.webp',                  true),
('Tea Tree Facial Toner',                             'Xpel Body Care',   'Body & Beauty',  3000, 55, 'TT-TONE-200',  'Facial toner — soothe, calm and cleanse your skin for a healthy glow. 200ml.',                                '/Img/41440_HERO.webp',                  true),
('Tea Tree Essential Oil',                            'Tea Tree',         'Body & Beauty',  3500, 50, 'TT-OIL-30',    'Pure tea tree essential oil for skin. Multipurpose, soothing and purifying.',                                  '/Img/40145_HERO.webp',                  true),

-- ── ALOE VERA (XPEL) ──
('Aloe Vera Conditioner',                             'Xpel Hair Care',   'Hair Care',      3500, 50, 'AV-COND-250',  'Conditioner for smooth & shiny hair. 250ml.',                                                                  '/Img/Photoroom-20260610_083250_80.png', true),
('Aloe Vera Nourishing Leave-In Conditioner',         'Xpel Hair Care',   'Hair Care',      4000, 45, 'AV-LEAV-250',  'Leave-in conditioner with aloe vera and pro-vitamin B5 — leaves hair soft and silky. Vegan. 250ml.',          '/Img/Photoroom-20260610_083250_81.png', true),
('Aloe Vera Cooling Gel',                             'Xpel Body Care',   'Body & Beauty',  2800, 60, 'AV-GEL-250',   'Cooling aloe vera gel — soothes, moisturises and restores dry and sun-exposed skin. 250ml.',                   '/Img/Photoroom-20260610_083250_82.png', true),
('Aloe Vera Nourishing Face Mask',                    'Xpel Beauty Care', 'Body & Beauty',  2200, 70, 'AV-MASK-1',    'Nourishing face mask with aloe vera extract and hyaluronic acid. Vegan, plastic-free sheet.',                  '/Img/Photoroom-20260610_083250_83.png', true),
('Aloe Vera Heat Defence Spray',                      'Xpel Hair Care',   'Hair Care',      4200, 45, 'AV-HEAT-150',  'Styling formula that helps hydrate and defend against heat-styling damage. 150ml.',                            '/Img/Photoroom-20260610_083250_80.png', true),
('Aloe Vera Cleansing Facial Wipes (Twin Pack)',      'Xpel Beauty Care', 'Body & Beauty',  3000, 60, 'AV-WIPE-25',   'Cleansing facial wipes with hydrating aloe vera. 25 wipes, twin pack.',                                       '/Img/Photoroom-20260610_083250_83.png', true),
('Aloe Vera Botanical Vegan Shampoo',                 'Xpel Hair Care',   'Hair Care',      4000, 45, 'AV-SHMP-400',  'Botanical vegan shampoo with aloe vera — gentle cleansing for soft, shiny hair. 400ml.',                      '/Img/XHC-Botanical-Vegan-Shampoo-Aloe-Vera-400ml-No-Banner-removebg-preview.png', true),
('Aloe Vera Face Toner',                              'Xpel Body Care',   'Body & Beauty',  3000, 55, 'AV-TONE-200',  'Soothing aloe vera face toner — calms, hydrates and preps skin for moisture. Vegan. 200ml.',                   '/Img/Aloe Vera Face Toner.png',          true),
('Aloe Vera Face & Body Wash',                        'Xpel Body Care',   'Body & Beauty',  3000, 60, 'AV-WASH-250',  'Gentle aloe vera face and body wash — cleanses, soothes and softens skin. Vegan. 250ml.',                     '/Img/Aloe face and body wash.png',       true),

-- ── BLACK CASTOR OIL & AVOCADO ──
('Black Castor Oil & Avocado Leave-In Conditioner',   'Xpel Hair Care',   'Hair Care',      4500, 40, 'BC-LEAV-250',  'Leave-in conditioner with black castor and avocado oil — detangles, adds moisture. 250ml.',                    '/Img/Black Castor Oil & Avocado Leave-In Conditioner.png',   true),
('Black Castor Oil & Avocado Shampoo',                'Xpel Hair Care',   'Hair Care',      4500, 40, 'BC-SHMP-400',  'Shampoo with black castor and avocado oil — cleanses, nourishes and boosts shine. 400ml.',                     '/Img/Black Castor Oil & Avocado Shampoo.png',                true),
('Black Castor Oil & Avocado Heat Defence Spray',     'Xpel Hair Care',   'Hair Care',      4500, 40, 'BC-HEAT-150',  'Heat defence styling spray with black castor oil and avocado extract. 150ml.',                                '/Img/Black Castor Oil & Avocado Heat Defence Spray.png',     true),
('Black Castor Oil & Avocado Hair & Scalp Treatment', 'Xpel Hair Care',   'Hair Care',      4800, 35, 'BC-TRT-150',   'Hair & scalp treatment with hyaluronic acid to maintain moisture and condition the scalp. 150ml.',            '/Img/Black Castor Oil & Avocado Hair & Scalp Treatment.png', true),

-- ── CHARCOAL (XPEL) ──
('Purifying Charcoal Cleansing Wipes',                'Xpel Body Care',   'Body & Beauty',  2800, 60, 'CH-WIPE-25',   'Daily use charcoal cleansing wipes — revitalising and purifying. 25 wipes.',                                   '/Img/Purifying Charcoal Cleansing Wipes.png',          true),
('Cleansing Charcoal Face Scrub',                     'Xpel Body Care',   'Body & Beauty',  3500, 50, 'CH-SCRB-250',  'Cleansing, revitalising and purifying charcoal face scrub. Paraben & sulfate free. 250ml.',                    '/Img/Cleansing Charcoal Face Scrub.jpg',               true),
('Black Tissue Charcoal Detox Facial Mask',           'Xpel Body Care',   'Body & Beauty',  2200, 70, 'CH-MASK-1',    'Black tissue charcoal detox facial mask — anti-blemish, revitalising, purifying.',                              '/Img/Black Tissue Charcoal Detox Facial Mask.png',    true),
('Cleansing Charcoal Toothpaste (Free Toothbrush)',   'Xpel Oral Care',   'Travel & Health',2500, 60, 'CH-PASTE-100', 'Cleansing charcoal toothpaste with free toothbrush. 100ml.',                                                   '/Img/Photoroom-20260610_083248_12.png',                true),

-- ── ROSEMARY & MINT (XHC) ──
('Rosemary & Mint Hair Oil',                          'Xpel Hair Care',   'Hair Care',      4000, 45, 'RM-OIL-60',    'Hair oil with natural oils — daily use, helps smooth split ends and dry scalp. 60ml.',                         '/Img/Photoroom-20260610_083249_63.png', true),
('Rosemary & Mint Conditioner',                       'Xpel Hair Care',   'Hair Care',      3800, 45, 'RM-COND-300',  'Conditioner with rosemary oil & mint — enhances natural shine and smooths split ends. Vegan. 300ml.',          '/Img/Photoroom-20260610_083249_64.png', true),
('Rosemary & Mint Shampoo',                           'Xpel Hair Care',   'Hair Care',      3800, 45, 'RM-SHMP-300',  'Shampoo with rosemary oil & mint — supports healthier hair, cleanses and refreshes the scalp. Vegan. 300ml.',  '/Img/Photoroom-20260610_083249_68.png', true),

-- ── ARGAN OIL (XPEL) ──
('Argan Oil Hair Treatment',                          'Argan Oil',        'Hair Care',      4500, 45, 'AO-TRT-100',   'Hair treatment with Moroccan argan oil — adds shine, vitamin E, repairs. 100ml.',                              '/Img/40167_HERO.webp',                  true),
('Argan Oil Conditioner',                             'Argan Oil',        'Hair Care',      4000, 45, 'AO-COND-300',  'Conditioner with Moroccan argan oil — hydrates and leaves hair shiny & smooth. Vegan. 300ml.',                '/Img/40184_HERO.webp',                  true),
('Argan Oil Hydrating Hair Mask',                     'Argan Oil',        'Hair Care',      4800, 40, 'AO-MASK-350',  'Hydrating hair mask with Moroccan argan oil — leaves hair shiny & smooth. Vegan. 350ml.',                    '/Img/Argan Oil Hydrating Hair Mask.webp', true),
('Argan Oil Heat Defence Leave-In Spray',             'Argan Oil',        'Hair Care',      4500, 40, 'AO-HEAT-150',  'Heat defence leave-in spray with Moroccan argan oil — conditions and defends against damage. 150ml.',         '/Img/40198_HERO.webp',                  true),
('Argan Oil Facial Wipes (Twin Pack)',                'Argan Oil',        'Body & Beauty',  3000, 60, 'AO-WIPE-25',   'Facial wipes with Moroccan argan oil extracts — cleansing & moisturising. 25 wipes, twin pack.',              '/Img/41541_HERO.webp',                  true),
('Argan Oil Shampoo',                                 'Argan Oil',        'Hair Care',      4500, 45, 'AO-SHMP-300',  'Shampoo with Moroccan argan oil — nourishes and adds shine. 300ml.',                                          '/Img/argan oil shampoo.webp',           true),

-- ── FRESH START SHOWER GELS ──
('Fresh Start Tea Tree & Lemon Shower Gel',           'Fresh Start',      'Body & Beauty',  2500, 70, 'FS-SG-TTL',    'Invigorating tea tree & lemon shower gel with essential oils.',                                               '/Img/Photoroom-20260610_083249_62.png', true),
('Fresh Start Mint & Cucumber Shower Gel',            'Fresh Start',      'Body & Beauty',  2500, 70, 'FS-SG-MC',     'Refreshing mint & cucumber shower gel with essential oils.',                                                  '/Img/Photoroom-20260610_083249_65.png', true),
('Fresh Start Coconut & Lime Shower Gel',             'Fresh Start',      'Body & Beauty',  2500, 70, 'FS-SG-CL',     'Moisturising coconut & lime shower gel with essential oils.',                                                 '/Img/Photoroom-20260610_083249_62.png', true),

-- ── SO FRESH WATERMELON CRUSH ──
('So Fresh Watermelon Crush Pore-Tight Toner',        'Xpel Beauty Care', 'Body & Beauty',  3500, 50, 'SF-TONE-200',  'Pore-tight toner — calms, soothes and reduces the look of pores. 200ml.',                                    '/Img/Photoroom-20260610_083250_72.png', true),
('So Fresh Watermelon Crush Gel Moisturiser',         'Xpel Beauty Care', 'Body & Beauty',  3800, 50, 'SF-GEL-50',    'Fast-absorbing gel moisturiser — leaves skin refreshed. Hyaluronic acid + watermelon extract.',               '/Img/Photoroom-20260610_083250_73.png', true),
('So Fresh Watermelon Crush Daily Facial Scrub',      'Xpel Beauty Care', 'Body & Beauty',  3500, 50, 'SF-SCRB-100',  'Daily facial scrub — gently buffs away dead cells leaving skin brighter & refreshed. 100ml.',                '/Img/Photoroom-20260610_083250_74.png', true),
('So Fresh Watermelon Crush Sheet Mask',              'Xpel Beauty Care', 'Body & Beauty',  2200, 70, 'SF-MASK-1',    'Plant-based hydrating sheet mask — moisturises, soothes & hydrates. Watermelon extract + vitamin B5.',       '/Img/Photoroom-20260610_083250_77.png', true),

-- ── XOC ORAL CARE ──
('Purple Whitening Toothpaste (Free Bamboo Toothbrush)', 'Xpel Oral Care', 'Travel & Health',3500, 50, 'XOC-PURP-100', 'Purple colour corrector toothpaste — helps correct yellow stains, polishing formula whitens teeth. 100ml.',   '/Img/Photoroom-20260610_083249_66.png', true),
('Purple Whitening Mouthwash',                        'Xpel Oral Care',   'Travel & Health',3200, 50, 'XOC-PMTH-500', 'Purple whitening mouthwash — freshens breath, helps prevent stains, reduces plaque. 500ml.',                  '/Img/Photoroom-20260610_083249_69.png', true),
('Purple Polishing Tooth Powder',                     'Xpel Oral Care',   'Travel & Health',2800, 60, 'XOC-PPWD-1',   'Purple polishing tooth powder for whiter teeth — colour correction technology.',                              '/Img/Photoroom-20260610_083249_70.png', true),
('Neem Oil & Mint Toothpaste (Free Toothbrush)',      'Xpel Oral Care',   'Travel & Health',2800, 60, 'XOC-NEEM-100', 'Neem oil & mint toothpaste — combats bad breath, prevents cavities, has anti-bacterial properties. 100ml.',   '/Img/Photoroom-20260610_083250_78.png', true),
('Activated Charcoal Whitening Mouthwash',            'Xpel Oral Care',   'Travel & Health',3200, 50, 'CH-MOUTH-500', 'Activated charcoal whitening mouthwash for deep stain removal. 500ml.',                                       '/Img/Activated Charcoal Whitening Mouthwash.png',     true),

-- ── TRUESMILE TOOTHPASTE RANGE ──
('TrueSmile Tartar Defence Toothpaste & Toothbrush',  'TrueSmile',        'Travel & Health',2800, 60, 'TS-TART-100',  'Tartar defence fluoride toothpaste with toothbrush — fights tartar for whiter teeth. 100ml.',                '/Img/Photoroom-20260610_083248_1.png',  true),
('TrueSmile Triple Protect Toothpaste & Toothbrush',  'TrueSmile',        'Travel & Health',2800, 60, 'TS-TRIP-100',  'Triple protect toothpaste — clean gums, healthy teeth, fresh breath. Total protection. 100ml.',             '/Img/Photoroom-20260610_083248_2.png',  true),
('TrueSmile ProPurple Toothpaste & Toothbrush',       'TrueSmile',        'Travel & Health',3200, 50, 'TS-PURP-100',  'ProPurple toothpaste with colour corrector — purple reveal formula for whiter looking teeth. 100ml.',        '/Img/Photoroom-20260610_083248_3.png',  true),
('Sensio Enamel Restore Toothpaste',                  'TrueSmile',        'Travel & Health',3000, 50, 'TS-ENAM-75',   'Enamel restore fluoride toothpaste — helps restore & reduce sensitivity. Cool mint. 75ml.',                  '/Img/Photoroom-20260610_083248_7.png',  true),
('Sensio Gentle Whitening Toothpaste',                'TrueSmile',        'Travel & Health',3000, 50, 'TS-GWHT-75',   'Sensio gentle whitening toothpaste — helps restore natural whiteness. Cool mint. 75ml.',                     '/Img/Photoroom-20260610_083248_8.png',  true),
('Sensio Instant Relief Toothpaste',                  'TrueSmile',        'Travel & Health',3000, 50, 'TS-IREL-75',   'Sensio instant relief toothpaste — helps relieve sensitivity pain fast. Fresh mint. 75ml.',                  '/Img/Photoroom-20260610_083248_9.png',  true),
('Sensio Sensitivity + Gum Twin Pack',                'TrueSmile',        'Travel & Health',5500, 35, 'TS-SGUM-2X75', 'Sensio sensitivity + gum fluoride toothpaste — soothe & strengthen gums. Twin pack 2x75ml.',                  '/Img/Photoroom-20260610_083248_10.png', true),
('TrueSmile Monster Kids Bubble Gum Toothpaste',      'TrueSmile',        'Travel & Health',2500, 70, 'TS-MKBG-100',  'Monster Kids bubble gum flavour toothpaste with fluoride and free toothbrush. Fun for kids!',                 '/Img/Photoroom-20260610_083248_11.png', true),
('TrueSmile Charcoal Natural Whitening Toothpaste',   'TrueSmile',        'Travel & Health',3200, 50, 'TS-CHAR-100',  'Charcoal natural whitening toothpaste with activated carbon and free toothbrush. 100ml.',                    '/Img/Photoroom-20260610_083248_12.png', true),
('TrueSmile Baking Soda Whitening Toothpaste',        'TrueSmile',        'Travel & Health',2800, 60, 'TS-BSOD-100',  'Baking soda whitening toothpaste — helps prevent stains, extra whitening with free toothbrush. 100ml.',      '/Img/Photoroom-20260610_083248_13.png', true),
('TrueSmile Monster Kids Strawberry Toothpaste',      'TrueSmile',        'Travel & Health',2500, 70, 'TS-MKST-100',  'Monster Kids strawberry flavour toothpaste with fluoride and free toothbrush. Fun for kids!',                 '/Img/Photoroom-20260610_083248_14.png', true),
('TrueSmile ProClean Toothpaste & Toothbrush',        'TrueSmile',        'Travel & Health',3000, 50, 'TS-PRCL-100',  'ProClean toothpaste with cooling crystals — extreme clean formula. 100ml.',                                   '/Img/Photoroom-20260610_083248_15.png', true),
('TrueSmile ProCare Toothpaste & Toothbrush',         'TrueSmile',        'Travel & Health',3000, 50, 'TS-PRCA-100',  'ProCare toothpaste with cavity protection — complete care formula. 100ml.',                                   '/Img/Photoroom-20260610_083248_16.png', true),
('TrueSmile ProWhite Toothpaste & Toothbrush',        'TrueSmile',        'Travel & Health',3200, 50, 'TS-PRWH-100',  'ProWhite toothpaste with sodium phytate — advanced whitening formula. 100ml.',                               '/Img/Photoroom-20260610_083248_17.png', true),

-- ── INTIMELLE ──
('Intimelle Aloe Vera Daily Feminine Wash',           'Intimelle',        'Body & Beauty',  3500, 50, 'IN-FEM-250',   'Daily feminine wash with aloe vera — soap free, pH balanced, hypo-allergenic. Gentle cleansing formula. 250ml.', '/Img/Photoroom-20260610_083248_18.png', true),

-- ── HOT ROSE LIP BUTTER ──
('Hot Rose Lip Butter Cherry Pie',                    'Hot Rose',         'Body & Beauty',  2500, 60, 'HR-LBCP-15',   'Nourishing lip butter in Cherry Pie flavour — moisturises and conditions lips. 15ml.',                         '/Img/Photoroom-20260610_083248_21.png', true),
('Hot Rose Lip Butter Peach Macaron',                 'Hot Rose',         'Body & Beauty',  2500, 60, 'HR-LBPM-15',   'Nourishing lip butter in Peach Macaron flavour — moisturises and conditions lips. 15ml.',                     '/Img/Photoroom-20260610_083249_60.png', true),

-- ── HOT ROSE FIXT SETTING SPRAYS ──
('Hot Rose Fixt Vit C Setting Spray',                 'Hot Rose',         'Body & Beauty',  4500, 40, 'HR-FVCS-1',    'Vitamin C energising setting spray — Tuscan Cypress + Mandarin. Locks in makeup all day.',                   '/Img/Photoroom-20260610_083248_20.png', true),
('Hot Rose Fixt Dewy Setting Spray',                  'Hot Rose',         'Body & Beauty',  4500, 40, 'HR-FDSS-1',    'Dewy setting spray — Lychee + Damask Rose Hydrosol. Ultra glow finish.',                                    '/Img/Photoroom-20260610_083248_22.png', true),
('Hot Rose Fixt Matte Setting Spray',                 'Hot Rose',         'Body & Beauty',  4500, 40, 'HR-FMSS-1',    'Matte setting spray — Vetiver Root + Squalane. All night long-lasting matte finish.',                       '/Img/Photoroom-20260610_083248_25.png', true),

-- ── HOT ROSE SKIN CAPSULE SERUMS ──
('Hot Rose Hyaluronic Acid Skin Capsule Serum',       'Hot Rose',         'Body & Beauty',  5500, 35, 'HR-SKHA-1',    'Hyaluronic acid skin capsule serum — multi-molecular formula plumps, hydrates, and smoothes skin.',          '/Img/Photoroom-20260610_083249_34.png', true),
('Hot Rose Vitamin C Glow Skin Capsule Serum',        'Hot Rose',         'Body & Beauty',  5500, 35, 'HR-SKVC-1',    'Vitamin C glow skin capsule serum — radiance boost, brightens and evens skin tone.',                         '/Img/Photoroom-20260610_083249_35.png', true),
('Hot Rose Vitamin E Antioxidant Skin Capsule Serum', 'Hot Rose',         'Body & Beauty',  5500, 35, 'HR-SKVE-1',    'Vitamin E antioxidant skin capsule serum — barrier repair, calming capsules.',                               '/Img/Photoroom-20260610_083249_37.png', true),
('Hot Rose Niacinamide Clarifying Skin Capsule Serum','Hot Rose',         'Body & Beauty',  5500, 35, 'HR-SKNM-1',    'Niacinamide clarifying skin capsule serum — pore care, oil control beads.',                                  '/Img/Photoroom-20260610_083249_39.png', true),

-- ── HOT ROSE MIXT DUO MAKEUP REMOVER ──
('Hot Rose Mixt Duo Makeup Remover Lychee & Rosewater', 'Hot Rose',       'Body & Beauty',  3800, 45, 'HR-MXLR-1',    'Duo makeup remover with lychee + rosewater — vitamin C formula. Removes all makeup gently.',                 '/Img/Photoroom-20260610_083249_56.png', true),
('Hot Rose Mixt Duo Makeup Remover Cucumber & Mint',  'Hot Rose',         'Body & Beauty',  3800, 45, 'HR-MXCM-1',    'Duo makeup remover with cucumber + wild mint — vitamin E formula. Refreshing gentle formula.',               '/Img/Photoroom-20260610_083249_58.png', true),
('Hot Rose Mixt Duo Makeup Remover Neroli & Mandarin','Hot Rose',         'Body & Beauty',  3800, 45, 'HR-MXNM-1',    'Duo makeup remover with neroli + mandarin — vitamin C formula. Brightening gentle formula.',                 '/Img/Photoroom-20260610_083249_59.png', true),

-- ── HOT ROSE SERENA SERUM DEODORANT ──
('Hot Rose Serena Serum Deodorant Twilight Dream',    'Hot Rose',         'Body & Beauty',  4000, 45, 'HR-SDTD-1',    'Serena serum deodorant in Twilight Dream (Santal + Cedarwood) — +5% AHA, aluminium-free.',                  '/Img/Photoroom-20260610_083249_46.png', true),
('Hot Rose Serena Serum Deodorant Tropical Green',    'Hot Rose',         'Body & Beauty',  4000, 45, 'HR-SDTG-1',    'Serena serum deodorant in Tropical Green (Bergamot + Green Fig) — +5% AHA, aluminium-free.',                '/Img/Photoroom-20260610_083249_47.png', true),
('Hot Rose Serena Serum Deodorant Blue Shell',        'Hot Rose',         'Body & Beauty',  4000, 45, 'HR-SDBS-1',    'Serena serum deodorant in Blue Shell (Seasalt + Driftwood) — +5% AHA, aluminium-free.',                    '/Img/Photoroom-20260610_083249_49.png', true),
('Hot Rose Serena Serum Deodorant First Bloom',       'Hot Rose',         'Body & Beauty',  4000, 45, 'HR-SDFB-1',    'Serena serum deodorant in First Bloom (Vanilla + Almond) — +5% AHA, aluminium-free.',                      '/Img/Photoroom-20260610_083249_50.png', true),

-- ── NULAB FEELIN DEODORANTS ──
('Nulab Feelin Bliss Roll-On Deodorant',              'Nulab',            'Body & Beauty',  3000, 60, 'NL-FBRO-50',   'Feelin Bliss 48h anti-perspirant roll-on — pomegranate & lotus. 0% alcohol. 50ml.',                          '/Img/Photoroom-20260610_083248_23.png', true),
('Nulab Feelin Bliss Stick Deodorant',                'Nulab',            'Body & Beauty',  3500, 50, 'NL-FBST-64',   'Feelin Bliss 48h anti-perspirant stick — pomegranate & lotus. 0% alcohol. 64g.',                            '/Img/Photoroom-20260610_083248_26.png', true),
('Nulab Feelin Bliss Mist Deodorant',                 'Nulab',            'Body & Beauty',  3000, 60, 'NL-FBMS-150',  'Feelin Bliss 24h mist deodorant — pomegranate & lotus. 0% alcohol, parabens, phthalates. 150ml.',           '/Img/Photoroom-20260610_083249_52.png', true),
('Nulab Feelin Fresh Roll-On Deodorant',              'Nulab',            'Body & Beauty',  3000, 60, 'NL-FFRO-50',   'Feelin Fresh 48h anti-perspirant roll-on — cucumber & jasmine. 0% alcohol. 50ml.',                         '/Img/Photoroom-20260610_083248_24.png', true),
('Nulab Feelin Fresh Mist Deodorant',                 'Nulab',            'Body & Beauty',  3000, 60, 'NL-FFMS-150',  'Feelin Fresh 24h mist deodorant — cucumber & jasmine. 0% alcohol, parabens, phthalates. 150ml.',           '/Img/Photoroom-20260610_083249_51.png', true),
('Nulab Feelin Zesty Roll-On Deodorant',              'Nulab',            'Body & Beauty',  3000, 60, 'NL-FZRO-50',   'Feelin Zesty 48h anti-perspirant roll-on — lemon. 0% alcohol. 50ml.',                                     '/Img/Photoroom-20260610_083249_27.png', true),
('Nulab Feelin Zesty Stick Deodorant',                'Nulab',            'Body & Beauty',  3500, 50, 'NL-FZST-64',   'Feelin Zesty 48h anti-perspirant stick — lemon. 0% alcohol. 64g.',                                        '/Img/Photoroom-20260610_083249_29.png', true),
('Nulab Feelin Zesty Mist Deodorant',                 'Nulab',            'Body & Beauty',  3000, 60, 'NL-FZMS-150',  'Feelin Zesty 24h mist deodorant — grapefruit & lemon zest. 0% alcohol, parabens, phthalates. 150ml.',      '/Img/Photoroom-20260610_083249_53.png', true),

-- ── NULAB MEN PROTECT ──
('Nulab Men Protect Adventure Roll-On',               'Nulab',            'Body & Beauty',  3200, 55, 'NL-MARO-50',   'Men Protect Adventure 48h anti-sweat roll-on — 0% alcohol anti-perspirant. 50ml.',                          '/Img/Photoroom-20260610_083249_28.png', true),
('Nulab Men Protect Adventure Stick',                 'Nulab',            'Body & Beauty',  3500, 50, 'NL-MAST-64',   'Men Protect Adventure 48h anti-sweat stick — 0% alcohol anti-perspirant. 64g.',                            '/Img/Photoroom-20260610_083249_30.png', true),
('Nulab Men Protect Extreme Dry Roll-On',             'Nulab',            'Body & Beauty',  3200, 55, 'NL-MERO-50',   'Men Protect Extreme Dry 48h anti-sweat roll-on — 0% alcohol. 50ml.',                                      '/Img/Photoroom-20260610_083249_31.png', true),
('Nulab Men Protect Extreme Dry Stick',               'Nulab',            'Body & Beauty',  3500, 50, 'NL-MEST-64',   'Men Protect Extreme Dry 48h anti-sweat stick — 0% alcohol. 64g.',                                        '/Img/Photoroom-20260610_083249_32.png', true),
('Nulab Men Protect Sport Cool Stick',                'Nulab',            'Body & Beauty',  3500, 50, 'NL-MSCS-64',   'Men Protect Sport Cool 48h anti-sweat stick — 0% alcohol anti-perspirant. 64g.',                          '/Img/Photoroom-20260610_083249_33.png', true),
('Nulab Men Protect Sport Cool Roll-On',              'Nulab',            'Body & Beauty',  3200, 55, 'NL-MSCR-50',   'Men Protect Sport Cool 48h anti-sweat roll-on — 0% alcohol anti-perspirant. 50ml.',                       '/Img/Photoroom-20260610_083249_36.png', true),

-- ── NULAB BODY & FACE ──
('Nulab Whole Body Cream Cocoa Butter',               'Nulab',            'Body & Beauty',  4500, 45, 'NL-WBCC-500',  'Whole Body Cream Cocoa Butter — 48hr moisturising, softens and relieves rough dry skin. 500ml.',            '/Img/Photoroom-20260610_083249_38.png', true),
('Nulab Whole Body Cream Vitamin C',                  'Nulab',            'Body & Beauty',  4500, 45, 'NL-WBCV-500',  'Whole Body Cream Vitamin C — 48hr moisturising, nourishes dry skin for visible radiance. 500ml.',           '/Img/Photoroom-20260610_083249_41.png', true),
('Nulab Whole Body Cream Olive Oil',                  'Nulab',            'Body & Beauty',  4500, 45, 'NL-WBCO-500',  'Whole Body Cream Olive Oil — 48hr moisturising, deeply moisturises and hydrates dry skin. 500ml.',         '/Img/Photoroom-20260610_083249_42.png', true),
('Nulab Whole Body Cream Vitamin E',                  'Nulab',            'Body & Beauty',  4500, 45, 'NL-WBCE-500',  'Whole Body Cream Vitamin E — 48hr moisturising, deeply nourishes and soothes dry skin. 500ml.',           '/Img/Photoroom-20260610_083250_79.png', true),
('Nulab Feelin Silky Skin Drenching Moisturising Cream', 'Nulab',         'Body & Beauty',  3800, 50, 'NL-FSMC-200',  'Feelin Silky skin drenching moisturising cream — with jojoba oil + vitamin E. For all day moisture. 200ml.', '/Img/Photoroom-20260610_083249_48.png', true),
('Nulab Q10 Radiance Night Cream',                    'Nulab',            'Body & Beauty',  5500, 35, 'NL-Q10N-1',    'Q10 Radiance firming anti-ageing night cream — 100% natural Q10, 24h moisture, peptide complex. 50ml.',     '/Img/Photoroom-20260610_083249_40.png', true),
('Nulab Q10 Radiance Day Cream',                      'Nulab',            'Body & Beauty',  5500, 35, 'NL-Q10D-1',    'Q10 Radiance firming anti-ageing day cream — 100% natural Q10, 24h moisture, peptide complex. 50ml.',      '/Img/Photoroom-20260610_083249_43.png', true),
('Nulab DreamLift Firming Anti-Wrinkle Night Cream',  'Nulab',            'Body & Beauty',  6500, 30, 'NL-DLNC-1',    'DreamLift firming anti-wrinkle night cream — restores skin structure, defines contours, reduces fine lines.', '/Img/Photoroom-20260610_083249_44.png', true),
('Nulab DreamLift Firming Anti-Wrinkle Day Cream',    'Nulab',            'Body & Beauty',  6500, 30, 'NL-DLDC-1',    'DreamLift firming anti-wrinkle day cream — restores skin structure, defines contours, reduces fine lines.',  '/Img/Photoroom-20260610_083249_45.png', true),

-- ── HYGIE HANDWASH ──
('Hygie Advanced Protection Citrus Handwash',         'Hygie',            'Body & Beauty',  2800, 70, 'HY-HCIT-500',  'Advanced protection anti-bacterial handwash in Citrus — clean, care & protect. 500ml.',                     '/Img/Photoroom-20260610_083249_54.png', true),
('Hygie Advanced Protection Aloe Vera Handwash',      'Hygie',            'Body & Beauty',  2800, 70, 'HY-HALV-500',  'Advanced protection anti-bacterial handwash with Aloe Vera — clean, care & protect. 500ml.',               '/Img/Photoroom-20260610_083249_55.png', true),
('Hygie Advanced Protection Original Handwash',       'Hygie',            'Body & Beauty',  2800, 70, 'HY-HORG-500',  'Advanced protection anti-bacterial handwash Original — clean, care & protect. 500ml.',                     '/Img/Photoroom-20260610_083249_57.png', true);

-- Verify
SELECT COUNT(*) AS total_products FROM products;
SELECT brand, COUNT(*) AS count FROM products GROUP BY brand ORDER BY brand;
