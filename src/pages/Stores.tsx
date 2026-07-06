import { useStores } from '@/hooks/useStores';
import { useSiteContent } from '@/hooks/useSiteContent';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';

export default function Stores() {
  const { stores, loading, error } = useStores();
  const content = useSiteContent();

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <SEO page="stores" />
      <div className="mb-8"><PromoBanner banner={content.banners.stores} /></div>
      <h1 className="text-5xl font-cormorant mb-3">{content.storesTitle}</h1>
      <p className="text-gray-600 mb-8">{content.storesIntro}</p>

      {loading && <div className="text-center py-12">Loading...</div>}
      {error && <div className="text-red-500">{error}</div>}

      {stores && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {stores.map((store) => (
            <div key={store.id} className="border rounded-lg p-6 hover:shadow-lg transition">
              {/* Store logo */}
              {store.logo && (
                <div className="mb-4 flex items-center justify-center" style={{ height: '72px' }}>
                  <img
                    src={store.logo}
                    alt={`${store.name} logo`}
                    style={{ maxHeight: '72px', maxWidth: '160px', objectFit: 'contain' }}
                    onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
                  />
                </div>
              )}

              <h3 className="text-2xl font-cormorant mb-2">{store.name}</h3>
              <p className="text-gray-600 mb-4">
                {store.address}
                <br />
                {store.city}, {store.state}
              </p>

              <div className="space-y-2 text-sm">
                <p>
                  <span className="font-semibold">Phone:</span>
                  <br />
                  <a href={`tel:${store.phone}`} className="text-gold-raw hover:underline">
                    {store.phone}
                  </a>
                </p>
                <p>
                  <span className="font-semibold">Email:</span>
                  <br />
                  <a href={`mailto:${store.email}`} className="text-gold-raw hover:underline">
                    {store.email}
                  </a>
                </p>
                {store.hours && (
                  <p>
                    <span className="font-semibold">Hours:</span>
                    <br />
                    {store.hours}
                  </p>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {stores?.length === 0 && (
        <div className="text-center py-12 text-gray-600">No stores found.</div>
      )}
    </div>
  );
}
