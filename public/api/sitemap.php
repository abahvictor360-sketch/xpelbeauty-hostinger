<?php
require_once __DIR__ . '/config.php';

$proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host  = $proto . '://' . $_SERVER['HTTP_HOST'];

header('Content-Type: application/xml; charset=utf-8');
header('Cache-Control: public, max-age=3600');

$db       = xpel_db();
$products = $db->query("SELECT id, updated_at FROM products WHERE active = 1 ORDER BY id")->fetchAll();
$posts    = $db->query("SELECT slug, updated_at FROM blog_posts WHERE published = 1 ORDER BY created_at DESC")->fetchAll();

$collections = [];
$contentRow = $db->query("SELECT data FROM site_content WHERE id = 1")->fetch();
if ($contentRow && !empty($contentRow['data'])) {
    $content = json_decode($contentRow['data'], true);
    if (!empty($content['collections']) && is_array($content['collections'])) {
        foreach ($content['collections'] as $c) {
            if (!empty($c['slug'])) $collections[] = $c['slug'];
        }
    }
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

$static = [
  ['loc' => '/',                      'priority' => '1.0', 'changefreq' => 'weekly'],
  ['loc' => '/shop',                  'priority' => '0.9', 'changefreq' => 'daily'],
  ['loc' => '/shop?cat=hair-care',    'priority' => '0.8', 'changefreq' => 'daily'],
  ['loc' => '/shop?cat=body-beauty',  'priority' => '0.8', 'changefreq' => 'daily'],
  ['loc' => '/about',                 'priority' => '0.7', 'changefreq' => 'monthly'],
  ['loc' => '/contact',               'priority' => '0.7', 'changefreq' => 'monthly'],
  ['loc' => '/stores',                'priority' => '0.7', 'changefreq' => 'weekly'],
  ['loc' => '/blog',                  'priority' => '0.8', 'changefreq' => 'weekly'],
  ['loc' => '/privacy',               'priority' => '0.3', 'changefreq' => 'monthly'],
];

foreach ($static as $p) {
    echo "  <url>\n";
    echo "    <loc>{$host}{$p['loc']}</loc>\n";
    echo "    <changefreq>{$p['changefreq']}</changefreq>\n";
    echo "    <priority>{$p['priority']}</priority>\n";
    echo "  </url>\n";
}

foreach ($collections as $slug) {
    $slugEsc = htmlspecialchars($slug, ENT_XML1);
    echo "  <url>\n";
    echo "    <loc>{$host}/collection/{$slugEsc}</loc>\n";
    echo "    <changefreq>weekly</changefreq>\n";
    echo "    <priority>0.7</priority>\n";
    echo "  </url>\n";
}

foreach ($products as $p) {
    $lastmod = date('Y-m-d', strtotime($p['updated_at']));
    echo "  <url>\n";
    echo "    <loc>{$host}/product/{$p['id']}</loc>\n";
    echo "    <lastmod>{$lastmod}</lastmod>\n";
    echo "    <changefreq>weekly</changefreq>\n";
    echo "    <priority>0.8</priority>\n";
    echo "  </url>\n";
}

foreach ($posts as $p) {
    $slug    = htmlspecialchars($p['slug'], ENT_XML1);
    $lastmod = date('Y-m-d', strtotime($p['updated_at']));
    echo "  <url>\n";
    echo "    <loc>{$host}/blog/{$slug}</loc>\n";
    echo "    <lastmod>{$lastmod}</lastmod>\n";
    echo "    <changefreq>monthly</changefreq>\n";
    echo "    <priority>0.7</priority>\n";
    echo "  </url>\n";
}

echo '</urlset>';
