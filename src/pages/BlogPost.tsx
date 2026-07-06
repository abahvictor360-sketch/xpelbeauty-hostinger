import { useParams, Link } from 'react-router-dom';
import { useBlogPost } from '@/hooks/useBlog';

export default function BlogPost() {
  const { slug } = useParams<{ slug: string }>();
  const { post, loading, error } = useBlogPost(slug || '');

  if (loading) return <div className="text-center py-12">Loading...</div>;
  if (error) return <div className="text-red-500 text-center py-12">{error}</div>;
  if (!post) return <div className="text-center py-12">Blog post not found</div>;

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <Link to="/blog" className="text-gold-raw hover:underline mb-4 inline-block">
        ← Back to Blog
      </Link>

      <article>
        <h1 className="text-5xl font-cormorant mb-4">{post.title}</h1>

        <div className="flex items-center gap-4 text-gray-600 mb-8 pb-8 border-b">
          <span>By {post.author}</span>
          <span>•</span>
          <span>{new Date(post.created_at).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
          })}</span>
        </div>

        <img
          src={post.image}
          alt={post.title}
          className="w-full h-96 object-cover rounded-lg mb-8"
        />

        <div className="prose prose-lg max-w-none mb-8">
          <p className="whitespace-pre-wrap text-gray-700 leading-relaxed">{post.content}</p>
        </div>

        <div className="bg-gray-50 rounded-lg p-6 mt-12">
          <h3 className="text-lg font-semibold mb-2">Have a question?</h3>
          <p className="text-gray-600 mb-4">
            Get in touch with us to learn more about our products and services.
          </p>
          <a
            href="mailto:info@xpelbeauty.com"
            className="inline-block px-6 py-2 bg-gold-raw text-white rounded-lg hover:bg-gold-hover transition"
          >
            Contact Us
          </a>
        </div>
      </article>
    </div>
  );
}
