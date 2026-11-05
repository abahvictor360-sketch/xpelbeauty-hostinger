import { useMemo, useState, type FormEvent } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useProducts } from '@/hooks/useProducts';
import { useBlogPosts } from '@/hooks/useBlog';
import SEO from '@/components/SEO';
import type { BlogPost, Product } from '@/types';
import './Search.css';

const CIRCLES = ['#d8efe2', '#f7dfe6', '#f6e6cf', '#e3e9f7', '#f3e2f0', '#e8f2d8'];
const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/') || src.startsWith('data:')) return src;
  return `/${src}`;
}

/** Lowercase, drop accents and punctuation, so "Avisé" matches "avise" and "& " is ignored. */
const norm = (s: string) =>
  s.toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, ' ').trim();

/** Score a product against the query words: every word must match somewhere, name matches rank highest. */
function scoreProduct(p: Product, words: string[], phrase: string): number {
  const name = norm(p.name || '');
  const brand = norm(p.brand || '');
  const cat = norm(p.category || '');
  const desc = norm(p.description || '');
  const sku = (p.sku || '').toLowerCase();
  let score = 0;
  for (const w of words) {
    if (name.split(' ').some((t) => t.startsWith(w))) score += 10;
    else if (name.includes(w)) score += 6;
    else if (brand.includes(w)) score += 4;
    else if (cat.includes(w)) score += 3;
    else if (desc.includes(w)) score += 1;
    else if (sku.includes(w)) score += 5;
    else return 0;
  }
  if (name.includes(phrase)) score += 15;
  if (name.startsWith(phrase)) score += 5;
  return score;
}

export default function Search() {
  const [params] = useSearchParams();
  const navigate = useNavigate();
  const query = (params.get('q') || '').trim();
  const [draft, setDraft] = useState(query);
  const [draftFor, setDraftFor] = useState(query);
  if (draftFor !== query) { setDraftFor(query); setDraft(query); }

  const { products, loading: loadingProducts } = useProducts();
  const { posts, loading: loadingPosts } = useBlogPosts();

  const phrase = norm(query);
  const words = useMemo(() => phrase.split(' ').filter(Boolean), [phrase]);

  const productHits = useMemo(() => {
    if (!words.length) return [];
    return products
      .filter((p) => (p as Product & { active?: boolean }).active !== false)
      .map((p) => ({ p, s: scoreProduct(p, words, phrase) }))
      .filter((x) => x.s > 0)
      .sort((a, b) => b.s - a.s || a.p.name.localeCompare(b.p.name))
      .map((x) => x.p);
  }, [products, words, phrase]);

  const postHits = useMemo(() => {
    if (!words.length) return [];
    return posts.filter((post) => {
      const hay = norm(`${post.title} ${post.excerpt || ''} ${post.category || ''}`);
      return words.every((w) => hay.includes(w));
    });
  }, [posts, words]);

  const loading = loadingProducts || loadingPosts;
  const total = productHits.length + postHits.length;

  const submit = (e: FormEvent) => {
    e.preventDefault();
    const q = draft.trim();
    if (q) navigate(`/search?q=${encodeURIComponent(q)}`);
  };

  return (
    <div className="search-page">
      <SEO
        page="shop"
        overrides={{
          fullTitle: query ? `Search results for "${query}" | Xpel Beauty NG` : 'Search | Xpel Beauty NG',
          canonicalPath: '/search',
          robots: 'noindex, follow',
        }}
      />

      <div className="search-page-head">
        <p className="search-page-kicker">Search</p>
        <h1 className="search-page-title">
          {query ? <>Results for <span>"{query}"</span></> : 'Search our range'}
        </h1>
        <form className="search-page-form" role="search" onSubmit={submit}>
          <input
            type="search"
            value={draft}
            onChange={(e) => setDraft(e.target.value)}
            placeholder="Search products or blog posts"
            aria-label="Search products or blog posts"
            autoComplete="off"
          />
          <button type="submit">Search</button>
        </form>
        {query && !loading && (
          <p className="search-page-count">
            {total === 0
              ? 'No matches found.'
              : `${productHits.length} product${productHits.length !== 1 ? 's' : ''}` +
                (postHits.length ? ` and ${postHits.length} blog post${postHits.length !== 1 ? 's' : ''}` : '')}
          </p>
        )}
      </div>

      {loading && query && <div className="shop-state">Searching…</div>}

      {!loading && query && total === 0 && (
        <div className="search-page-empty">
          <p>We could not find anything for "{query}". Check the spelling or try a shorter word, like the range name (Tea Tree, Argan Oil) or the product type (shampoo, face wash).</p>
          <Link to="/shop" className="search-page-btn">Browse all products</Link>
        </div>
      )}

      {!loading && productHits.length > 0 && (
        <section aria-labelledby="search-products">
          <h2 id="search-products" className="search-page-section">Products</h2>
          <div className="iva-grid shop-grid">
            {productHits.map((product, idx) => (
              <Link key={product.id} to={`/product/${product.id}`} className="iva-product">
                <div className="iva-product-stage">
                  <span className="iva-product-circle" style={{ background: CIRCLES[idx % CIRCLES.length] }}></span>
                  <img
                    src={resolveImg(product.image)}
                    alt={product.name}
                    className="iva-product-img"
                    width={300}
                    height={320}
                    loading={idx < 4 ? 'eager' : 'lazy'}
                    decoding="async"
                    onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                  />
                </div>
                <span className="iva-product-cat">{product.brand || product.category}</span>
                <h3 className="iva-product-name">{product.name}</h3>
              </Link>
            ))}
          </div>
        </section>
      )}

      {!loading && postHits.length > 0 && (
        <section aria-labelledby="search-posts">
          <h2 id="search-posts" className="search-page-section">Blog posts</h2>
          <ul className="search-page-posts">
            {postHits.map((post: BlogPost & { featured_image?: string }) => (
              <li key={post.id}>
                <Link to={`/blog/${post.slug}`}>
                  {(post.image || post.featured_image) && <img src={resolveImg(post.image || post.featured_image)} alt="" loading="lazy" />}
                  <span>
                    <strong>{post.title}</strong>
                    {post.excerpt && <small>{post.excerpt}</small>}
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}
