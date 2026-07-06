<?php
require_once __DIR__ . '/config.php';
xpel_cors();
header('Content-Type: application/json; charset=utf-8');

$db     = xpel_db();
$method = $_SERVER['REQUEST_METHOD'];
$id     = isset($_GET['id'])   ? (int)$_GET['id'] : null;
$slug   = $_GET['slug']        ?? null;
$admin  = isset($_GET['admin']);

if ($method === 'GET') {
    if ($id) {
        $stmt = $db->prepare('SELECT * FROM blog_posts WHERE id = ?');
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if (!$row) xpel_json(['error' => 'Not found'], 404);
        $row['image'] = $row['featured_image'];
        xpel_json($row);
    }

    if ($slug) {
        $stmt = $db->prepare('SELECT * FROM blog_posts WHERE slug = ? AND published = 1');
        $stmt->execute([$slug]);
        $row = $stmt->fetch();
        if (!$row) xpel_json(['error' => 'Not found'], 404);
        $row['image'] = $row['featured_image'];
        xpel_json($row);
    }

    if ($admin) {
        $stmt = $db->query('SELECT * FROM blog_posts ORDER BY created_at DESC');
    } else {
        $stmt = $db->query('SELECT * FROM blog_posts WHERE published = 1 ORDER BY created_at DESC');
    }
    $rows = $stmt->fetchAll();
    foreach ($rows as &$r) { $r['image'] = $r['featured_image']; }
    xpel_json($rows);
}

if ($method === 'POST') {
    xpel_require_token();
    $body    = xpel_body();
    $allowed = ['title','slug','content','excerpt','author','featured_image','published'];
    $body    = array_intersect_key($body, array_flip($allowed));
    if (empty($body['title'])) xpel_json(['error' => 'title is required'], 400);

    // Generate slug if missing
    if (empty($body['slug']) && !empty($body['title'])) {
        $body['slug'] = strtolower(trim(preg_replace('/[^a-z0-9]+/', '-', $body['title']), '-'));
    }
    $body['published'] = (int)($body['published'] ?? 0);

    $cols = implode(',', array_keys($body));
    $phs  = implode(',', array_fill(0, count($body), '?'));
    $stmt = $db->prepare("INSERT INTO blog_posts ($cols) VALUES ($phs)");
    $stmt->execute(array_values($body));
    $newId = (int)$db->lastInsertId();
    $stmt2 = $db->prepare('SELECT * FROM blog_posts WHERE id = ?');
    $stmt2->execute([$newId]);
    $row = $stmt2->fetch();
    $row['image'] = $row['featured_image'];
    xpel_json($row, 201);
}

if ($method === 'PUT') {
    xpel_require_token();
    $body    = xpel_body();
    $id      = (int)($body['id'] ?? 0);
    if (!$id) xpel_json(['error' => 'id required'], 400);

    $allowed = ['title','slug','content','excerpt','author','featured_image','published'];
    $fields  = array_intersect_key($body, array_flip($allowed));
    if (isset($fields['published'])) $fields['published'] = (int)$fields['published'];
    if (empty($fields)) xpel_json(['error' => 'Nothing to update'], 400);

    $set  = implode(',', array_map(fn($k) => "$k=?", array_keys($fields)));
    $vals = [...array_values($fields), $id];
    $stmt = $db->prepare("UPDATE blog_posts SET $set WHERE id=?");
    $stmt->execute($vals);
    $stmt2 = $db->prepare('SELECT * FROM blog_posts WHERE id = ?');
    $stmt2->execute([$id]);
    $row = $stmt2->fetch();
    $row['image'] = $row['featured_image'];
    xpel_json($row);
}

if ($method === 'DELETE') {
    xpel_require_token();
    if (!$id) xpel_json(['error' => 'id required'], 400);
    $stmt = $db->prepare('DELETE FROM blog_posts WHERE id = ?');
    $stmt->execute([$id]);
    xpel_json(['deleted' => $id]);
}

xpel_json(['error' => 'Method not allowed'], 405);
