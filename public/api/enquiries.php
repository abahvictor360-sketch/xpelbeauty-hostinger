<?php
require_once __DIR__ . '/config.php';
xpel_cors();
header('Content-Type: application/json; charset=utf-8');

$db     = xpel_db();
$method = $_SERVER['REQUEST_METHOD'];
$id     = isset($_GET['id']) ? (int)$_GET['id'] : null;

if ($method === 'GET') {
    xpel_require_token();
    $stmt = $db->query('SELECT * FROM enquiries ORDER BY created_at DESC');
    xpel_json($stmt->fetchAll());
}

if ($method === 'POST') {
    $body = xpel_body();

    // ── Honeypot: bots fill the hidden _hp field; silently fake success ──
    if (!empty($body['_hp'])) {
        xpel_json(['id' => 0], 201);
    }

    // ── Sanitize first: strip tags/control chars before we even look at length ──
    $strip = static fn(string $s): string => trim(preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/', '', strip_tags($s)));
    $name    = $strip($body['name']    ?? '');
    $email   = mb_strtolower(trim($body['email'] ?? ''));
    $subject = $strip($body['subject'] ?? '');
    $message = $strip($body['message'] ?? '');

    // ── Validate ─────────────────────────────────────────────────────────
    $errors = [];
    if (mb_strlen($name) < 2 || mb_strlen($name) > 100 || !preg_match('/^[\p{L}\s\-\'\.]+$/u', $name)) {
        $errors[] = 'name: 2-100 characters, letters/spaces/hyphens/apostrophes/dots only';
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 254) {
        $errors[] = 'email: enter a valid email address';
    }
    if (mb_strlen($subject) > 200) {
        $errors[] = 'subject: must be under 200 characters';
    }
    if ($message !== '' && (mb_strlen($message) < 10 || mb_strlen($message) > 2000)) {
        $errors[] = 'message: 10-2000 characters';
    }
    if (!empty($errors)) {
        xpel_json(['error' => implode('; ', $errors)], 422);
    }

    // ── Persist ───────────────────────────────────────────────────────────
    $allowed = ['type', 'name', 'email', 'subject', 'message', 'product_id', 'product_name', 'status'];
    $clean   = array_intersect_key($body, array_flip($allowed));

    $clean['name']    = $name;
    $clean['email']   = $email;
    $clean['subject'] = $subject;
    $clean['message'] = $message;
    $clean['status']  = 'new';
    $clean['type']    = $clean['type'] ?? 'contact';

    $cols = implode(',', array_keys($clean));
    $phs  = implode(',', array_fill(0, count($clean), '?'));
    $stmt = $db->prepare("INSERT INTO enquiries ($cols) VALUES ($phs)");
    $stmt->execute(array_values($clean));
    xpel_json(['id' => (int)$db->lastInsertId()], 201);
}

if ($method === 'PUT') {
    xpel_require_token();
    $body   = xpel_body();
    $id     = (int)($body['id'] ?? 0);
    $status = $body['status'] ?? null;
    if (!$id || !$status) xpel_json(['error' => 'id and status required'], 400);

    $stmt = $db->prepare('UPDATE enquiries SET status=? WHERE id=?');
    $stmt->execute([$status, $id]);
    xpel_json(['updated' => $id]);
}

if ($method === 'DELETE') {
    xpel_require_token();
    if (!$id) xpel_json(['error' => 'id required'], 400);
    $stmt = $db->prepare('DELETE FROM enquiries WHERE id = ?');
    $stmt->execute([$id]);
    xpel_json(['deleted' => $id]);
}

xpel_json(['error' => 'Method not allowed'], 405);
