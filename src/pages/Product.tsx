import { useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { CheckCircle2 } from 'lucide-react';
import { useProduct } from '@/hooks/useProducts';
import { api } from '@/lib/api';
import { useSiteContent } from '@/hooks/useSiteContent';
import { siteOrigin } from '@/lib/site';
import SEO from '@/components/SEO';

const FALLBACK_IMG = '/images/product-placeholder.svg';
const CIRCLE = '#f6e6cf';

function resolveImg(src?: string) {
  if (!src) return FALLBACK_IMG;
  if (src.startsWith('http') || src.startsWith('/')) return src;
  return `/${src}`;
}

const FALLBACK_BENEFITS = [
  'Nature-infused, botanically-derived formula',
  'Gentle enough for everyday use',
  'Dermatologically considerate ingredients',
  'Cruelty-free and thoughtfully made',
];

const FALLBACK_HOW_TO_USE = [
  'Apply an appropriate amount to clean skin or hair.',
  'Massage gently and evenly until absorbed.',
  'Use daily as part of your routine for best results.',
];

function formatWaNumber(phone: string) {
  const digits = phone.replace(/\D/g, '');
  if (digits.startsWith('0')) return '234' + digits.slice(1);
  return digits;
}

export default function Product() {
  const { id } = useParams<{ id: string }>();
  const { product, loading, error } = useProduct(Number(id));
  const content = useSiteContent();

  const [tab, setTab] = useState<'description' | 'benefits' | 'how'>('description');
  const [enquiryForm, setEnquiryForm]     = useState({ name: '', email: '', message: '', hp: '' });
  const [enquiryStatus, setEnquiryStatus] = useState<'idle' | 'sending' | 'done' | 'error'>('idle');
  const [enquiryErrors, setEnquiryErrors] = useState<Record<string, string>>({});

  if (loading) return <div className="text-center py-20 text-gray-500">Loading…</div>;
  if (error) return <div className="text-center py-20 text-red-500">{error}</div>;
  if (!product) {
    return (
      <div className="text-center py-20">
        <p className="text-gray-600 mb-4">Product not found.</p>
        <Link to="/shop" className="text-gold-raw underline">Back to shop</Link>
      </div>
    );
  }

  const waEnabled = content.whatsappEnabled !== false;
  const waNumber = formatWaNumber(content.whatsappNumber || content.footerPhone1 || '2348034883603');
  const waText = encodeURIComponent(`Hi, I'd like to enquire about *${product.name}* by ${product.brand}.`);

  const handleEnquirySubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const errs: Record<string, string> = {};
    const name    = enquiryForm.name.trim();
    const email   = enquiryForm.email.trim();
    const message = enquiryForm.message.trim();
    if (!name || name.length < 2)
      errs.name = 'Please enter your full name (at least 2 characters).';
    else if (name.length > 100 || !/^[\p{L}\s\-'.]+$/u.test(name))
      errs.name = 'Name can only contain letters, spaces, hyphens, apostrophes and dots.';
    if (!email || email.length > 254 || !/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(email))
      errs.email = 'Please enter a valid email address.';
    if (!message || message.length < 20)
      errs.message = `Message too short — please provide more detail (${message.length}/20 characters).`;
    else if (message.length > 2000)
      errs.message = 'Message must be under 2000 characters.';
    if (Object.keys(errs).length > 0) { setEnquiryErrors(errs); return; }
    setEnquiryErrors({});
    setEnquiryStatus('sending');
    try {
      await api.enquiries.create({
        type:         'product',
        name,
        email,
        message,
        product_id:   product.id,
        product_name: product.name,
        subject:      `Enquiry: ${product.name}`,
        status:       'new',
        _hp:          enquiryForm.hp,
      });
      setEnquiryStatus('done');
    } catch {
      setEnquiryStatus('error');
    }
  };

  return (
    <div className="product-page">
      <SEO
        page="shop"
        overrides={{
          fullTitle: `${product.name} | XpelBeauty NG`,
          description: product.description || `Discover ${product.name} by ${product.brand} — premium nature-infused beauty.`,
          ogImage: product.image || '',
          keywords: `${product.name}, ${product.brand}, buy beauty products nigeria`,
        }}
        jsonLd={{
          '@context': 'https://schema.org',
          '@type': 'Product',
          name: product.name,
          image: (() => { const img = resolveImg(product.image); return img.startsWith('http') ? img : siteOrigin() + img; })(),
          description: product.description || `${product.name} by ${product.brand}`,
          brand: { '@type': 'Brand', name: product.brand },
          category: product.category,
          offers: {
            '@type': 'Offer',
            priceCurrency: 'NGN',
            price: product.price,
            availability: product.stock > 0 ? 'https://schema.org/InStock' : 'https://schema.org/OutOfStock',
            url: siteOrigin() + `/product/${product.id}`,
          },
        }}
      />
      <div className="product-wrap">
        {/* Breadcrumb */}
        <nav className="product-crumb">
          <Link to="/">Home</Link> ›{' '}
          <Link to={`/shop?cat=${(product.category || '').toLowerCase().replace(/ & | /g, '-')}`}>
            {product.category}
          </Link>{' '}
          › <span>{product.name}</span>
        </nav>

        <div className="product-top">
          {/* Image */}
          <div className="product-stage">
            <span className="product-circle" style={{ background: CIRCLE }}></span>
            <img
              src={resolveImg(product.image)}
              alt={product.name}
              className="product-img"
              onError={(e) => { (e.target as HTMLImageElement).src = FALLBACK_IMG; }}
            />
          </div>

          {/* Details */}
          <div className="product-details">
            <span className="product-brand">{product.brand}</span>
            <h1 className="product-name">{product.name}</h1>
            <div className="product-rating">★★★★★ <span>(verified favourite)</span></div>

            <div className="product-price-row">
              {product.price > 0 && (
                <span className="product-price">₦{Number(product.price).toLocaleString('en-NG')}</span>
              )}
              <span className={`product-stock-chip ${product.stock > 0 ? 'in' : 'out'}`}>
                {product.stock > 0 ? 'In stock' : 'Out of stock'}
              </span>
            </div>

            <p className="product-short">
              {product.description ||
                `A nature-infused ${product.category?.toLowerCase()} essential, thoughtfully formulated to care for you every day.`}
            </p>

            {/* CTA buttons */}
            <div className="product-buy">
              <Link to="/contact" className="product-add-btn">
                Enquire Now
              </Link>
              {waEnabled && <a
                href={`https://wa.me/${waNumber}?text=${waText}`}
                target="_blank"
                rel="noopener noreferrer"
                className="product-whatsapp-btn"
              >
                <svg width="17" height="17" viewBox="0 0 24 24" fill="currentColor" style={{ flexShrink: 0 }}>
                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                </svg>
                WhatsApp
              </a>}
              <Link to="/stores" className="product-find-btn">
                Find a Stockist
              </Link>
            </div>

            <ul className="product-assurances">
              <li><CheckCircle2 size={15} strokeWidth={2} className="about-check-icon" /> Authentic Xpel Beauty Care product</li>
              <li><CheckCircle2 size={15} strokeWidth={2} className="about-check-icon" /> Available at stockists nationwide</li>
              <li><CheckCircle2 size={15} strokeWidth={2} className="about-check-icon" /> Nature-infused, quality-tested formula</li>
            </ul>
          </div>
        </div>

        {/* Read-more tabs */}
        <div className="product-tabs">
          <div className="product-tab-head">
            <button className={tab === 'description' ? 'active' : ''} onClick={() => setTab('description')}>Description</button>
            <button className={tab === 'benefits' ? 'active' : ''} onClick={() => setTab('benefits')}>Key Benefits</button>
            <button className={tab === 'how' ? 'active' : ''} onClick={() => setTab('how')}>How to Use</button>
          </div>
          <div className="product-tab-body">
            {tab === 'description' && (
              <p>
                {product.description ||
                  `Meet your new everyday essential. This ${product.category?.toLowerCase()} product from ${product.brand} is part of Xpel Beauty Care's nature-infused care collection — created to deliver visible results with ingredients you can trust.`}
              </p>
            )}
            {tab === 'benefits' && (
              <ul className="product-benefit-list">
                {(product.key_benefits
                  ? product.key_benefits.split('\n').filter(Boolean)
                  : FALLBACK_BENEFITS
                ).map((b) => (
                  <li key={b}><CheckCircle2 size={15} strokeWidth={2} className="about-check-icon" /> {b}</li>
                ))}
              </ul>
            )}
            {tab === 'how' && (
              <ol className="product-how-list">
                {(product.how_to_use
                  ? product.how_to_use.split('\n').filter(Boolean)
                  : FALLBACK_HOW_TO_USE
                ).map((h, i) => (
                  <li key={i}><strong>{i + 1}.</strong> {h}</li>
                ))}
              </ol>
            )}
          </div>
        </div>

        {/* Enquiry form */}
        <div className="product-enquiry">
          <h3>Have a question about this product?</h3>
          <p className="product-enquiry-sub">Send us a message — we usually reply within a few hours.</p>

          {enquiryStatus === 'done' ? (
            <div className="enquiry-success">
              ✅ Thank you! We've received your enquiry and will be in touch shortly.
            </div>
          ) : (
            <form className="enquiry-form" onSubmit={handleEnquirySubmit} noValidate>
              {/* Honeypot — invisible to real users, filled by bots */}
              <div style={{ position: 'absolute', left: '-9999px', top: '-9999px', opacity: 0, height: 1, width: 1, overflow: 'hidden', pointerEvents: 'none' }} aria-hidden="true">
                <label htmlFor="enq_website">Website</label>
                <input type="text" id="enq_website" name="hp" value={enquiryForm.hp}
                  onChange={e => setEnquiryForm({ ...enquiryForm, hp: e.target.value })}
                  tabIndex={-1} autoComplete="off" />
              </div>

              <input
                type="text"
                placeholder="Your Name *"
                value={enquiryForm.name}
                onChange={e => { setEnquiryForm({ ...enquiryForm, name: e.target.value }); setEnquiryErrors(p => { const n={...p}; delete n.name; return n; }); }}
                style={enquiryErrors.name ? { borderColor: '#dc2626' } : {}}
              />
              {enquiryErrors.name && <p style={{ color: '#dc2626', fontSize: 12, margin: '-8px 0 4px' }}>{enquiryErrors.name}</p>}

              <input
                type="email"
                placeholder="Your Email *"
                value={enquiryForm.email}
                onChange={e => { setEnquiryForm({ ...enquiryForm, email: e.target.value }); setEnquiryErrors(p => { const n={...p}; delete n.email; return n; }); }}
                style={enquiryErrors.email ? { borderColor: '#dc2626' } : {}}
              />
              {enquiryErrors.email && <p style={{ color: '#dc2626', fontSize: 12, margin: '-8px 0 4px' }}>{enquiryErrors.email}</p>}

              <textarea
                placeholder="Your Message * (at least 20 characters)"
                rows={4}
                value={enquiryForm.message}
                onChange={e => { setEnquiryForm({ ...enquiryForm, message: e.target.value }); setEnquiryErrors(p => { const n={...p}; delete n.message; return n; }); }}
                style={enquiryErrors.message ? { borderColor: '#dc2626' } : {}}
              />
              {enquiryErrors.message && <p style={{ color: '#dc2626', fontSize: 12, margin: '-8px 0 4px' }}>{enquiryErrors.message}</p>}

              {enquiryStatus === 'error' && (
                <p style={{ color: '#dc2626', fontSize: 13, margin: '4px 0' }}>Something went wrong — please try again.</p>
              )}
              <button type="submit" disabled={enquiryStatus === 'sending'}>
                {enquiryStatus === 'sending' ? 'Sending…' : 'Send Enquiry'}
              </button>

              {waEnabled && <a
                href={`https://wa.me/${waNumber}?text=${waText}`}
                target="_blank"
                rel="noopener noreferrer"
                className="enquiry-whatsapp-btn"
              >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
                </svg>
                Or enquire via WhatsApp
              </a>}
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
