<?php
require_once __DIR__ . '/config.php';
xpel_cors();
header('Content-Type: application/json; charset=utf-8');

$db     = xpel_db();
$method = $_SERVER['REQUEST_METHOD'];
$id     = isset($_GET['id'])   ? (int)$_GET['id']   : null;
$cat    = $_GET['category']   ?? null;
$admin  = isset($_GET['admin']);
$bulk   = isset($_GET['bulk']);

if ($method === 'GET') {
    if ($id) {
        $stmt = $db->prepare('SELECT * FROM products WHERE id = ?');
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if (!$row) xpel_json(['error' => 'Not found'], 404);
        xpel_json($row);
    }

    if ($cat) {
        $stmt = $db->prepare('SELECT * FROM products WHERE category = ? ORDER BY created_at DESC');
        $stmt->execute([$cat]);
        xpel_json($stmt->fetchAll());
    }

    // All products (admin or public — no auth difference for reads)
    $stmt = $db->query('SELECT * FROM products ORDER BY created_at DESC');
    xpel_json($stmt->fetchAll());
}

if ($method === 'POST') {
    xpel_require_token();

    $allowed = ['name','brand','category','price','stock','image','description','size','key_benefits','how_to_use'];

    if ($bulk) {
        $rows = xpel_body();
        if (!is_array($rows) || empty($rows)) xpel_json(['error' => 'Empty payload'], 400);
        $db->beginTransaction();
        foreach ($rows as $row) {
            $row = array_intersect_key($row, array_flip($allowed));
            if (empty($row)) continue;
            $cols = implode(',', array_keys($row));
            $phs  = implode(',', array_fill(0, count($row), '?'));
            $stmt = $db->prepare("INSERT INTO products ($cols) VALUES ($phs)");
            $stmt->execute(array_values($row));
        }
        $db->commit();
        xpel_json(['inserted' => count($rows)], 201);
    }

    $body = xpel_body();
    $body = array_intersect_key($body, array_flip($allowed));
    if (empty($body['name'])) xpel_json(['error' => 'name is required'], 400);

    $cols = implode(',', array_keys($body));
    $phs  = implode(',', array_fill(0, count($body), '?'));
    $stmt = $db->prepare("INSERT INTO products ($cols) VALUES ($phs)");
    $stmt->execute(array_values($body));
    $newId = (int)$db->lastInsertId();
    $stmt2 = $db->prepare('SELECT * FROM products WHERE id = ?');
    $stmt2->execute([$newId]);
    xpel_json($stmt2->fetch(), 201);
}

if ($method === 'PUT') {
    xpel_require_token();
    $body = xpel_body();
    $id   = (int)($body['id'] ?? 0);
    if (!$id) xpel_json(['error' => 'id required'], 400);

    $allowed = ['name','brand','category','price','stock','image','description','size','key_benefits','how_to_use'];
    $fields  = array_intersect_key($body, array_flip($allowed));
    if (empty($fields)) xpel_json(['error' => 'Nothing to update'], 400);

    $set  = implode(',', array_map(fn($k) => "$k=?", array_keys($fields)));
    $vals = [...array_values($fields), $id];
    $stmt = $db->prepare("UPDATE products SET $set WHERE id=?");
    $stmt->execute($vals);
    $stmt2 = $db->prepare('SELECT * FROM products WHERE id = ?');
    $stmt2->execute([$id]);
    xpel_json($stmt2->fetch());
}

if ($method === 'DELETE') {
    xpel_require_token();
    if (!$id) xpel_json(['error' => 'id required'], 400);
    $stmt = $db->prepare('DELETE FROM products WHERE id = ?');
    $stmt->execute([$id]);
    xpel_json(['deleted' => $id]);
}

xpel_json(['error' => 'Method not allowed'], 405);
