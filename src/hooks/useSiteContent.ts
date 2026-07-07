import { useState, useEffect } from 'react';
import { api } from '@/lib/api';

export interface SiteContent {
  // Global
  announcement: string;
  logo: string;
  footerLogo: string; // empty = use the header logo
  contactEmail: string;
  contactPhone: string;
  contactPhones: string[];  // phone numbers listed on the contact page
  contactAddress: string;   // multiline — contact page address block
  contactHours: string;     // multiline — contact page business hours
  freeShipping: string;
  footerTagline: string;

  // Home
  heroLine1: string;
  heroLine2: string;
  exploreLabel: string;
  exploreTitle: string;
  sellersTitle: string;
  quoteText: string;
  quoteImage: string;
  ctaText: string;
  ctaImage: string;
  slides: string[]; // legacy — kept so old saves don't break
  heroSlides: HeroSlide[];
  banner: string;
  catImages: string[];
  featureImages: string[];

  // Theme colours (applied as CSS variables site-wide)
  themeAccent: string;   // primary accent/gold — default #ca7c29
  themeNavy: string;     // secondary dark colour — default #1B2A3B
  themeBarFrom: string;  // announcement bar gradient start+end — default #ca7c29
  themeBarMid: string;   // announcement bar gradient middle — default #6f3716

  // About
  aboutKicker: string;
  aboutTitle: string;
  aboutLead: string;
  aboutStoryTitle: string;
  aboutStoryBody1: string;
  aboutStoryBody2: string;
  aboutValue1: string; aboutValue2: string; aboutValue3: string;
  aboutValue4: string; aboutValue5: string;
  pillar1Title: string; pillar1Desc: string;
  pillar2Title: string; pillar2Desc: string;
  pillar3Title: string; pillar3Desc: string;
  pillar4Title: string; pillar4Desc: string;
  step1Title: string; step1Desc: string;
  step2Title: string; step2Desc: string;
  step3Title: string; step3Desc: string;
  aboutMission: string;
  aboutVision: string;
  aboutCtaTitle: string;
  aboutCtaText: string;
  aboutCtaImage: string;      // CTA section background image
  aboutCatImages: string[];   // 7 product-category card images

  // Home features
  feat1Kicker: string; feat1Title: string; feat1Text: string; feat1Href: string;
  feat2Kicker: string; feat2Title: string; feat2Text: string; feat2Href: string;
  feat3Kicker: string; feat3Title: string; feat3Text: string; feat3Href: string;

  // Footer contact
  footerPhone1: string;
  footerPhone2: string;
  footerEmail: string;
  footerCompany: string;
  footerAddress: string;

  // Shop
  shopTitle: string;
  shopSubtitle: string;

  // Contact
  contactTitle: string;
  contactIntro: string;

  // Stores
  storesTitle: string;
  storesIntro: string;

  // Blog
  blogTitle: string;
  blogIntro: string;

  // Page banners (image + overlay text, editable in admin)
  banners: {
    shopHero: BannerItem;
    shop: BannerItem;
    stores: BannerItem;
    blog: BannerItem;
    contact: BannerItem;
  };

  // SEO — per-page meta tags, all admin-editable
  seo: SiteSEO;

  // WhatsApp enquiry settings
  whatsappEnabled: boolean;
  whatsappNumber: string;

  // Best sellers section (admin selectable product IDs)
  bestSellerIds: number[];

  // Admin users (stored here so no extra DB table is required)
  adminUsers: AdminUserRecord[];

  // Mega-menu configuration (categories, brand groups, feature panel)
  megaMenu: MegaMenuConfig;

  // Dedicated collection pages (/collection/:slug) — all editable in admin
  collections: CollectionConfig[];
}

// ── Mega-menu config ──────────────────────────────────────────────────────────
export interface MegaMenuCategory { label: string; slug: string; }
export interface MegaMenuItem     { name: string;  href: string; }
export interface MegaBrandGroup   { group: string; items: MegaMenuItem[]; }
export interface MegaMenuConfig {
  categories:  MegaMenuCategory[];
  brandGroups: MegaBrandGroup[];
  feature: { image: string; label: string; title: string; href: string; btnText: string; };
}

export interface AdminUserRecord {
  id: string;
  username: string;
  name: string;
  email: string;
  role: string;
  password_hash: string;
}

// ── Collection page config (one entry per /collection/:slug page) ─────────────
export interface CollectionConfig {
  slug: string;         // URL slug — e.g. "tea-tree"
  name: string;         // Display name — e.g. "Tea Tree"
  subtitle: string;     // Short tagline — e.g. "Purify & Protect"
  description: string;  // Paragraph shown below the hero
  heroImage: string;    // URL or base64 data-URL
  overlayColor: string; // CSS colour for hero gradient overlay
  accentColor: string;  // Hex accent colour for badge + back button
  filterType: 'brand' | 'name' | 'ids'; // How to query products
  filterValue: string;  // brand text / name substring / comma-separated IDs
}

export interface SEOPage {
  title: string;        // used in <title> and og:title
  description: string;  // meta description
  keywords: string;     // comma-separated keywords
  ogImage: string;      // og:image — leave blank to use site default
  robots: string;       // "index, follow" | "noindex, nofollow" etc.
}

export interface SiteSEO {
  siteTitle: string;          // "XpelBeauty NG"
  titleSeparator: string;     // " | "
  defaultDescription: string;
  defaultOgImage: string;
  twitterHandle: string;      // "@xpelbeautyng" — optional
  googleVerification: string; // content value for google-site-verification
  pages: {
    home: SEOPage;
    shop: SEOPage;
    about: SEOPage;
    contact: SEOPage;
    blog: SEOPage;
    stores: SEOPage;
  };
}

export interface BannerItem {
  image: string;
  kicker?: string;
  title: string;
  text: string;
  cta: string;
  href: string;
}

export interface HeroSlide {
  image: string;
  overlayColor: string;  // left-side gradient colour, e.g. "rgba(200,60,80,.88)"
  brandLockup: string;   // "xbc® | xpel beauty care"
  subLabel: string;      // "so fresh"
  headlineLine1: string; // "Watermelon"
  headlineLine2: string; // "Crush"
  headlineColor: string; // "#fff"
  descriptor: string;    // "Complete Hydrating Skincare Collection"
  benefits: string[];    // 3 bullet lines
  vegaBadge: string;     // pill label — empty = hidden
  vegaBadgeBg: string;   // badge background colour
  vegaBadgeColor: string;// badge text colour
  ctaLabel: string;      // "discover the range"
  ctaHref: string;       // "/shop?cat=body-beauty"
  ctaBg: string;         // button background colour — sampled from product/brand colour
  ctaColor: string;      // button text colour — chosen to contrast with ctaBg
}

export const DEFAULT_CONTENT: SiteContent = {
  announcement: 'exceptional products. unbeatable value.',
  logo: '/images/logo-xpel-beauty-ng.png',
  footerLogo: '',
  contactEmail: 'info@xpelbeauty.com',
  contactPhone: '08034883603',
  contactPhones: ['08034883603', '08140764150'],
  contactAddress: 'Xpel Beauty NG\nNigeria',
  contactHours: 'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed',
  freeShipping: '25000',
  footerTagline: 'exceptional products. unbeatable value.',

  heroLine1: 'Reveal the beauty',
  heroLine2: 'within yourself',
  exploreLabel: 'our products & brands',
  exploreTitle: 'explore our range',
  sellersTitle: 'best sellers',
  quoteText: 'True beauty begins with self-care — caring for yourself should feel effortless and empowering.',
  quoteImage: '/banner/BRAND_ARGAN_FOOTER-1.webp',
  ctaText: 'ready to reveal the beauty within yourself?',
  ctaImage: '/banner/Product-Face-Care.webp',
  slides: [],
  heroSlides: [
    {
      // Banner 1 — Tea Tree (sage/lime-green wall, XHC green bottles)
      image: '/banner/banner 1.webp',
      overlayColor: 'rgba(78, 108, 28, 0.88)',
      brandLockup: 'xhc®  |  xpel hair care',
      subLabel: 'tea tree',
      headlineLine1: 'Purify',
      headlineLine2: '& Protect',
      headlineColor: '#E8F5D0',
      descriptor: 'Anti-Bacterial Tea Tree Haircare Collection',
      benefits: [
        'Anti-bacterial tea tree oil formula',
        'Moisturising shampoo & conditioner',
        'Gentle enough for everyday use',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'explore tea tree',
      ctaHref: '/collection/tea-tree',
      ctaBg: '#1B6B2E',    // deep emerald green — product bottle cap colour
      ctaColor: '#FFFFFF', // white text on dark green
    },
    {
      // Banner 2 — Argan Oil (deep warm amber/golden-brown background)
      image: '/banner/banner 2.webp',
      overlayColor: 'rgba(65, 38, 4, 0.90)',
      brandLockup: 'xbc® xhc®  |  argan oil',
      subLabel: 'argan oil',
      headlineLine1: 'Nourish',
      headlineLine2: '& Repair',
      headlineColor: '#FFD166',
      descriptor: 'Premium Moroccan Argan Oil Collection',
      benefits: [
        'Repairs & strengthens damaged hair',
        'Adds brilliant shine & softness',
        'Rich body butter, mask & serum range',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop argan oil',
      ctaHref: '/collection/argan-oil',
      ctaBg: '#C8860A',    // warm golden amber — label/cap colour
      ctaColor: '#FFFFFF', // white text on amber
    },
    {
      // Banner 3 — Black Castor Oil & Avocado (very dark burnt-orange/fire)
      image: '/banner/banner3.png',
      overlayColor: 'rgba(30, 10, 2, 0.92)',
      brandLockup: 'xhc®  |  xpel hair care',
      subLabel: 'black castor oil',
      headlineLine1: 'Strengthen',
      headlineLine2: '& Grow',
      headlineColor: '#F5A623',
      descriptor: 'Black Castor Oil & Avocado Hair Collection',
      benefits: [
        'Strengthens & nourishes every strand',
        'Boosts shine for healthier-looking hair',
        'With Hyaluronic Acid to maintain moisture',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop the collection',
      ctaHref: '/collection/black-castor-oil',
      ctaBg: '#D4620A',    // warm burnt orange — bottle/product colour
      ctaColor: '#FFFFFF', // white text on orange
    },
    {
      // Banner 4 — So Fresh Watermelon Crush (bright coral/salmon-pink)
      image: '/banner/banner4.png',
      overlayColor: 'rgba(185, 50, 55, 0.88)',
      brandLockup: 'xbc®  |  xpel beauty care',
      subLabel: 'so fresh',
      headlineLine1: 'Watermelon',
      headlineLine2: 'Crush',
      headlineColor: '#FFE8E8',
      descriptor: 'Complete Hydrating Skincare Collection',
      benefits: [
        'Deeply hydrates with Hyaluronic Acid',
        'Brightens with Vitamin C + Vitamin E',
        'Soothes with Watermelon Extract & Aloe Vera',
      ],
      vegaBadge: 'Natural Vegan Ingredients',
      vegaBadgeBg: '#4DAA00',  // deep lime green — from the HYDRATING label on products
      vegaBadgeColor: '#FFFFFF', // white text on lime green
      ctaLabel: 'discover the range',
      ctaHref: '/collection/so-fresh',
      ctaBg: '#F72585',    // bright hot-pink — vivid watermelon pop
      ctaColor: '#FFFFFF', // white text on hot pink
    },
  ],
  banner: '',
  catImages: [
    '/banner/Product-Face-Care.webp', // Hydration & Radiance (Aloe/Watermelon/Vitamin C)
    '/banner/Brand_Argan_Oil_V3.webp', // Nourish & Repair (Argan/Black Castor)
    '/banner/Brand-Tea-Tree.webp', // Purify & Protect (Tea Tree/Charcoal/Rosemary)
    '/banner/Product-Body-Care.webp', // Fresh & Clean (Home Essentials)
    '/banner/Product-Hand-Care.webp', // Gift & Glow (Curated Sets & Treats)
  ],
  featureImages: [
    '/Img/XHC-Botanical-Vegan-Shampoo-Aloe-Vera-400ml-No-Banner-removebg-preview.png', // Aloe Vera
    '/Img/40322_HERO.webp', // Tea Tree
    '/Img/40167_HERO.webp', // Argan
  ],

  themeAccent: '#ca7c29',
  themeNavy: '#1B2A3B',
  themeBarFrom: '#ca7c29',
  themeBarMid: '#6f3716',

  aboutKicker: 'about xpel beauty ng',
  aboutTitle: 'Reveal the beauty within yourself',
  aboutLead:
    "You deserve to look and feel your best every single day — without harsh chemicals, confusing labels or premium price tags. That's exactly why we exist.",
  aboutStoryTitle: "We're here to make it simple",
  aboutStoryBody1:
    "Xpel Beauty Care is a trusted global name in personal care, health, beauty and household products. Our mission is simple: safe, effective and affordable products that genuinely enhance the quality of everyday life.",
  aboutStoryBody2:
    "We understand the frustration of products that overpromise and underdeliver — so we built collections rooted in nature, transparent about what's inside, and designed to solve real concerns. Quality should be accessible to everyone, everywhere.",
  aboutValue1: 'Nature-infused, botanically-derived formulas',
  aboutValue2: 'Ingredient transparency you can trust',
  aboutValue3: 'Targeted solutions for real concerns',
  aboutValue4: 'Exceptional quality at unbeatable value',
  aboutValue5: 'Trusted across health, beauty & home',
  pillar1Title: 'Eco-Friendly Formula',
  pillar1Desc: 'Botanically-derived, planet-conscious ingredients that are gentle on you and the earth.',
  pillar2Title: 'Consciously Crafted',
  pillar2Desc: '100% cruelty-free. Never tested on animals — because beauty should never come at a cost.',
  pillar3Title: 'Dermatologist Recommended',
  pillar3Desc: 'Clinically considered, skin-first formulations you can trust for your entire family.',
  pillar4Title: 'Nationwide Availability',
  pillar4Desc: 'Available at trusted retail partners across every state in Nigeria — always within reach.',
  step1Title: 'Discover your range',
  step1Desc: 'Tell us your concern — skin, hair, oral, nail or foot. We have a collection for each.',
  step2Title: 'Choose nature-infused care',
  step2Desc: 'Pick products powered by botanicals you can actually pronounce and trust.',
  step3Title: 'Glow, every single day',
  step3Desc: 'Make it part of your routine and feel the difference look back at you.',
  aboutMission:
    "We believe that true beauty begins with self-care. Our mission is to provide high-quality, affordable and effective products that nurture your skin, hair, body and overall confidence — because caring for yourself should feel effortless and empowering.",
  aboutVision:
    "To become the preferred brand in personal care and household essentials by consistently delivering dependable, affordable and innovative solutions that enhance daily living.",
  aboutCtaTitle: 'Your best self is waiting',
  aboutCtaText:
    "Imagine a routine you actually look forward to — skin that glows, hair that shines, and the quiet confidence that comes from caring for yourself well. Start today.",
  aboutCtaImage: '/banner/banner4.png',
  aboutCatImages: [
    '/banner/Product-Face-Care.webp',
    '/banner/Product-Body-Care.webp',
    '/banner/Product-Shampoo.webp',
    '/banner/Product-Hand-Care.webp',
    '/banner/Product-Foot-Care.webp',
    '/banner/Product-Oral-Care.webp',
    '/banner/Product-Nail-Care.webp',
  ],

  feat1Kicker: 'Nature-Infused Care',
  feat1Title: 'Aloe Vera Cooling Gel',
  feat1Text: 'Soothe, hydrate and refresh with botanically-derived aloe — 100% safe, gentle and made to calm skin after every day.',
  feat1Href: '/collection/aloe-vera',
  feat2Kicker: 'Purifying Botanicals',
  feat2Title: 'Tea Tree Collection',
  feat2Text: 'Foaming face wash, anti-dandruff shampoo and more — purifying tea tree formulas that cleanse, clarify and balance naturally.',
  feat2Href: '/collection/tea-tree',
  feat3Kicker: 'Nourish & Repair',
  feat3Title: 'Argan Nourishing Range',
  feat3Text: 'Argan hair mask and body butter rich in nourishing oils to restore softness, shine and manageability — repair that shows.',
  feat3Href: '/collection/argan-oil',

  footerPhone1: '08034883603',
  footerPhone2: '08140764150',
  footerEmail: 'info@xpelbeauty.com',
  footerCompany: 'Xpel Beauty NG',
  footerAddress: 'Nigeria',

  shopTitle: 'shop our range',
  shopSubtitle: 'Browse our full range of health, beauty, home & gifting products.',

  contactTitle: 'Get in touch',
  contactIntro: "Interested in our products? Contact us to place an order or for any inquiries about our beauty and wellness range.",

  storesTitle: 'find us in store',
  storesIntro: 'Discover Xpel Beauty Care products at trusted retailers near you.',

  blogTitle: 'beauty journal',
  blogIntro: 'Tips, guides and stories from the world of Xpel Beauty Care.',

  banners: {
    shopHero: {
      image: '/banner/Product-Body-Care.webp',
      kicker: 'our products & brands',
      title: 'shop our range',
      text: 'exceptional products. unbeatable value.',
      cta: '',
      href: '',
    },
    shop: {
      image: '/banner/Brand_Argan_Oil_V3.webp',
      title: 'The Argan Oil Collection',
      text: 'Nourish, repair and shine with Moroccan argan oil.',
      cta: 'Discover more',
      href: '/about',
    },
    stores: {
      image: '/banner/Brand-Tea-Tree.webp',
      title: 'Find Xpel Beauty Care near you',
      text: 'Available at trusted retailers nationwide.',
      cta: '',
      href: '',
    },
    blog: {
      image: '/banner/Brand_Argan_Oil_V3.webp',
      title: 'The Beauty Journal',
      text: 'Tips, guides and stories from Xpel Beauty Care.',
      cta: '',
      href: '',
    },
    contact: {
      image: '/banner/Product-Face-Care.webp',
      title: "We'd love to hear from you",
      text: 'Questions, orders or trade enquiries — get in touch.',
      cta: '',
      href: '',
    },
  },

  // SEO defaults
  seo: {
    siteTitle: 'Xpel Beauty NG',
    titleSeparator: ' | ',
    defaultDescription: 'Shop Xpel Beauty Care products in Nigeria — premium hair care, skin care, oral care and body care essentials. Nature-infused formulas at unbeatable prices, available nationwide.',
    defaultOgImage: '/banner/Brand_Argan_Oil_V3.webp',
    twitterHandle: '',
    googleVerification: '',
    pages: {
      home: {
        title: 'Reveal the Beauty Within',
        description: 'Shop Xpel Beauty Care in Nigeria — premium hair care, skin care, oral care and body care. Nature-infused formulas that deliver real results at unbeatable prices. Available nationwide.',
        keywords: 'xpel beauty nigeria, xpel beauty care, hair care nigeria, skin care nigeria, argan oil, tea tree, aloe vera, beauty products nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
      shop: {
        title: 'See All Products',
        description: 'Browse the full Xpel Beauty Care range — shampoos, conditioners, face washes, serums, body lotions, oral care and more. Premium nature-infused beauty at great prices.',
        keywords: 'buy beauty products nigeria, xpel beauty shop, hair care products nigeria, skin care products nigeria, body care nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
      about: {
        title: 'Our Story',
        description: 'Xpel Beauty NG — exceptional products, unbeatable value. Learn about our mission to make premium nature-infused beauty accessible to everyone in Nigeria.',
        keywords: 'about xpel beauty nigeria, xpel beauty care story, beauty brand nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
      contact: {
        title: 'Get In Touch',
        description: 'Contact Xpel Beauty NG for product orders, trade enquiries or any questions. We\'d love to hear from you.',
        keywords: 'contact xpel beauty nigeria, order xpel products, xpel trade enquiry',
        ogImage: '',
        robots: 'index, follow',
      },
      blog: {
        title: 'Beauty Journal',
        description: 'Hair care tips, skincare routines and beauty guides from the Xpel Beauty NG team. Expert advice for every skin and hair type.',
        keywords: 'beauty tips nigeria, skin care guide nigeria, hair care tips, xpel beauty blog',
        ogImage: '',
        robots: 'index, follow',
      },
      stores: {
        title: 'Find Us In Store',
        description: 'Find Xpel Beauty Care products at trusted retail stockists near you across Nigeria. Discover a store in your state.',
        keywords: 'xpel beauty stockists nigeria, where to buy xpel beauty care, xpel store locations nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
    },
  },

  // WhatsApp enquiry settings
  whatsappEnabled: true,
  whatsappNumber: '2348034883603',

  // Best sellers - admin can select which products to feature (auto-filled with popular products if empty)
  bestSellerIds: [],

  // Admin users stored in site_content (no separate DB table required)
  adminUsers: [],

  // Mega-menu defaults — all editable in Admin > Mega Menu
  megaMenu: {
    categories: [
      { label: 'Hair Care',       slug: 'hair-care'      },
      { label: 'Body & Beauty',   slug: 'body-beauty'    },
      { label: 'Home',            slug: 'home'           },
      { label: 'Travel & Health', slug: 'travel-health'  },
      { label: 'Gifting',         slug: 'gifting'        },
    ],
    brandGroups: [
      {
        group: 'Xpel Ranges',
        items: [
          { name: 'Xpel Body Care', href: '/collection/xpel-body-care' },
          { name: 'Xpel Hair Care', href: '/collection/xpel-hair-care' },
          { name: 'Xpel Oral Care', href: '/collection/xpel-oral-care' },
          { name: 'Xpel Foot Care', href: '/collection/xpel-foot-care' },
          { name: 'Xpel Nail Care', href: '/collection/xpel-nail-care' },
        ],
      },
      {
        group: 'Specialist Ranges',
        items: [
          { name: 'Black Castor Oil & Avocado', href: '/collection/black-castor-oil'},
          { name: 'So Fresh',                   href: '/collection/so-fresh'        },
          { name: 'Intimelle',                  href: '/collection/intimelle'       },
          { name: 'Truesmile',                  href: '/collection/truesmile'       },
          { name: 'Nulab',                      href: '/collection/nulab'           },
          { name: 'Hot Rose',                   href: '/collection/hot-rose'        },
        ],
      },
      {
        group: 'Natural Ranges',
        items: [
          { name: 'Aloe Vera', href: '/collection/aloe-vera' },
          { name: 'Vitamin C', href: '/collection/vitamin-c' },
          { name: 'Papaya',    href: '/collection/papaya'    },
          { name: 'Tea Tree',  href: '/collection/tea-tree'  },
          { name: 'Neem Oil',  href: '/collection/neem-oil'  },
          { name: 'Argan Oil', href: '/collection/argan-oil' },
        ],
      },
    ],
    feature: {
      image:   '/banner/Brand-Tea-Tree.webp',
      label:   'New Arrivals',
      title:   'Tea Tree Collection',
      href:    '/collection/tea-tree',
      btnText: 'Shop Now',
    },
  },

  // Collection pages — each maps to /collection/:slug
  collections: [
    // ── Xpel Ranges ─────────────────────────────────────────────
    { slug: 'xpel-body-care',   name: 'Xpel Body Care',   subtitle: 'Premium Body Care Essentials',
      description: 'Discover our complete range of body care products — from shower gels and body lotions to scrubs and moisturisers, crafted for everyday nourishment.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Body Care' },
    { slug: 'xpel-hair-care',   name: 'Xpel Hair Care',   subtitle: 'The Complete Hair Care Range',
      description: 'Shampoos, conditioners, masks and treatments — our full hair care collection for every hair type and concern.',
      heroImage: '/banner/Product-Shampoo.webp',   overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Hair Care' },
    { slug: 'xpel-oral-care',   name: 'Xpel Oral Care',   subtitle: 'Confident Smile, Every Day',
      description: 'Toothpastes, mouthwashes and oral care essentials for a brighter, fresher smile every morning.',
      heroImage: '/banner/Product-Oral-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Oral Care' },
    { slug: 'xpel-foot-care',   name: 'Xpel Foot Care',   subtitle: 'Happy Feet, Every Step',
      description: 'Foot creams, soaks and treatments to keep your feet soft, smooth and refreshed every day.',
      heroImage: '/banner/Product-Foot-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Foot Care' },
    { slug: 'xpel-nail-care',   name: 'Xpel Nail Care',   subtitle: 'Beautiful Nails, Naturally',
      description: 'Nail treatments, strengtheners and nail care essentials for healthy, beautiful nails.',
      heroImage: '/banner/Product-Nail-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Nail Care' },
    // ── Specialist Ranges ────────────────────────────────────────
    { slug: 'tea-tree',         name: 'Tea Tree',          subtitle: 'Purify & Protect',
      description: 'Anti-bacterial tea tree oil formulas for hair and skin — clarifying, cleansing and balancing for a fresh, healthy glow every day.',
      heroImage: '/banner/Brand-Tea-Tree.webp',    overlayColor: 'rgba(78, 108, 28, 0.82)', accentColor: '#1B6B2E',
      filterType: 'brand', filterValue: 'Tea Tree' },
    { slug: 'argan-oil',        name: 'Argan Oil',         subtitle: 'Nourish & Repair',
      description: 'Premium Moroccan argan oil collection — repairs and strengthens damaged hair while adding brilliant shine and softness to every strand.',
      heroImage: '/banner/Brand_Argan_Oil_V3.webp',overlayColor: 'rgba(65, 38, 4, 0.86)',  accentColor: '#C8860A',
      filterType: 'brand', filterValue: 'Argan Oil' },
    { slug: 'black-castor-oil', name: 'Black Castor Oil & Avocado', subtitle: 'Strengthen & Grow',
      description: 'Black castor oil and avocado hair collection — strengthens, nourishes every strand, and boosts shine for healthier-looking hair.',
      heroImage: '/banner/banner3.png',            overlayColor: 'rgba(30, 10, 2, 0.88)',   accentColor: '#D4620A',
      filterType: 'brand', filterValue: 'Black Castor Oil' },
    { slug: 'so-fresh',         name: 'So Fresh',          subtitle: 'Hydrate & Glow',
      description: 'Complete hydrating skincare collection — deeply hydrates with Hyaluronic Acid, brightens with Vitamin C & E, and soothes with Watermelon Extract.',
      heroImage: '/banner/banner4.png',            overlayColor: 'rgba(185, 50, 55, 0.82)', accentColor: '#F72585',
      filterType: 'brand', filterValue: 'So Fresh' },
    { slug: 'neem-oil',         name: 'Neem Oil',          subtitle: "Nature's Purifier",
      description: 'Neem oil-infused hair and skin care — naturally antibacterial and packed with nutrients for healthier, stronger hair and skin.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(40, 75, 20, 0.82)',  accentColor: '#3A7D1E',
      filterType: 'brand', filterValue: 'Neem Oil' },
    { slug: 'fresh-start',      name: 'Fresh Start',       subtitle: 'Start Fresh Every Day',
      description: 'Daily essentials for a clean, fresh routine — effective, affordable formulas to start every day feeling your very best.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#4D7CF6',
      filterType: 'brand', filterValue: 'Fresh Start' },
    { slug: 'intimelle',        name: 'Intimelle',         subtitle: 'Gentle Intimate Care',
      description: 'Specially formulated intimate care products — gentle, pH-balanced and dermatologist-tested for everyday confidence.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(140, 30, 70, 0.82)', accentColor: '#C0235A',
      filterType: 'brand', filterValue: 'Intimelle' },
    { slug: 'truesmile',        name: 'Truesmile',         subtitle: 'Confident Smile Every Day',
      description: 'Truesmile oral care range — effective, refreshing formulas for a brighter, healthier smile every day.',
      heroImage: '/banner/Product-Oral-Care.webp', overlayColor: 'rgba(0, 80, 140, 0.82)', accentColor: '#0A6EBD',
      filterType: 'brand', filterValue: 'Truesmile' },
    { slug: 'nulab',            name: 'Nulab',             subtitle: 'Advanced Personal Care',
      description: 'Nulab personal care collection — innovative formulas crafted for everyday performance and lasting freshness.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.82)', accentColor: '#5B3FC8',
      filterType: 'brand', filterValue: 'Nulab' },
    { slug: 'hot-rose',         name: 'Hot Rose',          subtitle: 'Luxurious Rose-Infused Care',
      description: 'Hot Rose collection — indulgent rose-infused beauty essentials for a luxurious self-care routine.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(160, 20, 60, 0.82)', accentColor: '#D4195C',
      filterType: 'brand', filterValue: 'Hot Rose' },
    // ── Natural Ranges (specific product IDs) ───────────────────
    { slug: 'aloe-vera',        name: 'Aloe Vera',         subtitle: 'Cool, Soothe & Hydrate',
      description: 'Nature-infused aloe vera collection — from botanical vegan shampoo and leave-in conditioner to face toner and cooling gel.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(14, 80, 50, 0.82)',  accentColor: '#1A7A4A',
      filterType: 'ids', filterValue: '236,230,231,234,232,323,324,233,235' },
    { slug: 'vitamin-c',        name: 'Vitamin C',         subtitle: 'Brighten & Revitalise',
      description: 'Vitamin C enriched skincare — face serum, foaming wash, revitalising mask and more for a brighter, more radiant complexion.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(180, 80, 0, 0.82)',  accentColor: '#D96A00',
      filterType: 'ids', filterValue: '213,214,215,216,217,218' },
    { slug: 'papaya',           name: 'Papaya',            subtitle: 'Glow from Within',
      description: 'Papaya enzyme skincare — naturally exfoliating and brightening formulas for a fresh, glowing complexion.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(150, 50, 0, 0.82)',  accentColor: '#E06020',
      filterType: 'ids', filterValue: '219,220' },
  ] as CollectionConfig[],
};

const LS_KEY = 'xpel_site_content';

/**
 * Increment this whenever the DEFAULT heroSlides structure changes
 * (new slide added, filename changed, etc.).
 * On mismatch the heroSlides from storage are discarded and defaults are used,
 * while all other saved settings (text, banners, SEO…) are preserved.
 */
const HERO_SLIDES_VERSION = 7; // bump when slides change
const LS_HERO_VER_KEY = 'xpel_hero_ver';

/** Convert an uploaded file to a base64 data URL (works without Supabase Storage). */
export function fileToDataURL(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result as string);
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

/**
 * Deep-merge stored content with defaults.
 * heroSlides is version-gated: if the stored version doesn't match
 * HERO_SLIDES_VERSION, the default slides are used (preserving all other
 * admin customisations like text & colours). This guarantees all banners
 * are always visible after a filename/count change.
 */
function mergeContent(stored: Partial<SiteContent>): SiteContent {
  const base: SiteContent = { ...DEFAULT_CONTENT, ...stored };

  // Check if stored hero slides version matches current code
  const storedVer = parseInt(localStorage.getItem(LS_HERO_VER_KEY) ?? '0', 10);
  const versionMatch = storedVer === HERO_SLIDES_VERSION;

  if (versionMatch && stored.heroSlides && stored.heroSlides.length > 0) {
    // Stored data is up-to-date: deep-merge per slide index.
    // For the default slides, prefer stored values (user may have edited them).
    // Extra slides the user added beyond the defaults are preserved as-is.
    const storedSlides: Partial<HeroSlide>[] = stored.heroSlides;
    const merged: HeroSlide[] = DEFAULT_CONTENT.heroSlides.map((def, i) => ({
      ...def,
      ...(storedSlides[i] ?? {}),
      image: storedSlides[i]?.image || def.image,
      overlayColor: storedSlides[i]?.overlayColor || def.overlayColor,
    }));
    // Append any user-added slides beyond the built-in defaults
    if (storedSlides.length > DEFAULT_CONTENT.heroSlides.length) {
      for (let i = DEFAULT_CONTENT.heroSlides.length; i < storedSlides.length; i++) {
        merged.push(storedSlides[i] as HeroSlide);
      }
    }
    base.heroSlides = merged;
  } else {
    // Version mismatch or no stored slides → use defaults entirely
    base.heroSlides = DEFAULT_CONTENT.heroSlides;
    localStorage.setItem(LS_HERO_VER_KEY, String(HERO_SLIDES_VERSION));
  }

  return base;
}

/** Read merged content: Supabase row id=1 → localStorage → defaults */
export function useSiteContent() {
  const [content, setContent] = useState<SiteContent>(() => {
    try {
      const ls = localStorage.getItem(LS_KEY);
      if (ls) return mergeContent(JSON.parse(ls));
    } catch { /* ignore */ }
    return DEFAULT_CONTENT;
  });

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const res = await api.siteContent.get();
        if (res?.data && active) {
          const merged = mergeContent(res.data);
          setContent(merged);
          localStorage.setItem(LS_KEY, JSON.stringify(merged));
          localStorage.setItem(LS_HERO_VER_KEY, String(HERO_SLIDES_VERSION));
        }
      } catch { /* API not reachable yet — fall back silently */ }
    })();
    return () => { active = false; };
  }, []);

  return content;
}

/** Save content to MySQL API (upsert id=1) and localStorage. Returns true if cloud save succeeded. */
export async function saveSiteContent(content: SiteContent): Promise<boolean> {
  localStorage.setItem(LS_KEY, JSON.stringify(content));
  localStorage.setItem(LS_HERO_VER_KEY, String(HERO_SLIDES_VERSION));
  try {
    await api.siteContent.save(content);
    return true;
  } catch {
    return false;
  }
}

export function loadLocalContent(): SiteContent {
  try {
    const ls = localStorage.getItem(LS_KEY);
    if (ls) return mergeContent(JSON.parse(ls));
  } catch { /* ignore */ }
  return DEFAULT_CONTENT;
}
