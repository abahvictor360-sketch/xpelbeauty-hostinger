import { Link } from 'react-router-dom';
import { Sprout, HeartHandshake, Stethoscope, Globe2, CheckCircle2 } from 'lucide-react';
import { useSiteContent } from '@/hooks/useSiteContent';
import SEO from '@/components/SEO';

/* ── Product categories — images are admin-editable ────────────── */
const CATEGORY_META = [
  { name: 'Facial Care', tagline: 'Glow-first formulations for every skin type', href: '/shop?cat=facial-care', fallback: '/banner/Product-Face-Care.webp' },
  { name: 'Body Care',   tagline: 'Head-to-toe nourishment, every single day',    href: '/shop?cat=body-care',   fallback: '/banner/Product-Body-Care.webp' },
  { name: 'Hair Care',   tagline: 'Strengthen, restore & shine — naturally',        href: '/shop?cat=hair-care',   fallback: '/banner/Product-Shampoo.webp' },
  { name: 'Hand Care',   tagline: 'Soft, smooth hands — beautifully maintained',    href: '/shop?cat=hand-care',   fallback: '/banner/Product-Hand-Care.webp' },
  { name: 'Foot Care',   tagline: 'Refresh, revive and comfort tired feet',          href: '/shop?cat=foot-care',   fallback: '/banner/Product-Foot-Care.webp' },
  { name: 'Oral Care',   tagline: 'Confidence starts with a radiant smile',          href: '/shop?cat=oral-care',   fallback: '/banner/Product-Oral-Care.webp' },
  { name: 'Nail Care',   tagline: 'Strong, beautiful nails deserve the best',        href: '/shop?cat=nail-care',   fallback: '/banner/Product-Nail-Care.webp' },
];

/* ── Brand pillars from xpelbeauty.com ─────────────────────────── */
/* Pillars & plan are now built from content inside the component */

export default function About() {
  const content = useSiteContent();

  // Build categories with admin-editable images
  const categories = CATEGORY_META.map((m, i) => ({
    ...m,
    image: content.aboutCatImages?.[i] || m.fallback,
  }));

  const pillars = [
    { icon: <Sprout size={30} strokeWidth={1.5} />, title: content.pillar1Title, desc: content.pillar1Desc },
    { icon: <HeartHandshake size={30} strokeWidth={1.5} />, title: content.pillar2Title, desc: content.pillar2Desc },
    { icon: <Stethoscope size={30} strokeWidth={1.5} />, title: content.pillar3Title, desc: content.pillar3Desc },
    { icon: <Globe2 size={30} strokeWidth={1.5} />, title: content.pillar4Title, desc: content.pillar4Desc },
  ];

  const plan = [
    { step: '01', title: content.step1Title, desc: content.step1Desc },
    { step: '02', title: content.step2Title, desc: content.step2Desc },
    { step: '03', title: content.step3Title, desc: content.step3Desc },
  ];

  return (
    <div className="about-page">
      <SEO page="about" />

      {/* ── HERO ───────────────────────────────────────────────── */}
      <section className="about-hero">
        <span className="section-label">{content.aboutKicker}</span>
        <h1 className="about-hero-title">{content.aboutTitle}</h1>
        <p className="about-hero-lead">{content.aboutLead}</p>
        <Link to="/shop" className="about-cta-btn">Explore our range</Link>
      </section>

      {/* ── PRODUCT CATEGORIES ─────────────────────────────────── */}
      <section className="about-categories-section">
        <div className="about-categories-head">
          <span className="section-label">what we offer</span>
          <h2 className="about-cat-title">Seven pillars of everyday luxury</h2>
          <p className="about-cat-sub">
            From your morning face wash to your evening hair ritual — Xpel Beauty Care covers every step.
          </p>
        </div>

        {/* Top row — 2 large feature cards */}
        <div className="about-cat-row about-cat-row-top">
          {categories.slice(0, 2).map((cat) => (
            <Link key={cat.name} to={cat.href} className="about-cat-card about-cat-card-large">
              <img src={cat.image} alt={cat.name} className="about-cat-img" loading="lazy" />
              <div className="about-cat-overlay">
                <div className="about-cat-text">
                  <p className="about-cat-tagline">{cat.tagline}</p>
                  <h3 className="about-cat-name">{cat.name}</h3>
                  <span className="about-cat-link">Shop now →</span>
                </div>
              </div>
            </Link>
          ))}
        </div>

        {/* Bottom row — 5 regular cards */}
        <div className="about-cat-row about-cat-row-bottom">
          {categories.slice(2).map((cat) => (
            <Link key={cat.name} to={cat.href} className="about-cat-card about-cat-card-regular">
              <img src={cat.image} alt={cat.name} className="about-cat-img" loading="lazy" />
              <div className="about-cat-overlay">
                <div className="about-cat-text">
                  <h3 className="about-cat-name">{cat.name}</h3>
                  <span className="about-cat-link">Shop →</span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </section>

      {/* ── BRAND PILLARS ──────────────────────────────────────── */}
      <section className="about-pillars-section">
        <div className="about-pillars-inner">
          <div className="about-pillars-head">
            <span className="section-label">our promise</span>
            <h2 className="section-title section-title-anim">The Xpel Beauty Care difference</h2>
          </div>
          <div className="about-pillars-grid">
            {pillars.map((p) => (
              <div key={p.title} className="about-pillar-card-new">
                <span className="about-pillar-icon-brand">{p.icon}</span>
                <h3>{p.title}</h3>
                <p>{p.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── BRAND STORY ────────────────────────────────────────── */}
      <section className="about-section">
        <div className="about-grid">
          <div>
            <span className="section-label">your trusted guide</span>
            <h2 className="section-title">{content.aboutStoryTitle}</h2>
            <p className="about-body">{content.aboutStoryBody1}</p>
            <p className="about-body">{content.aboutStoryBody2}</p>
          </div>
          <div className="about-values">
            <h3 className="about-values-title">Why people choose Xpel Beauty Care</h3>
            <ul>
              <li><CheckCircle2 size={16} strokeWidth={2} className="about-check-icon" /> {content.aboutValue1}</li>
              <li><CheckCircle2 size={16} strokeWidth={2} className="about-check-icon" /> {content.aboutValue2}</li>
              <li><CheckCircle2 size={16} strokeWidth={2} className="about-check-icon" /> {content.aboutValue3}</li>
              <li><CheckCircle2 size={16} strokeWidth={2} className="about-check-icon" /> {content.aboutValue4}</li>
              <li><CheckCircle2 size={16} strokeWidth={2} className="about-check-icon" /> {content.aboutValue5}</li>
            </ul>
          </div>
        </div>
      </section>

      {/* ── THREE-STEP PLAN ────────────────────────────────────── */}
      <section className="about-section about-plan-wrap">
        <div className="about-center">
          <span className="section-label">how it works</span>
          <h2 className="section-title section-title-anim">Your routine, in three simple steps</h2>
        </div>
        <div className="about-plan">
          {plan.map((p) => (
            <div key={p.step} className="about-plan-card">
              <span className="about-plan-step">{p.step}</span>
              <h3>{p.title}</h3>
              <p>{p.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* ── MISSION & VISION ───────────────────────────────────── */}
      <section className="about-section about-mv-wrap">
        <div className="about-mv">
          <div className="about-mv-card">
            <span className="section-label">our mission</span>
            <p>{content.aboutMission}</p>
          </div>
          <div className="about-mv-card">
            <span className="section-label">our vision</span>
            <p>{content.aboutVision}</p>
          </div>
        </div>
      </section>

      {/* ── THE XPEL DIFFERENCE ────────────────────────────────── */}
      <section className="about-section">
        <div className="about-center">
          <span className="section-label">the xpel beauty care difference</span>
          <h2 className="section-title section-title-anim">Quality you can count on</h2>
        </div>
        <div className="about-diff">
          <div className="about-diff-card">
            <h3>Research &amp; Quality</h3>
            <p>
              Every product is the result of in-depth research, advanced formulations and rigorous
              quality control — solutions that meet and exceed customer expectations.
            </p>
          </div>
          <div className="about-diff-card">
            <h3>Eco-Conscious</h3>
            <p>
              We prioritise environmentally responsible practices through eco-conscious packaging
              and responsibly sourced ingredients — quality and responsibility together.
            </p>
          </div>
          <div className="about-diff-card">
            <h3>Proudly for Nigeria</h3>
            <p>
              As the exclusive distributor of Xpel Beauty Care products across Nigeria, we partner with retail
              stores nationwide to keep authentic products accessible and affordable.
            </p>
          </div>
        </div>
      </section>

      {/* ── CTA ────────────────────────────────────────────────── */}
      <section
        className="about-success"
        style={{ backgroundImage: `url('${content.aboutCtaImage || '/banner/banner4.png'}')` }}
      >
        <div className="about-success-overlay" />
        <div className="about-success-content">
        <h2>{content.aboutCtaTitle}</h2>
        <p>{content.aboutCtaText}</p>
        <Link to="/shop" className="about-cta-btn about-cta-light">
          Shop the collection
        </Link>
        </div>
      </section>
    </div>
  );
}
