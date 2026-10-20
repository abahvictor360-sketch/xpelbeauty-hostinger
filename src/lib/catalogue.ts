import type { Product } from '@/types';

export interface CatalogueCategory {
  name: string;
  slug: string;
  blurb: string;
  tint: string;
}

// The eight catalogue categories, in display order
export const CATALOGUE_CATEGORIES: CatalogueCategory[] = [
  { name: 'Hair Care',            slug: 'hair-care',       tint: '#f6e6cf', blurb: 'Shampoos, conditioners, oils, masks and heat protection for every hair type.' },
  { name: 'Body Care',            slug: 'body-care',       tint: '#d8efe2', blurb: 'Face washes, serums, creams, scrubs, shower gels and deodorants.' },
  { name: 'Oral Care',            slug: 'oral-care',       tint: '#e3e9f7', blurb: 'Toothpastes, mouthwashes and whitening care for a confident smile.' },
  { name: 'Nail Care',            slug: 'nail-care',       tint: '#f7dfe6', blurb: 'Polish removers for natural, gel and acrylic nails.' },
  { name: 'Foot Care',            slug: 'foot-care',       tint: '#e8f2d8', blurb: 'Foot packs, odour control and shoe refreshers.' },
  { name: 'Make Up Essentials',   slug: 'make-up',         tint: '#f3e2f0', blurb: 'Lip butters, setting sprays and makeup removers.' },
  { name: 'Men Grooming',         slug: 'men-grooming',    tint: '#e1e6ea', blurb: 'Deodorants and everyday grooming made for men.' },
  { name: 'Home Essentials',      slug: 'home-essentials', tint: '#efe9dc', blurb: 'Hand washes, disinfectants, cleaning, laundry and pet care for the whole household.' },
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
