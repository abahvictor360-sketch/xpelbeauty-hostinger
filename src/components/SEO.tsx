import { useEffect } from 'react';
import { useSiteContent } from '@/hooks/useSiteContent';
import type { SEOPage } from '@/hooks/useSiteContent';

interface SEOProps {
  page: keyof import('@/hooks/useSiteContent').SiteSEO['pages'];
  /** Override any field for dynamic pages (e.g. a specific product) */
  overrides?: Partial<SEOPage & { fullTitle?: string }>;
  /** Schema.org structured data for this page (Product, Article, …) */
  jsonLd?: object | object[];
}

/** Sets <title> and all <meta> tags for the current page.
 *  Pure DOM manipulation — no extra library needed. */
export default function SEO({ page, overrides, jsonLd }: SEOProps) {
  const content = useSiteContent();
  const seo = content.seo;
  const pageData = seo.pages[page];

  const title    = overrides?.fullTitle
    ?? `${overrides?.title ?? pageData.title}${seo.titleSeparator}${seo.siteTitle}`;
  const desc     = overrides?.description ?? pageData.description ?? seo.defaultDescription;
  const keywords = overrides?.keywords    ?? pageData.keywords;
  const ogImage  = overrides?.ogImage ?? (pageData.ogImage || seo.defaultOgImage);
  const robots   = overrides?.robots      ?? pageData.robots
    ?? 'index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1';
  const ogTitle  = overrides?.title       ?? pageData.title;
  const ogDesc   = desc;
  const jsonLdStr = jsonLd ? JSON.stringify(jsonLd) : '';

  useEffect(() => {
    // ── <title> ──────────────────────────────────────────────────
    document.title = title;

    // ── helper: get-or-create a <meta> tag ──────────────────────
    const setMeta = (selector: string, attr: string, value: string) => {
      let el = document.head.querySelector<HTMLMetaElement>(selector);
      if (!el) {
        el = document.createElement('meta');
        const [attrName, attrVal] = attr.split('=');
        el.setAttribute(attrName, attrVal.replace(/"/g, ''));
        document.head.appendChild(el);
      }
      el.setAttribute('content', value);
    };

    const setLink = (rel: string, href: string) => {
      let el = document.head.querySelector<HTMLLinkElement>(`link[rel="${rel}"]`);
      if (!el) {
        el = document.createElement('link');
        el.rel = rel;
        document.head.appendChild(el);
      }
      el.href = href;
    };

    // ── Standard meta ────────────────────────────────────────────
    setMeta('meta[name="description"]',       'name="description"',       desc);
    if (keywords) setMeta('meta[name="keywords"]', 'name="keywords"', keywords);
    setMeta('meta[name="robots"]',            'name="robots"',            robots);

    // ── Open Graph ───────────────────────────────────────────────
    setMeta('meta[property="og:type"]',        'property=og:type',        'website');
    setMeta('meta[property="og:locale"]',      'property=og:locale',      'en_NG');
    setMeta('meta[property="og:title"]',       'property=og:title',       ogTitle);
    setMeta('meta[property="og:description"]', 'property=og:description', ogDesc);
    if (ogImage) setMeta('meta[property="og:image"]', 'property=og:image', ogImage);
    setMeta('meta[property="og:url"]',         'property=og:url',         window.location.href);
    setMeta('meta[property="og:site_name"]',   'property=og:site_name',   seo.siteTitle);

    // ── Twitter Card ─────────────────────────────────────────────
    setMeta('meta[name="twitter:card"]',        'name="twitter:card"',        'summary_large_image');
    setMeta('meta[name="twitter:title"]',       'name="twitter:title"',       ogTitle);
    setMeta('meta[name="twitter:description"]', 'name="twitter:description"', ogDesc);
    if (ogImage) setMeta('meta[name="twitter:image"]', 'name="twitter:image"', ogImage);
    if (seo.twitterHandle) setMeta('meta[name="twitter:site"]', 'name="twitter:site"', seo.twitterHandle);

    // ── Google Verification ──────────────────────────────────────
    if (seo.googleVerification) {
      setMeta(
        'meta[name="google-site-verification"]',
        'name="google-site-verification"',
        seo.googleVerification
      );
    }

    // ── Canonical ────────────────────────────────────────────────
    setLink('canonical', window.location.origin + window.location.pathname);

    // ── Page structured data (Product, Article, …) ───────────────
    let ld = document.getElementById('seo-jsonld') as HTMLScriptElement | null;
    if (jsonLdStr) {
      if (!ld) {
        ld = document.createElement('script');
        ld.id = 'seo-jsonld';
        ld.type = 'application/ld+json';
        document.head.appendChild(ld);
      }
      ld.textContent = jsonLdStr;
    } else if (ld) {
      ld.remove();
    }

    // ── Site-wide Organization schema (injected once) ─────────────
    if (!document.getElementById('org-jsonld')) {
      const org = document.createElement('script');
      org.id = 'org-jsonld';
      org.type = 'application/ld+json';
      org.textContent = JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'Organization',
        name: seo.siteTitle || 'Xpel Beauty NG',
        url: window.location.origin,
        logo: window.location.origin + '/images/logo-xpel-beauty-ng.png',
        email: content.contactEmail,
        telephone: content.contactPhone,
        address: { '@type': 'PostalAddress', addressCountry: 'NG' },
      });
      document.head.appendChild(org);
    }
  }, [title, desc, keywords, ogImage, ogTitle, ogDesc, robots, seo, jsonLdStr, content.contactEmail, content.contactPhone]);

  return null;
}
