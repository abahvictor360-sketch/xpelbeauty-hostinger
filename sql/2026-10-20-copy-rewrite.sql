-- Xpel Beauty NG copy rewrite (2026-10-20), Hostinger / MySQL. Run once in phpMyAdmin, after the other 2026-10-20 scripts.
-- Product names, sizes and copy
START TRANSACTION;
UPDATE `products` SET `name`='Vitamin C Face Serum', `size`=NULL, `description`='A lightweight face serum with vitamin C and niacinamide for skin that looks dull or uneven. It sinks in fast, so you can follow straight away with moisturiser or sunscreen, morning and night. Vegan.', `key_benefits`='Vitamin C for a brighter-looking complexion
Niacinamide for a more even-looking tone
Light texture that absorbs quickly
Made for twice-daily use', `how_to_use`='Cleanse and pat your face dry.
Press 2-3 drops into your face and neck.
Follow with moisturiser. Use morning and evening.' WHERE `id`=213;
UPDATE `products` SET `name`='Vitamin C Foaming Face Wash', `size`='200ml', `description`='A vitamin C and niacinamide face wash that turns into a soft foam and lifts off dirt and oil, leaving skin fresh rather than tight. A good first step for your morning routine. Vegan, 200ml.', `key_benefits`='Foams up to lift away dirt and excess oil
Vitamin C and niacinamide in every wash
Vegan formula
200ml bottle for daily use', `how_to_use`='Wet your face with warm water.
Massage a small amount into your skin until it foams.
Rinse well and pat dry. Use daily.' WHERE `id`=214;
UPDATE `products` SET `name`='Vitamin C Revitalising Face Mask', `size`=NULL, `description`='A sheet mask soaked in a vitamin C and niacinamide serum. Fifteen minutes is enough to leave tired skin looking fresher, which makes it a handy treat before an event or once a week. Vegan, with a plastic-free sheet.', `key_benefits`='Vitamin C and niacinamide serum
Plastic-free, vegan sheet
One-use mask, ready in 15-20 minutes
Easy weekly skin treat', `how_to_use`='Cleanse and pat your face dry.
Unfold the mask and smooth it on, pressing out air bubbles.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=215;
UPDATE `products` SET `name`='Vitamin C Exfoliating Facial Scrub', `size`='250ml', `description`='A creamy facial scrub with vitamin C that buffs away dry, flaky skin so your face feels smoother. Use it two or three times a week on damp skin and rinse clean. 250ml.', `key_benefits`='Fine scrub particles smooth rough patches
Vitamin C in a creamy base
Rinses off easily
250ml tube', `how_to_use`='Massage onto damp skin in small circles, avoiding the eyes.
Spend a little longer on rough or congested areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=216;
UPDATE `products` SET `name`='Vitamin C Salt Body Scrub', `size`=NULL, `description`='A vitamin C salt scrub for the whole body. The salt crystals polish away dry skin on elbows, knees and heels while the oils in the scrub leave skin soft after you rinse. Vegan.', `key_benefits`='Salt crystals for a thorough body polish
Leaves skin soft and smooth
Vegan formula
Made for use in the shower', `how_to_use`='Scoop a little onto damp skin in the shower.
Massage in circles, focusing on elbows, knees and heels.
Rinse well. Use 2-3 times a week.' WHERE `id`=217;
UPDATE `products` SET `name`='Vitamin C Facial Wipes', `size`=NULL, `description`='Vitamin C facial wipes that take off makeup, oil and the day''s grime in a few swipes. Keep a pack in your bag, gym kit or desk drawer for a quick clean face anywhere. 25 wipes. Vegan.', `key_benefits`='Removes makeup and daily grime
25 wipes per pack
Vegan formula
No water or rinsing needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use a fresh side for makeup.
No need to rinse. Follow with moisturiser.' WHERE `id`=218;
UPDATE `products` SET `name`='Papaya Cleansing Face Wash', `size`='250ml', `description`='A papaya face wash that builds a light lather and leaves skin feeling clean and fresh, never tight. Gentle enough for morning and evening, and a good match for normal to oily skin. 250ml.', `key_benefits`='Papaya fruit extract
Light lather for a fresh, clean feel
Gentle enough for twice-daily use
250ml tube', `how_to_use`='Wet your face with warm water.
Massage a small amount over your face in circles.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=219;
UPDATE `products` SET `name`='Papaya Hydrating Face Mask', `size`=NULL, `description`='A sheet mask soaked in papaya extract and hyaluronic acid for skin that feels dry. Leave it on for 15-20 minutes and your skin feels softer and looks more rested. Vegan, with a plastic-free sheet.', `key_benefits`='Papaya extract and hyaluronic acid
Helps dry skin feel soft and hydrated
Plastic-free, vegan sheet
Ideal once or twice a week', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=220;
UPDATE `products` SET `name`='Neem Oil Exfoliating Foaming Face Wash', `size`='200ml', `description`='A neem oil face wash that foams and gently exfoliates in one step, a good pick for oily skin or skin prone to spots. It cleans pores without leaving your face dry. 200ml.', `key_benefits`='Neem oil cleanser for oily or spot-prone skin
Gently exfoliates as it cleans
Foaming pump for easy use
200ml bottle', `how_to_use`='Wet your face with warm water.
Massage in circles until it foams.
Rinse well. Use morning and evening.' WHERE `id`=221;
UPDATE `products` SET `name`='Tea Tree & Peppermint Deep Moisturising Foot Pack', `size`='30ml', `description`='A foot pack with tea tree and peppermint for rough, dry feet. Wear it for 20 minutes like an at-home pedicure and your feet feel softer, smoother and fresher. 30ml per treatment.', `key_benefits`='Tea tree and peppermint for a cool, fresh feel
Softens rough, dry skin and heels
At-home pedicure in 20 minutes
One 30ml treatment', `how_to_use`='Put the pack on clean, dry feet.
Leave for 20 minutes.
Remove and massage any leftover product into your feet. Use weekly.' WHERE `id`=222;
UPDATE `products` SET `name`='Tea Tree Anti-Bacterial Handwash', `size`='500ml', `description`='An anti-bacterial tea tree handwash that rinses clean without a greasy feel. Gentle enough for the whole family to use many times a day. 500ml pump bottle.', `key_benefits`='Anti-bacterial tea tree formula
Rinses clean, no greasy residue
Gentle for frequent use
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=223;
UPDATE `products` SET `name`='Tea Tree Daily Cleansing Facial Wipes (Twin Pack)', `size`=NULL, `description`='Tea tree facial wipes for a quick daily clean. They take off makeup, oil and dirt and leave skin feeling fresh, at home or on the go. Twin pack, 2 x 25 wipes.', `key_benefits`='Tea tree oil wipes for a fresh, clean face
Removes makeup, oil and dirt
Twin pack of 2 x 25 wipes
Good for travel', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=224;
UPDATE `products` SET `name`='Tea Tree Foaming Face Wash', `size`='200ml', `description`='A tea tree foaming face wash for oily, combination and spot-prone skin. The rich foam lifts away dirt and oil, and your face feels clean and fresh after every wash. 200ml.', `key_benefits`='Tea tree oil for oily and spot-prone skin
Rich foam lifts dirt and oil
For morning and evening use
200ml pump bottle', `how_to_use`='Wet your face with warm water.
Massage in until it foams.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=225;
UPDATE `products` SET `name`='Tea Tree Moisturising Conditioner', `size`='400ml', `description`='A tea tree conditioner for dry hair. It softens, helps comb out knots and adds shine, and it is gentle enough to use after every wash. Pairs with XHC Tea Tree Moisturising Shampoo. 400ml.', `key_benefits`='Tea tree oil for dry hair
Softens and helps detangle
Adds shine
400ml, for frequent use', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=226;
UPDATE `products` SET `name`='Tea Tree Cleansing Pads', `size`=NULL, `description`='Tea tree cleansing pads, ready-soaked so you can wipe away leftover oil and dirt in one sweep. Use them after your face wash or on their own in the morning. 60 pads per jar. Dermatologically tested.', `key_benefits`='60 ready-soaked pads per jar
Contains natural tea tree oil
Cleans without over-drying
Dermatologically tested', `how_to_use`='After cleansing, sweep a pad over your face and neck.
Use morning and evening.
No need to rinse.' WHERE `id`=227;
UPDATE `products` SET `name`='Tea Tree Facial Toner', `size`='200ml', `description`='A light tea tree toner that refreshes skin after cleansing and gets it ready for your moisturiser. Non-greasy, for morning and evening. 200ml.', `key_benefits`='Tea tree oil toner
Light and non-greasy
Preps skin for moisturiser
200ml bottle', `how_to_use`='After cleansing, sweep over your face and neck with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=228;
UPDATE `products` SET `name`='Tea Tree Essential Oil', `size`='10ml', `description`='Concentrated tea tree essential oil for skin, hair and home. Add a few drops to a carrier oil, your shampoo or a diffuser. Always dilute before it touches your skin. 10ml.', `key_benefits`='Pure tea tree essential oil
For skin, hair and home use
A few drops go a long way
10ml bottle', `how_to_use`='Mix a few drops into a carrier oil before applying to skin.
Or add to shampoo, face wash or a diffuser.
Do a patch test before first use.' WHERE `id`=229;
UPDATE `products` SET `name`='Aloe Vera Conditioner', `size`='250ml', `description`='An aloe vera conditioner that leaves hair soft, smooth and shiny without weighing it down. Light enough for every wash and every hair type. 250ml.', `key_benefits`='Aloe vera for soft, smooth hair
Adds shine
Light, rinse-out formula
250ml, for every wash', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=230;
UPDATE `products` SET `name`='Aloe Vera Nourishing Leave-In Conditioner', `size`='250ml', `description`='An aloe vera leave-in conditioner with pro-vitamin B5 that keeps hair soft and hydrated through the day. Apply to damp or dry hair and style as normal, no rinsing. Vegan. 250ml.', `key_benefits`='Aloe vera and pro-vitamin B5
Keeps hair soft and hydrated all day
No rinsing needed
Vegan formula', `how_to_use`='Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse.
Style as usual.' WHERE `id`=231;
UPDATE `products` SET `name`='Aloe Vera Cooling Gel', `size`='250ml', `description`='A cooling aloe vera gel that soothes dry or sun-exposed skin and moisturises it. Use it after sun, after shaving or any time skin feels tight. Light and fast-absorbing. 250ml.', `key_benefits`='Cools and soothes dry, sun-exposed skin
Moisturises without feeling heavy
Fast-absorbing gel
250ml', `how_to_use`='Apply a generous layer to the skin.
Massage in gently until absorbed.
Reapply whenever your skin needs it.' WHERE `id`=232;
UPDATE `products` SET `name`='Aloe Vera Nourishing Face Mask', `size`=NULL, `description`='An aloe vera sheet mask with hyaluronic acid for dry or stressed skin. After 15-20 minutes your skin feels soothed and soft. Vegan, with a plastic-free sheet.', `key_benefits`='Aloe vera and hyaluronic acid
Soothes and softens dry skin
Plastic-free, vegan sheet
Ideal as a weekly treatment', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=233;
UPDATE `products` SET `name`='Aloe Vera Heat Defence Spray', `size`='150ml', `description`='An aloe vera heat defence spray to use before blow-drying or straightening. It helps protect hair from heat styling and leaves it smoother afterwards. 150ml.', `key_benefits`='Helps protect hair from heat styling
Aloe vera for hydration
Leaves hair smoother
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=234;
UPDATE `products` SET `name`='Aloe Vera Cleansing Facial Wipes (Twin Pack)', `size`=NULL, `description`='Aloe vera cleansing wipes that remove makeup and daily grime while leaving skin feeling soft, not stripped. Good for dry or sensitive skin. Twin pack, 2 x 25 wipes.', `key_benefits`='Hydrating aloe vera wipes
Removes makeup and dirt
Twin pack of 2 x 25 wipes
Vegan', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=235;
UPDATE `products` SET `name`='Aloe Vera Botanical Vegan Shampoo', `size`='400ml', `description`='A vegan aloe vera shampoo from the XHC Botanical range. It cleans away build-up and oil and leaves hair soft and shiny. 400ml.', `key_benefits`='Aloe vera botanical shampoo
Cleans without stripping hair
Leaves hair soft and shiny
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=236;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Leave-In Conditioner', `size`='250ml', `description`='A black castor oil and avocado leave-in conditioner with hyaluronic acid. It helps detangle and keeps hair moisturised between washes. Good for natural and relaxed hair. 250ml.', `key_benefits`='Black castor oil and avocado
Hyaluronic acid to keep moisture in
Helps detangle between washes
No rinsing needed', `how_to_use`='Apply to clean, damp or dry hair from mid-lengths to ends.
Do not rinse.
Style as usual.' WHERE `id`=237;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Shampoo', `size`='400ml', `description`='A black castor oil and avocado shampoo that cleans hair and scalp and leaves hair looking shiny and healthy. Especially good for dry hair. 400ml.', `key_benefits`='Black castor oil and avocado
Cleans hair and scalp
Adds shine
400ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=238;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Heat Defence Spray', `size`='150ml', `description`='A black castor oil and avocado heat defence spray to use before blow-drying, straightening or curling. It helps protect hair from heat and adds shine. 150ml.', `key_benefits`='Helps protect hair from heat styling
Black castor oil and avocado
Adds shine
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=239;
UPDATE `products` SET `name`='Black Castor Oil & Avocado Hair & Scalp Treatment', `size`='150ml', `description`='A black castor oil and avocado scalp treatment with hyaluronic acid for a dry or flaky scalp. Massage it in with your fingertips and leave it in or rinse it out. 150ml.', `key_benefits`='For a dry or flaky scalp
Hyaluronic acid to keep the scalp moisturised
Nozzle applies it straight to the scalp
150ml', `how_to_use`='Apply directly to the scalp, focusing on dry areas.
Massage in gently with your fingertips.
Leave in, or rinse after 10 minutes.' WHERE `id`=240;
UPDATE `products` SET `name`='Purifying Charcoal Cleansing Wipes', `size`=NULL, `description`='Charcoal cleansing wipes that take off makeup, oil and the day''s grime in one easy step. Good for normal to oily skin and handy for travel. 25 wipes.', `key_benefits`='Charcoal wipes for a deep-clean feel
Removes makeup, oil and dirt
25 wipes per pack
No water needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=241;
UPDATE `products` SET `name`='Cleansing Charcoal Face Scrub', `size`='250ml', `description`='A charcoal face scrub that buffs away dead skin and leaves your face feeling clean and smooth. Paraben and sulphate free. Good for oily and combination skin. 250ml.', `key_benefits`='Charcoal scrub for a deep-clean feel
Smooths rough skin
Paraben and sulphate free
250ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Focus on oily or congested areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=242;
UPDATE `products` SET `name`='Black Tissue Charcoal Detox Facial Mask', `size`=NULL, `description`='A black sheet mask with charcoal and hyaluronic acid for oily or congested skin. Leave it on for 15-20 minutes for a weekly deep-clean feel. The pack is marked anti-blemish, revitalising and purifying.', `key_benefits`='Charcoal and hyaluronic acid
Anti-blemish, revitalising and purifying
Good for oily or congested skin
Single-use sheet mask', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=243;
UPDATE `products` SET `name`='Cleansing Charcoal Toothpaste (Free Toothbrush)', `size`='100ml', `description`='A charcoal toothpaste that polishes away surface stains and leaves your mouth feeling clean and fresh. Comes with a free toothbrush. 100ml.', `key_benefits`='Charcoal formula for a cleaner-looking smile
Helps lift surface stains
Free toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=244;
UPDATE `products` SET `name`='Rosemary & Mint Hair Oil', `size`='60ml', `description`='A rosemary and mint hair oil for dry ends and a dry scalp. Smooth a few drops through damp or dry hair, or massage into the scalp before you wash. 60ml.', `key_benefits`='Rosemary and mint
Smooths dry ends
Use on hair or as a scalp massage oil
60ml, a few drops per use', `how_to_use`='Rub a few drops between your palms.
Work through the mid-lengths and ends, or massage into the scalp.
No need to rinse. Use daily or as needed.' WHERE `id`=245;
UPDATE `products` SET `name`='Rosemary & Mint Conditioner', `size`='300ml', `description`='A rosemary and mint conditioner that leaves hair soft, smooth and shiny, with a fresh minty feel on the scalp. Pairs with the Rosemary & Mint Shampoo. Vegan. 300ml.', `key_benefits`='Rosemary and mint
Leaves hair soft and shiny
Vegan formula
300ml, for every wash', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=246;
UPDATE `products` SET `name`='Rosemary & Mint Shampoo', `size`='300ml', `description`='A rosemary and mint shampoo that cleans and refreshes the scalp and leaves a cool, minty tingle. Use it with the matching conditioner. Vegan. 300ml.', `key_benefits`='Rosemary and mint
Cleans and refreshes the scalp
Vegan formula
300ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=247;
UPDATE `products` SET `name`='Argan Oil Hair Treatment', `size`='100ml', `description`='An argan oil hair treatment with Moroccan argan oil. A few drops tame frizz and leave dry or heat-styled hair smoother and shinier. No rinsing. 100ml.', `key_benefits`='Moroccan argan oil
Tames frizz and adds shine
Leave-in, no rinsing
100ml, a few drops per use', `how_to_use`='Smooth through towel-dried hair from mid-lengths to ends.
Do not rinse.
Style as usual, or use before heat styling.' WHERE `id`=248;
UPDATE `products` SET `name`='Argan Oil Conditioner', `size`='300ml', `description`='An argan oil conditioner that softens hair, helps it comb out easily and leaves a smooth, shiny finish without weighing it down. Good for normal to dry hair. Vegan. 300ml.', `key_benefits`='Moroccan argan oil
Soft, smooth, easy-to-comb hair
Adds shine
Vegan, 300ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=249;
UPDATE `products` SET `name`='Argan Oil Hydrating Hair Mask', `size`='350ml', `description`='A rich argan oil hair mask for a weekly deep condition. Leave it on for 5-10 minutes and dry hair feels softer, smoother and shinier. Vegan. 350ml jar.', `key_benefits`='Moroccan argan oil deep conditioner
Softer, smoother, shinier hair
Vegan formula
350ml jar for weekly use', `how_to_use`='Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use once a week.' WHERE `id`=250;
UPDATE `products` SET `name`='Argan Oil Heat Defence Leave-In Spray', `size`='150ml', `description`='An argan oil leave-in spray to use before heat styling. It helps protect hair from heat and leaves it soft, glossy and less frizzy. 150ml.', `key_benefits`='Helps protect hair from heat styling
Moroccan argan oil
Soft, glossy finish
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=251;
UPDATE `products` SET `name`='Argan Oil Facial Wipes (Twin Pack)', `size`=NULL, `description`='Argan oil facial wipes that remove makeup and daily grime and leave skin feeling soft, not tight. A good pick for dry skin. Twin pack, 2 x 25 wipes.', `key_benefits`='Moroccan argan oil extract
Removes makeup and dirt
Leaves skin feeling soft
Twin pack of 2 x 25 wipes', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=252;
UPDATE `products` SET `name`='Argan Oil Shampoo', `size`='300ml', `description`='An argan oil shampoo that cleans hair gently and leaves it soft and shiny. Use it with the Argan Oil Conditioner for the full routine. 300ml.', `key_benefits`='Moroccan argan oil
Gentle, everyday clean
Leaves hair soft and shiny
300ml, for frequent use', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=253;
UPDATE `products` SET `name`='Fresh Start Tea Tree & Lemon Shower Gel', `size`='400ml', `description`='A tea tree and lemon shower gel with essential oils. The zesty scent wakes you up in the morning and the rich lather leaves skin clean and fresh. 400ml.', `key_benefits`='Tea tree and lemon with essential oils
Rich lather for a fresh clean
Zesty, wake-up scent
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=254;
UPDATE `products` SET `name`='Fresh Start Mint & Cucumber Shower Gel', `size`='400ml', `description`='A mint and cucumber shower gel with essential oils and a cool, refreshing feel. Use it to wake up in the morning or cool down after a long day. 400ml.', `key_benefits`='Mint and cucumber with essential oils
Cool, refreshing feel
Gentle for daily use
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=255;
UPDATE `products` SET `name`='Fresh Start Coconut & Lime Shower Gel', `size`='400ml', `description`='A coconut and lime shower gel with essential oils. The creamy lather moisturises and leaves skin soft with a light tropical scent. 400ml.', `key_benefits`='Coconut and lime with essential oils
Moisturising lather
Leaves a light tropical scent
400ml', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=256;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Pore-Tight Toner', `size`='200ml', `description`='A watermelon toner with hyaluronic acid, vitamin C and aloe vera. Swipe it on after cleansing to refresh skin and help pores look smaller before your moisturiser. Natural vegan ingredients. 200ml.', `key_benefits`='Watermelon extract, hyaluronic acid and vitamin C
Helps pores look smaller
Refreshes skin after cleansing
200ml', `how_to_use`='After cleansing, sweep over your face with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=257;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Gel Moisturiser', `size`='50ml', `description`='A watermelon gel moisturiser with hyaluronic acid and vitamins C and E. It absorbs fast with no greasy feel, so it works well for oily, combination and normal skin. Natural vegan ingredients. 50ml jar.', `key_benefits`='Hyaluronic acid, watermelon and vitamins C and E
Fast-absorbing, non-greasy gel
Good for oily and combination skin
50ml jar', `how_to_use`='Apply a small amount to clean face and neck.
Massage in until absorbed.
Use morning and evening as your last step.' WHERE `id`=258;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Daily Facial Scrub', `size`='100ml', `description`='A daily watermelon facial scrub with hyaluronic acid and vitamins C and E. Gentle enough for every day, it smooths skin and leaves it feeling fresh. 100ml.', `key_benefits`='Gentle enough for daily use
Watermelon, hyaluronic acid and vitamins C and E
Smooths and refreshes skin
100ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use daily or as needed.' WHERE `id`=259;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Sheet Mask', `size`=NULL, `description`='A plant-based watermelon sheet mask with hyaluronic acid and vitamin B5. Fifteen to twenty minutes leaves skin hydrated, soothed and glowing. Great before an event. Vegan.', `key_benefits`='Watermelon, hyaluronic acid and vitamin B5
Hydrates and soothes skin
Plant-based sheet
Vegan', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=260;
UPDATE `products` SET `name`='Purple Whitening Toothpaste (Free Bamboo Toothbrush)', `size`='100ml', `description`='A purple colour-correcting toothpaste that helps cancel out yellow tones for a whiter-looking smile, plus a polishing formula for surface stains. Enamel safe. Comes with a free bamboo toothbrush. 100ml.', `key_benefits`='Purple colour correction for a whiter-looking smile
Polishing formula for surface stains
Enamel safe
Free bamboo toothbrush', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=261;
UPDATE `products` SET `name`='Purple Whitening Mouthwash', `size`='500ml', `description`='A purple whitening mouthwash that freshens breath and helps your smile look whiter. Use it after brushing with the Purple Whitening Toothpaste. 500ml.', `key_benefits`='Purple formula for a whiter-looking smile
Freshens breath
Pairs with the Purple Whitening Toothpaste
500ml', `how_to_use`='After brushing, pour 10-15ml.
Swish around your mouth for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=262;
UPDATE `products` SET `name`='Purple Polishing Tooth Powder', `size`=NULL, `description`='A purple polishing tooth powder for whiter-looking teeth. Dip a damp brush, brush for two minutes and rinse. Use it in place of toothpaste or alongside it.', `key_benefits`='Purple colour correction for a whiter-looking smile
Polishes away surface stains
Use instead of or with toothpaste
Compact pot, easy to travel with', `how_to_use`='Dip a damp toothbrush into the powder.
Brush gently for two minutes.
Rinse well. Use daily.' WHERE `id`=263;
UPDATE `products` SET `name`='Neem Oil & Mint Toothpaste (Free Toothbrush)', `size`='100ml', `description`='A neem oil and mint toothpaste that cleans teeth and leaves your breath fresh. Comes with a free toothbrush. 100ml.', `key_benefits`='Neem oil and mint
Fresh breath after brushing
Free toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=264;
UPDATE `products` SET `name`='Activated Charcoal Whitening Mouthwash', `size`='500ml', `description`='An activated charcoal whitening mouthwash made for deep stain removal. Rinse after brushing for fresher breath and a cleaner-looking smile. 500ml.', `key_benefits`='Activated charcoal whitening rinse
Helps remove stains
Freshens breath
500ml', `how_to_use`='After brushing, pour 10-15ml.
Swish around your mouth for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=265;
UPDATE `products` SET `name`='TrueSmile Tartar Defence Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile Tartar Defence toothpaste for everyday brushing. It helps prevent tartar build-up and leaves your teeth feeling clean. Comes with a toothbrush. 100ml.', `key_benefits`='Helps prevent tartar build-up
Cleaner-feeling teeth
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=266;
UPDATE `products` SET `name`='TrueSmile Triple Protect Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile Triple Protect toothpaste for all-round daily care of teeth, gums and breath. Comes with a toothbrush. 100ml.', `key_benefits`='All-round care for teeth, gums and breath
For the whole family''s daily brushing
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=267;
UPDATE `products` SET `name`='TrueSmile ProPurple Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProPurple toothpaste with a purple colour corrector that helps teeth look whiter as you brush. Comes with a toothbrush. 100ml.', `key_benefits`='Purple colour corrector for a whiter-looking smile
Visible effect from the first brush
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=268;
UPDATE `products` SET `name`='Sensio Enamel Restore Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Enamel Restore toothpaste with fluoride, made to help protect enamel that has worn down. Cool mint flavour. 75ml.', `key_benefits`='Helps protect worn enamel
Fluoride toothpaste
Cool mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=269;
UPDATE `products` SET `name`='Sensio Gentle Whitening Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Gentle Whitening toothpaste for sensitive teeth. It whitens gently, so you can brighten your smile without the sting. Cool mint. 75ml.', `key_benefits`='Gentle whitening
Made for sensitive teeth
Cool mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=270;
UPDATE `products` SET `name`='Sensio Instant Relief Toothpaste', `size`='75ml', `description`='TrueSmile Sensio Instant Relief toothpaste for teeth that react to hot, cold or sweet food. Use it twice a day in place of your usual toothpaste. Fresh mint. 75ml.', `key_benefits`='Made for sensitive teeth
For everyday brushing
Fresh mint flavour
75ml tube', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=271;
UPDATE `products` SET `name`='Sensio Sensitivity + Gum Twin Pack', `size`='2 x 75ml', `description`='A twin pack of TrueSmile Sensio Sensitivity + Gum toothpaste, made for sensitive teeth and gum care. Two 75ml tubes, so you stay stocked up.', `key_benefits`='For sensitive teeth and gum care
Two 75ml tubes
Good value twin pack
For everyday brushing', `how_to_use`='Brush for two minutes, morning and night.
Use in place of your usual toothpaste.
Spit out and avoid rinsing straight away.' WHERE `id`=272;
UPDATE `products` SET `name`='TrueSmile Monster Kids Bubble Gum Toothpaste', `size`=NULL, `description`='TrueSmile Monster Kids toothpaste in bubble gum flavour, with a fun monster box that makes brushing more fun for little ones. Comes with a kids'' toothbrush. For children aged 3 and up, with an adult watching.', `key_benefits`='Bubble gum flavour kids like
Monster packaging for fun brushing time
Kids'' toothbrush in the box
For children aged 3+', `how_to_use`='Brush for two minutes, morning and night, with an adult watching.
Use a pea-sized amount.
Spit out after brushing.' WHERE `id`=273;
UPDATE `products` SET `name`='TrueSmile Charcoal Natural Whitening Toothpaste', `size`='100ml', `description`='TrueSmile Charcoal toothpaste with activated carbon for natural-style whitening. It helps lift stains from tea and coffee for a brighter smile. Comes with a toothbrush. 100ml.', `key_benefits`='Activated carbon whitening
Helps lift tea and coffee stains
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=274;
UPDATE `products` SET `name`='TrueSmile Baking Soda Whitening Toothpaste', `size`='100ml', `description`='TrueSmile Baking Soda toothpaste for extra whitening. Baking soda helps polish away surface stains for a brighter smile. Comes with a toothbrush. 100ml.', `key_benefits`='Baking soda extra whitening
Helps polish away surface stains
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=275;
UPDATE `products` SET `name`='TrueSmile Monster Kids Strawberry Toothpaste', `size`=NULL, `description`='TrueSmile Monster Kids toothpaste in strawberry flavour, with a monster box that turns brushing into a game. Comes with a kids'' toothbrush. For children aged 3 and up, with an adult watching.', `key_benefits`='Strawberry flavour kids like
Monster packaging for fun brushing time
Kids'' toothbrush in the box
For children aged 3+', `how_to_use`='Brush for two minutes, morning and night, with an adult watching.
Use a pea-sized amount.
Spit out after brushing.' WHERE `id`=276;
UPDATE `products` SET `name`='TrueSmile ProClean Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProClean toothpaste with cooling crystals for an extreme clean, fresh feel every time you brush. Comes with a toothbrush. 100ml.', `key_benefits`='Cooling crystals for an extreme clean feel
Leaves your mouth fresh
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=277;
UPDATE `products` SET `name`='TrueSmile ProCare Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProCare toothpaste for complete everyday care of teeth and gums, with cavity protection. A good family toothpaste. Comes with a toothbrush. 100ml.', `key_benefits`='Complete daily care for teeth and gums
With cavity protection
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=278;
UPDATE `products` SET `name`='TrueSmile ProWhite Toothpaste & Toothbrush', `size`='100ml', `description`='TrueSmile ProWhite toothpaste with sodium phytate for advanced whitening. It helps keep new stains from building up so your smile stays brighter. Comes with a toothbrush. 100ml.', `key_benefits`='Advanced whitening with sodium phytate
Helps keep new stains away
Toothbrush in the box
100ml tube', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=279;
UPDATE `products` SET `name`='Intimelle Aloe Vera Daily Feminine Wash', `size`='250ml', `description`='Intimelle daily feminine wash with aloe vera. It is soap free, pH balanced and hypo-allergenic, so it cleans gently and leaves you feeling fresh. 250ml.', `key_benefits`='Soap free and pH balanced
Hypo-allergenic
With soothing aloe vera
250ml, for daily use', `how_to_use`='Use daily in the bath or shower.
Apply a small amount to the intimate area and rinse well with water.
Pat dry gently.' WHERE `id`=280;
UPDATE `products` SET `name`='Hot Rose Lip Butter Cherry Pie', `size`='15ml', `description`='Hot Rose Lip Butter in Cherry Pie. A creamy balm that softens dry lips, with a sweet cherry scent and a hint of tint. Wear it alone or under lipstick. 15ml.', `key_benefits`='Creamy lip butter for dry lips
Cherry Pie scent
Wear alone or under lipstick
15ml, fits in any bag', `how_to_use`='Apply to your lips whenever they feel dry.
Reapply after eating or drinking.
Wear alone or under lipstick.' WHERE `id`=281;
UPDATE `products` SET `name`='Hot Rose Lip Butter Peach Macaron', `size`='15ml', `description`='Hot Rose Lip Butter in Peach Macaron. A rich balm that keeps lips soft and smooth, with a sweet peach scent. Wear it in the day or as an overnight lip mask. 15ml.', `key_benefits`='Rich lip butter for soft, smooth lips
Peach Macaron scent
Day wear or overnight lip mask
15ml, fits in any bag', `how_to_use`='Apply to your lips whenever they feel dry.
Reapply after eating or drinking.
Use a thicker layer at night.' WHERE `id`=282;
UPDATE `products` SET `name`='Hot Rose Fixt Vit C Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Vit C setting spray. A fine mist that sets your makeup and gives skin a fresh glow, with a Tuscan cypress and mandarin scent. Vegan.', `key_benefits`='Sets makeup in place
Vitamin C for a fresh glow
Tuscan cypress and mandarin scent
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=283;
UPDATE `products` SET `name`='Hot Rose Fixt Dewy Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Dewy setting spray with lychee water and damask rose. It sets your makeup with a glowing, dewy finish. Best for normal to dry skin. Vegan.', `key_benefits`='Sets makeup with a dewy finish
Lychee water and damask rose
Good for normal to dry skin
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=284;
UPDATE `products` SET `name`='Hot Rose Fixt Matte Setting Spray', `size`=NULL, `description`='Hot Rose Fixt Matte setting spray with vetiver root and squalane. It sets your makeup with a matte finish that lasts all night and keeps shine down. Vegan.', `key_benefits`='Sets makeup with a matte finish
Made to last all night
Vetiver root and squalane
Vegan', `how_to_use`='Finish your makeup, then hold the bottle 20-30cm from your face.
Close your eyes and mist evenly.
Let it air dry. Do not rub.' WHERE `id`=285;
UPDATE `products` SET `name`='Hot Rose Hyaluronic Acid Skin Capsule Serum', `size`=NULL, `description`='Hot Rose hyaluronic acid serum in a capsule bottle, for skin that feels dry or tight. Massage it in before moisturiser for an extra drink of hydration.', `key_benefits`='Hyaluronic acid serum
Extra hydration for dry skin
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=286;
UPDATE `products` SET `name`='Hot Rose Vitamin C Glow Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Vitamin C Glow serum in a capsule bottle, for skin that looks dull or tired. Use it before moisturiser for a brighter, fresher look.', `key_benefits`='Vitamin C serum
For a brighter-looking complexion
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=287;
UPDATE `products` SET `name`='Hot Rose Vitamin E Antioxidant Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Vitamin E antioxidant serum in a capsule bottle, for skin that feels dry or stressed. Use it before moisturiser to keep skin soft and comfortable.', `key_benefits`='Vitamin E antioxidant serum
For dry or stressed skin
Light, fast-absorbing
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=288;
UPDATE `products` SET `name`='Hot Rose Niacinamide Clarifying Skin Capsule Serum', `size`=NULL, `description`='Hot Rose Niacinamide clarifying serum in a capsule bottle, for oily or congested skin. Use it before moisturiser to help pores look smaller and skin look clearer.', `key_benefits`='Niacinamide clarifying serum
Helps pores look smaller
Good for oily or congested skin
Use before moisturiser', `how_to_use`='Cleanse your face.
Massage a small amount into your face and neck.
Follow with moisturiser. Use daily or as needed.' WHERE `id`=289;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Lychee & Rosewater', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in lychee and rosewater. Shake to mix the two layers, then wipe away makeup, eye makeup included, with a cotton pad. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Lychee and rosewater
Takes off eye and face makeup
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=290;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Cucumber & Mint', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in cucumber and wild mint, with vitamin E. Shake, soak a cotton pad and wipe away full-face makeup with a cool, fresh feel. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Cucumber, wild mint and vitamin E
Cool, fresh feel
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=291;
UPDATE `products` SET `name`='Hot Rose Mixt Duo Makeup Remover Neroli & Mandarin', `size`=NULL, `description`='Hot Rose Mixt duo makeup remover in neroli and mandarin, with vitamin C. Shake, soak a cotton pad and wipe away makeup at the end of the day. Vegan.', `key_benefits`='Two-phase remover, shake to activate
Neroli, mandarin and vitamin C
Removes face and eye makeup
Vegan', `how_to_use`='Shake well.
Soak a cotton pad and hold it on your eyes for a few seconds, then wipe.
No need to rinse. Follow with your skincare.' WHERE `id`=292;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Twilight Dream', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Twilight Dream, a warm santal and cedarwood scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Santal and cedarwood scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=293;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Tropical Green', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Tropical Green, a fresh bergamot and green fig scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Bergamot and green fig scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=294;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant Blue Shell', `size`=NULL, `description`='Hot Rose Serena serum deodorant in Blue Shell, a clean sea salt and driftwood scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Sea salt and driftwood scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=295;
UPDATE `products` SET `name`='Hot Rose Serena Serum Deodorant First Bloom', `size`=NULL, `description`='Hot Rose Serena serum deodorant in First Bloom, a soft vanilla and almond scent. The serum has 5% AHA to care for underarm skin, and it is aluminium free. Vegan.', `key_benefits`='Serum deodorant with 5% AHA
Vanilla and almond scent
Aluminium free
Vegan', `how_to_use`='Apply to clean, dry underarms.
Let it absorb before dressing.
Use daily.' WHERE `id`=296;
UPDATE `products` SET `name`='Nulab Feelin Bliss Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Bliss roll-on anti-perspirant with 48-hour protection and a pomegranate and lotus scent. Alcohol free, so it stays comfortable on your skin. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Pomegranate and lotus scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=297;
UPDATE `products` SET `name`='Nulab Feelin Bliss Stick Deodorant', `size`='64g', `description`='Nulab Feelin Bliss anti-perspirant stick with 48-hour protection and a pomegranate and lotus scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-perspirant protection
Pomegranate and lotus scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=298;
UPDATE `products` SET `name`='Nulab Feelin Bliss Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Bliss deodorant mist with a pomegranate and lotus scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Pomegranate and lotus scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=299;
UPDATE `products` SET `name`='Nulab Feelin Fresh Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Fresh roll-on anti-perspirant with 48-hour protection and a cucumber and jasmine scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Cucumber and jasmine scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=300;
UPDATE `products` SET `name`='Nulab Feelin Fresh Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Fresh deodorant mist with a cucumber and jasmine scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Cucumber and jasmine scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=301;
UPDATE `products` SET `name`='Nulab Feelin Zesty Roll-On Deodorant', `size`='50ml', `description`='Nulab Feelin Zesty roll-on anti-perspirant with 48-hour protection and a bright lemon scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-perspirant protection
Lemon scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=302;
UPDATE `products` SET `name`='Nulab Feelin Zesty Stick Deodorant', `size`='64g', `description`='Nulab Feelin Zesty anti-perspirant stick with 48-hour protection and a bright lemon scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-perspirant protection
Lemon scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=303;
UPDATE `products` SET `name`='Nulab Feelin Zesty Mist Deodorant', `size`=NULL, `description`='Nulab Feelin Zesty deodorant mist with a grapefruit and lemon zest scent. A light spray you can top up during the day. 0% alcohol.', `key_benefits`='Light deodorant mist
Grapefruit and lemon zest scent
0% alcohol
Easy to top up during the day', `how_to_use`='Shake well.
Hold 15cm from your underarms and spray.
Let it dry before dressing.' WHERE `id`=304;
UPDATE `products` SET `name`='Nulab Men Protect Adventure Roll-On', `size`='50ml', `description`='Nulab Men Protect Adventure roll-on with 48-hour anti-sweat protection and a bold, fresh scent. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Adventure scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=305;
UPDATE `products` SET `name`='Nulab Men Protect Adventure Stick', `size`='64g', `description`='Nulab Men Protect Adventure stick with 48-hour anti-sweat protection and a bold, fresh scent. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-sweat protection
Adventure scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=306;
UPDATE `products` SET `name`='Nulab Men Protect Extreme Dry Roll-On', `size`='50ml', `description`='Nulab Men Protect Extreme Dry roll-on with 48-hour anti-sweat protection for long, hot days. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Extreme Dry formula
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=307;
UPDATE `products` SET `name`='Nulab Men Protect Extreme Dry Stick', `size`='64g', `description`='Nulab Men Protect Extreme Dry stick with 48-hour anti-sweat protection for long, hot days. Alcohol free and easy to carry. 64g.', `key_benefits`='48-hour anti-sweat protection
Extreme Dry formula
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=308;
UPDATE `products` SET `name`='Nulab Men Protect Sport Cool Stick', `size`='64g', `description`='Nulab Men Protect Sport Cool stick with 48-hour anti-sweat protection and a cool sporty scent, good for gym days. Alcohol free. 64g.', `key_benefits`='48-hour anti-sweat protection
Sport Cool scent
0% alcohol
64g stick', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=309;
UPDATE `products` SET `name`='Nulab Men Protect Sport Cool Roll-On', `size`='50ml', `description`='Nulab Men Protect Sport Cool roll-on with 48-hour anti-sweat protection and a cool sporty scent, good for gym days. Alcohol free. 50ml.', `key_benefits`='48-hour anti-sweat protection
Sport Cool scent
0% alcohol
50ml roll-on', `how_to_use`='Apply to clean, dry underarms.
Let it dry before dressing.
Use daily.' WHERE `id`=310;
UPDATE `products` SET `name`='Nulab Whole Body Cream Cocoa Butter', `size`='500ml', `description`='Nulab Whole Body Cream with cocoa butter. It gives 48 hours of moisture and softens rough, dry skin from head to toe. 500ml tub.', `key_benefits`='48-hour moisture
Cocoa butter for rough, dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=311;
UPDATE `products` SET `name`='Nulab Whole Body Cream Vitamin C', `size`='500ml', `description`='Nulab Whole Body Cream with vitamin C. It gives 48 hours of moisture and keeps dry areas like elbows, knees and heels soft. 500ml tub.', `key_benefits`='48-hour moisture
With vitamin C
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=312;
UPDATE `products` SET `name`='Nulab Whole Body Cream Olive Oil', `size`='500ml', `description`='Nulab Whole Body Cream with olive oil. It gives 48 hours of moisture and keeps dry or rough skin soft and comfortable. 500ml tub.', `key_benefits`='48-hour moisture
Olive oil for dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=313;
UPDATE `products` SET `name`='Nulab Whole Body Cream Vitamin E', `size`='500ml', `description`='Nulab Whole Body Cream with vitamin E. It gives 48 hours of moisture and soothes dry skin so it feels soft and smooth. 500ml tub.', `key_benefits`='48-hour moisture
Vitamin E to soothe dry skin
For the whole body
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=314;
UPDATE `products` SET `name`='Nulab Feelin Silky Skin Drenching Moisturising Cream', `size`='200ml', `description`='Nulab Feelin Silky, a skin-drenching moisturising cream with jojoba oil and vitamin E. Light, fast-absorbing and silky on the skin. 200ml tube.', `key_benefits`='Jojoba oil and vitamin E
Light, fast-absorbing cream
Leaves skin silky
200ml tube', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=315;
UPDATE `products` SET `name`='Nulab Q10 Radiance Night Cream', `size`='50ml', `description`='Nulab Q10 Radiance night cream with natural Q10 and a peptide complex. It moisturises while you sleep so your skin looks firmer and fresher in the morning. 50ml.', `key_benefits`='Natural Q10 and peptide complex
24-hour moisture
Firming, anti-ageing night care
50ml jar', `how_to_use`='Apply to clean face and neck in the evening.
Massage in with upward strokes.
Use nightly as your last step.' WHERE `id`=316;
UPDATE `products` SET `name`='Nulab Q10 Radiance Day Cream', `size`='50ml', `description`='Nulab Q10 Radiance day cream with natural Q10 and a peptide complex. It moisturises and helps skin look firmer, and it sits well under makeup. 50ml.', `key_benefits`='Natural Q10 and peptide complex
24-hour moisture
Firming, anti-ageing day care
50ml jar', `how_to_use`='Apply to clean face and neck in the morning.
Massage in with upward strokes.
Follow with sunscreen. Use daily.' WHERE `id`=317;
UPDATE `products` SET `name`='Nulab DreamLift Firming Anti-Wrinkle Night Cream', `size`='50ml', `description`='Nulab DreamLift firming anti-wrinkle night cream. It works while you sleep to help skin look firmer and smoother. 50ml.', `key_benefits`='Firming, anti-wrinkle formula
Night-time care
Helps skin look firmer and smoother
50ml jar', `how_to_use`='Apply to clean face and neck in the evening.
Massage in with upward strokes.
Use nightly as your last step.' WHERE `id`=318;
UPDATE `products` SET `name`='Nulab DreamLift Firming Anti-Wrinkle Day Cream', `size`='50ml', `description`='Nulab DreamLift firming anti-wrinkle day cream. A light cream that helps skin look firmer and smoother, and it wears well under makeup. 50ml.', `key_benefits`='Firming, anti-wrinkle formula
Light enough for under makeup
Helps skin look firmer and smoother
50ml jar', `how_to_use`='Apply to clean face and neck in the morning.
Massage in with upward strokes.
Follow with sunscreen. Use daily.' WHERE `id`=319;
UPDATE `products` SET `name`='Hygie Advanced Protection Citrus Handwash', `size`='500ml', `description`='Hygie Advanced Protection handwash with a fresh citrus scent. An anti-bacterial wash that keeps hands clean and soft, even with frequent washing. 500ml pump.', `key_benefits`='Anti-bacterial handwash
Fresh citrus scent
Gentle for frequent washing
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=320;
UPDATE `products` SET `name`='Hygie Advanced Protection Aloe Vera Handwash', `size`='500ml', `description`='Hygie Advanced Protection handwash with aloe vera. An anti-bacterial wash that keeps hands clean, soft and comfortable. Gentle for the whole family. 500ml pump.', `key_benefits`='Anti-bacterial handwash
With aloe vera
Gentle for the whole family
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=321;
UPDATE `products` SET `name`='Hygie Advanced Protection Original Handwash', `size`='500ml', `description`='Hygie Advanced Protection Original handwash with a clean, classic scent. An anti-bacterial wash that leaves hands clean and soft. 500ml pump.', `key_benefits`='Anti-bacterial handwash
Clean, classic scent
Gentle for frequent washing
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds, covering every surface.
Rinse well.' WHERE `id`=322;
UPDATE `products` SET `name`='Aloe Vera Face Toner', `size`='200ml', `description`='A hydrating aloe vera face toner that refreshes skin after cleansing and gets it ready for moisturiser. Gentle enough for dry and sensitive skin. Vegan. 200ml.', `key_benefits`='Hydrating aloe vera toner
Preps skin for moisturiser
Gentle for dry and sensitive skin
Vegan, 200ml', `how_to_use`='After cleansing, sweep over your face and neck with a cotton pad.
Avoid the eye area.
Follow with moisturiser. Use morning and evening.' WHERE `id`=323;
UPDATE `products` SET `name`='Aloe Vera Body Wash (250ml)', `size`='250ml', `description`='An aloe vera body wash that cleans, soothes and helps restore skin, and leaves you feeling fresh. 250ml.', `key_benefits`='Cleansing, soothing and restoring
With aloe vera
For daily showers
250ml', `how_to_use`='Squeeze onto wet skin or a sponge.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=324;
UPDATE `products` SET `name`='Odour Control Foot Spray', `size`='150ml', `description`='Xpel Foot Care odour control foot spray. A quick-drying spray that keeps feet fresh through the day. 150ml.', `key_benefits`='Controls foot odour
Quick-drying spray
Keeps feet fresh all day
150ml', `how_to_use`='Shake well.
Spray onto clean, dry feet.
Let it dry before putting on socks or shoes.' WHERE `id`=325;
UPDATE `products` SET `name`='Shoe Refresher Spray', `size`='150ml', `description`='Xpel Foot Care shoe refresher spray. Spray inside trainers, work shoes or any everyday pair to keep them smelling fresh between wears. 150ml.', `key_benefits`='Keeps shoes smelling fresh
For trainers and everyday shoes
Quick-drying spray
150ml', `how_to_use`='Shake well.
Spray inside your shoes.
Let them dry before wearing.' WHERE `id`=326;
UPDATE `products` SET `name`='Nail Polish Remover Vegan (150ml)', `size`='150ml', `description`='Xpel Nail Care vegan nail polish remover. It takes off nail polish cleanly and leaves your nails ready for the next colour. 150ml.', `key_benefits`='Vegan formula
Removes everyday nail polish
For regular use
150ml bottle', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=327;
UPDATE `products` SET `name`='Nail Polish Remover 80% Acetone (150ml)', `size`='150ml', `description`='Xpel Nail Care 80% acetone nail polish remover for fast removal, even glitter polish. The easy-use dosing cap helps you use less and waste less. 150ml.', `key_benefits`='80% acetone for fast removal
Easy-use dosing cap
Works on glitter polish
150ml bottle', `how_to_use`='Press the cotton pad onto the dosing cap to soak it.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=328;
UPDATE `products` SET `name`='Nail Polish Remover (250ml)', `size`='250ml', `description`='Xpel Nail Care nail polish remover in a large 250ml bottle, so it lasts for many manicures at home.', `key_benefits`='Large 250ml bottle
Removes everyday nail polish
For regular home use
Good value size', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=329;
UPDATE `products` SET `name`='Nail Polish Remover Acetone Free (250ml)', `size`='250ml', `description`='Xpel Nail Care acetone-free nail polish remover, a gentler choice for dry or weak nails. 250ml.', `key_benefits`='Acetone free
Gentler on dry or weak nails
Removes everyday nail polish
250ml bottle', `how_to_use`='Soak a cotton pad.
Press it on the nail for a few seconds.
Wipe from the base of the nail outwards.' WHERE `id`=330;
UPDATE `products` SET `name`='Neem Oil Facial Scrub', `size`=NULL, `description`='An XBC neem oil facial scrub that buffs away dead skin and leaves your face feeling clean and smooth. A good weekly step for oily, combination or spot-prone skin.', `key_benefits`='Neem oil scrub
Buffs away dead skin
Good for oily or spot-prone skin
Use 2-3 times a week', `how_to_use`='Massage onto damp skin in gentle circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=332;
UPDATE `products` SET `name`='XNC Super Strength Nail & Tip Remover (99% Acetone)', `size`=NULL, `description`='XNC Super Strength 99% acetone remover for artificial nails, tips and gel polish. Super fast removal. Use in a well-ventilated room.', `key_benefits`='99% acetone
Removes artificial nails, tips and gel polish
Super fast removal
Contains Bitrex to help protect children', `how_to_use`='Soak a cotton pad.
Press it on the nail or tip and hold.
Wipe from the base outwards. Use in a well-ventilated room.' WHERE `id`=333;
UPDATE `products` SET `name`='XNC Nail Polish Remover Dip Pot (150ml)', `size`='150ml', `description`='XNC acetone-free nail polish remover in a dip pot. Dip your nail in, twist and lift out clean. No cotton pads needed, and it is suitable for acrylic nails. 150ml.', `key_benefits`='Dip pot, no cotton pads needed
Acetone free
Suitable for acrylic nails
150ml pot', `how_to_use`='Dip one nail into the pot and hold for a few seconds.
Twist gently and lift out.
Wipe off any residue with a tissue.' WHERE `id`=334;
UPDATE `products` SET `name`='XBC Aqueous Cream 500ml', `size`='500ml', `description`='XBC Aqueous Cream for relief of dry skin. It soothes, softens and moisturises, and it is fragrance free and lanolin free, so the whole family can use it. 500ml tub.', `key_benefits`='Relief of dry skin
Soothes, softens and moisturises
Fragrance free and lanolin free
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, or as often as your skin needs.' WHERE `id`=335;
UPDATE `products` SET `name`='XBC Aqueous Cream SLS Free 500ml', `size`='500ml', `description`='XBC Aqueous Cream SLS Free, for relief of dry skin without SLS. It soothes, softens and moisturises, and it is fragrance free and lanolin free. 500ml tub.', `key_benefits`='SLS free
Relief of dry skin
Fragrance free and lanolin free
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, or as often as your skin needs.' WHERE `id`=336;
UPDATE `products` SET `name`='XBC Aloe Vera Cream 500ml', `size`='500ml', `description`='XBC Aloe Vera Cream that soothes, softens and moisturises skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With aloe vera
Soothes, softens and moisturises
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=337;
UPDATE `products` SET `name`='XBC Olive Oil Cream 500ml', `size`='500ml', `description`='XBC Olive Oil Cream that deeply moisturises and hydrates skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With olive oil
Deeply moisturises and hydrates
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=338;
UPDATE `products` SET `name`='XBC Cocoa Butter Cream 500ml', `size`='500ml', `description`='XBC Cocoa Butter Cream that nourishes and softens dry skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With cocoa butter
Nourishes and softens dry skin
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=339;
UPDATE `products` SET `name`='XBC Vitamin E Cream 500ml', `size`='500ml', `description`='XBC Vitamin E Cream that deeply moisturises and soothes skin. A big tub for everyday use by the whole family. 500ml.', `key_benefits`='With vitamin E
Deeply moisturises and soothes
For the whole family
500ml tub', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily.' WHERE `id`=340;
UPDATE `products` SET `name`='XBC Bamboo Cotton Buds (300 buds)', `size`='300 buds', `description`='XBC bamboo cotton buds with biodegradable bamboo stems and 100% pure cotton tips. Kind and gentle for makeup touch-ups, nail care and everyday use. 300 buds.', `key_benefits`='Biodegradable bamboo stems
100% pure cotton tips
Kind and gentle
300 buds per pot', `how_to_use`='Use one bud at a time.
Do not insert into the ear canal.
Keep out of reach of young children.' WHERE `id`=341;
UPDATE `products` SET `name`='XBC Coconut Water Deep Moisturising Foot Pack (30ml)', `size`='30ml', `description`='XBC Coconut Water deep moisturising foot pack. One 20-minute treatment leaves rough, dry feet softer and smoother. 30ml.', `key_benefits`='Coconut water
Deep moisturising for dry feet
20-minute treatment
One 30ml pack', `how_to_use`='Put the pack on clean, dry feet.
Leave for 20 minutes.
Remove and massage any leftover product into your feet.' WHERE `id`=342;
UPDATE `products` SET `name`='XBC Coconut Water Hydrating Shower Crème (300ml)', `size`='300ml', `description`='XBC Coconut Water hydrating shower creme that cleans and moisturises in one step, so skin feels soft after you rinse. 300ml.', `key_benefits`='Coconut water
Cleans and moisturises in one step
Creamy lather
300ml tube', `how_to_use`='Squeeze onto wet skin in the shower.
Work into a lather all over.
Rinse well. Use daily.' WHERE `id`=343;
UPDATE `products` SET `name`='XBC Coconut Water Hydrating Facial Wipes (Twin Pack)', `size`=NULL, `description`='XBC Coconut Water facial wipes that cleanse, tone and moisturise in one wipe. Twin pack, so you can keep one at home and one in your bag.', `key_benefits`='Coconut water wipes
Cleanse, tone and moisturise
Twin pack
No water needed', `how_to_use`='Take out a wipe and sweep it over your face and neck.
Use it to remove makeup and dirt.
No need to rinse. Follow with moisturiser.' WHERE `id`=344;
UPDATE `products` SET `name`='XHC Avocado & Almond Heat Defence Spray (150ml)', `size`='150ml', `description`='XHC avocado and almond heat defence spray. Use it before heat styling to help protect hair and keep it smooth and hydrated. 150ml.', `key_benefits`='Helps protect hair from heat styling
Avocado and almond
Keeps hair smooth
150ml spray', `how_to_use`='Spray onto towel-dried hair before heat styling.
Comb through the mid-lengths and ends.
Style with heated tools as usual.' WHERE `id`=345;
UPDATE `products` SET `name`='XOC Dual Action Mint Mouthwash (500ml)', `size`='500ml', `description`='XOC Dual Action mint mouthwash that helps freshen breath and keep your mouth clean. Alcohol free. Shake to activate. 500ml.', `key_benefits`='Dual action mint formula
Freshens breath and keeps your mouth clean
Alcohol free
500ml', `how_to_use`='Shake to activate.
After brushing, swish 10-15ml for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=348;
UPDATE `products` SET `name`='XOC Dual Action Clove Mouthwash (500ml)', `size`='500ml', `description`='XOC Dual Action clove mouthwash that helps freshen breath and keep your mouth clean. Alcohol free. Shake to activate. 500ml.', `key_benefits`='Dual action clove formula
Freshens breath and keeps your mouth clean
Alcohol free
500ml', `how_to_use`='Shake to activate.
After brushing, swish 10-15ml for 30 seconds.
Spit out. Do not swallow.' WHERE `id`=349;
UPDATE `products` SET `name`='XOC Hemp Toothpaste (100ml + Free Toothbrush)', `size`='100ml', `description`='XOC Hemp toothpaste with hemp oil for a gentle clean and fresh breath. Comes with a free toothbrush. Vegan. 100ml.', `key_benefits`='Hemp oil toothpaste
Gentle clean and fresh breath
Free toothbrush in the box
Vegan, 100ml', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=350;
UPDATE `products` SET `name`='XOC Hemp Mouthwash (500ml)', `size`='500ml', `description`='XOC Hemp mouthwash for everyday care of teeth and gums and lasting fresh breath. Pairs with the XOC Hemp Toothpaste. 500ml.', `key_benefits`='Hemp mouthwash
For teeth and gum care
Lasting fresh breath
500ml', `how_to_use`='After brushing, swish 10-15ml for 30 seconds.
Spit out.
Do not swallow.' WHERE `id`=351;
UPDATE `products` SET `name`='XHC Keratin Classic Shampoo (300ml)', `size`='300ml', `description`='XHC Keratin Classic shampoo that smooths, nourishes and adds shine, and helps keep frizz down. Use it with the Keratin Classic Conditioner. 300ml.', `key_benefits`='With keratin
Smooths, nourishes and adds shine
Helps tame frizz
300ml tube', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=352;
UPDATE `products` SET `name`='XHC Keratin Classic Conditioner (300ml)', `size`='300ml', `description`='XHC Keratin Classic conditioner that leaves hair soft, silky and shining. Pairs with the Keratin Classic Shampoo. 300ml.', `key_benefits`='With keratin
Soft, silky, shiny hair
Pairs with Keratin Classic Shampoo
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=353;
UPDATE `products` SET `name`='XHC Biotin & Collagen Shampoo (300ml)', `size`='300ml', `description`='XHC Biotin & Collagen shampoo that helps hair look thicker and fuller. Pairs with the Biotin & Collagen Conditioner. 300ml.', `key_benefits`='Biotin and collagen
For thicker, fuller-looking hair
Pairs with the matching conditioner
300ml tube', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=354;
UPDATE `products` SET `name`='XHC Biotin & Collagen Conditioner (300ml)', `size`='300ml', `description`='XHC Biotin & Collagen conditioner that strengthens, thickens and adds shine. Pairs with the Biotin & Collagen Shampoo. 300ml.', `key_benefits`='Biotin and collagen
Strengthens, thickens and adds shine
Pairs with the matching shampoo
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=355;
UPDATE `products` SET `name`='XHC Biotin & Collagen Hair Treatment (50ml)', `size`='50ml', `description`='XHC Biotin & Collagen hair treatment that hydrates, nourishes and adds shine. Use it once or twice a week for smoother-looking hair. 50ml.', `key_benefits`='Biotin and collagen
Hydrates, nourishes and adds shine
Weekly treatment
50ml', `how_to_use`='Apply to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use 1-2 times a week.' WHERE `id`=356;
UPDATE `products` SET `name`='So Fresh Watermelon Crush Facial Cleanser (100ml)', `size`='100ml', `description`='So Fresh Watermelon Crush facial cleanser with hyaluronic acid and vitamins C and E. A fresh, fruity daily wash that leaves skin clean and hydrated. 100ml.', `key_benefits`='Watermelon, hyaluronic acid and vitamins C and E
Fresh, fruity daily cleanse
Hydrating
100ml tube', `how_to_use`='Wet your face with warm water.
Massage a small amount over your face in circles.
Rinse well and pat dry. Use morning and evening.' WHERE `id`=357;
UPDATE `products` SET `name`='Tea Tree Body Scrub', `size`=NULL, `description`='An XBC tea tree body scrub that buffs away dry skin and leaves your body feeling smooth and fresh. Good for elbows, knees and heels.', `key_benefits`='Tea tree body scrub
Smooths rough, dry skin
Fresh, clean feel
For use 2-3 times a week', `how_to_use`='Massage onto damp skin in the shower, avoiding broken skin.
Focus on rough areas.
Rinse well. Use 2-3 times a week.' WHERE `id`=359;
UPDATE `products` SET `name`='Tea Tree Body Butter', `size`='250ml', `description`='An XBC tea tree body butter that nourishes and hydrates, leaving skin smooth and healthy. Rich enough for dry patches. 250ml tub.', `key_benefits`='Tea tree body butter
Nourishes and hydrates
Rich texture for dry patches
250ml tub', `how_to_use`='Warm a little between your palms.
Massage into skin, focusing on dry areas.
Use daily after a shower.' WHERE `id`=360;
UPDATE `products` SET `name`='Tea Tree Moisturising Sheet Mask', `size`=NULL, `description`='An XBC tea tree moisturising sheet mask with tea tree oil and pro-vitamin B5. It leaves skin looking revitalised and hydrated. Ready in 15-20 minutes.', `key_benefits`='Tea tree oil and pro-vitamin B5
Leaves skin revitalised and hydrated
Single-use sheet mask
A quick weekly treat', `how_to_use`='Cleanse and pat your face dry.
Smooth the mask over your face, avoiding eyes and lips.
Leave for 15-20 minutes, remove and massage in what is left.' WHERE `id`=361;
UPDATE `products` SET `name`='Tea Tree Mouthwash', `size`='500ml', `description`='An XOC tea tree mouthwash that freshens breath after brushing and keeps your mouth feeling clean. 500ml.', `key_benefits`='Tea tree mouthwash
Freshens breath
Keeps your mouth feeling clean
500ml', `how_to_use`='After brushing, swish 10-15ml for 30 seconds.
Spit out.
Do not swallow.' WHERE `id`=362;
UPDATE `products` SET `name`='Tea Tree Toothpaste (+ Free Bamboo Toothbrush)', `size`=NULL, `description`='An XOC tea tree toothpaste for a gentle clean and fresh breath. Comes with a free bamboo toothbrush.', `key_benefits`='Tea tree toothpaste
Gentle clean and fresh breath
Free bamboo toothbrush
For everyday brushing', `how_to_use`='Brush for two minutes, morning and night.
Spit out after brushing.
Avoid rinsing straight away.' WHERE `id`=363;
UPDATE `products` SET `name`='Tea Tree Facial Scrub', `size`=NULL, `description`='An XBC tea tree facial scrub in a jar. It buffs away dullness so your face feels smoother and fresher. Use two or three times a week.', `key_benefits`='Tea tree facial scrub
Buffs away dullness
Smoother, fresher-feeling skin
For use 2-3 times a week', `how_to_use`='Massage onto damp skin in gentle circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=364;
UPDATE `products` SET `name`='XHC Botanical Vegan Conditioner, Aloe Vera (300ml)', `size`='300ml', `description`='An XHC Botanical vegan conditioner with aloe vera. It conditions gently and leaves hair soft and shiny. Pairs with the Aloe Vera Botanical Vegan Shampoo. 300ml.', `key_benefits`='Aloe vera botanical conditioner
Leaves hair soft and shiny
Vegan
300ml tube', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=365;
UPDATE `products` SET `name`='XHC Botanical Aloe Vera Hair Mask', `size`=NULL, `description`='An XHC Botanical aloe vera hair mask for a weekly deep condition. Leave it on for 5-10 minutes for softer, shinier hair. Vegan.', `key_benefits`='Aloe vera deep conditioner
Softer, shinier hair
Weekly treatment
Vegan', `how_to_use`='Apply generously to clean, damp hair from mid-lengths to ends.
Leave for 5-10 minutes.
Rinse well. Use once a week.' WHERE `id`=366;
UPDATE `products` SET `name`='XHC Banana Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion banana shampoo that cleans and nourishes, leaving hair soft with a sweet banana scent. Pairs with the Banana Conditioner. Vegan. 400ml.', `key_benefits`='Banana Fruit Fusion shampoo
Cleans and nourishes
Soft hair with a fruity scent
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=367;
UPDATE `products` SET `name`='XHC Banana Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion banana conditioner that leaves hair sleek, shiny and smooth. Pairs with the Banana Shampoo. Vegan. 400ml.', `key_benefits`='Banana Fruit Fusion conditioner
Sleek, shiny, smooth hair
Pairs with Banana Shampoo
Vegan, 400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=368;
UPDATE `products` SET `name`='XHC Ginger Anti-Dandruff Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion ginger anti-dandruff shampoo. It cleans the scalp, helps keep dandruff away and leaves hair sleek and shiny. 400ml.', `key_benefits`='Anti-dandruff shampoo
Ginger Fruit Fusion formula
Cleans the scalp
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=369;
UPDATE `products` SET `name`='XHC Coconut Hydrating Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion coconut hydrating shampoo with coconut water. It cleans and helps add moisture so hair feels soft and shiny. 400ml.', `key_benefits`='Coconut water hydrating shampoo
Cleans and adds moisture
Soft, shiny hair
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=371;
UPDATE `products` SET `name`='XHC Coconut Hydrating Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion coconut hydrating conditioner with coconut water. It helps add moisture and leaves hair soft, sleek and shiny. 400ml.', `key_benefits`='Coconut water hydrating conditioner
Soft, sleek, shiny hair
Pairs with Coconut Hydrating Shampoo
400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=372;
UPDATE `products` SET `name`='XHC Strawberry Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion strawberry shampoo that cleans and leaves hair sleek and shiny with a fresh strawberry scent. Vegan. 400ml.', `key_benefits`='Strawberry Fruit Fusion shampoo
Sleek, shiny hair
Fresh strawberry scent
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=373;
UPDATE `products` SET `name`='XHC Strawberry Conditioner (400ml)', `size`='400ml', `description`='XHC Fruit Fusion strawberry conditioner that leaves hair soft, sleek and shiny. Pairs with the Strawberry Shampoo. Vegan. 400ml.', `key_benefits`='Strawberry Fruit Fusion conditioner
Soft, sleek, shiny hair
Pairs with Strawberry Shampoo
Vegan, 400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=374;
UPDATE `products` SET `name`='XHC Green Tea Shampoo (400ml)', `size`='400ml', `description`='XHC Fruit Fusion green tea shampoo that cleans and refreshes, leaving hair sleek and shiny. Pairs with the Green Tea Conditioner. Vegan. 400ml.', `key_benefits`='Green tea Fruit Fusion shampoo
Cleans and refreshes
Sleek, shiny hair
Vegan, 400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=375;
UPDATE `products` SET `name`='XHC Green Tea Conditioner (400ml)', `size`='400ml', `description`='XHC green tea conditioner that leaves hair soft, sleek and shiny. Paraben free and dermatologically tested. Pairs with the Green Tea Shampoo. 400ml.', `key_benefits`='Green tea conditioner
Soft, sleek, shiny hair
Paraben free, dermatologically tested
400ml', `how_to_use`='After shampooing, apply to the mid-lengths and ends.
Leave for 2-3 minutes.
Rinse well. Use with every wash.' WHERE `id`=376;
UPDATE `products` SET `name`='XBC Strawberry Body Yogurt (Deep Moisturising)', `size`=NULL, `description`='XBC Strawberry Body Yogurt, a deep moisturising body cream with a light, whipped feel and a sweet strawberry scent. It sinks in fast and leaves skin soft.', `key_benefits`='Deep moisturising body yogurt
Light, fast-absorbing texture
Sweet strawberry scent
For the whole body', `how_to_use`='Apply generously to clean, dry skin.
Massage in until absorbed.
Use daily, ideally after a shower.' WHERE `id`=378;
UPDATE `products` SET `name`='XBC Banana Face and Body Scrub (250ml)', `size`='250ml', `description`='XBC Banana face and body scrub with banana extracts. It gently exfoliates for visibly brighter skin, on your face and all over your body. 250ml.', `key_benefits`='Banana extracts
Gently exfoliates for brighter-looking skin
For face and body
250ml tube', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=379;
UPDATE `products` SET `name`='Nulab Cocoa Glow Radiance+ Body Gel Oil', `size`='200ml', `description`='Nulab Cocoa Glow Radiance+ body gel oil with cocoa butter. The gel melts into skin, leaves a healthy glow and does not feel greasy. 200ml.', `key_benefits`='Cocoa butter body gel oil
Leaves a healthy glow
Non-greasy, fast-absorbing
200ml', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily after a shower.' WHERE `id`=380;
UPDATE `products` SET `name`='Nulab Coconut Renew Radiance+ Body Gel Oil', `size`='200ml', `description`='Nulab Coconut Renew Radiance+ body gel oil with coconut oil. A light gel that moisturises and leaves skin soft and smooth without a greasy feel. 200ml.', `key_benefits`='Coconut oil body gel oil
Moisturises and softens
Non-greasy, fast-absorbing
200ml', `how_to_use`='Apply to clean, dry skin.
Massage in until absorbed.
Use daily after a shower.' WHERE `id`=381;
UPDATE `products` SET `name`='Aloe Vera Shampoo (250ml)', `size`='250ml', `description`='An aloe vera shampoo for smooth and shiny hair, in the classic leaf-shaped bottle. Gentle enough for regular washing. 250ml.', `key_benefits`='Aloe vera shampoo
Smooth, shiny hair
Gentle for regular use
250ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with conditioner.' WHERE `id`=382;
UPDATE `products` SET `name`='XBC Aloe Vera Face & Body Scrub', `size`=NULL, `description`='An XBC aloe vera face and body scrub with aloe vera extracts. It gently exfoliates for visibly brighter skin on your face and body. Jar.', `key_benefits`='Aloe vera extracts
Gently exfoliates for brighter-looking skin
For face and body
Easy-scoop jar', `how_to_use`='Massage onto damp skin in circles, avoiding the eyes.
Rinse well.
Use 2-3 times a week.' WHERE `id`=383;
UPDATE `products` SET `name`='Medex Aloe Vera Antibacterial Handwash (650ml)', `size`='650ml', `description`='Medex Clean & Hygienic aloe vera antibacterial handwash in a big 650ml pump bottle, with 30% extra free. Good value for a busy home.', `key_benefits`='Antibacterial handwash
With aloe vera
30% extra free
650ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather for 20-30 seconds.
Rinse well.' WHERE `id`=384;
UPDATE `products` SET `name`='Mediguard Antiseptic Disinfectant (1L)', `size`='1L', `description`='Mediguard antiseptic disinfectant that kills 99.9% of bacteria, tested to EN protocols (EN1276). Made in the UK. 1 litre.', `key_benefits`='Kills 99.9% of bacteria
Tested to EN1276
Made in the UK
1 litre', `how_to_use`='Follow the dilution and usage directions on the bottle.
Keep out of reach of children.' WHERE `id`=385;
UPDATE `products` SET `name`='Mucky Pup Flea Repellent Dog Shampoo', `size`=NULL, `description`='Mucky Pup flea repellent shampoo for dogs. It naturally repels fleas, removes dirt and helps reduce tangles, leaving your dog with a healthy, shiny coat.', `key_benefits`='Naturally repels fleas
Removes dirt and helps reduce tangles
Healthy, shiny coat
For dogs', `how_to_use`='Wet your dog''s coat well.
Massage in the shampoo, avoiding the eyes.
Rinse thoroughly.' WHERE `id`=386;
UPDATE `products` SET `name`='Dr Magic Double Action Foamer', `size`=NULL, `description`='Dr Magic Double Action Foamer for kitchen and bathroom drains. It clears build-up and removes blockages. Not for use in standing water.', `key_benefits`='Clears build-up
Removes blockages
Kitchen and bathroom drains
Double action foam', `how_to_use`='Follow the directions on the bottle.
Not for use in standing water.
Keep out of reach of children.' WHERE `id`=387;
UPDATE `products` SET `name`='Dr Magic Oven & Grill Cleaner', `size`=NULL, `description`='Dr Magic oven and grill cleaner with heavy-duty cleaning action for burnt-on grease. Use in a well-ventilated room.', `key_benefits`='Heavy-duty cleaning action
For ovens and grills
Aerosol spray
Cuts through grease', `how_to_use`='Follow the directions on the can.
Use in a well-ventilated room.
Keep out of reach of children.' WHERE `id`=388;
UPDATE `products` SET `name`='Dr Magic Snatch A Dye (20 Sheets)', `size`='20 sheets', `description`='Dr Magic Snatch A Dye colour catcher sheets. Drop one in with a mixed wash to avoid colour runs. 20 sheets.', `key_benefits`='Avoids colour runs in mixed washes
One sheet per wash
20 sheets per box
For washing machines', `how_to_use`='Put one sheet in the drum with your mixed wash.
Wash as normal.
Throw the sheet away after use.' WHERE `id`=389;
UPDATE `products` SET `name`='Medipure Hair & Scalp Scalp Treatment', `size`=NULL, `description`='Medipure Hair & Scalp scalp treatment that helps fight dandruff and gives a dry scalp a drink of moisture. With hyaluronic acid, aloe vera and vitamin E.', `key_benefits`='Helps fight dandruff
Hydrates a dry scalp
Hyaluronic acid, aloe vera and vitamin E
Nozzle for easy scalp application', `how_to_use`='Part your hair and apply directly to the scalp with the nozzle.
Massage in gently.
Use as directed on the pack.' WHERE `id`=390;
UPDATE `products` SET `name`='Medipure Hair & Scalp Conditioner', `size`=NULL, `description`='Medipure Hair & Scalp conditioner that helps fight dandruff and hydrates a dry scalp. With aloe vera, coconut oil and vitamin E.', `key_benefits`='Helps fight dandruff
Hydrates a dry scalp
Aloe vera, coconut oil and vitamin E
Pairs with the Hair & Scalp shampoo', `how_to_use`='After shampooing, apply through your hair.
Leave for 2-3 minutes.
Rinse well.' WHERE `id`=391;
UPDATE `products` SET `name`='Medipure Hair & Scalp Hair Mask', `size`=NULL, `description`='Medipure Hair & Scalp hair mask for a dry scalp that helps fight dandruff. With aloe vera, coconut oil and vitamin E.', `key_benefits`='Helps fight dandruff
For a dry scalp
Aloe vera, coconut oil and vitamin E
Rich hair mask', `how_to_use`='Apply to clean, damp hair and scalp.
Leave for a few minutes.
Rinse well.' WHERE `id`=392;
UPDATE `products` SET `name`='Medipure Hair & Scalp Anti-Dandruff Shampoo', `size`=NULL, `description`='Medipure Hair & Scalp shampoo with anti-dandruff properties, an effective treatment for dandruff that is gentle enough for frequent use. Improved formula.', `key_benefits`='Anti-dandruff properties
Improves hair and scalp
For frequent use
Improved formula', `how_to_use`='Massage into wet hair and scalp.
Rinse well.
Use as often as needed.' WHERE `id`=393;
UPDATE `products` SET `name`='Dalton House Sweet Rose Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House sweet rose fine handwash, a rich purple handwash with a soft rose scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Sweet rose scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=394;
UPDATE `products` SET `name`='Dalton House Sea Breeze Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House sea breeze fine handwash, a clear blue handwash with a fresh, clean scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Sea breeze scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=395;
UPDATE `products` SET `name`='Dalton House Orchard Burst Fine Handwash (500ml)', `size`='500ml', `description`='Dalton House orchard burst fine handwash, an olive green handwash with a fresh, fruity scent. A smart bottle to leave by the sink. 500ml.', `key_benefits`='Orchard burst scent
Fine handwash
Looks good by the sink
500ml pump bottle', `how_to_use`='Wet your hands.
Pump a little and lather.
Rinse well.' WHERE `id`=396;
UPDATE `products` SET `name`='Tea Tree & Peppermint Deep Moisturising Hand Pack', `size`=NULL, `description`='A tea tree and peppermint deep moisturising hand pack. It moisturises deeply and helps dry hands feel soft again. A simple at-home hand treatment.', `key_benefits`='Tea tree and peppermint
Deep moisturising
For dry hands
At-home treatment', `how_to_use`='Slip your hands into the gloves.
Leave for the time shown on the pack.
Massage any leftover product into your skin.' WHERE `id`=397;
UPDATE `products` SET `name`='XHC Tea Tree Moisturising Shampoo (400ml)', `size`='400ml', `description`='XHC tea tree moisturising shampoo for frequent use. It cleans and refreshes hair and scalp. Pairs with the Tea Tree Moisturising Conditioner. 400ml.', `key_benefits`='Tea tree oil
Moisturising formula
For frequent use
400ml', `how_to_use`='Wet your hair.
Massage into scalp and hair until it lathers.
Rinse well. Follow with Tea Tree Moisturising Conditioner.' WHERE `id`=398;

-- Site text (only the fields that changed; your other settings are kept)
UPDATE `site_content` SET `data` = JSON_SET(`data`,
  '$.heroLine1', 'Hair, skin and home care',
  '$.heroLine2', 'at 600+ stores in Nigeria',
  '$.exploreLabel', '180 products across 20+ ranges',
  '$.ctaText', 'Find your favourites at a store near you.',
  '$.quoteText', 'Caring for yourself should be simple, and it should not cost a fortune.',
  '$.shopSubtitle', 'Hair care, skin and body care, oral care, nail and foot care, and home essentials.',
  '$.feat1Text', 'A cooling aloe vera gel for dry or sun-exposed skin. Use it after sun, after shaving or any time your skin feels tight.',
  '$.feat2Text', 'Face wash, wipes, toner, shampoo and more, all with tea tree oil for a fresh, clean feel on oily and spot-prone skin.',
  '$.feat3Text', 'Argan oil shampoo, conditioner, hair mask and treatment oil that tame frizz and leave dry hair soft and shiny.',
  '$.pillar1Title', 'Ingredients you know',
  '$.pillar1Desc', 'Each range is built around one key ingredient, like aloe vera, tea tree, argan oil, vitamin C, neem or coconut, named right on the pack.',
  '$.pillar2Title', 'Vegan options',
  '$.pillar2Desc', 'Many of our ranges carry a vegan mark, including So Fresh, Aloe Vera, Argan Oil and XHC Fruit Fusion. Check the pack for the logo.',
  '$.pillar3Title', 'Made for everyday use',
  '$.pillar3Desc', 'Washes, creams and toothpastes for the whole family to use every day, with options for sensitive skin and sensitive teeth.',
  '$.pillar4Title', 'Nationwide availability',
  '$.pillar4Desc', 'Sold at more than 600 stores in 22 states, from Lagos and Abuja to Port Harcourt, Benin and Ibadan.',
  '$.step1Title', 'Pick your concern',
  '$.step1Desc', 'Skin, hair, teeth, nails, feet or home. Each has its own range in our catalogue.',
  '$.step2Title', 'Choose your products',
  '$.step2Desc', 'Every product page says what it does, the size and how to use it. Ask us on WhatsApp if you are not sure.',
  '$.step3Title', 'Get it near you',
  '$.step3Desc', 'Buy at one of our 600+ stockists across Nigeria, or send us an enquiry and we will help you order.',
  '$.aboutLead', 'Good hair, skin and home care should be easy to find and easy to afford. We bring Xpel Beauty Care to shops across Nigeria, so you can pick it up close to home.',
  '$.aboutStoryBody1', 'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria.',
  '$.aboutStoryBody2', 'Each range is built around one key ingredient, like tea tree, aloe vera or argan oil, and every pack says what the product is for. We supply more than 600 shops in 22 states, so most people can find our products close to home.',
  '$.aboutValue1', 'Ranges built around one key ingredient',
  '$.aboutValue2', 'Clear labels that say what each product does',
  '$.aboutValue3', 'Care for hair, skin, teeth, nails, feet and home',
  '$.aboutValue4', 'Good quality at prices that fit a family budget',
  '$.aboutValue5', 'Sold at 600+ stores across Nigeria',
  '$.aboutMission', 'To make good, affordable personal care and home products easy to find for every household in Nigeria.',
  '$.aboutVision', 'To be the first name Nigerian families think of for personal care and household essentials.',
  '$.aboutCtaTitle', 'Find your routine',
  '$.aboutCtaText', 'Browse the catalogue, choose what suits you, then pick it up at a store near you or send us an enquiry.',
  '$.contactIntro', 'Want to order, stock our products in your shop or ask about a product? Send us a message and we will get back to you.',
  '$.storesIntro', 'Find Xpel Beauty Care at more than 600 stores across Nigeria.',
  '$.seo.defaultDescription', 'Shop Xpel Beauty Care in Nigeria: hair care, skin and body care, oral care, nail and foot care and home essentials, sold at 600+ stores nationwide.',
  '$.seo.pages.home.description', 'Xpel Beauty Care hair, skin, body, oral and home care in Nigeria. 180 products, sold at 600+ stores in Lagos, Abuja, Port Harcourt and across 22 states.',
  '$.seo.pages.shop.description', 'Browse the full Xpel Beauty Care range: shampoos, conditioners, face washes, serums, body creams, toothpastes and home essentials. Find them at 600+ stores in Nigeria.',
  '$.seo.pages.about.description', 'Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria, supplying more than 600 stores in 22 states.',
  '$.seo.pages.contact.description', 'Contact Xpel Beauty NG to order, stock our products in your shop or ask about a product. We serve customers across Nigeria.',
  '$.seo.pages.stores.description', 'Find an Xpel Beauty Care stockist near you. More than 600 stores in Lagos, Abuja, Port Harcourt and 19 more states.',
  '$.banners.stores.text', 'Sold at more than 600 stores in 22 states.',
  '$.heroSlides[0].descriptor', 'Tea Tree Hair & Skin Collection',
  '$.heroSlides[0].benefits', JSON_ARRAY('Tea tree oil for a fresh, clean feel', 'Shampoo, conditioner, face wash and more', 'Gentle enough for everyday use'),
  '$.heroSlides[1].descriptor', 'Moroccan Argan Oil Collection',
  '$.heroSlides[1].benefits', JSON_ARRAY('Tames frizz and softens dry hair', 'Adds shine you can see', 'Shampoo, conditioner, mask and oil'),
  '$.heroSlides[2].descriptor', 'Black Castor Oil & Avocado Hair Collection',
  '$.heroSlides[2].headlineLine1', 'Nourish',
  '$.heroSlides[2].headlineLine2', '& Shine',
  '$.heroSlides[2].benefits', JSON_ARRAY('Black castor oil and avocado', 'Adds shine to dry hair', 'With hyaluronic acid to hold in moisture'),
  '$.heroSlides[3].descriptor', 'Hydrating Watermelon Skincare',
  '$.heroSlides[3].benefits', JSON_ARRAY('Hydrates with hyaluronic acid', 'With vitamins C and E', 'Watermelon extract and aloe vera')) WHERE `id` = 1;
COMMIT;
