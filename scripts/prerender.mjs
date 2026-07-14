#!/usr/bin/env node
// scripts/prerender.mjs — run AFTER `vite build` (dist/index.html is the template).
// Renders every public route in src/prerender/routes.tsx to dist/<route>/index.html
// with real body content and per-route head tags baked in, so crawlers and
// link-preview bots (which run no JS) see the actual page instead of an empty shell.
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer, loadEnv } from 'vite';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.join(__dirname, '..');
const DIST = path.join(ROOT, 'dist');
const TEMPLATE_PATH = path.join(DIST, 'index.html');

async function main() {
  if (!fs.existsSync(TEMPLATE_PATH)) {
    console.error('✖ dist/index.html not found — run `vite build` first.');
    process.exit(1);
  }
  const template = fs.readFileSync(TEMPLATE_PATH, 'utf8');

  // Vite's SSR module runner does not expose custom VITE_* vars via import.meta.env
  // the way `vite build` inlines them, so inject the ones our modules read via
  // `define` (sourced from .env or process.env, with harmless fallbacks).
  const fileEnv = loadEnv('production', ROOT, 'VITE_');
  const pick = (k, fb) => fileEnv[k] || process.env[k] || fb;
  const define = {
    'import.meta.env.VITE_SITE_URL':      JSON.stringify(pick('VITE_SITE_URL', '')),
    'import.meta.env.VITE_PRERENDER_API': JSON.stringify(pick('VITE_PRERENDER_API', '')),
    'import.meta.env.VITE_API_BASE':      JSON.stringify(pick('VITE_API_BASE', '/api')),
    'import.meta.env.VITE_API_TOKEN':     JSON.stringify(pick('VITE_API_TOKEN', '')),
  };

  // Middleware-mode server only to transform + SSR-load our TS modules.
  // hmr:false + watch:null kill the file watcher so no handle keeps Node alive.
  const vite = await createServer({
    mode: 'production',
    define,
    server: { middlewareMode: true, hmr: false, watch: null },
    optimizeDeps: { noDiscovery: true },
    appType: 'custom',
    logLevel: 'warn',
  });

  try {
    const { prerenderRoutes } = await vite.ssrLoadModule('/src/prerender/routes.tsx');
    const { renderRoute, buildHeadHtml, injectIntoTemplate } =
      await vite.ssrLoadModule('/src/prerender/render.tsx');

    let written = 0;
    for (const route of prerenderRoutes) {
      try {
        if (route.path.includes(':')) {
          const items = route.getData ? await route.getData() : [];
          if (items.length === 0) {
            console.log(`– skipped ${route.path} (no VITE_PRERENDER_API or empty list)`);
            continue;
          }
          for (const item of items) {
            const routePath = route.path.replace(/:[^/]+/, encodeURIComponent(item.param));
            const bodyHtml = renderRoute({
              path: routePath,
              routePattern: route.path,
              Component: route.Component,
            });
            const headHtml = buildHeadHtml(item.head, routePath);
            writeRoute(injectIntoTemplate(template, { headHtml, bodyHtml }), routePath);
            written++;
          }
        } else {
          const bodyHtml = renderRoute({ path: route.path, Component: route.Component });
          const headHtml = buildHeadHtml(route.head, route.path);
          writeRoute(injectIntoTemplate(template, { headHtml, bodyHtml }), route.path);
          written++;
        }
      } catch (err) {
        // Log and continue — the SPA fallback still serves this route client-side.
        console.warn(`⚠ prerender skipped ${route.path}: ${err.message}`);
      }
    }
    console.log(`✔ prerendered ${written} routes`);
  } finally {
    await vite.close();
  }
}

function writeRoute(html, routePath) {
  const rel = routePath === '/' ? 'index.html' : path.join(routePath.replace(/^\//, ''), 'index.html');
  const outPath = path.join(DIST, rel);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, html, 'utf8');
}

main()
  .then(() => process.exit(0)) // force clean exit; esbuild handles can otherwise hang the build
  .catch((err) => { console.error('✖ prerender failed:', err); process.exit(1); });
