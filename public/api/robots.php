<?php
$proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host  = $proto . '://' . $_SERVER['HTTP_HOST'];
header('Content-Type: text/plain; charset=utf-8');
header('Cache-Control: public, max-age=86400');

$bots = [
    'Googlebot', 'Bingbot',
    // AI answer-engine crawlers (AEO) — explicitly allowed
    'GPTBot', 'ChatGPT-User', 'OAI-SearchBot',
    'ClaudeBot', 'Claude-Web', 'anthropic-ai',
    'PerplexityBot', 'Perplexity-User',
    'Google-Extended', 'Applebot', 'Applebot-Extended',
    'Bytespider', 'meta-externalagent',
];

echo "User-agent: *\n";
echo "Allow: /\n";
echo "Disallow: /admin/\n";
echo "Disallow: /api/\n";
echo "\n";

foreach ($bots as $bot) {
    echo "User-agent: $bot\n";
    echo "Allow: /\n";
    echo "\n";
}

echo "Sitemap: $host/sitemap.xml\n";
