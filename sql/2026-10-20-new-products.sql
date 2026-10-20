-- Xpel Beauty NG product update (Hostinger / MySQL). Run once in phpMyAdmin on the live database.

UPDATE `products` SET `name` = 'Aloe Vera Body Wash (250ml)', `image` = '/Img/aloe-vera-body-wash-250ml.jpg', `size` = '250ml' WHERE `id` = 324;

INSERT INTO `products` (`id`,`name`,`brand`,`category`,`price`,`stock`,`sku`,`image`,`size`,`description`,`key_benefits`,`how_to_use`,`active`) VALUES
(382,'Aloe Vera Shampoo (250ml)','Aloe Vera','Hair Care',0,40,'AV-SHMP-250','/Img/aloe-vera-shampoo-250ml.jpg','250ml','Aloe vera shampoo for smooth and shiny hair. 250ml.','Enriched with aloe vera
Leaves hair smooth and shiny
Gentle enough for regular use','Massage into wet hair and scalp.
Rinse thoroughly.
Follow with conditioner.',1),
(383,'XBC Aloe Vera Face & Body Scrub','Xpel Body Care','Body & Beauty',0,40,'XBC-AVSCR-JAR','/Img/xbc-aloe-vera-face-body-scrub.jpg',NULL,'Aloe vera face and body scrub with aloe vera extracts - gently exfoliates for visibly brighter skin.','With aloe vera extracts
Gently exfoliates
For visibly brighter skin','Apply to damp skin using circular motions.
Avoid the eye area.
Rinse thoroughly. Use 2-3 times a week.',1),
(384,'Medex Aloe Vera Antibacterial Handwash (650ml)','Medex','Home',0,40,'MDX-AVHW-650','/Img/medex-aloe-vera-antibacterial-handwash-650ml.jpg','650ml','Medex clean and hygienic aloe vera antibacterial handwash. 650ml pump bottle with 30% extra free.','Antibacterial formula
With aloe vera
650ml - 30% extra free','Pump onto wet hands and lather.
Rinse thoroughly.',1),
(385,'Mediguard Antiseptic Disinfectant (1L)','Mediguard','Home',0,40,'MDG-ANTI-1L','/Img/mediguard-antiseptic-disinfectant-1l.png','1L','Mediguard antiseptic disinfectant - kills 99.9% of bacteria. Tested to EN protocols (EN1276). 1 litre.','Kills 99.9% of bacteria
Tested to EN protocols (EN1276)
Made in the UK','Follow the dilution and usage directions on the bottle.
Keep out of reach of children.',1),
(386,'Mucky Pup Flea Repellent Dog Shampoo','Mucky Pup','Home',0,40,'MP-FLEA-SHMP','/Img/mucky-pup-flea-repellent-shampoo.jpg',NULL,'Mucky Pup flea repellent shampoo for dogs - naturally repels fleas, removes dirt and helps reduce tangles for a healthy, shiny coat.','Naturally repels fleas
Removes dirt and helps reduce tangles
Leaves a healthy, shiny coat','Wet your dog''s coat thoroughly.
Massage in the shampoo, avoiding the eyes.
Rinse well.',1),
(387,'Dr Magic Double Action Foamer','Dr Magic','Home',0,40,'DRM-DAF','/Img/dr-magic-double-action-foamer.jpg',NULL,'Dr Magic double action drain foamer - clears build up and removes blockages. For kitchen and bathroom use.','Clears build up
Removes blockages
Kitchen and bathroom use','Follow the directions on the bottle.
Not for use in standing water.',1),
(388,'Dr Magic Oven & Grill Cleaner','Dr Magic','Home',0,40,'DRM-OVEN','/Img/dr-magic-oven-grill-cleaner.png',NULL,'Dr Magic oven and grill cleaner - heavy duty cleaning action for ovens and grills.','Heavy duty cleaning action
For ovens and grills','Follow the directions on the can.
Use in a well-ventilated area.',1),
(389,'Dr Magic Snatch A Dye (20 Sheets)','Dr Magic','Home',0,40,'DRM-SAD-20','/Img/dr-magic-snatch-a-dye-20-sheets.png','20 sheets','Dr Magic Snatch A Dye colour catcher sheets - avoids colour runs in mixed washes. 20 sheets.','Avoids colour runs in mixed washes
20 sheets per box','Add one sheet to the drum with your mixed wash.
Discard after use.',1),
(390,'Medipure Hair & Scalp Scalp Treatment','Medipure','Hair Care',0,40,'MPU-HS-TRT','/Img/medipure-hair-scalp-treatment.png',NULL,'Medipure Hair & Scalp scalp treatment - helps to fight against dandruff with quenching hydration for dry scalp. With hyaluronic acid, aloe vera and vitamin E.','Helps to fight against dandruff
Quenching hydration for dry scalp
With hyaluronic acid, aloe vera and vitamin E','Apply directly to the scalp using the nozzle.
Massage in gently.',1),
(391,'Medipure Hair & Scalp Conditioner','Medipure','Hair Care',0,40,'MPU-HS-COND','/Img/medipure-hair-scalp-conditioner.jpg',NULL,'Medipure Hair & Scalp conditioner - helps to fight against dandruff with quenching hydration for dry scalp. With aloe vera, coconut oil and vitamin E.','Helps to fight against dandruff
Quenching hydration for dry scalp
With aloe vera, coconut oil and vitamin E','After shampooing, apply through hair.
Leave for 2-3 minutes.
Rinse thoroughly.',1),
(392,'Medipure Hair & Scalp Hair Mask','Medipure','Hair Care',0,40,'MPU-HS-MASK','/Img/medipure-hair-scalp-hair-mask.png',NULL,'Medipure Hair & Scalp hair mask for dry scalp - helps to fight against dandruff. With aloe vera, coconut oil and vitamin E.','Helps to fight against dandruff
For dry scalp
With aloe vera, coconut oil and vitamin E','Apply to clean, damp hair and scalp.
Leave for a few minutes.
Rinse thoroughly.',1),
(393,'Medipure Hair & Scalp Anti-Dandruff Shampoo','Medipure','Hair Care',0,40,'MPU-HS-SHMP','/Img/medipure-hair-scalp-shampoo.png',NULL,'Medipure Hair & Scalp shampoo with anti-dandruff properties - effective treatment for dandruff. For frequent use.','Anti-dandruff properties
Improves hair and scalp
For frequent use','Massage into wet hair and scalp.
Rinse thoroughly.',1),
(394,'Dalton House Sweet Rose Fine Handwash (500ml)','Dalton House','Home',0,40,'DH-ROSE-500','/Img/dalton-house-sweet-rose-handwash-500ml.jpg','500ml','Dalton House England sweet rose fine handwash. 500ml pump bottle.','Sweet rose fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1),
(395,'Dalton House Sea Breeze Fine Handwash (500ml)','Dalton House','Home',0,40,'DH-SEAB-500','/Img/dalton-house-sea-breeze-handwash-500ml.jpg','500ml','Dalton House England sea breeze fine handwash. 500ml pump bottle.','Sea breeze fragrance
Fine handwash
500ml pump bottle','Pump onto wet hands and lather.
Rinse thoroughly.',1);
