<?php
require_once __DIR__ . '/config.php';
xpel_cors();
header('Content-Type: application/json; charset=utf-8');

$db     = xpel_db();
$method = $_SERVER['REQUEST_METHOD'];
$id     = isset($_GET['id']) ? (int)$_GET['id'] : null;

if ($method === 'GET') {
    if ($id) {
        $stmt = $db->prepare('SELECT * FROM stores WHERE id = ?');
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if (!$row) xpel_json(['error' => 'Not found'], 404);
        xpel_json($row);
    }
    $stmt = $db->query('SELECT * FROM stores ORDER BY name ASC');
    xpel_json($stmt->fetchAll());
}

if ($method === 'POST') {
    xpel_require_token();
    $body    = xpel_body();
    $allowed = ['name','address','city','state','phone','email','hours','logo','latitude','longitude'];
    $body    = array_intersect_key($body, array_flip($allowed));
    if (empty($body['name'])) xpel_json(['error' => 'name is required'], 400);

    $cols = implode(',', array_keys($body));
    $phs  = implode(',', array_fill(0, count($body), '?'));
    $stmt = $db->prepare("INSERT INTO stores ($cols) VALUES ($phs)");
    $stmt->execute(array_values($body));
    $newId = (int)$db->lastInsertId();
    $stmt2 = $db->prepare('SELECT * FROM stores WHERE id = ?');
    $stmt2->execute([$newId]);
    xpel_json($stmt2->fetch(), 201);
}

if ($method === 'PUT') {
    xpel_require_token();
    $body    = xpel_body();
    $id      = (int)($body['id'] ?? 0);
    if (!$id) xpel_json(['error' => 'id required'], 400);

    $allowed = ['name','address','city','state','phone','email','hours','logo','latitude','longitude'];
    $fields  = array_intersect_key($body, array_flip($allowed));
    if (empty($fields)) xpel_json(['error' => 'Nothing to update'], 400);

    $set  = implode(',', array_map(fn($k) => "$k=?", array_keys($fields)));
    $vals = [...array_values($fields), $id];
    $stmt = $db->prepare("UPDATE stores SET $set WHERE id=?");
    $stmt->execute($vals);
    $stmt2 = $db->prepare('SELECT * FROM stores WHERE id = ?');
    $stmt2->execute([$id]);
    xpel_json($stmt2->fetch());
}

if ($method === 'DELETE') {
    xpel_require_token();
    if (!$id) xpel_json(['error' => 'id required'], 400);
    $stmt = $db->prepare('DELETE FROM stores WHERE id = ?');
    $stmt->execute([$id]);
    xpel_json(['deleted' => $id]);
}

xpel_json(['error' => 'Method not allowed'], 405);
