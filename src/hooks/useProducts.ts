import { useState, useEffect } from 'react';
import { api } from '@/lib/api';
import type { Product } from '@/types';

export function useProducts(category?: string) {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading]   = useState(true);
  const [error, setError]       = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    setLoading(true);
    api.products.getAll(category)
      .then((data: Product[]) => { if (active) setProducts(data ?? []); })
      .catch((err: Error) => { if (active) setError(err.message ?? 'Failed to fetch products'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [category]);

  return { products, loading, error };
}

export function useProduct(id: number) {
  const [product, setProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError]     = useState<string | null>(null);

  useEffect(() => {
    if (!id) return;
    let active = true;
    setLoading(true);
    api.products.getById(id)
      .then((data: Product) => { if (active) setProduct(data); })
      .catch((err: Error)   => { if (active) setError(err.message ?? 'Failed to fetch product'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [id]);

  return { product, loading, error };
}

export async function createProduct(product: Omit<Product, 'id' | 'created_at' | 'updated_at'>) {
  return api.products.create(product);
}

export async function updateProduct(id: number, updates: Partial<Product>) {
  return api.products.update(id, updates);
}

export async function deleteProduct(id: number) {
  return api.products.delete(id);
}
