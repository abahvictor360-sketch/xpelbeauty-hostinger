import { useState, useEffect } from 'react';
import { api } from '@/lib/api';
import type { Store } from '@/types';

export function useStores() {
  const [stores, setStores] = useState<Store[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError]     = useState<string | null>(null);
  const [reloadKey, setReloadKey] = useState(0);

  useEffect(() => {
    let active = true;
    setLoading(true);
    setError(null);
    api.stores.getAll()
      .then((data: Store[]) => { if (active) setStores(data ?? []); })
      .catch((err: Error)   => { if (active) setError(err.message || 'Failed to fetch stores'); })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [reloadKey]);

  const refetch = () => setReloadKey((k) => k + 1);

  return { stores, loading, error, refetch };
}

export async function createStore(store: Omit<Store, 'id' | 'created_at'>) {
  return api.stores.create(store);
}

export async function updateStore(id: number, updates: Partial<Store>) {
  return api.stores.update(id, updates);
}

export async function deleteStore(id: number) {
  return api.stores.delete(id);
}
