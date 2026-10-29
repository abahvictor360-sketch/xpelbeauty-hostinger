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
import Collection from '../pages/Collection';
import Catalogue from '../pages/Catalogue';
import BlogPost from '../pages/BlogPost';
import { DEFAULT_CONTENT } from '../hooks/useSiteContent';
import { faqPageJsonLd } from '../lib/faq';

export interface RouteHead {
  title: string;
  description: string;
  keywords?: string;
  ogImage?: string;
  /** Structured data baked into the page (reused by the client SEO component). */
  jsonLd?: Record<string, unknown>[];
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

// GS1 barcodes (8/12/13/14 digits) go into structured data as gtinNN, which is
// what Google matches when someone scans or searches the number on a pack.
const GTIN_KEY: Record<number, string> = { 8: 'gtin8', 12: 'gtin12', 13: 'gtin13', 14: 'gtin14' };
const SITE = ((import.meta.env.VITE_SITE_URL as string | undefined) ?? 'https://xpelbeauty.vercel.app').replace(/\/$/, '');
const absUrl = (u?: string) => (!u ? undefined : u.startsWith('http') ? u : SITE + (u.startsWith('/') ? u : `/${u}`));

function productJsonLd(p: { id: number; name: string; brand: string; description?: string; image?: string; category?: string; sku?: string | null }) {
  const code = (p.sku ?? '').trim();
  const gtin = /^\d+$/.test(code) && GTIN_KEY[code.length] ? { [GTIN_KEY[code.length]]: code } : {};
  return [
    {
      '@context': 'https://schema.org',
      '@type': 'Product',
      name: p.name,
      url: `${SITE}/product/${p.id}`,
      ...(p.image ? { image: absUrl(p.image) } : {}),
      description: p.description || `${p.name} by ${p.brand}`,
      brand: { '@type': 'Brand', name: p.brand },
      ...(p.category ? { category: p.category } : {}),
      ...(code ? { sku: code } : {}),
      ...gtin,
    },
    {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: `${SITE}/` },
        { '@type': 'ListItem', position: 2, name: 'Shop', item: `${SITE}/shop` },
        { '@type': 'ListItem', position: 3, name: p.name, item: `${SITE}/product/${p.id}` },
      ],
    },
  ];
}

async function getProducts(): Promise<Array<{ param: string; head: RouteHead }>> {
  if (!API) return [];
  const res = await fetch(`${API}/products.php`, {
    headers: { Accept: 'application/json' },
    signal: AbortSignal.timeout(20000),
  });
  if (!res.ok) throw new Error(`products API ${res.status}`);
  const items: Array<{ id: number; name: string; brand: string; description?: string; image?: string; category?: string; sku?: string | null }> = await res.json();
  return items.map((p) => ({
    param: String(p.id),
    head: {
      title: `${p.name} | Wholesale Supply in Nigeria - Xpel Beauty NG`,
      description: p.description || `${p.name} by ${p.brand}, available wholesale from Xpel Beauty NG, the exclusive Nigerian distributor of Xpel Beauty Care.`,
      keywords: `${p.name}, ${p.brand}, ${p.name.toLowerCase()} wholesale nigeria, wholesale beauty products nigeria${p.sku ? `, ${p.sku}` : ''}`,
      ogImage: p.image,
      jsonLd: productJsonLd(p),
    },
  }));
}

async function getCollections(): Promise<Array<{ param: string; head: RouteHead }>> {
  if (!API) return [];
  const res = await fetch(`${API}/site_content.php`, {
    headers: { Accept: 'application/json' },
    signal: AbortSignal.timeout(20000),
  });
  if (!res.ok) throw new Error(`site_content API ${res.status}`);
  const body: { data?: { collections?: Array<{ slug: string; name: string; description: string; subtitle: string }> } } = await res.json();
  const collections = body?.data?.collections ?? [];
  return collections.map((c) => ({
    param: c.slug,
    head: {
      title: `${c.name} in Nigeria | Xpel Beauty NG`,
      description: `${c.description} Available wholesale to distributors and retailers across Nigeria.`,
      keywords: `${c.name.toLowerCase()} nigeria, ${c.name.toLowerCase()} wholesale nigeria, ${c.name.toLowerCase()} lagos, xpel beauty nigeria, ${(c.subtitle || '').toLowerCase()}`,
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

function orgJsonLd(): Record<string, unknown> {
  const site = ((import.meta.env.VITE_SITE_URL as string | undefined) ?? '').replace(/\/$/, '');
  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: seo.siteTitle,
    ...(site ? { url: site + '/', logo: site + '/images/logo-xpel-beauty-ng.png' } : {}),
    description: seo.defaultDescription,
    email: DEFAULT_CONTENT.contactEmail,
    address: { '@type': 'PostalAddress', streetAddress: DEFAULT_CONTENT.contactAddress, addressLocality: 'Lagos', addressCountry: 'NG' },
    areaServed: { '@type': 'Country', name: 'Nigeria' },
    contactPoint: { '@type': 'ContactPoint', contactType: 'sales', email: DEFAULT_CONTENT.contactEmail, areaServed: 'NG', availableLanguage: 'English' },
  };
}

export const prerenderRoutes: PrerenderRoute[] = [
  // Homepage carries the FAQ and the business description for search and answer engines
  { path: '/',        Component: Home,    head: { ...pageHead('home'), jsonLd: [faqPageJsonLd(), orgJsonLd()] } },
  { path: '/shop',    Component: Shop,    head: pageHead('shop') },
  {
    path: '/catalogue',
    Component: Catalogue,
    head: {
      title: `Product Catalogue${seo.titleSeparator}${seo.siteTitle}`,
      description: 'Browse the full Xpel Beauty NG product catalogue - hair care, body care, oral care, nail care, foot care, make up essentials, men grooming and home essentials. Available wholesale to distributors and retailers across Nigeria.',
    },
  },
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
  { path: '/product/:id',      Component: Product,    head: pageHead('shop'), getData: getProducts },
  { path: '/collection/:slug', Component: Collection, head: pageHead('shop'), getData: getCollections },
  { path: '/blog/:slug',       Component: BlogPost,   head: pageHead('blog'), getData: getBlogPosts },
];
