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

  // Barcode scanner (camera "scan a product" entry point)
  barcodeScannerEnabled: boolean;

  // Best sellers section (admin selectable product IDs)
  bestSellerIds: number[];

  // Admin users (stored here so no extra DB table is required)
  adminUsers: AdminUserRecord[];

  // Mega-menu configuration (categories, brand groups, feature panel)
  megaMenu: MegaMenuConfig;

  // Dedicated collection pages (/collection/:slug) — all editable in admin
  collections: CollectionConfig[];

  // Catalogue page (/catalogue): categories, product placement, hidden items — editable in admin
  catalogue?: import('@/lib/catalogue').CatalogueSettings;

  // Customer testimonials shown on the homepage — all editable in admin
  testimonials: Testimonial[];
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

export interface Testimonial {
  id: string;
  text: string;      // the customer's own words — kept verbatim, no rewriting
  author: string;    // defaults to "Verified Customer" since real names aren't published
  source: string;    // where it came from — e.g. "WhatsApp", "Google Reviews"
  image?: string;    // optional customer/proof photo — URL or uploaded data URL
  rating?: number;   // optional star rating (1-5) — shown when the source publishes one, e.g. Google Reviews
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
  contactAddress: 'Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos',
  contactHours: 'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed',
  freeShipping: '25000',
  footerTagline: 'exceptional products. unbeatable value.',

  heroLine1: 'Hair, skin and home care',
  heroLine2: 'at 600+ stores in Nigeria',
  exploreLabel: '180 products across 20+ ranges',
  exploreTitle: 'explore our range',
  sellersTitle: 'best sellers',
  quoteText: 'Caring for yourself should be simple, and it should not cost a fortune.',
  quoteImage: '/banner/BRAND_ARGAN_FOOTER-1.webp',
  ctaText: 'Find your favourites at a store near you.',
  ctaImage: '/banner/Product-Face-Care.webp',
  slides: [],
  heroSlides: [
    {
      // Rebrand: Tea Tree face wash + facial scrub in the new XBC pack
      image: '/banner/rebrand-tea-tree.webp',
      overlayColor: 'rgba(16, 62, 28, 0.86)',
      brandLockup: 'xbc®  |  xpel beauty care',
      subLabel: 'tea tree · new look',
      headlineLine1: 'Same Tea Tree.',
      headlineLine2: 'New Pack.',
      headlineColor: '#EAF7D6',
      descriptor: 'Face wash & facial scrub, newly packed',
      benefits: [
        'Same tea tree formula as before',
        'Old and new packs are the same product',
        'Look for the new pack in stores',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop the face wash',
      ctaHref: '/product/225',
      ctaBg: '#1B6B2E',
      ctaColor: '#FFFFFF',
    },
    {
      // Rebrand: Cocoa Butter body cream in the new white and brown jar
      image: '/banner/rebrand-cocoa-butter.webp',
      overlayColor: 'rgba(72, 40, 20, 0.86)',
      brandLockup: 'xbc®  |  xpel body care',
      subLabel: 'cocoa butter · new look',
      headlineLine1: 'Same Cream.',
      headlineLine2: 'New Jar.',
      headlineColor: '#F6E7D6',
      descriptor: 'Cocoa butter body cream, 500ml',
      benefits: [
        'Same rich cream for dry skin',
        'Old and new jars are the same product',
        'Look for the new jar in stores',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'see cocoa butter cream',
      ctaHref: '/product/339',
      ctaBg: '#6B3A1F',
      ctaColor: '#FFFFFF',
    },
    {
      // Rebrand: Argan Oil body butter in the new brown and gold jar
      image: '/banner/rebrand-argan-body-butter.webp',
      overlayColor: 'rgba(40, 22, 6, 0.86)',
      brandLockup: 'xbc®  |  xpel body care',
      subLabel: 'argan oil · new look',
      headlineLine1: 'Same Butter.',
      headlineLine2: 'New Gold Jar.',
      headlineColor: '#F7E3B0',
      descriptor: 'Argan oil body butter, new look',
      benefits: [
        'Same body butter with Moroccan argan oil',
        'Old and new jars are the same product',
        'Look for the new jar in stores',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'see argan body butter',
      ctaHref: '/product/411',
      ctaBg: '#C8960A',
      ctaColor: '#1B1205',
    },
    {
      // Range: Papaya face care
      image: '/banner/range-papaya.webp',
      overlayColor: 'rgba(150, 70, 20, 0.86)',
      brandLockup: 'xbc®  |  xpel beauty care',
      subLabel: 'papaya',
      headlineLine1: 'Papaya',
      headlineLine2: 'Glow Routine',
      headlineColor: '#FFE9D2',
      descriptor: 'Face wash, toner, scrub & mask',
      benefits: [
        'Cleansing face wash and pore refining toner',
        'Face & body scrub for visibly brighter skin',
        'Vegan hydrating sheet mask',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop papaya',
      ctaHref: '/collection/papaya',
      ctaBg: '#E8761E',
      ctaColor: '#FFFFFF',
    },
    {
      // Range: XBC 500ml body creams
      image: '/banner/range-xbc-creams.webp',
      overlayColor: 'rgba(28, 48, 104, 0.86)',
      brandLockup: 'xbc®  |  xpel body care',
      subLabel: 'body creams',
      headlineLine1: 'Everyday',
      headlineLine2: 'Body Creams',
      headlineColor: '#E6EEFF',
      descriptor: 'Five creams, 500ml tubs',
      benefits: [
        'Aloe Vera, Olive Oil and Cocoa Butter',
        'Aqueous Cream for relief of dry skin',
        'Vitamin E to moisturise and soothe',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop body creams',
      ctaHref: '/shop?q=Cream%20500ml',
      ctaBg: '#1E4FB8',
      ctaColor: '#FFFFFF',
    },
    {
      // Range: Vitamin C skincare
      image: '/banner/range-vitamin-c.webp',
      overlayColor: 'rgba(170, 70, 0, 0.84)',
      brandLockup: 'xbc®  |  xpel beauty care',
      subLabel: 'vitamin c',
      headlineLine1: 'Vitamin C',
      headlineLine2: 'Radiance',
      headlineColor: '#FFF1DC',
      descriptor: 'Serum, face wash, scrubs, mask & wipes',
      benefits: [
        'With vitamin C and niacinamide',
        'Serum helps boost skin\'s natural radiance',
        'Vegan face wash, body scrub and mask',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop vitamin c',
      ctaHref: '/collection/vitamin-c',
      ctaBg: '#E86A00',
      ctaColor: '#FFFFFF',
    },
    {
      // Range: Charcoal face, body and oral care
      image: '/banner/range-charcoal.webp',
      overlayColor: 'rgba(18, 18, 22, 0.88)',
      brandLockup: 'xbc®  xoc®  |  charcoal',
      subLabel: 'charcoal',
      headlineLine1: 'Deep Clean',
      headlineLine2: 'Charcoal',
      headlineColor: '#FFFFFF',
      descriptor: 'Mask, scrub, wipes & oral care',
      benefits: [
        'Cleansing, revitalising, purifying',
        'Detox face mask, scrub and cleansing wipes',
        'Charcoal toothpaste and whitening mouthwash',
      ],
      vegaBadge: '',
      vegaBadgeBg: 'rgba(255,255,255,.18)',
      vegaBadgeColor: '#fff',
      ctaLabel: 'shop charcoal',
      ctaHref: '/shop?q=charcoal',
      ctaBg: '#E6007E',
      ctaColor: '#FFFFFF',
    },
    {
      // Banner 1 — Tea Tree (sage/lime-green wall, XHC green bottles)
      image: '/banner/banner 1.webp',
      overlayColor: 'rgba(78, 108, 28, 0.88)',
      brandLockup: 'xhc®  |  xpel hair care',
      subLabel: 'tea tree',
      headlineLine1: 'Purify',
      headlineLine2: '& Protect',
      headlineColor: '#E8F5D0',
      descriptor: 'Tea Tree Hair & Skin Collection',
      benefits: [
        'Tea tree oil for a fresh, clean feel',
        'Shampoo, conditioner, face wash and more',
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
      descriptor: 'Moroccan Argan Oil Collection',
      benefits: [
        'Tames frizz and softens dry hair',
        'Adds shine you can see',
        'Shampoo, conditioner, mask and oil',
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
      headlineLine1: 'Nourish',
      headlineLine2: '& Shine',
      headlineColor: '#F5A623',
      descriptor: 'Black Castor Oil & Avocado Hair Collection',
      benefits: [
        'Black castor oil and avocado',
        'Adds shine to dry hair',
        'With hyaluronic acid to hold in moisture',
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
      descriptor: 'Hydrating Watermelon Skincare',
      benefits: [
        'Hydrates with hyaluronic acid',
        'With vitamins C and E',
        'Watermelon extract and aloe vera',
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
    'Good hair, skin and home care should be easy to find and easy to afford. We bring Xpel Beauty Care to shops across Nigeria, so you can pick it up close to home.',
  aboutStoryTitle: "We're here to make it simple",
  aboutStoryBody1:
    'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria.',
  aboutStoryBody2:
    'Each range is built around one key ingredient, like tea tree, aloe vera or argan oil, and every pack says what the product is for. We supply more than 600 shops in 22 states, so most people can find our products close to home.',
  aboutValue1: 'Ranges built around one key ingredient',
  aboutValue2: 'Clear labels that say what each product does',
  aboutValue3: 'Care for hair, skin, teeth, nails, feet and home',
  aboutValue4: 'Good quality at prices that fit a family budget',
  aboutValue5: 'Sold at 600+ stores across Nigeria',
  pillar1Title: 'Ingredients you know',
  pillar1Desc: 'Each range is built around one key ingredient, like aloe vera, tea tree, argan oil, vitamin C, neem or coconut, named right on the pack.',
  pillar2Title: 'Vegan options',
  pillar2Desc: 'Many of our ranges carry a vegan mark, including So Fresh, Aloe Vera, Argan Oil and XHC Fruit Fusion. Check the pack for the logo.',
  pillar3Title: 'Made for everyday use',
  pillar3Desc: 'Washes, creams and toothpastes for the whole family to use every day, with options for sensitive skin and sensitive teeth.',
  pillar4Title: 'Nationwide availability',
  pillar4Desc: 'Sold at more than 600 stores in 22 states, from Lagos and Abuja to Port Harcourt, Benin and Ibadan.',
  step1Title: 'Pick your concern',
  step1Desc: 'Skin, hair, teeth, nails, feet or home. Each has its own range in our catalogue.',
  step2Title: 'Choose your products',
  step2Desc: 'Every product page says what it does, the size and how to use it. Ask us on WhatsApp if you are not sure.',
  step3Title: 'Get it near you',
  step3Desc: 'Buy at one of our 600+ stockists across Nigeria, or send us an enquiry and we will help you order.',
  aboutMission:
    'To make good, affordable personal care and home products easy to find for every household in Nigeria.',
  aboutVision:
    'To be the first name Nigerian families think of for personal care and household essentials.',
  aboutCtaTitle: 'Find your routine',
  aboutCtaText:
    'Browse the catalogue, choose what suits you, then pick it up at a store near you or send us an enquiry.',
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
  feat1Text: 'A cooling aloe vera gel for dry or sun-exposed skin. Use it after sun, after shaving or any time your skin feels tight.',
  feat1Href: '/collection/aloe-vera',
  feat2Kicker: 'Purifying Botanicals',
  feat2Title: 'Tea Tree Collection',
  feat2Text: 'Face wash, wipes, toner, shampoo and more, all with tea tree oil for a fresh, clean feel on oily and spot-prone skin.',
  feat2Href: '/collection/tea-tree',
  feat3Kicker: 'Nourish & Repair',
  feat3Title: 'Argan Nourishing Range',
  feat3Text: 'Argan oil shampoo, conditioner, hair mask and treatment oil that tame frizz and leave dry hair soft and shiny.',
  feat3Href: '/collection/argan-oil',

  footerPhone1: '08034883603',
  footerPhone2: '08140764150',
  footerEmail: 'info@xpelbeauty.com',
  footerCompany: 'Xpel Beauty NG',
  footerAddress: 'Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos',

  shopTitle: 'shop our range',
  shopSubtitle: 'Hair care, skin and body care, oral care, nail and foot care, and home essentials.',

  contactTitle: 'Get in touch',
  contactIntro: 'Want to order, stock our products in your shop or ask about a product? Send us a message and we will get back to you.',

  storesTitle: 'find us in store',
  storesIntro: 'Find Xpel Beauty Care at more than 600 stores across Nigeria.',

  blogTitle: 'Popular articles',
  blogIntro: 'Tips, guides and stories from the world of Xpel Beauty Care.',

  banners: {
    shopHero: {
      image: '/banner/Product-Body-Care.webp',
      kicker: 'our products & brands',
      title: 'shop our range',
      text: 'Sold at more than 600 stores in 22 states.',
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
      text: 'Questions, orders or trade enquiries - get in touch.',
      cta: '',
      href: '',
    },
  },

  // SEO defaults
  seo: {
    siteTitle: 'Xpel Beauty NG',
    titleSeparator: ' | ',
    defaultDescription: 'Shop Xpel Beauty Care in Nigeria: hair care, skin and body care, oral care, nail and foot care and home essentials, sold at 600+ stores nationwide.',
    defaultOgImage: '/banner/Brand_Argan_Oil_V3.webp',
    twitterHandle: '',
    googleVerification: '',
    pages: {
      home: {
        title: 'Hair Care, Skin Care & Body Care Products in Nigeria',
        description: 'Xpel Beauty Care hair, skin, body, oral and home care in Nigeria. 180 products, sold at 600+ stores in Lagos, Abuja, Port Harcourt and across 22 states.',
        keywords: 'xpel beauty nigeria, best skincare brand lagos, hair care products nigeria, buy beauty products online nigeria, skin care products abuja, body care nigeria, argan oil nigeria, tea tree products nigeria, aloe vera skincare nigeria, beauty store lagos',
        ogImage: '',
        robots: 'index, follow',
      },
      shop: {
        title: 'Shop All Beauty Products Online in Nigeria',
        description: 'Browse the full Xpel Beauty Care range: shampoos, conditioners, face washes, serums, body creams, toothpastes and home essentials. Find them at 600+ stores in Nigeria.',
        keywords: 'buy beauty products online nigeria, shop hair care products nigeria, shop skin care lagos, body care products abuja, xpel beauty shop, best beauty store nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
      about: {
        title: "About Us - Nigeria's Nature-Infused Beauty Brand",
        description: 'Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria, supplying more than 600 stores in 22 states.',
        keywords: 'about xpel beauty nigeria, xpel beauty care story, nigerian beauty brand, best beauty brand nigeria, natural beauty brand lagos',
        ogImage: '',
        robots: 'index, follow',
      },
      contact: {
        title: 'Contact Us - Orders & Enquiries',
        description: 'Contact Xpel Beauty NG to order, stock our products in your shop or ask about a product. We serve customers across Nigeria.',
        keywords: 'contact xpel beauty nigeria, order xpel beauty products, xpel beauty trade enquiry lagos, buy xpel products nigeria',
        ogImage: '',
        robots: 'index, follow',
      },
      blog: {
        title: 'Beauty Journal - Hair & Skin Care Tips for Nigeria',
        description: 'Hair care tips, skincare routines and beauty guides tailored to the Nigerian climate - expert advice from the Xpel Beauty NG team for every skin and hair type.',
        keywords: 'beauty tips nigeria, skin care guide nigeria, hair care tips lagos, natural beauty routine nigeria, xpel beauty blog',
        ogImage: '',
        robots: 'index, follow',
      },
      stores: {
        title: 'Find Xpel Beauty Stockists Near You in Nigeria',
        description: 'Find an Xpel Beauty Care stockist near you. More than 600 stores in Lagos, Abuja, Port Harcourt and 19 more states.',
        keywords: 'xpel beauty stockists nigeria, where to buy xpel beauty care lagos, beauty store near me nigeria, xpel store locations abuja',
        ogImage: '',
        robots: 'index, follow',
      },
    },
  },

  // WhatsApp enquiry settings
  whatsappEnabled: true,
  whatsappNumber: '2347060521947',
  barcodeScannerEnabled: true,

  // Best sellers - admin can select which products to feature (auto-filled with popular products if empty)
  bestSellerIds: [225, 398, 424, 242, 265, 253, 250, 213, 216], // homepage best sellers, in display order

  // Admin users stored in site_content (no separate DB table required)
  adminUsers: [],

  // Mega-menu defaults — all editable in Admin > Mega Menu
  megaMenu: {
    categories: [
      { label: 'Hair Care',       slug: 'hair-care'      },
      { label: 'Body & Beauty',   slug: 'body-beauty'    },
      { label: 'Home',            slug: 'home'           },
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
          { name: 'Men Grooming Products',      href: '/collection/men-grooming'    },
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
      {
        group: 'Shop by Type',
        items: [
          { name: 'Facial Toner',           href: '/collection/facial-toner' },
          { name: 'Facial Wipes',           href: '/collection/facial-wipes' },
          { name: 'Facial & Body Scrubs',   href: '/collection/scrubs'       },
          { name: 'Shampoo',                href: '/collection/shampoo'      },
          { name: 'Conditioner',            href: '/collection/conditioner'  },
          { name: 'Toothpaste',             href: '/collection/toothpaste'   },
          { name: 'Mouthwash',              href: '/collection/mouthwash'    },
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
      description: 'Body creams, scrubs, shower creme, wipes and face care from Xpel Body Care, made for everyday use.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Body Care' },
    { slug: 'xpel-hair-care',   name: 'Xpel Hair Care',   subtitle: 'The Complete Hair Care Range',
      description: 'Shampoos, conditioners, masks, oils and heat protection from Xpel Hair Care, for every hair type.',
      heroImage: '/banner/Product-Shampoo.webp',   overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Hair Care' },
    { slug: 'xpel-oral-care',   name: 'Xpel Oral Care',   subtitle: 'Confident Smile, Every Day',
      description: 'Toothpastes, mouthwashes and tooth powder from Xpel Oral Care for a fresher, cleaner-feeling smile.',
      heroImage: '/banner/Product-Oral-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Oral Care' },
    { slug: 'xpel-foot-care',   name: 'Xpel Foot Care',   subtitle: 'Happy Feet, Every Step',
      description: 'Foot sprays, shoe refresher and foot packs to keep feet and shoes fresh.',
      heroImage: '/banner/Product-Foot-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Foot Care' },
    { slug: 'xpel-nail-care',   name: 'Xpel Nail Care',   subtitle: 'Beautiful Nails, Naturally',
      description: 'Nail polish removers for natural, gel and artificial nails, including acetone-free options.',
      heroImage: '/banner/Product-Nail-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#ca7c29',
      filterType: 'brand', filterValue: 'Xpel Nail Care' },
    // ── Specialist Ranges ────────────────────────────────────────
    { slug: 'tea-tree',         name: 'Tea Tree',          subtitle: 'Purify & Protect',
      description: 'Tea tree oil shampoo, face wash, wipes, toner, scrubs and more, for a fresh, clean feel on hair and skin.',
      heroImage: '/banner/Brand-Tea-Tree.webp',    overlayColor: 'rgba(78, 108, 28, 0.82)', accentColor: '#1B6B2E',
      filterType: 'brand', filterValue: 'Tea Tree' },
    { slug: 'argan-oil',        name: 'Argan Oil',         subtitle: 'Nourish & Repair',
      description: 'Moroccan argan oil shampoo, conditioner, hair mask, treatment and wipes that tame frizz and add shine.',
      heroImage: '/banner/Brand_Argan_Oil_V3.webp',overlayColor: 'rgba(65, 38, 4, 0.86)',  accentColor: '#C8860A',
      filterType: 'brand', filterValue: 'Argan Oil' },
    { slug: 'black-castor-oil', name: 'Black Castor Oil & Avocado', subtitle: 'Strengthen & Grow',
      description: 'Black castor oil and avocado shampoo, leave-in, heat spray and scalp treatment for dry hair that needs moisture and shine.',
      heroImage: '/banner/banner3.png',            overlayColor: 'rgba(30, 10, 2, 0.88)',   accentColor: '#D4620A',
      filterType: 'brand', filterValue: 'Black Castor Oil' },
    { slug: 'so-fresh',         name: 'So Fresh',          subtitle: 'Hydrate & Glow',
      description: 'Watermelon skincare with hyaluronic acid and vitamins C and E: toner, gel moisturiser, scrub, cleanser and sheet mask.',
      heroImage: '/banner/banner4.png',            overlayColor: 'rgba(185, 50, 55, 0.82)', accentColor: '#F72585',
      filterType: 'brand', filterValue: 'So Fresh' },
    { slug: 'neem-oil',         name: 'Neem Oil',          subtitle: "Nature's Purifier",
      description: 'Neem oil face wash, facial scrub and toothpaste for oily and spot-prone skin and a fresh-feeling mouth.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(40, 75, 20, 0.82)',  accentColor: '#3A7D1E',
      filterType: 'brand', filterValue: 'Neem Oil' },
    { slug: 'fresh-start',      name: 'Fresh Start',       subtitle: 'Start Fresh Every Day',
      description: 'Fresh Start shower gels with essential oils in zesty, cool and tropical scents.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#4D7CF6',
      filterType: 'brand', filterValue: 'Fresh Start' },
    { slug: 'intimelle',        name: 'Intimelle',         subtitle: 'Gentle Intimate Care',
      description: 'Intimelle daily feminine wash with aloe vera: soap free, pH balanced and hypo-allergenic.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(140, 30, 70, 0.82)', accentColor: '#C0235A',
      filterType: 'brand', filterValue: 'Intimelle' },
    { slug: 'truesmile',        name: 'Truesmile',         subtitle: 'Confident Smile Every Day',
      description: 'TrueSmile toothpastes for whitening, sensitive teeth, tartar control and kids, most with a toothbrush in the box.',
      heroImage: '/banner/Product-Oral-Care.webp', overlayColor: 'rgba(0, 80, 140, 0.82)', accentColor: '#0A6EBD',
      filterType: 'brand', filterValue: 'Truesmile' },
    { slug: 'nulab',            name: 'Nulab',             subtitle: 'Advanced Personal Care',
      description: 'Nulab deodorants, body creams, face creams and body gel oils for everyday care.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.82)', accentColor: '#5B3FC8',
      filterType: 'brand', filterValue: 'Nulab' },
    { slug: 'hot-rose',         name: 'Hot Rose',          subtitle: 'Luxurious Rose-Infused Care',
      description: 'Hot Rose lip butters, setting sprays, makeup removers, skin serums and serum deodorants.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(160, 20, 60, 0.82)', accentColor: '#D4195C',
      filterType: 'brand', filterValue: 'Hot Rose' },
    // ── Natural Ranges (specific product IDs) ───────────────────
    { slug: 'aloe-vera',        name: 'Aloe Vera',         subtitle: 'Cool, Soothe & Hydrate',
      description: 'Aloe vera shampoo, conditioner, leave-in, cooling gel, toner, masks and wipes to soothe and hydrate.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(14, 80, 50, 0.82)',  accentColor: '#1A7A4A',
      filterType: 'ids', filterValue: '236,230,231,234,232,323,324,233,235' },
    { slug: 'vitamin-c',        name: 'Vitamin C',         subtitle: 'Brighten & Revitalise',
      description: 'Vitamin C face serum, foaming wash, mask, scrubs and wipes for a brighter-looking complexion.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(180, 80, 0, 0.82)',  accentColor: '#D96A00',
      filterType: 'ids', filterValue: '213,214,215,216,217,218' },
    { slug: 'papaya',           name: 'Papaya',            subtitle: 'Glow from Within',
      description: 'Papaya face wash and hydrating sheet mask for a fresh, clean feel.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(150, 50, 0, 0.82)',  accentColor: '#E06020',
      filterType: 'ids', filterValue: '219,220' },
    // ── Shop by Type (matched by keyword in product name, spans every brand) ──
    { slug: 'facial-toner',     name: 'Facial Toner',      subtitle: 'Balance & Refresh',
      description: 'Every facial toner across our range, in one place - balances, soothes and preps skin for moisture.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#D96A00',
      filterType: 'name', filterValue: 'toner' },
    { slug: 'facial-wipes',     name: 'Facial Wipes',      subtitle: 'Cleanse On The Go',
      description: 'Every facial and cleansing wipe pack across our range - quick, effective cleansing wherever you are.',
      heroImage: '/banner/Product-Face-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#3A7D1E',
      filterType: 'name', filterValue: 'wipes' },
    { slug: 'scrubs',           name: 'Facial & Body Scrubs', subtitle: 'Exfoliate & Renew',
      description: 'Every exfoliating facial and body scrub across our range - buffs away dullness for brighter, smoother skin.',
      heroImage: '/banner/Product-Body-Care.webp', overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#C0235A',
      filterType: 'name', filterValue: 'scrub' },
    { slug: 'shampoo',          name: 'Shampoo',           subtitle: 'Cleanse & Nourish',
      description: 'Every shampoo across our hair care range, in one place - find the formula for your hair type.',
      heroImage: '/banner/Product-Shampoo.webp',    overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#0A6EBD',
      filterType: 'name', filterValue: 'shampoo' },
    { slug: 'conditioner',      name: 'Conditioner',       subtitle: 'Soften & Smooth',
      description: 'Every conditioner across our hair care range - leaves hair soft, smooth and manageable.',
      heroImage: '/banner/Product-Shampoo.webp',    overlayColor: 'rgba(26, 31, 58, 0.80)', accentColor: '#5B3FC8',
      filterType: 'name', filterValue: 'conditioner' },
    { slug: 'toothpaste',       name: 'Toothpaste',        subtitle: 'Confident Smile, Every Day',
      description: "Every toothpaste across our oral care range - whitening, sensitivity, kids' and everyday formulas.",
      heroImage: '/banner/Product-Oral-Care.webp',  overlayColor: 'rgba(0, 80, 140, 0.82)', accentColor: '#0A6EBD',
      filterType: 'name', filterValue: 'toothpaste' },
    { slug: 'mouthwash',        name: 'Mouthwash',         subtitle: 'Fresh Breath, All Day',
      description: 'Every mouthwash across our oral care range - freshens breath and helps protect against plaque.',
      heroImage: '/banner/Product-Oral-Care.webp',  overlayColor: 'rgba(0, 80, 140, 0.82)', accentColor: '#0A6EBD',
      filterType: 'name', filterValue: 'mouthwash' },
    { slug: 'men-grooming',     name: 'Men Grooming Products', subtitle: 'Built For The Everyday Grind',
      description: 'Nulab Men Protect roll-ons and sticks with 48-hour anti-sweat protection.',
      heroImage: '/banner/Product-Body-Care.webp',  overlayColor: 'rgba(20, 42, 59, 0.85)', accentColor: '#1B2A3B',
      filterType: 'name', filterValue: 'Men Protect' },
  ] as CollectionConfig[],

  // Real customer messages, kept verbatim
  testimonials: [
    { id: 't1', text: 'I love my products.', author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't2', text: 'The boils have reduced and no new ones. I am doing the routine as we discussed last time. My serum will finish soon.', author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't3', text: "I feel good o. My face skin breathes. I can't explain o. And it feels clean.", author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't4', text: "It's always blending my skin and makes my butt soft.", author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't5', text: "I'm enjoying it.", author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't6', text: "Oh! I'm really enjoying the face wash and cleanser. My face is now coming back to normal. I want everything to clear off before sending my face to you.", author: 'Verified Customer', source: 'WhatsApp' },
    { id: 't7', text: "I've been using Xpel Beauty products for some time now and the quality remains consistent.", author: 'Abah Victor', source: 'Google Reviews', rating: 5 },
    { id: 't8', text: "Using Xpel beauty products has been a game changer for me in my beauty journey.\nThe fact that they have different categories of products to cater to different needs; whether its skincare, body care, hair care, nail and even foot care makes me love the brand so so much.\nThey are very intentional about their customers and providing quality products that actually deliver results.\nLove love itt✨🫶", author: 'Laura Akpan (Laurex)', source: 'Google Reviews', rating: 5 },
    { id: 't9', text: "Xpel Beauty NG is a sure and reliable hub for great quality products at reasonable prices. I've purchased several times and I'm always satisfied. Also I have recommended them to my friends, family & colleague and they can't stop thanking me for it.", author: 'Genesis Archibong', source: 'Google Reviews', rating: 5 },
    { id: 't10', text: 'The Argan Oil range really helped improve the overall appearance of my hair.', author: 'O S', source: 'Google Reviews', rating: 5 },
    { id: 't11', text: "Great quality products at reasonable prices. I've purchased several times and I'm always satisfied.", author: 'James Peter', source: 'Google Reviews', rating: 5 },
    { id: 't12', text: "Today I went to make braids and my hair was not itching me because the last time I washed it I applied the conditioners. I love the fact that it's non greasy. I also apply them on my straight wigs for shine. And it dries up before evening, so I won't have to wash the weavon.", author: 'Dee', source: 'WhatsApp' },
    { id: 't13', text: "I have used the face wash consistently. It's very good and not drying. It's also leaves a finishing glow. It also reduces my red painful inflammations.", author: 'Apunawu', source: 'WhatsApp' },
  ] as Testimonial[],
};

const LS_KEY = 'xpel_site_content';

/**
 * Increment this whenever the DEFAULT heroSlides structure changes
 * (new slide added, filename changed, etc.).
 * On mismatch the heroSlides from storage are discarded and defaults are used,
 * while all other saved settings (text, banners, SEO…) are preserved.
 */
const HERO_SLIDES_VERSION = 9; // bump when slides change
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
      } catch { /* API not reachable yet - fall back silently */ }
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

/** Fetch the live content (row id=1) merged with defaults, or null if it can't be read. */
export async function loadCloudContent(): Promise<SiteContent | null> {
  try {
    const res = await api.siteContent.get();
    if (!res?.data) return null;
    localStorage.setItem(LS_HERO_VER_KEY, String(HERO_SLIDES_VERSION));
    return mergeContent(res.data);
  } catch {
    return null;
  }
}
