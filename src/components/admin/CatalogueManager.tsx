import { useMemo, useState } from 'react';
import type { Product } from '../../types';
import type { SiteContent } from '../../hooks/useSiteContent';
import {
  CATALOGUE_CATEGORIES,
  DEFAULT_CATALOGUE_TITLE,
  autoCatalogueSlug,
  catalogueCategories,
  catalogueSlug,
  type CatalogueCategory,
  type CatalogueSettings,
} from '../../lib/catalogue';

interface Props {
  content: SiteContent;
  updateContent: (patch: Partial<SiteContent>) => void;
  onSave: () => void | Promise<void>;
  products: Product[];
  productsLoading: boolean;
}

const slugify = (s: string) => s.toLowerCase().trim().replace(/&/g, 'and').replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');

function thumb(src?: string) {
  if (!src) return '/images/product-placeholder.svg';
  if (src.startsWith('/Img/') && !src.startsWith('/Img/thumbs/')) return `/Img/thumbs/${src.slice(5).replace(/\.[a-z0-9]+$/i, '')}.webp`;
  return src.startsWith('http') || src.startsWith('/') || src.startsWith('data:') ? src : `/${src}`;
}

/** Admin panel for the /catalogue page: title, categories and where each product appears. */
export default function CatalogueManager({ content, updateContent, onSave, products, productsLoading }: Props) {
  const settings: CatalogueSettings = content.catalogue ?? {};
  const categories = catalogueCategories(settings);
  const assignments = settings.assignments ?? {};
  const hidden = useMemo(() => new Set(settings.hidden ?? []), [settings.hidden]);

  const [query, setQuery] = useState('');
  const [filter, setFilter] = useState<string>('all');
  const [openCat, setOpenCat] = useState<number | null>(null);

  const patch = (p: Partial<CatalogueSettings>) => updateContent({ catalogue: { ...settings, ...p } });

  // Editing categories always works on a real copy, so the defaults get saved the first time.
  const setCategories = (next: CatalogueCategory[]) => patch({ categories: next });
  const updateCat = (i: number, p: Partial<CatalogueCategory>) =>
    setCategories(categories.map((c, j) => (j === i ? { ...c, ...p } : c)));
  const moveCat = (i: number, dir: -1 | 1) => {
    const j = i + dir;
    if (j < 0 || j >= categories.length) return;
    const next = [...categories];
    [next[i], next[j]] = [next[j], next[i]];
    setCategories(next);
  };
  const addCat = () => {
    let n = 1, slug = 'new-category';
    while (categories.some((c) => c.slug === slug)) slug = `new-category-${++n}`;
    setCategories([...categories, { name: 'New Category', slug, blurb: '', accent: '#6b5b3e', tint: '#efe9dc' }]);
    setOpenCat(categories.length);
  };
  const deleteCat = (i: number) => {
    const c = categories[i];
    const count = counts[c.slug] ?? 0;
    if (categories.length <= 1) return;
    if (!window.confirm(`Delete "${c.name}"? Its ${count} product${count === 1 ? '' : 's'} will go back to automatic sorting.`)) return;
    const nextAssign = Object.fromEntries(Object.entries(assignments).filter(([, s]) => s !== c.slug));
    patch({ categories: categories.filter((_, j) => j !== i), assignments: nextAssign });
    setOpenCat(null);
  };
  const resetCats = () => {
    if (!window.confirm('Reset categories to the original eight? Manual product placements stay where they still fit.')) return;
    patch({ categories: CATALOGUE_CATEGORIES });
  };

  const setAssignment = (id: number, slug: string) => {
    const next = { ...assignments };
    if (slug === '') delete next[String(id)];
    else next[String(id)] = slug;
    patch({ assignments: next });
  };
  const toggleHidden = (id: number) => {
    const next = new Set(hidden);
    if (next.has(id)) next.delete(id); else next.add(id);
    patch({ hidden: [...next] });
  };

  const counts = useMemo(() => {
    const m: Record<string, number> = {};
    for (const p of products) {
      if (hidden.has(p.id)) continue;
      const s = catalogueSlug(p, settings);
      m[s] = (m[s] ?? 0) + 1;
    }
    return m;
  }, [products, settings, hidden]);

  const visible = useMemo(() => {
    const q = query.trim().toLowerCase();
    return products
      .filter((p) => !q || p.name.toLowerCase().includes(q) || (p.brand || '').toLowerCase().includes(q))
      .filter((p) => {
        if (filter === 'all') return true;
        if (filter === 'hidden') return hidden.has(p.id);
        if (filter === 'manual') return !!assignments[String(p.id)];
        return catalogueSlug(p, settings) === filter && !hidden.has(p.id);
      })
      .sort((a, b) => a.name.localeCompare(b.name));
  }, [products, query, filter, settings, hidden, assignments]);

  const nameOf = (slug: string) => categories.find((c) => c.slug === slug)?.name ?? slug;
  const manualCount = Object.keys(assignments).length;

  return (
    <div className="panel-section catalogue-admin">
      <div className="catalogue-admin-intro">
        <p>
          Controls the <strong>/catalogue</strong> page and its PDF. Products sort into categories automatically;
          override any of them below, or leave them out of the catalogue. Changes go live when you click <strong>Save Catalogue</strong>.
        </p>
        <div className="catalogue-admin-actions">
          <a href="/catalogue" target="_blank" rel="noopener noreferrer" className="btn-secondary" style={{ textDecoration: 'none' }}>Preview ↗</a>
          <button type="button" className="btn-primary" onClick={onSave}>Save Catalogue</button>
        </div>
      </div>

      {/* ── Page text ─────────────────────────────────────────── */}
      <section className="catalogue-admin-card">
        <h3 className="catalogue-admin-h">Page text</h3>
        <div className="catalogue-admin-grid2">
          <div className="form-group">
            <label className="form-label" htmlFor="cat-title">Title</label>
            <input id="cat-title" className="form-input" value={settings.title ?? ''} placeholder={DEFAULT_CATALOGUE_TITLE}
              onChange={(e) => patch({ title: e.target.value })} />
          </div>
          <div className="form-group">
            <label className="form-label" htmlFor="cat-intro">Intro line</label>
            <input id="cat-intro" className="form-input" value={settings.intro ?? ''}
              placeholder={`Every product in our range, sorted into ${categories.length} categories.`}
              onChange={(e) => patch({ intro: e.target.value })} />
          </div>
        </div>
      </section>

      {/* ── Categories ────────────────────────────────────────── */}
      <section className="catalogue-admin-card">
        <div className="catalogue-admin-head">
          <h3 className="catalogue-admin-h">Categories <span className="badge badge-muted">{categories.length}</span></h3>
          <div style={{ display: 'flex', gap: 8 }}>
            <button type="button" className="btn-secondary btn-sm" onClick={resetCats}>Reset to defaults</button>
            <button type="button" className="btn-primary btn-sm" onClick={addCat}>+ Add category</button>
          </div>
        </div>

        <ol className="catalogue-admin-cats">
          {categories.map((c, i) => (
            <li key={c.slug + i} className={`catalogue-admin-cat ${openCat === i ? 'open' : ''}`}>
              <div className="catalogue-admin-cat-row">
                <span className="catalogue-admin-swatch" style={{ background: c.accent }} aria-hidden="true" />
                <button type="button" className="catalogue-admin-cat-name" onClick={() => setOpenCat(openCat === i ? null : i)} aria-expanded={openCat === i}>
                  {c.name || '(Unnamed)'} <span className="catalogue-admin-muted">{counts[c.slug] ?? 0} products</span>
                </button>
                <div className="catalogue-admin-cat-tools">
                  <button type="button" className="btn-secondary btn-sm" onClick={() => moveCat(i, -1)} disabled={i === 0} aria-label={`Move ${c.name} up`}>↑</button>
                  <button type="button" className="btn-secondary btn-sm" onClick={() => moveCat(i, 1)} disabled={i === categories.length - 1} aria-label={`Move ${c.name} down`}>↓</button>
                  <button type="button" className="btn-secondary btn-sm" onClick={() => setOpenCat(openCat === i ? null : i)}>{openCat === i ? 'Done' : 'Edit'}</button>
                </div>
              </div>

              {openCat === i && (
                <div className="catalogue-admin-cat-body">
                  <div className="catalogue-admin-grid2">
                    <div className="form-group">
                      <label className="form-label">Name</label>
                      <input className="form-input" value={c.name} onChange={(e) => updateCat(i, { name: e.target.value })} />
                    </div>
                    <div className="form-group">
                      <label className="form-label">Key (used for links)</label>
                      <input className="form-input" value={c.slug}
                        onChange={(e) => {
                          const slug = slugify(e.target.value);
                          if (!slug || categories.some((o, j) => j !== i && o.slug === slug)) return;
                          const nextAssign = Object.fromEntries(Object.entries(assignments).map(([id, s]) => [id, s === c.slug ? slug : s]));
                          patch({ categories: categories.map((o, j) => (j === i ? { ...o, slug } : o)), assignments: nextAssign });
                        }} />
                      <small className="catalogue-admin-muted">/catalogue#cat-{c.slug}</small>
                    </div>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Description</label>
                    <textarea className="form-input" rows={2} value={c.blurb} onChange={(e) => updateCat(i, { blurb: e.target.value })} />
                  </div>
                  <div className="catalogue-admin-grid2">
                    <div className="form-group">
                      <label className="form-label">Accent colour (title and default band)</label>
                      <div className="catalogue-admin-colour">
                        <input type="color" value={c.accent} onChange={(e) => updateCat(i, { accent: e.target.value })} aria-label="Accent colour" />
                        <input className="form-input" value={c.accent} onChange={(e) => updateCat(i, { accent: e.target.value })} />
                      </div>
                    </div>
                    <div className="form-group">
                      <label className="form-label">Soft tint</label>
                      <div className="catalogue-admin-colour">
                        <input type="color" value={c.tint} onChange={(e) => updateCat(i, { tint: e.target.value })} aria-label="Tint colour" />
                        <input className="form-input" value={c.tint} onChange={(e) => updateCat(i, { tint: e.target.value })} />
                      </div>
                    </div>
                  </div>
                  <button type="button" className="btn-danger-soft btn-sm" onClick={() => deleteCat(i)} disabled={categories.length <= 1}>Delete category</button>
                </div>
              )}
            </li>
          ))}
        </ol>
      </section>

      {/* ── Products ──────────────────────────────────────────── */}
      <section className="catalogue-admin-card">
        <div className="catalogue-admin-head">
          <h3 className="catalogue-admin-h">Products <span className="badge badge-muted">{products.length}</span></h3>
          <span className="catalogue-admin-muted">{manualCount} placed by hand · {hidden.size} hidden</span>
        </div>
        <div className="catalogue-admin-filters">
          <input className="form-input" type="search" placeholder="Search products or brands…" value={query}
            onChange={(e) => setQuery(e.target.value)} aria-label="Search products" />
          <select className="form-input" value={filter} onChange={(e) => setFilter(e.target.value)} aria-label="Filter by category">
            <option value="all">All products</option>
            {categories.map((c) => <option key={c.slug} value={c.slug}>{c.name} ({counts[c.slug] ?? 0})</option>)}
            <option value="manual">Placed by hand ({manualCount})</option>
            <option value="hidden">Hidden ({hidden.size})</option>
          </select>
        </div>

        {productsLoading ? (
          <p className="catalogue-admin-muted" style={{ padding: 20 }}>Loading products…</p>
        ) : (
          <div className="data-table catalogue-admin-table">
            <table>
              <thead>
                <tr><th style={{ width: 56 }}></th><th>Product</th><th style={{ width: 240 }}>Catalogue category</th><th style={{ width: 110 }}>In catalogue</th></tr>
              </thead>
              <tbody>
                {visible.map((p) => {
                  const manual = assignments[String(p.id)] ?? '';
                  const auto = autoCatalogueSlug(p);
                  const isHidden = hidden.has(p.id);
                  return (
                    <tr key={p.id} className={isHidden ? 'is-hidden' : ''}>
                      <td><img src={thumb(p.image)} alt="" className="catalogue-admin-thumb" loading="lazy"
                        onError={(e) => { (e.target as HTMLImageElement).src = '/images/product-placeholder.svg'; }} /></td>
                      <td>
                        <div className="catalogue-admin-pname">{p.name}</div>
                        <div className="catalogue-admin-muted">{p.brand}{p.size ? ` · ${p.size}` : ''}</div>
                      </td>
                      <td>
                        <select className="form-input" value={manual} onChange={(e) => setAssignment(p.id, e.target.value)}
                          aria-label={`Catalogue category for ${p.name}`}>
                          <option value="">Automatic ({nameOf(catalogueSlug(p, { categories }))})</option>
                          {categories.map((c) => <option key={c.slug} value={c.slug}>{c.name}</option>)}
                        </select>
                      </td>
                      <td>
                        <label className="catalogue-admin-toggle">
                          <input type="checkbox" checked={!isHidden} onChange={() => toggleHidden(p.id)} />
                          <span>{isHidden ? 'Hidden' : 'Shown'}</span>
                        </label>
                      </td>
                    </tr>
                  );
                })}
                {visible.length === 0 && (
                  <tr><td colSpan={4} className="catalogue-admin-muted" style={{ textAlign: 'center', padding: 24 }}>No products match.</td></tr>
                )}
              </tbody>
            </table>
          </div>
        )}
      </section>

      <div className="catalogue-admin-actions" style={{ justifyContent: 'flex-end' }}>
        <button type="button" className="btn-primary" onClick={onSave}>Save Catalogue</button>
      </div>
    </div>
  );
}
