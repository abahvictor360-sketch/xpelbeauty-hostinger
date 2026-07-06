import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { CheckCircle2 } from 'lucide-react';
import { useProducts } from '@/hooks/useProducts';
import { useSiteContent } from '@/hooks/useSiteContent';
import SEO from '@/components/SEO';

const CIRCLES = ['#d8efe2', '#f7dfe6', '#f6e6cf', '#e3e9f7', '#f3e2f0', '#e8f2d8'];
const FALLBACK_IMG = '/images/product-placeholder.svg';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/')) return src;
  return `/${src}`;
}

export default function Home() {
  const [currentSlide, setCurrentSlide] = useState(0);
  const { products } = useProducts();
  const content = useSiteContent();

  // Best sellers: use admin-chosen IDs when set, else fall back to products with images
  const chosenIds = content.bestSellerIds ?? [];
  const withImages = products.filter((p) => p.image && p.image.trim() !== '' && !p.image.includes('placeholder'));
  const realBestSellers = chosenIds.length > 0
    ? products.filter(p => chosenIds.includes(p.id)).slice(0, 6)
    : (withImages.length >= 6 ? withImages : products).slice(0, 6);

  const heroSlides = content.heroSlides ?? [];

  // Nature-infused ranges (inspired by the XPEL collections)
  const categories = [
    { href: '/shop?cat=body-beauty', label: 'Hydration & Radiance', sub: 'Aloe · Watermelon · Vitamin C' },
    { href: '/shop?cat=hair-care', label: 'Nourish & Repair', sub: 'Argan · Black Castor · Avocado' },
    { href: '/shop?cat=travel-health', label: 'Purify & Protect', sub: 'Tea Tree · Charcoal · Rosemary' },
    { href: '/shop?cat=home', label: 'Fresh & Clean', sub: 'Everyday home essentials' },
    { href: '/shop?cat=gifting', label: 'Gift & Glow', sub: 'Curated sets & treats' },
  ].map((c, i) => ({ ...c, bg: content.catImages[i] }));

  // Demo fallback used only if Supabase has no products yet
  const demoBestSellers = [
    { id: 'p1', name: 'Argan Oil Shampoo', rating: '★★★★★', img: '/images/product-40183.png', circle: '#d8efe2' },
    { id: 'p2', name: 'Tea Tree Anti-Bacterial Handwash', rating: '★★★★★', img: '/Img/40155_HERO.webp', circle: '#f7dfe6' },
    { id: 'p3', name: 'Argan Oil Conditioner', rating: '★★★★☆', img: '/Img/40184_HERO.webp', circle: '#f6e6cf' },
    { id: 'p4', name: 'Tea Tree Cleansing Pads', rating: '★★★★★', img: '/Img/40862_HERO.webp', circle: '#e3e9f7' },
    { id: 'p5', name: 'Tea Tree Facial Toner', rating: '★★★★★', img: '/Img/41440_HERO.webp', circle: '#f3e2f0' },
    { id: 'p6', name: 'Argan Oil Hair Treatment', rating: '★★★★☆', img: '/Img/40167_HERO.webp', circle: '#e8f2d8' },
  ];

  // IVA-style alternating feature blocks — all text editable via Admin > Content Manager
  const features = [
    { kicker: content.feat1Kicker, title: content.feat1Title, text: content.feat1Text, href: content.feat1Href },
    { kicker: content.feat2Kicker, title: content.feat2Title, text: content.feat2Text, href: content.feat2Href },
    { kicker: content.feat3Kicker, title: content.feat3Title, text: content.feat3Text, href: content.feat3Href },
  ].map((f, i) => ({ ...f, img: content.featureImages[i] }));

  const handlePrevSlide = () => {
    setCurrentSlide((prev) => (prev === 0 ? heroSlides.length - 1 : prev - 1));
  };

  const handleNextSlide = () => {
    setCurrentSlide((prev) => (prev === heroSlides.length - 1 ? 0 : prev + 1));
  };

  useEffect(() => {
    if (heroSlides.length === 0) return;
    const timer = setInterval(() => {
      setCurrentSlide((prev) => (prev === heroSlides.length - 1 ? 0 : prev + 1));
    }, 6000);
    return () => clearInterval(timer);
  }, [heroSlides.length]);

  // IVA-style scroll reveal — animate sections into view as they scroll up
  useEffect(() => {
    const targets = document.querySelectorAll('.fade-up, .fade-up-stagger, .reveal');
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: '0px 0px -60px 0px' }
    );
    targets.forEach((el) => observer.observe(el));
    return () => observer.disconnect();
  }, []);

  return (
    <div>
      <SEO page="home" />
      {/* ══════════════════════════════════════════════════════════
          HERO CAROUSEL — rich text banners
      ═══════════════════════════════════════════════════════════ */}
      <section className="carousel" aria-label="Featured products" data-xpel-section="hero">
        <div
          className="carousel-track"
          style={{ transform: `translateX(-${currentSlide * 100}%)` }}
        >
          {heroSlides.map((slide, idx) => (
            <div
              key={idx}
              className={`carousel-slide ${idx === currentSlide ? 'active' : ''}`}
              style={{
                '--hs-overlay': slide.overlayColor || 'rgba(20,10,5,.88)',
                // Fallback background if image fails to load — extracted from overlayColor
                backgroundColor: (slide.overlayColor || 'rgba(20,10,5,1)').replace(/[\d.]+\)$/, '1)'),
              } as React.CSSProperties}
            >
              {/* Background image */}
              <img src={slide.image} alt={slide.headlineLine1 + ' ' + slide.headlineLine2} loading={idx === 0 ? 'eager' : 'lazy'} />

              {/* Colour-matched gradient overlay — colour is sampled from the banner */}
              <div className="hs-fade" aria-hidden="true" />

              {/* Text overlay */}
              <div className="hs-text">
                {/* Layer 1 — brand lockup */}
                {slide.brandLockup && (
                  <span className="hs-brand">{slide.brandLockup}</span>
                )}

                {/* Layer 2 — sub-range label */}
                {slide.subLabel && (
                  <span className="hs-sub">{slide.subLabel}</span>
                )}

                {/* Layer 3 — display headline */}
                <h2 className="hs-headline" style={{ color: slide.headlineColor }}>
                  {slide.headlineLine1}<br />{slide.headlineLine2}
                </h2>

                {/* Layer 4 — descriptor */}
                {slide.descriptor && (
                  <p className="hs-descriptor">{slide.descriptor}</p>
                )}

                {/* Layer 5 — benefit stack */}
                {slide.benefits?.length > 0 && (
                  <ul className="hs-benefits">
                    {slide.benefits.map((b, bi) => (
                      <li key={bi}>
                        <CheckCircle2 size={14} strokeWidth={2} className="hs-tick" style={{ color: slide.headlineColor }} /> {b}
                      </li>
                    ))}
                  </ul>
                )}

                {/* Layer 6 — vegan badge */}
                {slide.vegaBadge && (
                  <span
                    className="hs-badge"
                    style={{
                      background: slide.vegaBadgeBg || 'rgba(255,255,255,.18)',
                      color: slide.vegaBadgeColor || '#fff',
                      border: `1px solid ${slide.vegaBadgeBg || 'rgba(255,255,255,.35)'}`,
                    }}
                  >
                    {slide.vegaBadge}
                  </span>
                )}

                {/* Layer 7 — CTA button */}
                {slide.ctaLabel && slide.ctaHref && (
                  <Link
                    to={slide.ctaHref}
                    className="hs-cta"
                    style={{
                      backgroundColor: slide.ctaBg || '#fff',
                      color: slide.ctaColor || '#000',
                    }}
                  >
                    {slide.ctaLabel}
                  </Link>
                )}
              </div>
            </div>
          ))}
        </div>

        {/* Arrows */}
        <button className="carousel-arrow prev" aria-label="Previous slide" onClick={handlePrevSlide}>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <polyline points="15 18 9 12 15 6" />
          </svg>
        </button>
        <button className="carousel-arrow next" aria-label="Next slide" onClick={handleNextSlide}>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <polyline points="9 18 15 12 9 6" />
          </svg>
        </button>

        {/* Dots */}
        <div className="carousel-dots">
          {heroSlides.map((_, idx) => (
            <button
              key={idx}
              className={`carousel-dot ${idx === currentSlide ? 'active' : ''}`}
              onClick={() => setCurrentSlide(idx)}
              aria-label={`Go to slide ${idx + 1}`}
            />
          ))}
        </div>
      </section>

      {/* ══════════════════════════════════════════════════════════
          PROMO BANNER (admin-uploaded)
      ═══════════════════════════════════════════════════════════ */}
      {content.banner && (
        <section className="home-banner">
          <Link to="/shop">
            <img src={content.banner} alt="Featured promotion" />
          </Link>
        </section>
      )}

      {/* ══════════════════════════════════════════════════════════
          EXPLORE OUR RANGE  (3 + 2 grid)
      ═══════════════════════════════════════════════════════════ */}
      <section style={{ background: 'var(--white)', padding: '60px 40px' }} data-xpel-section="explore">
        <div style={{ maxWidth: '1280px', margin: '0 auto' }}>
          <div className="reveal" style={{ textAlign: 'center', marginBottom: '32px' }}>
            <span className="section-label" data-xpel-key="home-explore-label">{content.exploreLabel}</span>
            <h2 className="section-title" style={{ marginBottom: '0' }} data-xpel-key="home-explore-title">{content.exploreTitle}</h2>
          </div>

          {/* Row 1: 3 cards */}
          <div className="cat-grid-3 reveal">
            {categories.slice(0, 3).map((cat, idx) => (
              <a key={idx} href={cat.href} className="cat-card-v2">
                <div className="cat-card-v2-bg" style={{ backgroundImage: `url('${cat.bg}')` }}></div>
                <div className="cat-card-v2-overlay"></div>
                <div className="cat-card-v2-text">
                  <span className="cat-card-v2-label">{cat.sub}</span>
                  <span className="cat-card-v2-name">{cat.label}</span>
                </div>
              </a>
            ))}
          </div>

          {/* Row 2: 2 cards centred */}
          <div className="cat-grid-2 reveal">
            {categories.slice(3, 5).map((cat, idx) => (
              <a key={idx} href={cat.href} className="cat-card-v2">
                <div className="cat-card-v2-bg" style={{ backgroundImage: `url('${cat.bg}')` }}></div>
                <div className="cat-card-v2-overlay"></div>
                <div className="cat-card-v2-text">
                  <span className="cat-card-v2-label">{cat.sub}</span>
                  <span className="cat-card-v2-name">{cat.label}</span>
                </div>
              </a>
            ))}
          </div>
        </div>
      </section>

      {/* ══════════════════════════════════════════════════════════
          BEST SELLERS — enhanced cards with hover quick actions
      ═══════════════════════════════════════════════════════════ */}
      <section style={{ background: 'var(--white)', padding: '80px 40px' }} data-xpel-section="bestSellers">
        <div style={{ maxWidth: '1280px', margin: '0 auto' }}>
          <div className="fade-up" style={{ textAlign: 'center', marginBottom: '56px' }}>
            <span className="section-label">what's hot</span>
            <h2 className="section-title section-title-anim" style={{ marginBottom: '0' }} data-xpel-key="home-sellers-title">{content.sellersTitle}</h2>
            <p style={{ color: 'var(--muted)', fontSize: '15px', maxWidth: '520px', margin: '18px auto 0', lineHeight: '1.7' }}>The nature-infused favourites our customers reach for again and again — your routine's new essentials.</p>
          </div>

          <div className="iva-grid fade-up-stagger">
            {realBestSellers.length > 0
              ? realBestSellers.map((product, idx) => (
                  <Link key={product.id} to={`/product/${product.id}`} className="iva-product">
                    <div className="iva-product-stage">
                      <span className="iva-product-circle" style={{ background: CIRCLES[idx % CIRCLES.length] }}></span>
                      <img
                        src={resolveImg(product.image)}
                        alt={product.name}
                        className="iva-product-img"
                        onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
                      />
                    </div>
                    <span className="iva-product-cat">{product.category}</span>
                    <h3 className="iva-product-name">{product.name}</h3>
                    <div className="iva-product-rating">★★★★★</div>
                  </Link>
                ))
              : demoBestSellers.map((product) => (
                  <div key={product.id} className="iva-product">
                    <div className="iva-product-stage">
                      <span className="iva-product-circle" style={{ background: product.circle }}></span>
                      <img src={product.img} alt={product.name} className="iva-product-img" />
                    </div>
                    <h3 className="iva-product-name">{product.name}</h3>
                    <div className="iva-product-rating">{product.rating}</div>
                  </div>
                ))}
          </div>

          <div style={{ textAlign: 'center', marginTop: '48px' }} className="fade-up">
            <a
              href="/shop"
              style={{
                display: 'inline-block',
                padding: '14px 42px',
                borderRadius: '9999px',
                background: 'var(--gold-raw)',
                color: 'white',
                fontSize: '13px',
                fontWeight: '600',
                textTransform: 'uppercase',
                letterSpacing: '1.5px',
                textDecoration: 'none',
                transition: 'all .25s ease',
                boxShadow: '0 4px 12px rgba(202,124,41,.3)',
              }}
              onMouseOver={(e) => {
                e.currentTarget.style.transform = 'translateY(-2px)';
                e.currentTarget.style.boxShadow = '0 6px 20px rgba(202,124,41,.4)';
              }}
              onMouseOut={(e) => {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 4px 12px rgba(202,124,41,.3)';
              }}
            >
              See All Products
            </a>
          </div>
        </div>
      </section>

      {/* ══════════════════════════════════════════════════════════
          IVA-STYLE QUOTE BANNER (in-between section)
      ═══════════════════════════════════════════════════════════ */}
      <section
        className="home-quote reveal"
        style={content.quoteImage ? {
          backgroundImage: `linear-gradient(135deg, rgba(202,124,41,.88), rgba(111,55,22,.9)), url('${content.quoteImage}')`,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
        } : undefined}
      >
        <div className="home-quote-inner">
          <span className="home-quote-kicker">100% safe &amp; pure</span>
          <h2 className="home-quote-text">“{content.quoteText}”</h2>
          <Link to="/about" className="home-quote-btn">Our Story</Link>
        </div>
      </section>

      {/* ══════════════════════════════════════════════════════════
          ALTERNATING FEATURE BLOCKS (IVA style)
      ═══════════════════════════════════════════════════════════ */}
      <section className="home-features">
        <div className="reveal" style={{ textAlign: 'center', padding: '60px 40px 0', marginBottom: '8px' }}>
          <span className="section-label">crafted for you</span>
          <h2 className="section-title section-title-anim" style={{ marginBottom: '0' }}>our featured ranges</h2>
          <p style={{ color: 'var(--muted)', fontSize: '15px', maxWidth: '520px', margin: '16px auto 0', lineHeight: '1.7' }}>
            Nature-infused collections designed to care for your skin and hair, every day.
          </p>
        </div>
        {features.map((f, i) => (
          <div key={f.title} className={`feature-row ${i % 2 === 1 ? 'reverse' : ''} reveal`}>
            <div className="feature-media">
              <img src={f.img} alt={f.title} />
            </div>
            <div className="feature-text">
              <span className="feature-kicker">{f.kicker}</span>
              <h3 className="feature-title">{f.title}</h3>
              <p className="feature-desc">{f.text}</p>
              <Link to={f.href} className="feature-link">Discover more →</Link>
            </div>
          </div>
        ))}
      </section>

      {/* ══════════════════════════════════════════════════════════
          CTA BANNER — BCO slide image as background
      ═══════════════════════════════════════════════════════════ */}
      {(() => {
        const bcoSlide = heroSlides.find(s =>
          (s.subLabel || '').toLowerCase().includes('castor') ||
          (s.descriptor || '').toLowerCase().includes('castor')
        );
        const bgImg = bcoSlide ? bcoSlide.image : '/banner/banner3.png';
        return (
          <section
            className="reveal home-cta"
            data-xpel-section="cta"
            style={{
              padding: '72px 40px',
              textAlign: 'center',
              position: 'relative',
              backgroundColor: '#1e0a02',
              backgroundImage: `linear-gradient(rgba(30,10,2,.72), rgba(30,10,2,.72)), url('${bgImg}')`,
              backgroundSize: 'cover',
              backgroundPosition: 'center',
            }}
          >
            <h2
              style={{
                fontFamily: "'Cormorant Garamond',serif",
                fontSize: 'clamp(28px,4vw,48px)',
                color: 'white',
                fontStyle: 'italic',
                marginBottom: '28px',
              }}
              data-xpel-key="home-cta-text"
            >
              {content.ctaText}
            </h2>
            <a
              href="/shop"
              style={{
                display: 'inline-block',
                padding: '12px 36px',
                borderRadius: '9999px',
                border: '2px solid var(--gold-raw)',
                color: 'var(--gold-raw)',
                fontSize: '13px',
                fontWeight: '600',
                textTransform: 'uppercase',
                letterSpacing: '1px',
                textDecoration: 'none',
                transition: 'all .25s ease',
              }}
              onMouseOver={(e) => {
                e.currentTarget.style.background = 'var(--gold-raw)';
                e.currentTarget.style.color = 'white';
              }}
              onMouseOut={(e) => {
                e.currentTarget.style.background = 'transparent';
                e.currentTarget.style.color = 'var(--gold-raw)';
              }}
            >
              shop the collection
            </a>
          </section>
        );
      })()}
    </div>
  );
}
