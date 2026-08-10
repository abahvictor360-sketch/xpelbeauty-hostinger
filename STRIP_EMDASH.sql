-- Removes em dashes (—) from all stored content, replacing with a plain
-- hyphen (-). Mirrors the cleanup already applied to the Supabase database.
-- Safe to run more than once — REPLACE() is a no-op once there's nothing
-- left to replace.
--
-- Run this in Hostinger's phpMyAdmin / SQL tool against the xpel database.

UPDATE products
SET
  description  = REPLACE(description,  '—', '-'),
  how_to_use   = REPLACE(how_to_use,    '—', '-'),
  key_benefits = REPLACE(key_benefits,  '—', '-')
WHERE description  LIKE '%—%'
   OR how_to_use   LIKE '%—%'
   OR key_benefits LIKE '%—%';

UPDATE blog_posts
SET
  title   = REPLACE(title,   '—', '-'),
  content = REPLACE(content, '—', '-'),
  excerpt = REPLACE(excerpt, '—', '-')
WHERE title   LIKE '%—%'
   OR content LIKE '%—%'
   OR excerpt LIKE '%—%';

-- site_content.data is a JSON blob stored as TEXT — REPLACE() works
-- directly on the raw text, so this is safe and doesn't touch the JSON
-- structure, only the character inside string values.
UPDATE site_content
SET data = REPLACE(data, '—', '-')
WHERE data LIKE '%—%';
