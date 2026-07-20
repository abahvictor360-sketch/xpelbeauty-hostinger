import { useMemo, useState } from 'react';
import { useStores } from '@/hooks/useStores';
import { useSiteContent } from '@/hooks/useSiteContent';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';
import type { Store } from '@/types';

export default function Stores() {
  const { stores, loading, error } = useStores();
  const content = useSiteContent();
  const [search, setSearch] = useState('');
  const [stateFilter, setStateFilter] = useState<string | null>(null);

  // Group stores by state, ordered by store count (Lagos first), "Others" last
  const grouped = useMemo(() => {
    const list = (stores ?? []).filter((s) => {
      if (stateFilter && (s.state || 'Others') !== stateFilter) return false;
      if (search.trim()) {
        const q = search.toLowerCase();
        return (
          s.name.toLowerCase().includes(q) ||
          (s.city || '').toLowerCase().includes(q) ||
          (s.state || '').toLowerCase().includes(q)
        );
      }
      return true;
    });

    const byState = new Map<string, Store[]>();
    for (const s of list) {
      const key = s.state || 'Others';
      if (!byState.has(key)) byState.set(key, []);
      byState.get(key)!.push(s);
    }
    for (const arr of byState.values()) {
      arr.sort((a, b) => (a.city || '').localeCompare(b.city || '') || a.name.localeCompare(b.name));
    }
    return [...byState.entries()].sort((a, b) => {
      if (a[0] === 'Others') return 1;
      if (b[0] === 'Others') return -1;
      return b[1].length - a[1].length || a[0].localeCompare(b[0]);
    });
  }, [stores, search, stateFilter]);

  const allStates = useMemo(() => {
    const c = new Map<string, number>();
    for (const s of stores ?? []) {
      const key = s.state || 'Others';
      c.set(key, (c.get(key) ?? 0) + 1);
    }
    return [...c.entries()].sort((a, b) => {
      if (a[0] === 'Others') return 1;
      if (b[0] === 'Others') return -1;
      return b[1] - a[1] || a[0].localeCompare(b[0]);
    });
  }, [stores]);

  const total = stores?.length ?? 0;
  const shown = grouped.reduce((n, [, arr]) => n + arr.length, 0);

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <SEO page="stores" />
      <div className="mb-8"><PromoBanner banner={content.banners.stores} /></div>
      <h1 className="text-5xl font-cormorant mb-3">{content.storesTitle}</h1>
      <p className="text-gray-600 mb-8">{content.storesIntro}</p>

      {loading && <div className="text-center py-12">Loading...</div>}
      {error && <div className="text-red-500">{error}</div>}

      {!loading && !error && total > 0 && (
        <>
          {/* Search + state filter */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '14px', marginBottom: '32px' }}>
            <input
              type="text"
              placeholder="Search stores by name, city or state…"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="w-full px-4 py-3 border rounded-full focus:outline-none focus:ring-2 focus:ring-gold-raw"
              style={{ maxWidth: '480px' }}
            />
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
              <button
                onClick={() => setStateFilter(null)}
                style={{
                  padding: '6px 16px', borderRadius: '99px', fontSize: '13px', fontWeight: 600,
                  cursor: 'pointer', transition: 'all .15s',
                  border: stateFilter === null ? '2px solid var(--gold-raw)' : '1px solid #e5e5e5',
                  background: stateFilter === null ? 'var(--gold-raw)' : '#fff',
                  color: stateFilter === null ? '#fff' : '#444',
                }}
              >
                All ({total})
              </button>
              {allStates.map(([st, n]) => (
                <button
                  key={st}
                  onClick={() => setStateFilter(stateFilter === st ? null : st)}
                  style={{
                    padding: '6px 16px', borderRadius: '99px', fontSize: '13px', fontWeight: 600,
                    cursor: 'pointer', transition: 'all .15s',
                    border: stateFilter === st ? '2px solid var(--gold-raw)' : '1px solid #e5e5e5',
                    background: stateFilter === st ? 'var(--gold-raw)' : '#fff',
                    color: stateFilter === st ? '#fff' : '#444',
                  }}
                >
                  {st} ({n})
                </button>
              ))}
            </div>
            <p className="text-sm text-gray-500">
              Showing {shown} of {total} stockists
            </p>
          </div>

          {/* State sections */}
          {grouped.map(([st, list]) => (
            <section key={st} style={{ marginBottom: '40px' }}>
              <h2
                className="font-cormorant"
                style={{
                  fontSize: '28px', fontWeight: 700, marginBottom: '4px',
                  display: 'flex', alignItems: 'baseline', gap: '10px',
                }}
              >
                {st}
                <span style={{ fontSize: '13px', fontFamily: 'Inter, sans-serif', fontWeight: 600, color: '#999' }}>
                  {list.length} store{list.length !== 1 ? 's' : ''}
                </span>
              </h2>
              <div style={{ height: '2px', width: '48px', background: 'var(--gold-raw)', marginBottom: '18px' }} />

              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                {list.map((store) => (
                  <div
                    key={store.id}
                    className="border rounded-lg hover:shadow-md transition"
                    style={{ padding: '14px 18px' }}
                  >
                    <h3 style={{ fontWeight: 600, fontSize: '15px', lineHeight: 1.35 }}>{store.name}</h3>
                    {(store.city || store.address) && (
                      <p className="text-gray-500" style={{ fontSize: '13px', marginTop: '4px' }}>
                        {[store.address, store.city].filter(Boolean).join(', ')}
                      </p>
                    )}
                    {store.phone && (
                      <a href={`tel:${store.phone}`} className="text-gold-raw hover:underline" style={{ fontSize: '13px' }}>
                        {store.phone}
                      </a>
                    )}
                  </div>
                ))}
              </div>
            </section>
          ))}

          {shown === 0 && (
            <div className="text-center py-12 text-gray-600">
              No stores match your search.{' '}
              <button
                onClick={() => { setSearch(''); setStateFilter(null); }}
                style={{ color: 'var(--gold-raw)', textDecoration: 'underline', background: 'none', border: 'none', cursor: 'pointer' }}
              >
                Clear filters
              </button>
            </div>
          )}
        </>
      )}

      {!loading && !error && total === 0 && (
        <div className="text-center py-12 text-gray-600">No stores found.</div>
      )}
    </div>
  );
}
