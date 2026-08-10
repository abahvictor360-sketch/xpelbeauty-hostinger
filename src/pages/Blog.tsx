import { Link } from 'react-router-dom';
import { useBlogPosts } from '@/hooks/useBlog';
import { useSiteContent } from '@/hooks/useSiteContent';
import SEO from '@/components/SEO';

const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/') || src.startsWith('data:')) return src;
  return `/${src}`;
}

export default function Blog() {
  const { posts, loading, error } = useBlogPosts();
  const content = useSiteContent();

  return (
    <div className="min-h-screen bg-white">
      <SEO page="blog" />

      <div className="max-w-6xl mx-auto px-6 py-20">
        {/* ── Header ─────────────────────────────────────────── */}
        <div className="text-center max-w-xl mx-auto mb-14">
          <span className="inline-block px-4 py-1.5 mb-5 rounded-full bg-gold-raw text-white text-xs font-jost font-semibold uppercase tracking-wide">
            Blog
          </span>
          <h1 className="font-cormorant text-4xl md:text-5xl text-navy mb-4">
            {content.blogTitle || 'Latest News'}
          </h1>
          <p className="text-gray-500 text-[15px] leading-relaxed font-jost">
            {content.blogIntro || 'Hair care tips, skincare routines and beauty guides from the Xpel Beauty NG team.'}
          </p>
        </div>

        {loading && <div className="text-center py-16 text-gray-500">Loading…</div>}
        {error && <div className="text-center py-16 text-red-500">{error}</div>}
        {!loading && posts?.length === 0 && (
          <div className="text-center py-16 text-gray-500">No blog posts found.</div>
        )}

        {/* ── Card grid ──────────────────────────────────────── */}
        {!loading && posts && posts.length > 0 && (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {posts.map((post) => (
              <Link
                key={post.id}
                to={`/blog/${post.slug}`}
                className="group block rounded-2xl border border-gray-100 bg-white shadow-sm hover:shadow-xl transition-shadow duration-300 overflow-hidden"
              >
                <div className="relative p-2">
                  <img
                    src={resolveImg(post.image)}
                    alt={post.title}
                    className="w-full h-44 object-cover rounded-xl"
                    onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                  />
                  {post.category && (
                    <span className="absolute top-4 left-4 px-3 py-1 rounded-full bg-gold-raw text-white text-[11px] font-jost font-semibold uppercase tracking-wide shadow-sm">
                      {post.category}
                    </span>
                  )}
                </div>
                <div className="px-5 pb-6 pt-2">
                  <h2 className="font-jost font-semibold text-[17px] text-navy leading-snug mb-2 line-clamp-2 group-hover:text-gold-raw transition-colors">
                    {post.title}
                  </h2>
                  <p className="text-gray-500 text-sm leading-relaxed line-clamp-2">
                    {post.excerpt}
                  </p>
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
