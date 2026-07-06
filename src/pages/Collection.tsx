import { useState, useEffect, useMemo } from 'react';
import { Link, useParams } from 'react-router-dom';
import { api } from '@/lib/api';
import { useSiteContent } from '@/hooks/useSiteContent';
import type { Product } from '@/types';
import SEO from '@/components/SEO';

const FALLBACK_IMG = '/images/product-placeholder.svg';
const CIRCLES = ['#d8efe2', '#f7dfe6', '#f6e6cf', '#e3e9f7', '#f3e2f0', '#e8f2d8'];

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/') || src.startsWith('data:')) return src;
  return `/${src}`;
}

export default function Collection() {
  const { slug } = useParams<{ slug: string }>();
  const siteContent = useSiteContent();

  // Find this collection from admin-editable content
  const collection = useMemo(
    () => (siteContent.collections ?? []).find((c) => c.slug === slug) ?? null,
    [siteContent.collections, slug]
  );

  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading]   = useState(true);
  const [error, setError]       = useState<string | null>(null);
  const [sort, setSort]         = useState('featured');
  const [search, setSearch]     = useState('');

  useEffect(() => {
    if (!collection) { setLoading(false); return; }
    let active = true;

    (async () => {
      setLoading(true);
      setError(null);
      try {
        const all: Product[] = await api.products.getAll();
        const fv = collection.filterValue.toLowerCase();

        let data: Product[];
        if (collection.filterType === 'ids') {
          const ids = collection.filterValue
            .split(',')
            .map((s) => parseInt(s.trim(), 10))
            .filter(Boolean);
          data = all.filter((p) => ids.includes(p.id));
        } else if (collection.filterType === 'brand') {
          data = all.filter((p) => p.brand?.toLowerCase().includes(fv));
        } else {
          data = all.filter((p) => p.name?.toLowerCase().includes(fv));
        }

        if (active) setProducts(data);
      } catch (e) {
        if (active) setError(e instanceof Error ? e.message : 'Failed to load products');
      } finally {
        if (active) setLoading(false);
      }
    })();

    return () => { active = false; };
  }, [collection]); // eslint-disable-line react-hooks/exhaustive-deps

  const filtered = useMemo(() => {
    let list = [...products];
    if (search.trim()) {
      const q = search.toLowerCase();
      list = list.filter((p) => p.name.toLowerCase().includes(q));
    }
    if (sort === 'name') list.sort((a, b) => a.name.localeCompare(b.name));
    return list;
  }, [products, search, sort]);

  // ── 404 ──
  if (!loading && !collection) {
    return (
      <div className="collection-notfound">
        <p>Collection not found.</p>
        <Link to="/shop">Browse all products →</Link>
      </div>
    );
  }

  // While content is loading (collection might not be resolved yet)
  if (!collection) {
    return <div className="shop-state">Loading…</div>;
  }

  return (
    <div className="collection-page">
      <SEO
        page="shop"
        overrides={{
          fullTitle: `${collection.name} | Xpel Beauty NG`,
          description: collection.description,
          keywords: `${collection.name.toLowerCase()}, xpel beauty nigeria, ${collection.subtitle.toLowerCase()}`,
        }}
      />

      {/* ── Hero ─────────────────────────────────────────────── */}
      <section
        className="collection-hero"
        style={{ backgroundImage: `url('${collection.heroImage}')` }}
      >
        <div className="collection-hero-overlay" style={{ background: collection.overlayColor }}>
          <div className="collection-hero-inner">
            <nav className="collection-crumb">
              <Link to="/">Home</Link>
              <span> › </span>
              <Link to="/shop">Shop</Link>
              <span> › </span>
              <span className="collection-crumb-current">{collection.name}</span>
            </nav>

            <p className="collection-hero-eyebrow">The Collection</p>
            <h1 className="collection-hero-title">{collection.name}</h1>
            <p className="collection-hero-sub">{collection.subtitle}</p>

            {!loading && (
              <span
                className="collection-hero-badge"
                style={{ background: collection.accentColor }}
              >
                {filtered.length} product{filtered.length !== 1 ? 's' : ''}
              </span>
            )}
          </div>
        </div>
      </section>

      {/* ── Description strip ────────────────────────────────── */}
      <div className="collection-desc-strip">
        <div className="collection-desc-inner">
          <p>{collection.description}</p>
        </div>
      </div>

      {/* ── Products ─────────────────────────────────────────── */}
      <div className="collection-inner">
        <div className="collection-toolbar">
          <input
            type="text"
            className="shop-search"
            placeholder={`Search in ${collection.name}…`}
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <select
            className="shop-sort"
            value={sort}
            onChange={(e) => setSort(e.target.value)}
          >
            <option value="featured">Featured</option>
            <option value="name">Name A–Z</option>
          </select>
        </div>

        {loading && <div className="shop-state">Loading products…</div>}
        {error   && <div className="shop-state shop-error">{error}</div>}

        {!loading && !error && (
          <>
            <p className="shop-count">
              Showing {filtered.length} product{filtered.length !== 1 ? 's' : ''}
            </p>

            <div className="iva-grid shop-grid">
              {filtered.map((product, idx) => (
                <Link
                  key={product.id}
                  to={`/product/${product.id}`}
                  className="iva-product"
                >
                  <div className="iva-product-stage">
                    <span
                      className="iva-product-circle"
                      style={{ background: CIRCLES[idx % CIRCLES.length] }}
                    />
                    <img
                      src={resolveImg(product.image)}
                      alt={product.name}
                      className="iva-product-img"
                      onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                    />
                  </div>
                  <span className="iva-product-cat">{product.category}</span>
                  <h3 className="iva-product-name">{product.name}</h3>
                </Link>
              ))}
            </div>

            {filtered.length === 0 && (
              <div className="shop-state">
                No products found in this collection.{' '}
                <Link to="/shop" style={{ color: 'var(--gold-raw)', textDecoration: 'underline' }}>
                  Browse all products →
                </Link>
              </div>
            )}
          </>
        )}
      </div>

      {/* ── Footer CTA ───────────────────────────────────────── */}
      <div className="collection-footer-cta">
        <Link to="/shop" className="collection-back-btn">← View All Products</Link>
      </div>
    </div>
  );
}
