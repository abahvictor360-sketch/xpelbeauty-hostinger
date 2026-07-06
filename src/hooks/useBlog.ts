import { useState, useEffect } from 'react';
import { api } from '@/lib/api';
import type { BlogPost } from '@/types';

export function useBlogPosts() {
  const [posts, setPosts] = useState<BlogPost[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError]     = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    setLoading(true);
    api.blog.getAll()
      .then((data: BlogPost[]) => { if (active) setPosts(data ?? []); })
      .catch((err: Error) => { if (active) setError(err.message ?? 'Failed to fetch blog posts'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, []);

  return { posts, loading, error };
}

export function useBlogPost(slug: string) {
  const [post, setPost]   = useState<BlogPost | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError]     = useState<string | null>(null);

  useEffect(() => {
    if (!slug) return;
    let active = true;
    setLoading(true);
    api.blog.getBySlug(slug)
      .then((data: BlogPost) => { if (active) setPost(data); })
      .catch((err: Error)    => { if (active) setError(err.message ?? 'Failed to fetch blog post'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [slug]);

  return { post, loading, error };
}

export async function createBlogPost(post: Omit<BlogPost, 'id' | 'created_at' | 'updated_at'>) {
  return api.blog.create(post);
}

export async function updateBlogPost(id: number, updates: Partial<BlogPost>) {
  return api.blog.update(id, updates);
}

export async function deleteBlogPost(id: number) {
  return api.blog.delete(id);
}
