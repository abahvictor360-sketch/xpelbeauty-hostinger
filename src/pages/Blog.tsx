import { useMemo } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { useBlogPosts } from '@/hooks/useBlog';
import { useSiteContent } from '@/hooks/useSiteContent';
import SEO from '@/components/SEO';
import '@/styles/blog.css';

const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/') || src.startsWith('data:')) return src;
  return `/${src}`;
}

const SORTS = {
  newest: 'Newest first',
  oldest: 'Oldest first',
  title: 'Title A to Z',
} as const;
type SortKey = keyof typeof SORTS;

const dateFmt = new Intl.DateTimeFormat('en-NG', { year: 'numeric', month: 'long', day: 'numeric' });

export default function Blog() {
  const { posts, loading, error } = useBlogPosts();
  const content = useSiteContent();
  // Filter and sort live in the URL so a filtered view can be shared or bookmarked
  const [params, setParams] = useSearchParams();
  const active = params.get('cat') ?? '';
  const sort = (params.get('sort') as SortKey) in SORTS ? (params.get('sort') as SortKey) : 'newest';

  const setParam = (key: string, value: string) => {
    const next = new URLSearchParams(params);
    if (value) next.set(key, value); else next.delete(key);
    setParams(next, { replace: true });
  };

  const categories = useMemo(
    () => [...new Set((posts ?? []).map((p) => p.category).filter((c): c is string => !!c))].sort(),
    [posts],
  );

  const visible = useMemo(() => {
    const list = (posts ?? []).filter((p) => !active || p.category === active);
    return [...list].sort((a, b) => {
      if (sort === 'title') return a.title.localeCompare(b.title);
      const d = new Date(a.created_at).getTime() - new Date(b.created_at).getTime();
      return sort === 'oldest' ? d : -d;
    });
  }, [posts, active, sort]);

  return (
    <div className="journal-page">
      <SEO page="blog" />

      <div className="journal-panel">
        <header className="journal-head">
          <h1 className="journal-title">{content.blogTitle || 'Popular articles'}</h1>
          {content.blogIntro && <p className="journal-intro">{content.blogIntro}</p>}
        </header>

        <div className="journal-toolbar">
          <div className="journal-pills" role="group" aria-label="Filter by category">
            <button type="button" className={`journal-pill ${!active ? 'is-active' : ''}`} aria-pressed={!active}
              onClick={() => setParam('cat', '')}>
              All categories
            </button>
            {categories.map((c) => (
              <button key={c} type="button" className={`journal-pill ${active === c ? 'is-active' : ''}`} aria-pressed={active === c}
                onClick={() => setParam('cat', c)}>
                {c}
              </button>
            ))}
          </div>
          <label className="journal-sort">
            <span>Sort by</span>
            <select value={sort} onChange={(e) => setParam('sort', e.target.value === 'newest' ? '' : e.target.value)}>
              {Object.entries(SORTS).map(([k, label]) => <option key={k} value={k}>{label}</option>)}
            </select>
          </label>
        </div>

        {loading && <p className="journal-state">Loading…</p>}
        {error && <p className="journal-state journal-state-error">{error}</p>}

        {!loading && !error && (
          <>
            <p className="journal-count">Showing {visible.length} of {posts?.length ?? 0}</p>
            {visible.length === 0 ? (
              <p className="journal-state">No articles in this category yet.</p>
            ) : (
              <div className="journal-grid">
                {visible.map((post) => (
                  <article key={post.id} className="journal-card">
                    <Link to={`/blog/${post.slug}`} className="journal-card-media" tabIndex={-1} aria-hidden="true">
                      <img
                        src={resolveImg(post.image)}
                        alt=""
                        width={600}
                        height={600}
                        loading="lazy"
                        decoding="async"
                        onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                      />
                    </Link>
                    <p className="journal-card-meta">
                      {post.created_at && <time dateTime={post.created_at}>{dateFmt.format(new Date(post.created_at))}</time>}
                      {post.created_at && post.author && <span aria-hidden="true"> • </span>}
                      {post.author}
                    </p>
                    <h2 className="journal-card-title">
                      <Link to={`/blog/${post.slug}`}>{post.title}</Link>
                    </h2>
                    {post.excerpt && <p className="journal-card-excerpt">{post.excerpt}</p>}
                    <Link to={`/blog/${post.slug}`} className="journal-card-more" aria-label={`Read more: ${post.title}`}>
                      Read more <span aria-hidden="true">→</span>
                    </Link>
                  </article>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}
