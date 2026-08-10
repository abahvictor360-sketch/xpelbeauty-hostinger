-- Adds the "Makeup Essentials" and "Men Grooming Products" collections to
-- this database's site_content JSON blob, IF a site_content row already
-- exists and has saved data (i.e. it's not just falling back to code
-- defaults). Safe to run more than once — checks first with JSON_SEARCH.
--
-- Run this in Hostinger's phpMyAdmin / SQL tool against the xpel database.

-- 1. Append to the root "collections" array (safe — always index 0 append target)
UPDATE site_content
SET data = JSON_ARRAY_APPEND(
  data, '$.collections',
  JSON_OBJECT(
    'slug', 'makeup-essentials',
    'name', 'Makeup Essentials',
    'subtitle', 'Prep, Set & Perfect',
    'description', 'Everything you need to prep, set and perfect your makeup — lip butters, setting sprays, makeup removers and glow serums from Hot Rose.',
    'heroImage', '/banner/Product-Face-Care.webp',
    'overlayColor', 'rgba(180, 45, 90, 0.82)',
    'accentColor', '#B42D5A',
    'filterType', 'brand',
    'filterValue', 'Hot Rose'
  )
)
WHERE id = 1
  AND JSON_SEARCH(data, 'one', 'makeup-essentials') IS NULL;

UPDATE site_content
SET data = JSON_ARRAY_APPEND(
  data, '$.collections',
  JSON_OBJECT(
    'slug', 'men-grooming',
    'name', 'Men Grooming Products',
    'subtitle', 'Built For The Everyday Grind',
    'description', '48-hour protection built for men — deodorants and grooming essentials from the Nulab Men Protect range.',
    'heroImage', '/banner/Product-Body-Care.webp',
    'overlayColor', 'rgba(20, 42, 59, 0.85)',
    'accentColor', '#1B2A3B',
    'filterType', 'name',
    'filterValue', 'Men Protect'
  )
)
WHERE id = 1
  AND JSON_SEARCH(data, 'one', 'men-grooming') IS NULL;

-- 2. Mega menu "Shop by Type" links: the brandGroups array's index for that
--    group can vary, so this part is NOT scripted blindly here to avoid
--    appending into the wrong group. Instead:
--    a) Check the current structure first:
--       SELECT JSON_SEARCH(data, 'one', 'Shop by Type') FROM site_content WHERE id = 1;
--       This returns a path like "$.megaMenu.brandGroups[7].group" — note the index.
--    b) Then run (replacing N with that index):
--       UPDATE site_content
--       SET data = JSON_ARRAY_APPEND(
--         JSON_ARRAY_APPEND(
--           data, '$.megaMenu.brandGroups[N].items',
--           JSON_OBJECT('name', 'Makeup Essentials', 'href', '/collection/makeup-essentials')
--         ),
--         '$.megaMenu.brandGroups[N].items',
--         JSON_OBJECT('name', 'Men Grooming Products', 'href', '/collection/men-grooming')
--       )
--       WHERE id = 1;
--    Or simpler and safer: add these two links through the Admin > Content
--    Manager UI, if this build has one wired to mega menu editing.
