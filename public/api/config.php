<?php
/**
 * Database & API configuration for XpelBeauty Hostinger.
 *
 * On production, create /home/USERNAME/xpel-config.php (one level above
 * public_html) with your real credentials so they are never in the repo:
 *
 *   <?php
 *   define('DB_HOST', 'localhost');
 *   define('DB_NAME', 'your_db_name');
 *   define('DB_USER', 'your_db_user');
 *   define('DB_PASS', 'your_db_password');
 *   define('API_TOKEN', 'some-long-random-secret');
 *   define('ALLOWED_ORIGIN', 'https://yourdomain.com');
 *
 * This file then loads that, falling back to local dev values.
 */

// Load config — checks public_html root first, then one level above as fallback.
// The file is excluded from FTP deploy so it is never overwritten on redeploy.
$extConfig = dirname(dirname(__FILE__)) . '/xpel-config.php';          // public_html/xpel-config.php
$extConfigAbove = dirname(dirname(dirname(__FILE__))) . '/xpel-config.php'; // one above public_html
if (file_exists($extConfig)) {
    require_once $extConfig;
} elseif (file_exists($extConfigAbove)) {
    require_once $extConfigAbove;
}

// Defaults for local dev — override by defining constants in xpel-config.php
defined('DB_HOST')       || define('DB_HOST',       'localhost');
defined('DB_NAME')       || define('DB_NAME',       'xpelbeauty');
defined('DB_USER')       || define('DB_USER',       'root');
defined('DB_PASS')       || define('DB_PASS',       '');
defined('API_TOKEN')     || define('API_TOKEN',     'dev-token-change-me');
defined('ALLOWED_ORIGIN')|| define('ALLOWED_ORIGIN', '*');

// ── CORS ─────────────────────────────────────────────────────────────────────
function xpel_cors(): void {
    $origin = ALLOWED_ORIGIN === '*' ? '*' : ALLOWED_ORIGIN;
    header("Access-Control-Allow-Origin: $origin");
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, X-Admin-Token');
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }
}

// ── DB connection (singleton) ─────────────────────────────────────────────────
function xpel_db(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4';
        $pdo = new PDO($dsn, DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]);
    }
    return $pdo;
}

// ── Auth helper ───────────────────────────────────────────────────────────────
function xpel_require_token(): void {
    $sent = $_SERVER['HTTP_X_ADMIN_TOKEN'] ?? '';
    if (!hash_equals(API_TOKEN, $sent)) {
        http_response_code(401);
        echo json_encode(['error' => 'Unauthorized']);
        exit;
    }
}

// ── JSON helpers ──────────────────────────────────────────────────────────────
function xpel_json(mixed $data, int $status = 200): void {
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function xpel_body(): array {
    $raw = file_get_contents('php://input');
    return json_decode($raw, true) ?? [];
}
