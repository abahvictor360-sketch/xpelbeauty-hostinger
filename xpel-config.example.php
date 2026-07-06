<?php
/**
 * XpelBeauty Hostinger — production config
 *
 * 1. Copy this file to /home/USERNAME/xpel-config.php
 *    (one level ABOVE public_html, so it is not web-accessible)
 * 2. Fill in the real values below
 * 3. Done — public/api/config.php loads it automatically
 *
 * Get your DB credentials from Hostinger → Hosting → Manage → Databases
 */

define('DB_HOST', 'localhost');          // usually localhost on Hostinger
define('DB_NAME', 'u123456789_xpel');    // your Hostinger DB name
define('DB_USER', 'u123456789_xpel');    // your Hostinger DB user
define('DB_PASS', 'your-db-password');

// Must match VITE_API_TOKEN in your build environment / GitHub Secret
define('API_TOKEN', 'your-long-random-secret-token');

// Set to your domain to restrict CORS (or '*' for open — not recommended in prod)
define('ALLOWED_ORIGIN', 'https://yourdomain.com');
