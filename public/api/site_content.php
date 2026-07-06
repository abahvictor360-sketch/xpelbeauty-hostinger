<?php
require_once __DIR__ . '/config.php';
xpel_cors();
header('Content-Type: application/json; charset=utf-8');

$db     = xpel_db();
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $stmt = $db->prepare('SELECT data FROM site_content WHERE id = 1');
    $stmt->execute();
    $row = $stmt->fetch();
    if (!$row) xpel_json(['data' => null]);
    xpel_json(['data' => json_decode($row['data'], true)]);
}

if ($method === 'POST') {
    xpel_require_token();
    $body = xpel_body();
    if (empty($body)) xpel_json(['error' => 'Empty payload'], 400);

    $json = json_encode($body, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

    $stmt = $db->prepare('INSERT INTO site_content (id, data) VALUES (1, ?) ON DUPLICATE KEY UPDATE data = ?');
    $stmt->execute([$json, $json]);
    xpel_json(['saved' => true]);
}

if ($method === 'PUT') {
    // Targeted patch: merge a partial object into the existing data
    xpel_require_token();
    $patch = xpel_body();
    if (empty($patch)) xpel_json(['error' => 'Empty payload'], 400);

    $stmt = $db->prepare('SELECT data FROM site_content WHERE id = 1');
    $stmt->execute();
    $row = $stmt->fetch();
    $existing = $row ? (json_decode($row['data'], true) ?? []) : [];

    $merged = array_merge($existing, $patch);
    $json   = json_encode($merged, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

    $stmt2 = $db->prepare('INSERT INTO site_content (id, data) VALUES (1, ?) ON DUPLICATE KEY UPDATE data = ?');
    $stmt2->execute([$json, $json]);
    xpel_json(['saved' => true]);
}

xpel_json(['error' => 'Method not allowed'], 405);
