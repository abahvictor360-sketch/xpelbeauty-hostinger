import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { useProducts } from '@/hooks/useProducts';
import SEO from '@/components/SEO';
import { useSiteContent } from '@/hooks/useSiteContent';
import { siteOrigin } from '@/lib/site';
import { CATALOGUE_CATEGORIES, groupByCatalogue } from '@/lib/catalogue';

const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/') || src.startsWith('data:')) return src;
  return `/${src}`;
}

/** Product images are lazy-loaded, so ones never scrolled to are blank when the
 *  browser prints. Force every image to load (with a time cap) before printing. */
function loadAllImages(timeoutMs = 20000): Promise<void> {
  const imgs = Array.from(document.querySelectorAll<HTMLImageElement>('.catalogue-page img'));
  imgs.forEach((img) => { img.loading = 'eager'; });
  const pending = imgs.filter((img) => !img.complete).map(
    (img) => new Promise<void>((resolve) => {
      img.addEventListener('load', () => resolve(), { once: true });
      img.addEventListener('error', () => resolve(), { once: true });
    })
  );
  return Promise.race([
    Promise.all(pending).then(() => undefined),
    new Promise<void>((resolve) => setTimeout(resolve, timeoutMs)),
  ]);
}

export default function Catalogue() {
  const { products, loading, error } = useProducts();
  const content = useSiteContent();
  const [search, setSearch] = useState('');
  const [preparing, setPreparing] = useState(false);

  // Ctrl+P / browser menu printing: at least start loading every image
  useEffect(() => {
    const onBeforePrint = () => { void loadAllImages(); };
    window.addEventListener('beforeprint', onBeforePrint);
    return () => window.removeEventListener('beforeprint', onBeforePrint);
  }, []);

  const printCatalogue = async () => {
    setPreparing(true);
    setSearch('');                                    // the PDF always lists the full range
    await new Promise((r) => requestAnimationFrame(() => requestAnimationFrame(r)));
    await loadAllImages();
    setPreparing(false);
    window.print();
  };

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return products;
    return products.filter(
      (p) => p.name.toLowerCase().includes(q) || (p.brand || '').toLowerCase().includes(q)
    );
  }, [products, search]);

  const groups = useMemo(() => groupByCatalogue(filtered), [filtered]);

  const jumpTo = (slug: string) => {
    document.getElementById(`cat-${slug}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  };

  return (
    <div className="catalogue-page">
      <SEO
        page="shop"
        overrides={{
          fullTitle: 'Product Catalogue | Xpel Beauty NG',
          description: 'Browse the full Xpel Beauty NG product catalogue - hair care, body care, oral care, nail care, foot care, make up essentials, men grooming and home essentials. Delivered across Nigeria.',
          keywords: 'xpel beauty catalogue, beauty products nigeria, hair care nigeria, body care nigeria, oral care nigeria, nail care, foot care, make up essentials, men grooming nigeria, home essentials',
          canonicalPath: '/catalogue',
        }}
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'BreadcrumbList',
          itemListElement: [
            { '@type': 'ListItem', position: 1, name: 'Home', item: siteOrigin() + '/' },
            { '@type': 'ListItem', position: 2, name: 'Catalogue', item: siteOrigin() + '/catalogue' },
          ],
        }}
      />

      <nav className="shop-crumb">
        <Link to="/">Home</Link> <span>›</span> <span className="current">Catalogue</span>
      </nav>

      {/* Hero */}
      <section className="catalogue-hero">
        <img
          className="catalogue-print-logo"
          src={content.logo || '/images/logo-xpel-beauty-ng.svg'}
          alt="Xpel Beauty NG"
          onError={(e) => { (e.target as HTMLImageElement).src = '/images/logo-xpel-beauty-ng.svg'; }}
        />
        <p className="catalogue-hero-kicker">Xpel Beauty NG</p>
        <h1 className="catalogue-hero-title">Product Catalogue</h1>
        <p className="catalogue-hero-text">
          Every product in our range, sorted into {CATALOGUE_CATEGORIES.length} categories.
          {!loading && !error && ` ${products.length} products in total.`}
        </p>
        <button type="button" className="catalogue-print" onClick={printCatalogue} disabled={loading || preparing}>
          {preparing ? 'Preparing images…' : 'Print / save as PDF'}
        </button>
      </section>

      {/* Category jump bar */}
      <div className="catalogue-bar">
        <div className="catalogue-bar-inner">
          <div className="catalogue-jump">
            {CATALOGUE_CATEGORIES.map((c) => (
              <button key={c.slug} type="button" className="catalogue-jump-pill" onClick={() => jumpTo(c.slug)}>
                {c.name}
                {!loading && <span className="catalogue-jump-count">{groups[c.name].length}</span>}
              </button>
            ))}
          </div>
          <input
            type="text"
            className="shop-search catalogue-search"
            placeholder="Search the catalogue..."
            aria-label="Search the catalogue"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
      </div>

      <div className="catalogue-inner">
        {loading && <div className="shop-state">Loading catalogue…</div>}
        {error && <div className="shop-state shop-error">{error}</div>}

        {!loading && !error && CATALOGUE_CATEGORIES.map((c, i) => {
          const items = groups[c.name];
          if (search.trim() && items.length === 0) return null;
          return (
            <section key={c.slug} id={`cat-${c.slug}`} className="catalogue-section">
              <div className="catalogue-section-head" style={{ background: c.tint }}>
                <span className="catalogue-section-num">{String(i + 1).padStart(2, '0')}</span>
                <div>
                  <h2 className="catalogue-section-title">{c.name}</h2>
                  <p className="catalogue-section-blurb">{c.blurb}</p>
                </div>
                <span className="catalogue-section-count">
                  {items.length} product{items.length !== 1 ? 's' : ''}
                </span>
              </div>

              {items.length === 0 ? (
                <p className="catalogue-empty">New {c.name.toLowerCase()} products coming soon.</p>
              ) : (
                <div className="catalogue-grid">
                  {items.map((p) => (
                    <Link key={p.id} to={`/product/${p.id}`} className="catalogue-card">
                      <div className="catalogue-card-img" style={{ background: c.tint }}>
                        <img
                          src={resolveImg(p.image)}
                          alt={p.name}
                          loading="lazy"
                          onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                        />
                      </div>
                      <span className="catalogue-card-brand">{p.brand}</span>
                      <h3 className="catalogue-card-name">{p.name}</h3>
                      {p.size && <span className="catalogue-card-size">{p.size}</span>}
                    </Link>
                  ))}
                </div>
              )}
            </section>
          );
        })}

        {!loading && !error && search.trim() && filtered.length === 0 && (
          <div className="shop-state">No products match "{search}".</div>
        )}
      </div>

      {/* Shown only in the printed / PDF catalogue */}
      <footer className="catalogue-print-footer">
        <strong>Xpel Beauty NG</strong>
        {[content.footerPhone1 || content.contactPhone, content.contactEmail, content.contactAddress].filter(Boolean).join('  ·  ')}
      </footer>
    </div>
  );
}
