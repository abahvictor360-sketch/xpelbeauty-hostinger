import { useMemo, useState } from 'react';
import { Navigation } from 'lucide-react';
import { useStores } from '@/hooks/useStores';
import { useSiteContent } from '@/hooks/useSiteContent';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';
import type { Store } from '@/types';

// Cycled pastel backgrounds for initials avatars — matches the redesign's stage palette.
const AVATAR_BG = ['var(--stage-mint)', 'var(--stage-blush)', 'var(--stage-sky)', 'var(--stage-sand)'];

function avatarColor(name: string) {
  let hash = 0;
  for (let i = 0; i < name.length; i++) hash = (hash * 31 + name.charCodeAt(i)) >>> 0;
  return AVATAR_BG[hash % AVATAR_BG.length];
}

function directionsUrl(store: Store) {
  const parts = [store.name, store.address, store.city, store.state, 'Nigeria'].filter(Boolean);
  return `https://www.google.com/maps/dir/?api=1&destination=${encodeURIComponent(parts.join(', '))}`;
}

function StoreCard({ store }: { store: Store }) {
  const [logoFailed, setLogoFailed] = useState(false);
  const showLogo = store.logo && !logoFailed;
  const initial = store.name.trim().charAt(0).toUpperCase() || '?';

  const openDirections = () => window.open(directionsUrl(store), '_blank', 'noopener,noreferrer');

  return (
    <div
      className="xp-store-card"
      role="button"
      tabIndex={0}
      onClick={openDirections}
      onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openDirections(); } }}
      aria-label={`Get directions to ${store.name}`}
    >
      {showLogo ? (
        <img
          src={store.logo}
          alt=""
          className="xp-store-logo-img"
          onError={() => setLogoFailed(true)}
        />
      ) : (
        <span className="xp-store-logo-initial" style={{ background: avatarColor(store.name) }} aria-hidden="true">
          {initial}
        </span>
      )}
      <div className="xp-store-body">
        <h3 className="xp-store-name">{store.name}</h3>
        {(store.city || store.address) && (
          <p className="xp-store-loc">
            {[store.address, store.city].filter(Boolean).join(', ')}
          </p>
        )}
        {store.phone && (
          <a
            href={`tel:${store.phone}`}
            className="xp-store-tel"
            onClick={(e) => e.stopPropagation()}
          >
            {store.phone}
          </a>
        )}
        <span className="xp-store-directions">
          <Navigation size={12} strokeWidth={2.5} /> Get directions
        </span>
      </div>
    </div>
  );
}

export default function Stores() {
  const { stores, loading, error, refetch } = useStores();
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
      {error && (
        <div className="xp-scan-status xp-scan-status-warn" style={{ maxWidth: '460px', margin: '0 auto 24px' }}>
          <p><strong>Couldn't load stores.</strong></p>
          <p className="xp-scan-status-sub">{error}</p>
          <button type="button" className="xp-scan-retry-btn" onClick={refetch}>Retry</button>
        </div>
      )}

      {!loading && !error && total > 0 && (
        <>
          {/* Sticky search + state filter */}
          <div className="xp-stores-toolbar">
            <input
              type="text"
              className="xp-stores-search"
              placeholder="Search stores by name, city or state…"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
            <div className="xp-state-pills">
              <button
                className={`xp-state-pill ${stateFilter === null ? 'active' : ''}`}
                onClick={() => setStateFilter(null)}
              >
                All ({total})
              </button>
              {allStates.map(([st, n]) => (
                <button
                  key={st}
                  className={`xp-state-pill ${stateFilter === st ? 'active' : ''}`}
                  onClick={() => setStateFilter(stateFilter === st ? null : st)}
                >
                  {st} ({n})
                </button>
              ))}
            </div>
            <p className="xp-stores-count">Showing {shown} of {total} stockists</p>
          </div>

          {/* State sections */}
          {grouped.map(([st, list]) => (
            <section key={st} className="xp-state-section">
              <h2 className="xp-state-heading">
                {st}
                <small>{list.length} store{list.length !== 1 ? 's' : ''}</small>
              </h2>
              <div className="xp-state-rule" />

              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                {list.map((store) => <StoreCard key={store.id} store={store} />)}
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
