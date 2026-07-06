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
    $body    = xpel_body();
    $allowed = ['type','name','email','subject','message','product_id','product_name','status'];
    $body    = array_intersect_key($body, array_flip($allowed));
    if (empty($body['name']) || empty($body['email'])) {
        xpel_json(['error' => 'name and email are required'], 400);
    }
    $body['status'] = $body['status'] ?? 'new';
    $body['type']   = $body['type']   ?? 'contact';

    $cols = implode(',', array_keys($body));
    $phs  = implode(',', array_fill(0, count($body), '?'));
    $stmt = $db->prepare("INSERT INTO enquiries ($cols) VALUES ($phs)");
    $stmt->execute(array_values($body));
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
