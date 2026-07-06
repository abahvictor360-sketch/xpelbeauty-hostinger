import { Link } from 'react-router-dom';
import type { BannerItem } from '@/hooks/useSiteContent';

export default function PromoBanner({ banner }: { banner: BannerItem }) {
  if (!banner || !banner.image) return null;

  const hasText = banner.title || banner.text;

  return (
    <section className="promo-band">
      <img className="promo-band-img" src={banner.image} alt={banner.title || 'Xpel Beauty Care'} />
      {hasText && (
        <>
          {/* Gradient that blends with the banner's own background colour */}
          <div className="promo-band-fade" aria-hidden="true" />
          {/* Text sits on top — unaffected by the blend */}
          <div className="promo-band-overlay">
            {banner.title && <h3 className="promo-band-title">{banner.title}</h3>}
            {banner.text && <p className="promo-band-text">{banner.text}</p>}
            {banner.cta && banner.href && (
              <Link to={banner.href} className="promo-band-cta">{banner.cta}</Link>
            )}
          </div>
        </>
      )}
    </section>
  );
}
