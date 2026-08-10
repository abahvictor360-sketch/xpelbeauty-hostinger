import { useEffect, useMemo, useRef, useState } from 'react';
import { api } from '@/lib/api';
import type { Product, BlogPost } from '@/types';

export interface ProductSuggestion {
  type: 'product';
  id: number;
  name: string;
  image?: string;
  brand?: string;
}

export interface BlogSuggestion {
  type: 'blog';
  id: number;
  slug: string;
  title: string;
  image?: string;
}

export type Suggestion = ProductSuggestion | BlogSuggestion;

/**
 * Live product + blog post suggestions for a search query.
 * The PHP API has no dedicated search endpoint, so the full product and
 * published-post lists are fetched once and cached, then filtered
 * in-memory per keystroke — fine at this catalogue size and avoids a
 * network round-trip on every character typed.
 */
export function useSearchSuggestions(query: string, limit = 5) {
  const [allProducts, setAllProducts] = useState<Product[]>([]);
  const [allPosts, setAllPosts] = useState<BlogPost[]>([]);
  const loadedRef = useRef(false);

  useEffect(() => {
    const q = query.trim();
    if (q.length < 2 || loadedRef.current) return;
    loadedRef.current = true;
    (async () => {
      try {
        const [products, posts] = await Promise.all([
          api.products.getAll(),
          api.blog.getAll(),
        ]);
        setAllProducts(Array.isArray(products) ? products : []);
        setAllPosts((Array.isArray(posts) ? posts : []).filter((p: BlogPost) => p.published));
      } catch {
        // silently ignore — search suggestions are non-critical
      }
    })();
  }, [query]);

  const results = useMemo<Suggestion[]>(() => {
    const q = query.trim().toLowerCase();
    if (q.length < 2) return [];

    const products: ProductSuggestion[] = allProducts
      .filter((p) => p.name.toLowerCase().includes(q))
      .slice(0, limit)
      .map((p) => ({ type: 'product', id: p.id, name: p.name, image: p.image, brand: p.brand }));

    const posts: BlogSuggestion[] = allPosts
      .filter((p) => p.title.toLowerCase().includes(q))
      .slice(0, limit)
      .map((p) => ({ type: 'blog', id: p.id, slug: p.slug, title: p.title, image: p.image }));

    return [...products, ...posts];
  }, [query, allProducts, allPosts, limit]);

  const loading = query.trim().length >= 2 && allProducts.length === 0 && allPosts.length === 0 && loadedRef.current;

  return { results, loading };
}
