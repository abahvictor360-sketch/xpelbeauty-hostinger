import { useState, useRef } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useSiteContent } from '@/hooks/useSiteContent';
import './Header.css';

/* ── Hardcoded range → product-ID sub-menu (kept here; not admin-editable) ── */

// Sub-products shown on hover inside the mega menu for range groups
const RANGE_PRODUCTS: Record<string, { name: string; id: number }[]> = {
  'Aloe Vera': [
    { name: 'Botanical Vegan Shampoo', id: 236 },
    { name: 'Conditioner', id: 230 },
    { name: 'Leave-In Conditioner', id: 231 },
    { name: 'Heat Defence Spray', id: 234 },
    { name: 'Cooling Gel', id: 232 },
    { name: 'Face Toner', id: 323 },
    { name: 'Face & Body Wash', id: 324 },
    { name: 'Nourishing Face Mask', id: 233 },
    { name: 'Cleansing Facial Wipes', id: 235 },
  ],
  'Vitamin C': [
    { name: 'Face Serum', id: 213 },
    { name: 'Foaming Face Wash', id: 214 },
    { name: 'Revitalising Face Mask', id: 215 },
    { name: 'Exfoliating Facial Scrub', id: 216 },
    { name: 'Salt Body Scrub', id: 217 },
    { name: 'Facial Wipes', id: 218 },
  ],
  'Papaya': [
    { name: 'Cleansing Face Wash', id: 219 },
    { name: 'Hydrating Face Mask', id: 220 },
  ],
  'Tea Tree': [
    { name: 'Foaming Face Wash', id: 225 },
    { name: 'Anti-Bacterial Handwash', id: 223 },
    { name: 'Daily Cleansing Facial Wipes', id: 224 },
    { name: 'Foot Pack', id: 222 },
    { name: 'Essential Oil', id: 229 },
  ],
  'Neem Oil': [
    { name: 'Exfoliating Foaming Face Wash', id: 221 },
    { name: 'Neem Oil & Mint Toothpaste', id: 264 },
    { name: 'Facial Scrub', id: 332 },
  ],
  'Argan Oil': [
    { name: 'Shampoo', id: 253 },
    { name: 'Conditioner', id: 249 },
    { name: 'Hair Treatment', id: 248 },
    { name: 'Hydrating Hair Mask', id: 250 },
    { name: 'Heat Defence Leave-In Spray', id: 251 },
    { name: 'Facial Wipes', id: 252 },
  ],
};

const BASIC_LINKS = [
  { to: '/',        label: 'home'    },
  { to: '/about',   label: 'about'   },
  { to: '/blog',    label: 'blog'    },
  { to: '/stores',  label: 'stores'  },
  { to: '/contact', label: 'contact' },
];

/* ── Component ──────────────────────────────────────────────────── */
export default function Header() {
  const [mobileOpen, setMobileOpen]       = useState(false);
  const [mobileProdOpen, setMobileProdOpen] = useState(false);
  const [megaOpen, setMegaOpen]           = useState(false);
  const megaTimer                          = useRef<ReturnType<typeof setTimeout> | null>(null);
  const content = useSiteContent();
  const location = useLocation();

  const close = () => { setMobileOpen(false); setMobileProdOpen(false); };

  /* Keep mega-menu open while mouse travels from nav → panel */
  const openMega  = () => { if (megaTimer.current) clearTimeout(megaTimer.current); setMegaOpen(true); };
  const closeMega = () => { megaTimer.current = setTimeout(() => setMegaOpen(false), 120); };

  return (
    <>
      {/* ── Announcement Bar ──────────────────────────────────────── */}
      <div className="top-gradient-bar">
        <p>{content.announcement}</p>
      </div>

      {/* ══════════════════════════════════════════════════════════
          DESKTOP HEADER
      ══════════════════════════════════════════════════════════ */}
      <header className="site-header-main desktop-header">
        <div className="header-inner">
          <div className="header-search">
            <div className="search-box">
              <button className="search-btn" aria-label="Search">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" />
                </svg>
              </button>
              <input type="text" placeholder="Search..." aria-label="Search products" />
            </div>
          </div>

          <div className="header-logo">
            <Link to="/" aria-label="Xpel Beauty NG – home">
              <img
                src={content.logo}
                alt="Xpel Beauty NG"
                style={{ height: '60px', width: 'auto', display: 'block' }}
                onError={(e) => { (e.target as HTMLImageElement).src = '/images/logo-xpel-beauty-ng.svg'; }}
              />
            </Link>
          </div>

          <div className="header-actions" />
        </div>
      </header>

      {/* ── Desktop nav bar ─────────────────────────────────────── */}
      <nav className="site-nav desktop-nav">
        <div className="nav-inner">
          <ul className="nav-links">
            {/* Home */}
            <li>
              <Link to="/" className={location.pathname === '/' ? 'active' : ''}>home</Link>
            </li>

            {/* Product — with mega-menu */}
            <li
              className="has-mega"
              onMouseEnter={openMega}
              onMouseLeave={closeMega}
            >
              <Link
                to="/shop"
                className={location.pathname.startsWith('/shop') ? 'active' : ''}
              >
                product
                <svg className="mega-chevron" width="10" height="10" viewBox="0 0 10 6" fill="none">
                  <path d="M1 1l4 4 4-4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </Link>

              {/* ── Mega-menu panel ─────────────────────────────── */}
              {megaOpen && (
                <div
                  className="mega-menu"
                  onMouseEnter={openMega}
                  onMouseLeave={closeMega}
                >
                  <div className="mega-inner">
                    {/* Column 1 — By Category */}
                    <div className="mega-col">
                      <p className="mega-col-title">Shop by Range</p>
                      <ul>
                        <li><Link to="/shop" onClick={() => setMegaOpen(false)}>All Products</Link></li>
                        {(content.megaMenu?.categories ?? []).map(c => (
                          <li key={c.slug}>
                            <Link to={c.slug ? `/shop?cat=${c.slug}` : '/shop'} onClick={() => setMegaOpen(false)}>{c.label}</Link>
                          </li>
                        ))}
                      </ul>
                    </div>

                    {/* Brand group columns */}
                    {(content.megaMenu?.brandGroups ?? []).map(group => (
                      <div className="mega-col" key={group.group}>
                        <p className="mega-col-title">{group.group}</p>
                        <ul>
                          {group.items.map(item => {
                            const subProducts = RANGE_PRODUCTS[item.name];
                            if (subProducts) {
                              return (
                                <li key={item.name} className="mega-range-item">
                                  <Link to={item.href} className="mega-range-link" onClick={() => setMegaOpen(false)}>
                                    {item.name}
                                    <svg className="mega-range-chevron" width="8" height="8" viewBox="0 0 6 10" fill="none">
                                      <path d="M1 1l4 4-4 4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                                    </svg>
                                  </Link>
                                  <div className="mega-range-sub">
                                    <p className="mega-range-sub-title">{item.name}</p>
                                    {subProducts.map(p => (
                                      <Link key={p.id} to={`/product/${p.id}`} onClick={() => setMegaOpen(false)}>{p.name}</Link>
                                    ))}
                                    <Link to={item.href} className="mega-range-sub-all" onClick={() => setMegaOpen(false)}>View all →</Link>
                                  </div>
                                </li>
                              );
                            }
                            return (
                              <li key={item.name}>
                                <Link to={item.href} onClick={() => setMegaOpen(false)}>{item.name}</Link>
                              </li>
                            );
                          })}
                        </ul>
                      </div>
                    ))}

                    {/* Feature panel */}
                    {content.megaMenu?.feature && (
                      <div className="mega-feature">
                        <img src={content.megaMenu.feature.image} alt={content.megaMenu.feature.title} />
                        <div className="mega-feature-body">
                          <p className="mega-feature-label">{content.megaMenu.feature.label}</p>
                          <p className="mega-feature-title">{content.megaMenu.feature.title}</p>
                          <Link to={content.megaMenu.feature.href} className="mega-feature-btn" onClick={() => setMegaOpen(false)}>
                            {content.megaMenu.feature.btnText}
                          </Link>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              )}
            </li>

            {/* Rest of links */}
            {BASIC_LINKS.filter(l => l.to !== '/').map(({ to, label }) => (
              <li key={to}>
                <Link to={to} className={location.pathname === to ? 'active' : ''}>{label}</Link>
              </li>
            ))}
          </ul>
        </div>
      </nav>

      {/* ══════════════════════════════════════════════════════════
          MOBILE HEADER
      ══════════════════════════════════════════════════════════ */}
      <header className="mobile-header">
        <Link to="/" className="mobile-logo" aria-label="Xpel Beauty NG – home" onClick={close}>
          <img
            src={content.logo}
            alt="Xpel Beauty NG"
            onError={(e) => { (e.target as HTMLImageElement).src = '/images/logo-xpel-beauty-ng.svg'; }}
          />
        </Link>

        <button
          className={`mob-hamburger ${mobileOpen ? 'is-open' : ''}`}
          aria-label={mobileOpen ? 'Close menu' : 'Open menu'}
          onClick={() => setMobileOpen(!mobileOpen)}
        >
          <span /><span /><span />
        </button>
      </header>

      {/* ── Mobile dropdown nav ─────────────────────────────────── */}
      {mobileOpen && (
        <nav className="mobile-nav">
          <ul>
            <li><Link to="/" className={location.pathname === '/' ? 'active' : ''} onClick={close}>home</Link></li>

            {/* Product — expandable accordion */}
            <li className="mob-has-sub">
              <button
                className={`mob-sub-toggle ${mobileProdOpen ? 'open' : ''}`}
                onClick={() => setMobileProdOpen(!mobileProdOpen)}
              >
                <span>product</span>
                <svg width="10" height="10" viewBox="0 0 10 6" fill="none">
                  <path d="M1 1l4 4 4-4" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </button>
              {mobileProdOpen && (
                <div className="mob-sub-panel">
                  <p className="mob-sub-heading">By Range</p>
                  <Link to="/shop" onClick={close}>All Products</Link>
                  {(content.megaMenu?.categories ?? []).map(c => (
                    <Link key={c.slug} to={c.slug ? `/shop?cat=${c.slug}` : '/shop'} onClick={close}>{c.label}</Link>
                  ))}
                  {(content.megaMenu?.brandGroups ?? []).map(group => (
                    <div key={group.group}>
                      <p className="mob-sub-heading">{group.group}</p>
                      {group.items.map(item => {
                        const subProducts = RANGE_PRODUCTS[item.name];
                        return (
                          <div key={item.name}>
                            <Link to={item.href} onClick={close} style={{ fontWeight: subProducts ? 600 : 400 }}>{item.name}</Link>
                            {subProducts && subProducts.map(p => (
                              <Link key={p.id} to={`/product/${p.id}`} onClick={close} style={{ paddingLeft: '36px', fontSize: '12px', color: '#666' }}>{p.name}</Link>
                            ))}
                          </div>
                        );
                      })}
                    </div>
                  ))}
                </div>
              )}
            </li>

            {BASIC_LINKS.filter(l => l.to !== '/').map(({ to, label }) => (
              <li key={to}>
                <Link to={to} className={location.pathname === to ? 'active' : ''} onClick={close}>{label}</Link>
              </li>
            ))}
          </ul>
        </nav>
      )}
    </>
  );
}
