// Route manifest for build-time prerendering — the single source of truth for
// which public routes get baked to static HTML. Eager imports only (renderToString
// cannot resolve React.lazy). Private routes (/admin) are excluded to match robots.txt.
import type { ComponentType } from 'react';
import Home from '../pages/Home';
import Shop from '../pages/Shop';
import About from '../pages/About';
import Contact from '../pages/Contact';
import Stores from '../pages/Stores';
import Blog from '../pages/Blog';
import Privacy from '../pages/Privacy';
import Product from '../pages/Product';
import BlogPost from '../pages/BlogPost';
import { DEFAULT_CONTENT } from '../hooks/useSiteContent';

export interface RouteHead {
  title: string;
  description: string;
  keywords?: string;
  ogImage?: string;
}

export interface PrerenderRoute {
  /** Route path. A ':param' segment marks a dynamic template expanded by the build script. */
  path: string;
  Component: ComponentType;
  /** Head tags baked into the static HTML for this route. */
  head: RouteHead;
  /** For dynamic templates: fetch the item list at build time (one file per item). */
  getData?: () => Promise<Array<{ param: string; head: RouteHead }>>;
}

const seo = DEFAULT_CONTENT.seo;

function pageHead(page: keyof typeof seo.pages): RouteHead {
  const p = seo.pages[page];
  return {
    title: `${p.title}${seo.titleSeparator}${seo.siteTitle}`,
    description: p.description || seo.defaultDescription,
    keywords: p.keywords,
    ogImage: p.ogImage || seo.defaultOgImage,
  };
}

// Optional: set VITE_PRERENDER_API (e.g. https://yourdomain.com/api) to also
// prerender every product and blog post from the live database at build time.
// When unset, dynamic routes are skipped and served by the SPA fallback instead.
const API = (import.meta.env.VITE_PRERENDER_API as string | undefined) ?? '';

async function getProducts(): Promise<Array<{ param: string; head: RouteHead }>> {
  if (!API) return [];
  const res = await fetch(`${API}/products.php`, {
    headers: { Accept: 'application/json' },
    signal: AbortSignal.timeout(20000),
  });
  if (!res.ok) throw new Error(`products API ${res.status}`);
  const items: Array<{ id: number; name: string; brand: string; description?: string; image?: string }> = await res.json();
  return items.map((p) => ({
    param: String(p.id),
    head: {
      title: `${p.name} | XpelBeauty NG`,
      description: p.description || `Discover ${p.name} by ${p.brand} — premium nature-infused beauty.`,
      keywords: `${p.name}, ${p.brand}, buy beauty products nigeria`,
      ogImage: p.image,
    },
  }));
}

async function getBlogPosts(): Promise<Array<{ param: string; head: RouteHead }>> {
  if (!API) return [];
  const res = await fetch(`${API}/blog.php`, {
    headers: { Accept: 'application/json' },
    signal: AbortSignal.timeout(20000),
  });
  if (!res.ok) throw new Error(`blog API ${res.status}`);
  const items: Array<{ slug: string; title: string; excerpt?: string; content?: string; image?: string }> = await res.json();
  return items.map((b) => ({
    param: b.slug,
    head: {
      title: `${b.title} | Xpel Beauty NG`,
      description: b.excerpt || (b.content || '').slice(0, 155),
      ogImage: b.image && !b.image.startsWith('data:') ? b.image : undefined,
    },
  }));
}

export const prerenderRoutes: PrerenderRoute[] = [
  { path: '/',        Component: Home,    head: pageHead('home') },
  { path: '/shop',    Component: Shop,    head: pageHead('shop') },
  { path: '/about',   Component: About,   head: pageHead('about') },
  { path: '/contact', Component: Contact, head: pageHead('contact') },
  { path: '/stores',  Component: Stores,  head: pageHead('stores') },
  { path: '/blog',    Component: Blog,    head: pageHead('blog') },
  {
    path: '/privacy',
    Component: Privacy,
    head: {
      title: `Privacy Policy${seo.titleSeparator}${seo.siteTitle}`,
      description: 'How Xpel Beauty NG collects, uses and protects your personal information.',
    },
  },
  { path: '/product/:id',  Component: Product,  head: pageHead('shop'), getData: getProducts },
  { path: '/blog/:slug',   Component: BlogPost, head: pageHead('blog'), getData: getBlogPosts },
];
