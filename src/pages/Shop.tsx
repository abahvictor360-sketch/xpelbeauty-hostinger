import { useState, useEffect, useMemo } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { useProducts } from '@/hooks/useProducts';
import { useSiteContent } from '@/hooks/useSiteContent';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';

// Map URL slug -> category label
const CAT_SLUGS: Record<string, string> = {
  'body-beauty': 'Body & Beauty',
  'hair-care': 'Hair Care',
  'travel-health': 'Travel & Health',
  home: 'Home',
  gifting: 'Gifting',
};

const CATEGORIES = ['Hair Care', 'Body & Beauty', 'Home', 'Travel & Health', 'Gifting'];

// Soft pastel circles cycled across the grid (IVA Cosmetic style)
const CIRCLES = ['#d8efe2', '#f7dfe6', '#f6e6cf', '#e3e9f7', '#f3e2f0', '#e8f2d8'];

const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/')) return src;
  return `/${src}`;
}

export default function Shop() {
  const { products, loading, error } = useProducts();
  const content = useSiteContent();
  const [searchParams, setSearchParams] = useSearchParams();
  const [category, setCategory] = useState<string | null>(null);
  const [brand, setBrand] = useState<string | null>(null);
  const [search, setSearch] = useState('');
  const [sort, setSort] = useState('featured');
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 12;

  // Read ?cat= and ?brand= from URL on load / change
  useEffect(() => {
    const slug = searchParams.get('cat') || searchParams.get('category');
    if (slug) {
      setCategory(CAT_SLUGS[slug] || slug);
    } else {
      setCategory(null);
    }
    const b = searchParams.get('brand');
    setBrand(b ? decodeURIComponent(b) : null);
  }, [searchParams]);

  const selectCategory = (cat: string | null) => {
    setCategory(cat);
    if (cat) {
      const slug = Object.keys(CAT_SLUGS).find((k) => CAT_SLUGS[k] === cat);
      setSearchParams(slug ? { cat: slug } : {});
    } else {
      setSearchParams({});
    }
  };

  const filteredProducts = useMemo(() => {
    let list = [...products];
    if (category) list = list.filter((p) => p.category === category);
    if (brand) list = list.filter((p) => p.brand === brand);
    if (search.trim()) {
      const q = search.toLowerCase();
      list = list.filter(
        (p) =>
          p.name.toLowerCase().includes(q) ||
          (p.brand || '').toLowerCase().includes(q)
      );
    }
    switch (sort) {
      case 'name':
        list.sort((a, b) => a.name.localeCompare(b.name));
        break;
    }
    return list;
  }, [products, category, search, sort]);

  // Pagination
  const totalPages = Math.ceil(filteredProducts.length / ITEMS_PER_PAGE);
  const startIdx = (currentPage - 1) * ITEMS_PER_PAGE;
  const visible = filteredProducts.slice(startIdx, startIdx + ITEMS_PER_PAGE);

  // Reset to page 1 when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [category, brand, search, sort]);

  return (
    <div className="shop-page">
      <SEO page="shop" />
      {/* Breadcrumb */}
      <nav className="shop-crumb">
        <Link to="/">Home</Link> <span>›</span> <span className="current">Product</span>
      </nav>

      {/* Hero banner with left-aligned overlay text */}
      <section className="shop-hero" style={{ backgroundImage: `url('${content.banners.shopHero.image}')` }}>
        <div className="shop-hero-overlay">
          {content.banners.shopHero.kicker && (
            <span className="shop-hero-kicker">{content.banners.shopHero.kicker}</span>
          )}
          <h1 className="shop-hero-title">{content.banners.shopHero.title || content.shopTitle}</h1>
          <p className="shop-hero-text">{content.banners.shopHero.text || content.shopSubtitle}</p>
        </div>
      </section>

      <div className="shop-inner">
        {/* Toolbar */}
        <div className="shop-toolbar">
          <div className="shop-cats">
            <button
              onClick={() => selectCategory(null)}
              className={`shop-cat-pill ${category === null ? 'active' : ''}`}
            >
              All
            </button>
            {CATEGORIES.map((cat) => (
              <button
                key={cat}
                onClick={() => selectCategory(cat)}
                className={`shop-cat-pill ${category === cat ? 'active' : ''}`}
              >
                {cat}
              </button>
            ))}
          </div>

          {/* Brand pills — shown when a brand is active or always */}
          {brand && (
            <div className="shop-cats shop-brand-filter">
              <span className="shop-filter-label">Brand:</span>
              <button
                className="shop-cat-pill active"
                onClick={() => setSearchParams(category ? { cat: Object.keys(CAT_SLUGS).find(k => CAT_SLUGS[k] === category) || category } : {})}
              >
                {brand} ✕
              </button>
            </div>
          )}

          <div className="shop-controls">
            <input
              type="text"
              placeholder="Search products..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="shop-search"
            />
            <select
              value={sort}
              onChange={(e) => setSort(e.target.value)}
              className="shop-sort"
            >
              <option value="featured">Featured</option>
              <option value="name">Name A–Z</option>
            </select>
          </div>
        </div>

        {loading && <div className="shop-state">Loading products…</div>}
        {error && <div className="shop-state shop-error">{error}</div>}

        {!loading && !error && (
          <>
            <p className="shop-count">
              Showing {visible.length} product{visible.length !== 1 ? 's' : ''}
            </p>

            <div className="iva-grid shop-grid">
              {visible.map((product, idx) => (
                <Link
                  key={product.id}
                  to={`/product/${product.id}`}
                  className="iva-product"
                >
                  <div className="iva-product-stage">
                    <span
                      className="iva-product-circle"
                      style={{ background: CIRCLES[idx % CIRCLES.length] }}
                    ></span>
                    <img
                      src={resolveImg(product.image)}
                      alt={product.name}
                      className="iva-product-img"
                      onError={(e) => {
                        (e.target as HTMLImageElement).src = FALLBACK_IMG;
                      }}
                    />
                  </div>
                  <span className="iva-product-cat">{product.category}</span>
                  <h3 className="iva-product-name">{product.name}</h3>
                </Link>
              ))}
            </div>

            {visible.length === 0 && (
              <div className="shop-state">No products found. Try a different filter.</div>
            )}

            {/* Pagination */}
            {totalPages > 1 && (
              <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '6px', marginTop: '48px', padding: '0 16px', flexWrap: 'wrap' }}>
                {/* Previous button */}
                <button
                  onClick={() => { setCurrentPage(Math.max(1, currentPage - 1)); window.scrollTo({ top: 0, behavior: 'smooth' }); }}
                  disabled={currentPage === 1}
                  style={{ padding: '10px 14px', border: '1px solid #E8E8E8', background: currentPage === 1 ? '#F5F5F5' : 'white', cursor: currentPage === 1 ? 'not-allowed' : 'pointer', borderRadius: '6px', fontSize: '13px', fontWeight: '600', color: currentPage === 1 ? '#AAA' : '#1A1A1A' }}
                >
                  ← Prev
                </button>

                {/* Smart page numbers with ellipsis */}
                {(() => {
                  const pages: (number | string)[] = [];
                  const delta = 2; // pages around current

                  // Always show page 1
                  pages.push(1);

                  // Left ellipsis
                  if (currentPage - delta > 2) pages.push('...');

                  // Pages around current
                  for (let i = Math.max(2, currentPage - delta); i <= Math.min(totalPages - 1, currentPage + delta); i++) {
                    pages.push(i);
                  }

                  // Right ellipsis
                  if (currentPage + delta < totalPages - 1) pages.push('...');

                  // Always show last page
                  if (totalPages > 1) pages.push(totalPages);

                  return pages.map((page, idx) =>
                    page === '...' ? (
                      <span key={`ellipsis-${idx}`} style={{ padding: '0 4px', color: '#888', fontSize: '14px' }}>…</span>
                    ) : (
                      <button
                        key={page}
                        onClick={() => { setCurrentPage(page as number); window.scrollTo({ top: 0, behavior: 'smooth' }); }}
                        style={{
                          minWidth: '40px', padding: '10px 12px',
                          border: page === currentPage ? '2px solid #ca7c29' : '1px solid #E8E8E8',
                          background: page === currentPage ? '#ca7c29' : 'white',
                          color: page === currentPage ? 'white' : '#1A1A1A',
                          cursor: 'pointer', borderRadius: '6px', fontSize: '13px', fontWeight: '600', transition: 'all 0.2s ease',
                        }}
                      >
                        {page}
                      </button>
                    )
                  );
                })()}

                {/* Next button */}
                <button
                  onClick={() => { setCurrentPage(Math.min(totalPages, currentPage + 1)); window.scrollTo({ top: 0, behavior: 'smooth' }); }}
                  disabled={currentPage === totalPages}
                  style={{ padding: '10px 14px', border: '1px solid #E8E8E8', background: currentPage === totalPages ? '#F5F5F5' : 'white', cursor: currentPage === totalPages ? 'not-allowed' : 'pointer', borderRadius: '6px', fontSize: '13px', fontWeight: '600', color: currentPage === totalPages ? '#AAA' : '#1A1A1A' }}
                >
                  Next →
                </button>

                {/* Page counter */}
                <span style={{ marginLeft: '12px', fontSize: '13px', color: '#888' }}>
                  Page {currentPage} of {totalPages} ({filteredProducts.length} products)
                </span>
              </div>
            )}
          </>
        )}
      </div>

      {/* Promo banner before footer (editable in admin) */}
      <div className="shop-banner-wrap">
        <PromoBanner banner={content.banners.shop} />
      </div>
    </div>
  );
}
