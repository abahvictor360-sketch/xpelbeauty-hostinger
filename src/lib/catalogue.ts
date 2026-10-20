import type { Product } from '@/types';

export interface CatalogueCategory {
  name: string;
  slug: string;
  blurb: string;
  tint: string;
  /** Deep brand colour for the section title and default product band */
  accent: string;
}

// The eight catalogue categories, in display order
export const CATALOGUE_CATEGORIES: CatalogueCategory[] = [
  { name: 'Hair Care',            slug: 'hair-care',       accent: '#b5651d', tint: '#f6e6cf', blurb: 'Shampoos, conditioners, oils, masks and heat protection for every hair type.' },
  { name: 'Body Care',            slug: 'body-care',       accent: '#2e8b57', tint: '#d8efe2', blurb: 'Face washes, serums, creams, scrubs, shower gels and deodorants.' },
  { name: 'Oral Care',            slug: 'oral-care',       accent: '#1f5fa8', tint: '#e3e9f7', blurb: 'Toothpastes, mouthwashes and whitening care for a confident smile.' },
  { name: 'Nail Care',            slug: 'nail-care',       accent: '#c2577f', tint: '#f7dfe6', blurb: 'Polish removers for natural, gel and acrylic nails.' },
  { name: 'Foot Care',            slug: 'foot-care',       accent: '#1e64b4', tint: '#e8f2d8', blurb: 'Foot packs, odour control and shoe refreshers.' },
  { name: 'Make Up Essentials',   slug: 'make-up',         accent: '#a3368f', tint: '#f3e2f0', blurb: 'Lip butters, setting sprays and makeup removers.' },
  { name: 'Men Grooming',         slug: 'men-grooming',    accent: '#1b2a3b', tint: '#e1e6ea', blurb: 'Deodorants and everyday grooming made for men.' },
  { name: 'Home Essentials',      slug: 'home-essentials', accent: '#6b5b3e', tint: '#efe9dc', blurb: 'Hand washes, disinfectants, cleaning, laundry and pet care for the whole household.' },
];

// Legacy / alternate category labels that map straight to a catalogue category
const CATEGORY_ALIASES: Record<string, string> = {
  'hair care': 'Hair Care',
  'body care': 'Body Care',
  'oral care': 'Oral Care',
  'nail care': 'Nail Care',
  'foot care': 'Foot Care',
  'make up essentials': 'Make Up Essentials',
  'makeup essentials': 'Make Up Essentials',
  'make up': 'Make Up Essentials',
  'makeup': 'Make Up Essentials',
  'men grooming': 'Men Grooming',
  "men's grooming": 'Men Grooming',
  'home essentials': 'Home Essentials',
  'home': 'Home Essentials',
};

/** Works out which catalogue category a product belongs to.
 *  An exact category set in the admin always wins; otherwise the product's
 *  brand and name decide (the DB currently only stores Hair Care / Body & Beauty). */
export function catalogueCategory(p: Pick<Product, 'name' | 'brand' | 'category'>): string {
  const cat = (p.category || '').trim().toLowerCase();
  if (CATEGORY_ALIASES[cat]) return CATEGORY_ALIASES[cat];

  const name = p.name || '';
  const brand = (p.brand || '').toLowerCase();

  if (/\bmen\b/i.test(name)) return 'Men Grooming';
  if (brand === 'xpel nail care' || /\bnail/i.test(name)) return 'Nail Care';
  if (brand === 'xpel foot care' || /\bfoot\b|\bshoe\b/i.test(name)) return 'Foot Care';
  if (brand === 'xpel oral care' || brand === 'truesmile' || /tooth|mouthwash|sensio/i.test(name)) return 'Oral Care';
  if (/lip butter|setting spray|make ?up|mascara|lipstick|foundation|concealer/i.test(name)) return 'Make Up Essentials';
  if (/hand ?wash/i.test(name)) return 'Home Essentials';
  return 'Body Care';
}

/** Groups products into the catalogue categories (every category present, even if empty). */
export function groupByCatalogue(products: Product[]): Record<string, Product[]> {
  const groups: Record<string, Product[]> = {};
  for (const c of CATALOGUE_CATEGORIES) groups[c.name] = [];
  for (const p of products) groups[catalogueCategory(p)].push(p);
  for (const list of Object.values(groups)) {
    list.sort((a, b) => (a.brand || '').localeCompare(b.brand || '') || a.name.localeCompare(b.name));
  }
  return groups;
}

// Band colours for the brochure-style catalogue, picked from the product's
// key ingredient or range. All dark enough for white text on top.
const BAND_RULES: Array<[RegExp, string]> = [
  [/strawberry/i, '#c62839'], [/banana/i, '#b8860b'], [/coconut/i, '#1f8a8a'], [/green tea/i, '#2e7d32'],
  [/ginger/i, '#c0611a'], [/watermelon|so fresh/i, '#d6375a'], [/papaya/i, '#c94f1c'], [/vitamin c/i, '#c2560f'],
  [/vitamin e/i, '#2563c0'], [/cocoa/i, '#6d3b1f'], [/olive/i, '#5f7f1f'], [/aqueous/i, '#1f4fa8'],
  [/rosemary/i, '#2c7a6f'], [/black castor/i, '#8c3b12'], [/argan/i, '#8a5a2b'], [/charcoal/i, '#2b2b2b'],
  [/neem/i, '#556b2f'], [/hemp/i, '#4f7a28'], [/keratin/i, '#6a4fb3'], [/biotin|collagen/i, '#c2334a'],
  [/purple/i, '#6a3fa0'], [/tea tree/i, '#2f7d32'], [/aloe/i, '#2f8f46'], [/sweet rose/i, '#7b3fa0'],
  [/sea breeze/i, '#1f78b4'], [/orchard/i, '#5f7a24'], [/lip butter/i, '#c4456c'], [/setting spray/i, '#7d3cc0'],
  [/makeup remover/i, '#c4513a'], [/serena|capsule serum/i, '#b0306a'], [/men protect/i, '#1b2a3b'],
  [/feelin bliss/i, '#c23f62'], [/feelin zesty/i, '#a87400'], [/feelin fresh|feelin silky/i, '#2f8f5f'],
  [/q10|dreamlift|whole body/i, '#4b3a9c'], [/truesmile|sensio/i, '#1f5fa8'], [/nail/i, '#c2577f'],
  [/foot|shoe/i, '#1e64b4'], [/medipure|hair & scalp/i, '#2a74b8'], [/dr magic/i, '#d4560f'],
  [/mediguard|medex|hygie|handwash/i, '#2f8f5f'], [/mucky pup/i, '#2a9d8f'], [/intimelle/i, '#4f8f7f'],
  [/fresh start/i, '#c77d00'], [/cotton buds/i, '#8b6b45'], [/botanical/i, '#4f8a2b'],
];

export function bandColor(p: Pick<Product, 'name' | 'brand' | 'category'>): string {
  const text = `${p.name} ${p.brand || ''}`;
  for (const [re, colour] of BAND_RULES) if (re.test(text)) return colour;
  const cat = CATALOGUE_CATEGORIES.find((c) => c.name === catalogueCategory(p));
  return cat ? cat.accent : '#6b5b3e';
}

/** First sentence of the description, trimmed for the band. */
export function shortLine(description?: string, max = 90): string {
  const first = (description || '').split(/(?<=[.!?])\s/)[0].trim();
  return first.length > max ? first.slice(0, max - 1).replace(/\s+\S*$/, '') + '…' : first;
}
