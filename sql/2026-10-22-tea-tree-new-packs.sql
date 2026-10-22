-- Xpel Beauty NG (2026-10-22): Tea Tree Foaming Face Wash and Facial Scrub in the new XBC pack. Hostinger / MySQL. Safe to run more than once.
UPDATE `products` SET `image` = '/Img/xbc-tea-tree-foaming-face-wash-new.png',
  `description` = 'A tea tree foaming face wash made with tea tree and peppermint oils. The rich foam cleanses and refreshes skin, so your face feels clean and fresh after every wash. 200ml.',
  `key_benefits` = 'With tea tree and peppermint oils\nCleanses and refreshes skin\nRich foam lifts dirt and oil\n200ml pump bottle'
WHERE `id` = 225;
UPDATE `products` SET `image` = '/Img/xbc-tea-tree-facial-scrub-250ml-new.png', `name` = 'Tea Tree Facial Scrub (250ml)',
  `description` = 'XBC Tea Tree facial scrub in a 250ml tube. It cleanses pores and gently exfoliates for fresher, smoother skin.',
  `key_benefits` = 'Cleanses pores\nGently exfoliates\nFor fresher, smoother skin\n250ml tube'
WHERE `id` = 424;
