# Deploying XpelBeauty NG to Hostinger

This is the complete, from-scratch checklist to get this site live on Hostinger shared hosting. Do the steps in order — each one depends on the last.

You need: a Hostinger hosting plan with PHP 8+ and MySQL (any shared plan works), and your domain pointed at Hostinger.

---

## 1. Create the MySQL database

In **hPanel → Databases → MySQL Databases**:

1. Create a new database (e.g. `u123456789_xpel`) and a database user with a strong password. Hostinger auto-prefixes both with your account ID — that's normal.
2. Write down: **DB name**, **DB user**, **DB password**, **DB host** (usually `localhost`).

## 2. Import the database — one file, one click

This repo has exactly **one** SQL file: **`COMPLETE_IMPORT.sql`** (repo root). It contains every table (`products`, `blog_posts`, `stores`, `enquiries`, `site_content`) and the full current catalogue — all 164 products, all 5 blog posts, 600 stockists, and every homepage/menu/content setting — pulled fresh from the live site.

1. hPanel → Databases → **phpMyAdmin** → open your new database.
2. **Import** tab → choose `COMPLETE_IMPORT.sql` → Go.
3. It drops-and-recreates all 5 tables and loads all the data. Safe to re-run any time you want to reset to a known-good state (it will wipe any admin edits made after import, so only re-run intentionally).

You will **never** need any of the older scattered `.sql` scripts that used to live in this repo — they've been deleted and folded into this one file.

## 3. Set the real DB credentials (kept out of git, on purpose)

The PHP API reads its DB credentials from a file that is **not** in this repo, so your password never touches GitHub.

1. Copy `xpel-config.example.php` → rename to `xpel-config.php`.
2. Fill in the real values:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_NAME', 'u123456789_xpel');
   define('DB_USER', 'u123456789_xpel');
   define('DB_PASS', 'your-real-db-password');
   define('API_TOKEN', 'a-long-random-secret');   // generate: openssl rand -hex 32
   define('ALLOWED_ORIGIN', 'https://yourdomain.com');
   ```
3. Upload this file via Hostinger **File Manager** to the folder **one level above** `public_html` (i.e. your home directory, next to `public_html`, not inside it). `public/api/config.php` already checks that location first. Keeping it outside `public_html` means it's never web-accessible and never gets overwritten when you re-upload the build.
4. `API_TOKEN` here must exactly match `VITE_API_TOKEN` you set in step 4 below — this is the shared secret that lets the admin dashboard write to the database.

## 4. Build the site locally

In this project folder, create `.env` (copy `.env.example`) and set:

```
VITE_API_BASE=/api
VITE_API_TOKEN=the-same-long-random-secret-from-xpel-config.php
VITE_SITE_URL=https://yourdomain.com
VITE_PRERENDER_API=https://yourdomain.com/api
```

`VITE_SITE_URL` / `VITE_PRERENDER_API` are what let the build step pre-render every product, collection and blog page with correct SEO tags — leave them blank only if you don't have the domain live yet.

Then:

```bash
npm install
npm run build
```

This produces a `dist/` folder containing the compiled site **and** the PHP API (`dist/api/*.php`) and `.htaccess` (both are copied automatically from `public/`).

## 5. Upload `dist/` to Hostinger

Via hPanel **File Manager** (or FTP):

1. Open `public_html` — delete any placeholder/default files already there.
2. Upload the **entire contents of `dist/`** (not the `dist` folder itself — its contents) into `public_html`. That means `index.html`, the `assets/` folder, `.htaccess`, `api/`, `Img/`, `banner/`, `robots.txt`/`sitemap.xml` handling, etc. all end up directly in `public_html`.
3. Confirm `xpel-config.php` from step 3 is still sitting one level **above** `public_html` — it is untouched by this upload since it was never part of `dist/`.

## 6. Verify

1. Visit `https://yourdomain.com` — homepage, shop, a product page, blog, stores.
2. Visit `https://yourdomain.com/admin`, log in, confirm you can edit a product and it saves (this proves `xpel-config.php` + `API_TOKEN` are wired correctly).
3. Test `/scan` (barcode scanner) on a mobile device.
4. Check `https://yourdomain.com/robots.txt` and `/sitemap.xml` load (served by `api/robots.php` / `api/sitemap.php`).

If admin edits fail with 401, double-check `API_TOKEN` matches exactly in both `xpel-config.php` and the `.env` used for the build (the token gets baked into the built JS, so a mismatch requires a rebuild + re-upload, not just an edit on the server).

---

## Updating the live site later

- **Code/content changes** (new products via admin, new copy, etc.): just use the `/admin` dashboard — writes go straight to the live MySQL database, no redeploy needed.
- **Code changes** (new features, design changes): `npm run build` again locally, re-upload the new `dist/` contents over `public_html`. The database is untouched by this — you do **not** need to re-import `COMPLETE_IMPORT.sql`.
- **Full data reset**: only if you want to wipe live edits and restore to the last known-good snapshot, re-run `COMPLETE_IMPORT.sql` in phpMyAdmin. Generate a fresh one from live Supabase data if you want an updated snapshot first.
