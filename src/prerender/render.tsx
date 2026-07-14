// Build-time rendering: renderRoute() turns one route into body HTML, and
// injectIntoTemplate() bakes head + body into the built dist/index.html shell.
// The client-side SEO component adopts these tags at runtime (it updates
// existing <meta>/<title> nodes via querySelector), so nothing is duplicated.
import type { ComponentType } from 'react';
import { renderToString } from 'react-dom/server';
import { MemoryRouter, Routes, Route } from 'react-router-dom';
import type { RouteHead } from './routes';

export interface RenderInput {
  /** Concrete URL, e.g. '/product/213' */
  path: string;
  /** React Router pattern, e.g. '/product/:id' — defaults to path. */
  routePattern?: string;
  Component: ComponentType;
}

export function renderRoute(input: RenderInput): string {
  const pattern = input.routePattern ?? input.path;

  // react-router's <Link> calls useLayoutEffect, which warns during server
  // rendering; across many routes it floods the log. Filter just that message.
  const prevConsoleError = console.error;
  console.error = (...args: unknown[]) => {
    const first = typeof args[0] === 'string' ? args[0] : '';
    if (first.includes('useLayoutEffect does nothing on the server')) return;
    prevConsoleError(...(args as []));
  };

  try {
    return renderToString(
      <MemoryRouter initialEntries={[input.path]}>
        <Routes>
          <Route path={pattern} element={<input.Component />} />
        </Routes>
      </MemoryRouter>
    );
  } finally {
    console.error = prevConsoleError;
  }
}

const esc = (s: string) =>
  s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

/** Build the per-route <head> tags baked into the static HTML. */
export function buildHeadHtml(head: RouteHead, path: string): string {
  const origin = (import.meta.env.VITE_SITE_URL as string | undefined) ?? '';
  const abs = (u: string) => (u.startsWith('http') ? u : origin ? origin + (u.startsWith('/') ? u : `/${u}`) : u);
  const ogImage = head.ogImage ? abs(head.ogImage) : '';

  const lines = [
    `<title>${esc(head.title)}</title>`,
    `<meta name="description" content="${esc(head.description)}" />`,
    `<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1" />`,
    head.keywords ? `<meta name="keywords" content="${esc(head.keywords)}" />` : '',
    `<meta property="og:type" content="website" />`,
    `<meta property="og:locale" content="en_NG" />`,
    `<meta property="og:site_name" content="Xpel Beauty NG" />`,
    `<meta property="og:title" content="${esc(head.title)}" />`,
    `<meta property="og:description" content="${esc(head.description)}" />`,
    ogImage ? `<meta property="og:image" content="${esc(ogImage)}" />` : '',
    origin ? `<meta property="og:url" content="${origin}${path}" />` : '',
    `<meta name="twitter:card" content="summary_large_image" />`,
    `<meta name="twitter:title" content="${esc(head.title)}" />`,
    `<meta name="twitter:description" content="${esc(head.description)}" />`,
    ogImage ? `<meta name="twitter:image" content="${esc(ogImage)}" />` : '',
    origin ? `<link rel="canonical" href="${origin}${path}" />` : '',
  ];
  return lines.filter(Boolean).join('\n    ');
}

// The shell's default head tags are stripped before injecting per-route ones,
// so the final HTML never carries duplicate title/description/OG/Twitter tags.
const DEFAULT_HEAD_PATTERNS: RegExp[] = [
  /<title>[^<]*<\/title>/i,
  /<meta\s+name="description"[^>]*>/i,
  /<meta\s+name="robots"[^>]*>/i,
  /<meta\s+property="og:[^"]*"[^>]*>/gi,
  /<meta\s+name="twitter:[^"]*"[^>]*>/gi,
];

/** Pure function: bake rendered head + body into the built index.html template. */
export function injectIntoTemplate(
  template: string,
  parts: { headHtml: string; bodyHtml: string }
): string {
  let html = template;
  for (const re of DEFAULT_HEAD_PATTERNS) html = html.replace(re, '');
  html = html.replace('</head>', `    ${parts.headHtml}\n  </head>`);
  html = html.replace('<div id="root"></div>', `<div id="root">${parts.bodyHtml}</div>`);
  return html;
}
