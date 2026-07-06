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

    // ── Validate ─────────────────────────────────────────────────────────
    $name    = trim($body['name']    ?? '');
    $email   = trim($body['email']   ?? '');
    $subject = trim($body['subject'] ?? '');
    $message = trim($body['message'] ?? '');

    $errors = [];
    if (strlen($name) < 2 || !preg_match('/[a-zA-Z]/', $name)) {
        $errors[] = 'name: enter a valid name (at least 2 characters with letters)';
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'email: enter a valid email address';
    }
    if ($message !== '' && strlen($message) < 10) {
        $errors[] = 'message: too short — please provide more detail';
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
