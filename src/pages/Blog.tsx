import { Link } from 'react-router-dom';
import { useBlogPosts } from '@/hooks/useBlog';
import { useSiteContent } from '@/hooks/useSiteContent';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';

export default function Blog() {
  const { posts, loading, error } = useBlogPosts();
  const content = useSiteContent();

  return (
    <div className="min-h-screen">
      <SEO page="blog" />
      <div className="max-w-6xl mx-auto px-4 py-12">
        <div className="mb-8"><PromoBanner banner={content.banners.blog} /></div>
        <h1 className="text-5xl font-cormorant mb-3">{content.blogTitle}</h1>
        <p className="text-gray-600 mb-8">{content.blogIntro}</p>

        {loading && <div className="text-center py-12">Loading...</div>}
        {error && <div className="text-red-500">{error}</div>}

        {posts && (
          <div className="space-y-8">
            {posts.map((post) => (
              <article
                key={post.id}
                className="grid grid-cols-1 md:grid-cols-3 gap-6 border-b pb-8 last:border-b-0 hover:shadow-lg transition p-4 rounded-lg"
              >
                <img
                  src={post.image}
                  alt={post.title}
                  className="w-full h-48 object-cover rounded-lg md:col-span-1"
                />
                <div className="md:col-span-2">
                  <h2 className="text-2xl font-cormorant mb-2 hover:text-gold-raw transition">
                    <Link to={`/blog/${post.slug}`}>{post.title}</Link>
                  </h2>
                  <p className="text-sm text-gray-600 mb-4">
                    By {post.author} · {new Date(post.created_at).toLocaleDateString()}
                  </p>
                  <p className="text-gray-700 mb-4">{post.excerpt}</p>
                  <Link
                    to={`/blog/${post.slug}`}
                    className="inline-block px-4 py-2 border border-gold-raw text-gold-raw rounded-lg hover:bg-gold-raw hover:text-white transition"
                  >
                    Read More
                  </Link>
                </div>
              </article>
            ))}
          </div>
        )}

        {posts?.length === 0 && (
          <div className="text-center py-12 text-gray-600">No blog posts found.</div>
        )}
      </div>
    </div>
  );
}
