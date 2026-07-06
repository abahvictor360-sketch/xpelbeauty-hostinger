# 🔧 Supabase Setup — Fix Dashboard Connection & Product Images

Run these in **Supabase → SQL Editor → New Query → Run**.

---

## 1️⃣ Allow public READ (fixes "Failed to connect" + empty Shop)

If Row Level Security (RLS) is ON with no policy, the anon key can't read data,
so the dashboard shows "Failed to connect" and the Shop looks empty.
This adds safe **read-only** access for everyone (writes stay protected):

```sql
-- Enable RLS (safe to run even if already enabled)
ALTER TABLE products    ENABLE ROW LEVEL SECURITY;
ALTER TABLE blog_posts  ENABLE ROW LEVEL SECURITY;
ALTER TABLE stores      ENABLE ROW LEVEL SECURITY;

-- Public READ policies
CREATE POLICY "public read products"   ON products   FOR SELECT USING (true);
CREATE POLICY "public read blog_posts" ON blog_posts FOR SELECT USING (true);
CREATE POLICY "public read stores"     ON stores     FOR SELECT USING (true);
```

If a policy already exists you'll get a "policy already exists" notice — that's fine.

---

## 2️⃣ (Optional) Allow the dashboard to WRITE

The admin dashboard uses the public anon key. To let it add/edit/delete from the
browser, add write policies too (or manage data via the SQL editor instead):

```sql
CREATE POLICY "anon write products" ON products
  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "anon write blog_posts" ON blog_posts
  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "anon write stores" ON stores
  FOR ALL USING (true) WITH CHECK (true);
```

> ⚠️ This makes writes public. Fine for a demo/internal store; for production,
> use Supabase Auth and restrict writes to authenticated admins.

---

## 3️⃣ Fix product images (point to images that exist)

The app ships with these real product images in `/public/images/`:
`product-40183.png`, `product-41639.webp`, `product-41696.webp`

Until you upload real photos, map existing products to these so nothing looks broken:

```sql
-- Spread the 3 available images across all products by id
UPDATE products SET image = 'images/product-40183.png' WHERE id % 3 = 0;
UPDATE products SET image = 'images/product-41639.webp' WHERE id % 3 = 1;
UPDATE products SET image = 'images/product-41696.webp' WHERE id % 3 = 2;
```

Or set a real hosted image for a single product:

```sql
UPDATE products
SET image = 'https://your-cdn.com/argan-shampoo.png'
WHERE name = 'Argan Oil Shampoo';
```

You can also paste an image URL per product directly in
**Admin → Products → Edit → Image URL** (a live preview now shows).

---

## 4️⃣ Live CMS — make Content Manager & Logo/Media update the site

Create a single-row table the storefront reads and the admin writes. This makes
edits in **Admin → Content Manager** and **Logo & Media** appear on the live site
for everyone:

```sql
CREATE TABLE IF NOT EXISTS site_content (
  id    INT PRIMARY KEY DEFAULT 1,
  data  JSONB NOT NULL DEFAULT '{}'::jsonb
);

ALTER TABLE site_content ENABLE ROW LEVEL SECURITY;

-- Everyone can read the content
CREATE POLICY "public read site_content" ON site_content
  FOR SELECT USING (true);

-- Allow the dashboard (anon key) to write content
CREATE POLICY "anon write site_content" ON site_content
  FOR ALL USING (true) WITH CHECK (true);

-- Seed the first row
INSERT INTO site_content (id, data) VALUES (1, '{}'::jsonb)
  ON CONFLICT (id) DO NOTHING;
```

After this, saving in the admin shows **"Saved — live site updated"** and the
homepage hero text, announcement bar, section titles, logo and carousel slides
update for all visitors. Until the table exists it saves locally (admin browser
only) and shows "Saved locally".

---

## ✅ Verify

```sql
SELECT count(*) FROM products;
SELECT id, name, image FROM products LIMIT 10;
```
