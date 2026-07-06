<?php
/**
 * XpelBeauty — production config
 *
 * SETUP (one time only):
 *   1. Rename/copy this file to:  xpel-config.php
 *   2. Fill in the real values below
 *   3. Upload it to:  public_html/xpel-config.php  via Hostinger File Manager
 *
 * IMPORTANT: This file is excluded from GitHub deploys — it will NEVER
 * be overwritten when you push new code. Upload it once and forget it.
 *
 * Get DB credentials: Hostinger hPanel → Hosting → Manage → Databases
 */

define('DB_HOST', 'localhost');
define('DB_NAME', 'u123456789_xpel');   // your Hostinger DB name
define('DB_USER', 'u123456789_xpel');   // your Hostinger DB user
define('DB_PASS', 'your-db-password');

// Must match VITE_API_TOKEN GitHub Secret
define('API_TOKEN', 'your-long-random-secret-token');

// Your domain (or '*' during testing — change before going live)
define('ALLOWED_ORIGIN', 'https://yourdomain.com');
