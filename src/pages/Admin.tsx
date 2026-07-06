import React, { useState, useEffect } from 'react';
import { Check, X, Info, Star, Moon, Sun, Palette, Home, ShoppingBag, Mail, FileText, MapPin } from 'lucide-react';
import { api } from '../lib/api';
import type { Product, BlogPost, Store } from '../types';
import { saveSiteContent, loadLocalContent, fileToDataURL, type SiteContent, type AdminUserRecord, type MegaMenuConfig, type CollectionConfig } from '../hooks/useSiteContent';
import Icon from '../components/Icon';
import { PRODUCT_IMAGES } from '../imageManifest';
import '../styles/admin-dashboard.css';

interface Toast {
  id: string;
  message: string;
  type: 'success' | 'error' | 'info';
}

interface SupabaseStatus {
  connected: boolean;
  message: string;
}

// ── Generic admin credentials (env-var preferred, hardcoded fallback) ──
const ADMIN_USER = import.meta.env.VITE_ADMIN_USER || 'admin';
const ADMIN_PASS = import.meta.env.VITE_ADMIN_PASS || 'xpel2026';

// ── Password hashing (SHA-256 via Web Crypto API) ──
async function hashPassword(password: string): Promise<string> {
  const data = new TextEncoder().encode(password);
  const hash = await crypto.subtle.digest('SHA-256', data);
  return Array.from(new Uint8Array(hash)).map(b => b.toString(16).padStart(2, '0')).join('');
}

// ── Brute-force protection: max 5 attempts in 15 minutes ──
const LOCK_KEY = 'xpel_admin_lock';
const ATTEMPTS_KEY = 'xpel_admin_attempts';
const MAX_ATTEMPTS = 5;
const LOCK_DURATION_MS = 15 * 60 * 1000; // 15 min

function isLockedOut(): boolean {
  const lockUntil = parseInt(localStorage.getItem(LOCK_KEY) || '0', 10);
  if (Date.now() < lockUntil) return true;
  if (Date.now() >= lockUntil && lockUntil > 0) {
    localStorage.removeItem(LOCK_KEY);
    localStorage.removeItem(ATTEMPTS_KEY);
  }
  return false;
}

function recordFailedAttempt(): number {
  const attempts = parseInt(localStorage.getItem(ATTEMPTS_KEY) || '0', 10) + 1;
  localStorage.setItem(ATTEMPTS_KEY, String(attempts));
  if (attempts >= MAX_ATTEMPTS) {
    localStorage.setItem(LOCK_KEY, String(Date.now() + LOCK_DURATION_MS));
  }
  return attempts;
}

// ── Fixed category list (matches Shop.tsx) ──────────────────────────────────
const FIXED_CATEGORIES = ['Body & Beauty', 'Gifting', 'Hair Care', 'Home', 'Travel & Health'];

// ── ComboSelect — dropdown + inline "Add new" ───────────────────────────────
function ComboSelect({
  value, options, onChange, onAddNew, placeholder,
}: {
  value: string;
  options: string[];
  onChange: (v: string) => void;
  onAddNew: (v: string) => void;
  placeholder?: string;
}) {
  const [adding, setAdding] = useState(false);
  const [draft, setDraft] = useState('');
  const ADD_KEY = '__add__';

  const commit = () => {
    const trimmed = draft.trim();
    if (!trimmed) return;
    onAddNew(trimmed);
    onChange(trimmed);
    setAdding(false);
    setDraft('');
  };

  if (adding) {
    return (
      <div style={{ display: 'flex', gap: '6px' }}>
        <input
          autoFocus
          type="text"
          className="form-input"
          value={draft}
          onChange={(e) => setDraft(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') commit(); if (e.key === 'Escape') { setAdding(false); setDraft(''); } }}
          placeholder={placeholder || 'Type new option…'}
        />
        <button type="button" className="btn-primary btn-sm" onClick={commit}>Add</button>
        <button type="button" className="btn-secondary btn-sm" onClick={() => { setAdding(false); setDraft(''); }}>✕</button>
      </div>
    );
  }

  return (
    <select
      className="form-input"
      value={value || ''}
      onChange={(e) => { if (e.target.value === ADD_KEY) setAdding(true); else onChange(e.target.value); }}
    >
      <option value="">— select —</option>
      {options.map((o) => <option key={o} value={o}>{o}</option>)}
      <option disabled style={{ color: '#ccc' }}>──────────</option>
      <option value={ADD_KEY}>＋ Add new…</option>
    </select>
  );
}

export default function Admin() {
  const [activePanel, setActivePanel] = useState('overview');
  const [toasts, setToasts] = useState<Toast[]>([]);
  const [supabaseStatus, setSupabaseStatus] = useState<SupabaseStatus>({ connected: false, message: 'Checking...' });

  // ── Auth gate ──
  const [authed, setAuthed] = useState<boolean>(
    () => localStorage.getItem('xpel_admin_authed') === 'true'
  );
  const [loginUser, setLoginUser] = useState('');
  const [loginPass, setLoginPass] = useState('');
  const [loginError, setLoginError] = useState('');

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (isLockedOut()) {
      setLoginError('Too many failed attempts. Please wait 15 minutes and try again.');
      return;
    }

    // Normalise input once — all comparisons are case-insensitive
    const inputId = loginUser.trim().toLowerCase();

    // Helper: does a stored user record match the typed identifier?
    const matchesId = (u: AdminUserRecord) =>
      u.username.toLowerCase() === inputId ||
      (u.email && u.email.toLowerCase() === inputId);

    // Check primary env-var / hardcoded admin (username OR email, case-insensitive)
    if (
      (inputId === ADMIN_USER.toLowerCase() || inputId === 'abahvictor760@gmail.com') &&
      loginPass === ADMIN_PASS
    ) {
      localStorage.setItem('xpel_admin_authed', 'true');
      localStorage.removeItem(ATTEMPTS_KEY);
      localStorage.removeItem(LOCK_KEY);
      setAuthed(true);
      setLoginError('');
      return;
    }

    // Check additional users — localStorage first (works offline), then Supabase
    try {
      const inputHash = await hashPassword(loginPass);

      // 1. Check dedicated localStorage user store (fastest, works offline)
      const localUsers: AdminUserRecord[] = (() => {
        try { return JSON.parse(localStorage.getItem('xpel_admin_users') || '[]'); } catch { return []; }
      })();
      const localMatch = localUsers.find(
        (u) => matchesId(u) && u.password_hash === inputHash
      );
      if (localMatch) {
        localStorage.setItem('xpel_admin_authed', 'true');
        localStorage.removeItem(ATTEMPTS_KEY);
        localStorage.removeItem(LOCK_KEY);
        setAuthed(true);
        setLoginError('');
        return;
      }

      // 2. Fall back to API (in case user was added from another device)
      const res = await api.siteContent.get().catch(() => null);
      const cloudUsers: AdminUserRecord[] = res?.data?.adminUsers ?? [];
      const cloudMatch = cloudUsers.find(
        (u) => matchesId(u) && u.password_hash === inputHash
      );
      if (cloudMatch) {
        // Cache to localStorage so next login is instant
        const merged = [...new Map([...localUsers, ...cloudUsers].map(u => [u.username, u])).values()];
        localStorage.setItem('xpel_admin_users', JSON.stringify(merged));
        localStorage.setItem('xpel_admin_authed', 'true');
        localStorage.removeItem(ATTEMPTS_KEY);
        localStorage.removeItem(LOCK_KEY);
        setAuthed(true);
        setLoginError('');
        return;
      }
    } catch { /* ignore */ }

    const attempts = recordFailedAttempt();
    const remaining = MAX_ATTEMPTS - attempts;
    if (remaining <= 0) {
      setLoginError('Account locked for 15 minutes due to too many failed attempts.');
    } else {
      setLoginError(`Invalid username or password. ${remaining} attempt${remaining === 1 ? '' : 's'} remaining.`);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('xpel_admin_authed');
    setAuthed(false);
    setLoginUser('');
    setLoginPass('');
  };

  // ── Theme toggle ──
  const [theme, setTheme] = useState<'light' | 'dark'>(
    () => (localStorage.getItem('xpel_admin_theme') as 'light' | 'dark') || 'light'
  );

  const toggleTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
    localStorage.setItem('xpel_admin_theme', newTheme);
    document.documentElement.setAttribute('data-theme', newTheme);
  };

  // Apply theme on mount
  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
  }, [theme]);

  // Data states
  const [products, setProducts] = useState<Product[]>([]);
  const [blogPosts, setBlogPosts] = useState<BlogPost[]>([]);
  const [stores, setStores] = useState<Store[]>([]);

  interface Enquiry {
    id: number; type: string; name: string | null; email: string | null; phone: string | null;
    subject: string | null; message: string; product_id: number | null; product_name: string | null;
    status: string; created_at: string;
  }
  const [enquiries, setEnquiries] = useState<Enquiry[]>([]);
  const [loadingEnquiries, setLoadingEnquiries] = useState(false);
  const [expandedEnquiry, setExpandedEnquiry] = useState<number | null>(null);
  const [enquiryFilter, setEnquiryFilter] = useState<'all' | 'new' | 'contact' | 'product'>('all');

  // Loading states
  const [loadingProducts, setLoadingProducts] = useState(false);
  const [loadingBlogs, setLoadingBlogs] = useState(false);
  const [loadingStores, setLoadingStores] = useState(false);

  // Modal states
  const [showProductModal, setShowProductModal] = useState(false);
  const [showBlogModal, setShowBlogModal] = useState(false);
  const [showStoreModal, setShowStoreModal] = useState(false);
  const [editingProduct, setEditingProduct] = useState<Product | null>(null);
  const [editingBlog, setEditingBlog] = useState<BlogPost | null>(null);
  const [editingStore, setEditingStore] = useState<Store | null>(null);

  // Form states
  const [showGallery, setShowGallery] = useState(false);
  const [productForm, setProductForm] = useState<Partial<Product>>({});
  const [blogForm, setBlogForm] = useState<Partial<BlogPost>>({});
  const [storeForm, setStoreForm] = useState<Partial<Store>>({});

  // Search and filter states
  const [productSearch, setProductSearch] = useState('');
  const [blogSearch, setBlogSearch] = useState('');
  const [storeSearch, setStoreSearch] = useState('');

  // ── Brand & Category options (seeded from products + admin-added extras) ──
  const [customBrands, setCustomBrands] = useState<string[]>(() => {
    try { return JSON.parse(localStorage.getItem('xpel_custom_brands') || '[]'); } catch { return []; }
  });
  const [customCategories, setCustomCategories] = useState<string[]>(() => {
    try { return JSON.parse(localStorage.getItem('xpel_custom_categories') || '[]'); } catch { return []; }
  });

  const allBrands = [...new Set([...products.map(p => p.brand).filter(Boolean), ...customBrands])].sort((a, b) => a.localeCompare(b));
  const allCategories = [...new Set([...FIXED_CATEGORIES, ...products.map(p => p.category).filter(Boolean), ...customCategories])].sort((a, b) => a.localeCompare(b));

  const addCustomBrand = (brand: string) => {
    const next = [...new Set([...customBrands, brand])];
    setCustomBrands(next);
    localStorage.setItem('xpel_custom_brands', JSON.stringify(next));
  };
  const addCustomCategory = (cat: string) => {
    const next = [...new Set([...customCategories, cat])];
    setCustomCategories(next);
    localStorage.setItem('xpel_custom_categories', JSON.stringify(next));
  };

  // ── Unified site content (single source of truth, cloud + local) ──
  const [content, setContent] = useState<SiteContent>(() => {
    const c = loadLocalContent();
    // Merge dedicated xpel_admin_users store into content on init
    try {
      const localUsers: AdminUserRecord[] = JSON.parse(localStorage.getItem('xpel_admin_users') || '[]');
      if (localUsers.length > 0) {
        const merged = [...new Map([...(c.adminUsers ?? []), ...localUsers].map(u => [u.username, u])).values()];
        return { ...c, adminUsers: merged };
      }
    } catch { /* ignore */ }
    return c;
  });
  const updateContent = (patch: Partial<SiteContent>) => setContent((c) => ({ ...c, ...patch }));
  const updateSlide = (i: number, val: string) => {
    setContent((c) => {
      const slides = [...(c.slides ?? [])];
      slides[i] = val;
      return { ...c, slides };
    });
  };
  const updateHeroSlide = (i: number, patch: Partial<import('@/hooks/useSiteContent').HeroSlide>) => {
    setContent((c) => {
      const heroSlides = [...(c.heroSlides ?? [])];
      heroSlides[i] = { ...heroSlides[i], ...patch };
      return { ...c, heroSlides };
    });
  };
  const addHeroSlide = () => {
    setContent((c) => {
      const heroSlides = [...(c.heroSlides ?? [])];
      heroSlides.push({
        image: '',
        overlayColor: 'rgba(28,10,2,0.88)',
        brandLockup: 'xbc® | xpel beauty care',
        subLabel: '',
        headlineLine1: 'New',
        headlineLine2: 'Slide',
        headlineColor: '#ffffff',
        descriptor: '',
        benefits: ['', '', ''],
        vegaBadge: '',
        vegaBadgeBg: '#2d6a4f',
        vegaBadgeColor: '#ffffff',
        ctaLabel: 'shop now',
        ctaHref: '/shop',
        ctaBg: '#ca7c29',
        ctaColor: '#ffffff',
      });
      return { ...c, heroSlides };
    });
  };

  const removeHeroSlide = (i: number) => {
    if (!window.confirm(`Delete slide ${i + 1}? This cannot be undone.`)) return;
    setContent((c) => {
      const heroSlides = (c.heroSlides ?? []).filter((_, idx) => idx !== i);
      return { ...c, heroSlides };
    });
  };

  const updateHeroSlideBenefit = (slideIdx: number, benIdx: number, val: string) => {
    setContent((c) => {
      const heroSlides = [...(c.heroSlides ?? [])];
      const benefits = [...(heroSlides[slideIdx].benefits ?? [])];
      benefits[benIdx] = val;
      heroSlides[slideIdx] = { ...heroSlides[slideIdx], benefits };
      return { ...c, heroSlides };
    });
  };
  const updateArrayImage = (key: 'catImages' | 'featureImages' | 'aboutCatImages', i: number, val: string) => {
    setContent((c) => {
      const arr = [...c[key]];
      arr[i] = val;
      return { ...c, [key]: arr };
    });
  };
  type BannerKey = keyof SiteContent['banners'];
  const updateBanner = (key: BannerKey, patch: Partial<SiteContent['banners'][BannerKey]>) => {
    setContent((c) => ({ ...c, banners: { ...c.banners, [key]: { ...c.banners[key], ...patch } } }));
  };
  const uploadBannerImage = async (e: React.ChangeEvent<HTMLInputElement>, key: BannerKey) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (file.size > 1.5 * 1024 * 1024) { addToast('Image too large — use one under 1.5 MB', 'error'); return; }
    const dataUrl = await fileToDataURL(file);
    updateBanner(key, { image: dataUrl });
    addToast('Banner image loaded — remember to Save', 'info');
  };
  const saveContent = async () => {
    const cloud = await saveSiteContent(content);
    addToast(
      cloud ? 'Saved — live site updated' : 'Saved locally (add site_content table to go live)',
      cloud ? 'success' : 'info'
    );
  };
  // Upload a file -> data URL -> assign to a content field (or a slide index)
  const handleUpload = async (
    e: React.ChangeEvent<HTMLInputElement>,
    field: keyof SiteContent | { slide: number } | { arr: 'catImages' | 'featureImages' | 'aboutCatImages'; i: number } | { heroSlide: number }
  ) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (file.size > 1.5 * 1024 * 1024) {
      addToast('Image too large — please use one under 1.5 MB', 'error');
      return;
    }
    const dataUrl = await fileToDataURL(file);
    if (typeof field === 'object' && 'slide' in field) updateSlide(field.slide, dataUrl);
    else if (typeof field === 'object' && 'arr' in field) updateArrayImage(field.arr, field.i, dataUrl);
    else if (typeof field === 'object' && 'heroSlide' in field) updateHeroSlide(field.heroSlide, { image: dataUrl });
    else updateContent({ [field as keyof SiteContent]: dataUrl } as Partial<SiteContent>);
    addToast('Image loaded — remember to Save', 'info');
  };

  // ── Admin Users ──────────────────────────────────────────────────────────────
  type AdminUser = AdminUserRecord;
  const [userForm, setUserForm] = useState<{ username: string; name: string; email: string; password: string; role: string }>({
    username: '', name: '', email: '', password: '', role: 'Editor',
  });
  // Derived from content (always in sync)
  const adminUsers: AdminUser[] = content.adminUsers ?? [];

  /**
   * Persist the admin users list to:
   * 1. Dedicated localStorage key (xpel_admin_users) — instant & offline
   * 2. Supabase site_content.data.adminUsers — targeted patch, no huge payload
   * Returns true if API sync succeeded.
   */
  const persistAdminUsers = async (users: AdminUser[]): Promise<boolean> => {
    localStorage.setItem('xpel_admin_users', JSON.stringify(users));
    try {
      await api.siteContent.patch({ adminUsers: users });
      return true;
    } catch {
      return false;
    }
  };

  // Load data once + pull latest content from API
  useEffect(() => {
    (async () => {
      try {
        const res = await api.siteContent.get();
        if (res?.data) {
          const cloudUsers: AdminUserRecord[] = res.data.adminUsers ?? [];
          const localUsers: AdminUserRecord[] = (() => {
            try { return JSON.parse(localStorage.getItem('xpel_admin_users') || '[]'); } catch { return []; }
          })();
          const mergedUsers = [...new Map([...localUsers, ...cloudUsers].map(u => [u.username, u])).values()];
          localStorage.setItem('xpel_admin_users', JSON.stringify(mergedUsers));
          setContent((c) => ({ ...c, ...res.data, adminUsers: mergedUsers }));
        }
      } catch { /* API not reachable — use local state */ }
    })();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Auto-load all store data (quietly) once authenticated
  useEffect(() => {
    if (!authed) return;
    (async () => {
      try {
        const [p, b, s] = await Promise.all([
          api.products.getAllAdmin(),
          api.blog.getAll(true),
          api.stores.getAll(),
        ]);
        setProducts(p ?? []);
        setBlogPosts(b ?? []);
        setStores(s ?? []);
      } catch { /* ignore — panels can reload individually */ }
    })();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [authed]);

  const addUser = async () => {
    if (!userForm.username.trim() || !userForm.name.trim() || !userForm.password) {
      addToast('Enter username, full name and password', 'error');
      return;
    }
    if (userForm.username.trim() === ADMIN_USER) {
      addToast('That username is reserved', 'error');
      return;
    }
    if (adminUsers.some(u => u.username === userForm.username.trim())) {
      addToast('Username already exists', 'error');
      return;
    }
    if (userForm.password.length < 6) {
      addToast('Password must be at least 6 characters', 'error');
      return;
    }
    try {
      const password_hash = await hashPassword(userForm.password);
      const newUser: AdminUser = {
        id: Date.now().toString(),
        username: userForm.username.trim(),
        name: userForm.name.trim(),
        email: userForm.email.trim(),
        role: userForm.role || 'Editor',
        password_hash,
      };
      const next = [...adminUsers, newUser];

      // Update UI immediately
      updateContent({ adminUsers: next });

      // Persist to localStorage + Supabase (targeted — no large payload risk)
      const synced = await persistAdminUsers(next);

      setUserForm({ username: '', name: '', email: '', password: '', role: 'Editor' });
      if (synced) {
        addToast(`User "${newUser.username}" added — they can now log in from any device`, 'success');
      } else {
        addToast(`User "${newUser.username}" saved locally — will sync to cloud on next full save`, 'info');
      }
    } catch (err) {
      addToast('Failed to add user: ' + ((err as Error)?.message || 'unknown error'), 'error');
    }
  };

  const deleteUser = async (id: string) => {
    if (!window.confirm('Remove this user? They will no longer be able to log in.')) return;
    const next = adminUsers.filter(u => u.id !== id);
    updateContent({ adminUsers: next });
    await persistAdminUsers(next);
    addToast('User removed', 'info');
  };

  const resetUserPassword = async (id: string) => {
    const newPass = window.prompt('Enter new password for this user (min 6 characters):');
    if (!newPass) return;
    if (newPass.length < 6) { addToast('Password too short — must be at least 6 characters', 'error'); return; }
    const password_hash = await hashPassword(newPass);
    const next = adminUsers.map(u => u.id === id ? { ...u, password_hash } : u);
    updateContent({ adminUsers: next });
    const synced = await persistAdminUsers(next);
    addToast(synced ? 'Password updated' : 'Password updated locally (sync to cloud on next full save)', synced ? 'success' : 'info');
  };

  // ── Collection page helpers ───────────────────────────────────────────────
  const collections: CollectionConfig[] = content.collections ?? [];

  const updateCollection = (idx: number, patch: Partial<CollectionConfig>) => {
    const next = collections.map((c, i) => i === idx ? { ...c, ...patch } : c);
    updateContent({ collections: next });
  };

  const deleteCollection = (idx: number) => {
    if (!window.confirm('Delete this collection page? The URL will stop working.')) return;
    const next = collections.filter((_, i) => i !== idx);
    updateContent({ collections: next });
  };

  const addCollection = () => {
    const newCol: CollectionConfig = {
      slug: 'new-collection',
      name: 'New Collection',
      subtitle: '',
      description: '',
      heroImage: '/banner/Product-Body-Care.webp',
      overlayColor: 'rgba(26, 31, 58, 0.82)',
      accentColor: '#ca7c29',
      filterType: 'brand',
      filterValue: '',
    };
    updateContent({ collections: [...collections, newCol] });
  };

  const uploadCollectionHero = async (e: React.ChangeEvent<HTMLInputElement>, idx: number) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (file.size > 1.5 * 1024 * 1024) { addToast('Image too large — use one under 1.5 MB', 'error'); return; }
    const dataUrl = await fileToDataURL(file);
    updateCollection(idx, { heroImage: dataUrl });
    addToast('Hero image loaded — remember to Save Collections', 'info');
  };

  // Check API connection
  useEffect(() => {
    api.products.getAllAdmin()
      .then(() => setSupabaseStatus({ connected: true, message: 'Connected to MySQL API' }))
      .catch((err: Error) => setSupabaseStatus({
        connected: false,
        message: 'Failed to connect: ' + (err?.message || 'unknown error'),
      }));
  }, []);

  // Toast notification handler
  const addToast = (message: string, type: 'success' | 'error' | 'info' = 'info') => {
    const id = Date.now().toString();
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts(prev => prev.filter(t => t.id !== id));
    }, 4000);
  };

  // Load products
  const loadProducts = async () => {
    setLoadingProducts(true);
    try {
      const data = await api.products.getAllAdmin();
      setProducts(data || []);
      addToast('Products loaded successfully', 'success');
    } catch (error) {
      addToast('Failed to load products: ' + (error as Error).message, 'error');
    } finally {
      setLoadingProducts(false);
    }
  };

  // Load blog posts
  const loadBlogPosts = async () => {
    setLoadingBlogs(true);
    try {
      const data = await api.blog.getAll(true);
      setBlogPosts(data || []);
      addToast('Blog posts loaded successfully', 'success');
    } catch (error) {
      addToast('Failed to load blog posts: ' + (error as Error).message, 'error');
    } finally {
      setLoadingBlogs(false);
    }
  };

  // Load stores
  const loadStores = async () => {
    setLoadingStores(true);
    try {
      const data = await api.stores.getAll();
      setStores(data || []);
      addToast('Stores loaded successfully', 'success');
    } catch (error) {
      addToast('Failed to load stores: ' + (error as Error).message, 'error');
    } finally {
      setLoadingStores(false);
    }
  };

  // Load enquiries
  const loadEnquiries = async () => {
    setLoadingEnquiries(true);
    try {
      const data = await api.enquiries.getAll();
      setEnquiries(data || []);
    } catch {
      addToast('Could not load enquiries', 'error');
    } finally {
      setLoadingEnquiries(false);
    }
  };

  const markEnquiryRead = async (id: number) => {
    await api.enquiries.updateStatus(id, 'read');
    setEnquiries(prev => prev.map(e => e.id === id ? { ...e, status: 'read' } : e));
  };

  const deleteEnquiry = async (id: number) => {
    await api.enquiries.delete(id);
    setEnquiries(prev => prev.filter(e => e.id !== id));
    addToast('Enquiry deleted', 'success');
  };

  // Add or update product
  const handleSaveProduct = async () => {
    if (!productForm.name) {
      addToast('Please fill in all required fields', 'error');
      return;
    }

    // Only send columns that exist in the products table
    const KNOWN_COLUMNS = ['name','category','brand','price','compare_price','stock','sku','description','image','best_seller','active','size'];
    const safeForm = Object.fromEntries(
      Object.entries(productForm).filter(([k]) => KNOWN_COLUMNS.includes(k))
    );

    try {
      if (editingProduct) {
        await api.products.update(editingProduct.id, safeForm);
        addToast('Product updated successfully', 'success');
      } else {
        await api.products.create(safeForm);
        addToast('Product created successfully', 'success');
      }
      setShowProductModal(false);
      setProductForm({});
      setEditingProduct(null);
      await loadProducts();
    } catch (error) {
      addToast('Failed to save product: ' + (error as Error).message, 'error');
    }
  };

  // Delete product
  const handleDeleteProduct = async (id: number) => {
    if (window.confirm('Are you sure you want to delete this product?')) {
      try {
        await api.products.delete(id);
        addToast('Product deleted successfully', 'success');
        await loadProducts();
      } catch (error) {
        addToast('Failed to delete product: ' + (error as Error).message, 'error');
      }
    }
  };

  // Add or update blog post
  const handleSaveBlog = async () => {
    if (!blogForm.title || !blogForm.content) {
      addToast('Please fill in all required fields', 'error');
      return;
    }

    try {
      const BLOG_COLUMNS = ['title','slug','content','excerpt','author','category','featured_image','published','featured','published_at'];
      const { image, ...rest } = blogForm as BlogPost & { image?: string };
      const rawPayload = { ...rest, featured_image: image || (rest as any).featured_image || '' };
      const dbPayload = Object.fromEntries(Object.entries(rawPayload).filter(([k]) => BLOG_COLUMNS.includes(k)));

      if (editingBlog) {
        await api.blog.update(editingBlog.id, dbPayload);
        addToast('Blog post updated successfully', 'success');
      } else {
        await api.blog.create(dbPayload);
        addToast('Blog post created successfully', 'success');
      }
      setShowBlogModal(false);
      setBlogForm({});
      setEditingBlog(null);
      await loadBlogPosts();
    } catch (error) {
      addToast('Failed to save blog post: ' + (error as Error).message, 'error');
    }
  };

  // Delete blog post
  const handleDeleteBlog = async (id: number) => {
    if (window.confirm('Are you sure you want to delete this blog post?')) {
      try {
        await api.blog.delete(id);
        addToast('Blog post deleted successfully', 'success');
        await loadBlogPosts();
      } catch (error) {
        addToast('Failed to delete blog post: ' + (error as Error).message, 'error');
      }
    }
  };

  // Add or update store
  const handleSaveStore = async () => {
    if (!storeForm.name || !storeForm.address || !storeForm.phone) {
      addToast('Please fill in all required fields', 'error');
      return;
    }

    // Columns confirmed in the DB. Run the SQL below in Supabase SQL Editor to unlock city/state/email/hours/logo:
    //   ALTER TABLE stores ADD COLUMN IF NOT EXISTS city text;
    //   ALTER TABLE stores ADD COLUMN IF NOT EXISTS state text;
    //   ALTER TABLE stores ADD COLUMN IF NOT EXISTS email text;
    //   ALTER TABLE stores ADD COLUMN IF NOT EXISTS hours text;
    //   ALTER TABLE stores ADD COLUMN IF NOT EXISTS logo text;
    // After running, change this list to also include: 'city','state','email','hours','logo'
    const STORE_COLUMNS = ['name','area','type','address','phone','active'];
    const safeForm = Object.fromEntries(Object.entries(storeForm).filter(([k]) => STORE_COLUMNS.includes(k)));

    try {
      if (editingStore) {
        await api.stores.update(editingStore.id, safeForm);
        addToast('Store updated successfully', 'success');
      } else {
        await api.stores.create(safeForm);
        addToast('Store created successfully', 'success');
      }
      setShowStoreModal(false);
      setStoreForm({});
      setEditingStore(null);
      await loadStores();
    } catch (error) {
      addToast('Failed to save store: ' + (error as Error).message, 'error');
    }
  };

  // Delete store
  const handleDeleteStore = async (id: number) => {
    if (window.confirm('Are you sure you want to delete this store?')) {
      try {
        await api.stores.delete(id);
        addToast('Store deleted successfully', 'success');
        await loadStores();
      } catch (error) {
        addToast('Failed to delete store: ' + (error as Error).message, 'error');
      }
    }
  };

  // Open edit product modal
  const openEditProduct = (product: Product) => {
    setEditingProduct(product);
    setProductForm(product);
    setShowProductModal(true);
  };

  // Open edit blog modal
  const openEditBlog = (blog: BlogPost) => {
    setEditingBlog(blog);
    setBlogForm(blog);
    setShowBlogModal(true);
  };

  // Open edit store modal
  const openEditStore = (store: Store) => {
    setEditingStore(store);
    setStoreForm(store);
    setShowStoreModal(true);
  };

  // CSV export
  const exportCSV = (data: any[], filename: string) => {
    const csv = [
      Object.keys(data[0]).join(','),
      ...data.map(row => Object.values(row).map(v => `"${v}"`).join(','))
    ].join('\n');

    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    a.click();
    window.URL.revokeObjectURL(url);
    addToast('CSV exported successfully', 'success');
  };

  // CSV import
  const handleCSVImport = async (e: React.ChangeEvent<HTMLInputElement>, type: string) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = async (event) => {
      try {
        const csv = event.target?.result as string;
        const lines = csv.split('\n');
        const headers = lines[0].split(',').map(h => h.trim());
        const data = lines.slice(1).filter(line => line.trim()).map(line => {
          const values = line.split(',').map(v => v.replace(/^"|"$/g, '').trim());
          return headers.reduce((obj, header, index) => {
            obj[header] = values[index];
            return obj;
          }, {} as any);
        });

        if (data.length === 0) {
          addToast('No data in CSV file', 'error');
          return;
        }

        if (type === 'products') {
          await api.products.bulkInsert(data);
          await loadProducts();
        } else if (type === 'stores') {
          for (const row of data) { await api.stores.create(row); }
          await loadStores();
        }

        addToast(`${data.length} records imported successfully`, 'success');
      } catch (error) {
        addToast('Failed to import CSV: ' + (error as Error).message, 'error');
      }
    };
    reader.readAsText(file);
  };

  // ── Login screen ──
  if (!authed) {
    return (
      <div className="admin-login">
        <form className="admin-login-card" onSubmit={handleLogin}>
          <h1>Xpel Admin</h1>
          <p>Sign in to manage your store</p>
          <input
            type="text"
            placeholder="Username or email"
            value={loginUser}
            onChange={(e) => setLoginUser(e.target.value.slice(0, 128))}
            autoComplete="username email"
            autoFocus
          />
          <input
            type="password"
            placeholder="Password"
            autoComplete="current-password"
            value={loginPass}
            onChange={(e) => setLoginPass(e.target.value.slice(0, 128))}
          />
          {loginError && <div className="admin-login-error">{loginError}</div>}
          <button type="submit">Sign In</button>
        </form>
      </div>
    );
  }

  // Live theme preview in admin (reads from local content state)
  const accent   = content.themeAccent  || '#ca7c29';
  const navy     = content.themeNavy    || '#1B2A3B';
  const barFrom  = content.themeBarFrom || accent;
  const barMid   = content.themeBarMid  || '#6f3716';

  return (
    <div className="admin-container">
      <style>{`
        :root {
          --gold-raw:   ${accent};
          --gold:       ${accent};
          --gold-hover: ${accent};
          --navy:       ${navy};
        }
        .top-gradient-bar {
          background: linear-gradient(90deg, ${barFrom} 0%, ${barMid} 50%, ${barFrom} 100%) !important;
        }
      `}</style>
      {/* Sidebar Navigation */}
      <aside className="admin-sidebar">
        <div className="sidebar-header">
          <h2 className="sidebar-title">Xpel Admin</h2>
          <p className="sidebar-subtitle">Dashboard</p>
        </div>

        <nav className="sidebar-nav">
          {[
            { group: '', items: [{ id: 'overview', label: 'Overview', icon: 'dashboard' }] },
            { group: 'Management', items: [
              { id: 'products', label: 'Products', icon: 'box', load: loadProducts },
              { id: 'blog', label: 'Blog', icon: 'doc', load: loadBlogPosts },
              { id: 'stores', label: 'Stores', icon: 'store', load: loadStores },
              { id: 'enquiries', label: 'Enquiries', icon: 'mail', load: loadEnquiries },
            ] },
            { group: 'Content', items: [
              { id: 'content', label: 'Content Manager', icon: 'edit' },
              { id: 'media', label: 'Logo & Media', icon: 'image' },
              { id: 'mega-menu', label: 'Mega Menu', icon: 'home' },
              { id: 'collections', label: 'Collections', icon: 'box' },
              { id: 'seo', label: 'SEO', icon: 'search' },
            ] },
            { group: 'Tools', items: [
              { id: 'users', label: 'Users', icon: 'user' },
              { id: 'import-export', label: 'Import/Export', icon: 'download' },
              { id: 'settings', label: 'Settings', icon: 'settings' },
            ] },
          ].map((section) => (
            <div key={section.group || 'top'}>
              {section.group && <div className="nav-section-title">{section.group}</div>}
              {section.items.map((item) => (
                <button
                  key={item.id}
                  onClick={() => { setActivePanel(item.id); (item as { load?: () => void }).load?.(); }}
                  className={`nav-item ${activePanel === item.id ? 'active' : ''}`}
                >
                  <span className="nav-icon"><Icon name={item.icon} size={18} /></span>
                  <span className="nav-label">{item.label}</span>
                </button>
              ))}
            </div>
          ))}
        </nav>

        <div className="sidebar-footer">
          <div className={`status-indicator ${supabaseStatus.connected ? 'connected' : 'disconnected'}`}>
            <span className="status-dot"></span>
            <span className="status-text">{supabaseStatus.message}</span>
          </div>
          <button className="sidebar-logout" onClick={handleLogout}>Sign Out</button>
        </div>
      </aside>

      {/* Main Content */}
      <main className="admin-main">
        {/* Header */}
        <header className="admin-header">
          <h1 className="page-title">
            {activePanel === 'overview' && 'Dashboard Overview'}
            {activePanel === 'products' && 'Product Manager'}
            {activePanel === 'blog' && 'Blog Manager'}
            {activePanel === 'stores' && 'Store Manager'}
            {activePanel === 'content' && 'Content Manager'}
            {activePanel === 'media' && 'Logo & Media'}
            {activePanel === 'mega-menu' && 'Mega Menu Editor'}
            {activePanel === 'collections' && 'Collections Editor'}
            {activePanel === 'users' && 'User Management'}
            {activePanel === 'import-export' && 'Import/Export'}
            {activePanel === 'settings' && 'Settings'}
            {activePanel === 'seo' && 'SEO Manager'}
            {activePanel === 'enquiries' && 'Enquiries'}
          </h1>
          <div className="header-actions">
            <button className="btn-secondary" onClick={toggleTheme} title={`Switch to ${theme === 'light' ? 'dark' : 'light'} mode`}>
              {theme === 'light' ? <Moon size={16} /> : <Sun size={16} />}
            </button>
            <button className="btn-secondary" onClick={handleLogout}>Logout</button>
          </div>
        </header>

        {/* Content Panels */}
        <div className="admin-content">

          {/* Overview Panel */}
          {activePanel === 'overview' && (
            <div className="panel-overview">
              <div className="metrics-grid">
                <div className="metric-card">
                  <div className="metric-icon"><Icon name="box" size={22} /></div>
                  <div className="metric-info">
                    <h3>Total Products</h3>
                    <p className="metric-value">{products.length}</p>
                  </div>
                </div>
                <div className="metric-card">
                  <div className="metric-icon"><Icon name="doc" size={22} /></div>
                  <div className="metric-info">
                    <h3>Blog Posts</h3>
                    <p className="metric-value">{blogPosts.length}</p>
                  </div>
                </div>
                <div className="metric-card">
                  <div className="metric-icon"><Icon name="store" size={22} /></div>
                  <div className="metric-info">
                    <h3>Stores</h3>
                    <p className="metric-value">{stores.length}</p>
                  </div>
                </div>
              </div>

              <div className="overview-sections">
                <section className="overview-section">
                  <h2>Recent Products</h2>
                  {products.length === 0 ? (
                    <p className="empty-state">No products yet</p>
                  ) : (
                    <div className="recent-list">
                      {products.slice(0, 5).map(product => (
                        <div key={product.id} className="recent-item">
                          <div>
                            <p className="recent-item-title">{product.name}</p>
                            <p className="recent-item-subtitle">{product.brand}</p>
                          </div>
                          <span className="recent-item-value">{product.category}</span>
                        </div>
                      ))}
                    </div>
                  )}
                </section>
              </div>
            </div>
          )}

          {/* Products Panel */}
          {activePanel === 'products' && (
            <div className="panel-products">
              <div className="panel-header">
                <div className="search-bar">
                  <input
                    type="text"
                    placeholder="Search products..."
                    value={productSearch}
                    onChange={(e) => setProductSearch(e.target.value)}
                    className="search-input"
                  />
                </div>
                <button
                  onClick={() => {
                    setEditingProduct(null);
                    setProductForm({});
                    setShowProductModal(true);
                  }}
                  className="btn-primary"
                >
                  + Add Product
                </button>
              </div>

              {loadingProducts ? (
                <div className="loading-state">
                  <div className="spinner"></div>
                  <p>Loading products...</p>
                </div>
              ) : products.length === 0 ? (
                <div className="empty-state-large">
                  <p>No products found</p>
                  <button
                    onClick={() => {
                      setEditingProduct(null);
                      setProductForm({});
                      setShowProductModal(true);
                    }}
                    className="btn-primary"
                  >
                    Create First Product
                  </button>
                </div>
              ) : (
                <div className="data-table">
                  <table>
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Category</th>
                        <th>Featured</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {products
                        .filter(p => p.name.toLowerCase().includes(productSearch.toLowerCase()))
                        .map(product => (
                          <tr key={product.id}>
                            <td>{product.name}</td>
                            <td>{product.brand}</td>
                            <td>{product.category}</td>
                            <td style={{ textAlign: 'center' }}>
                              <button
                                title={content.bestSellerIds?.includes(product.id) ? 'Remove from homepage' : 'Feature on homepage'}
                                style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '4px', color: content.bestSellerIds?.includes(product.id) ? '#ca7c29' : '#ccc', transition: 'color 0.2s' }}
                                onClick={async () => {
                                  const ids = content.bestSellerIds ?? [];
                                  const next = ids.includes(product.id)
                                    ? ids.filter(id => id !== product.id)
                                    : [...ids, product.id];
                                  updateContent({ bestSellerIds: next });
                                  // Targeted patch — avoids sending large base64 images
                                  try {
                                    await api.siteContent.patch({ bestSellerIds: next });
                                    addToast(next.includes(product.id) ? `"${product.name}" featured on homepage` : `"${product.name}" removed from homepage`, 'success');
                                  } catch {
                                    addToast('Saved locally — sync to cloud failed', 'info');
                                  }
                                  // Also update localStorage
                                  saveSiteContent({ ...content, bestSellerIds: next });
                                }}
                              >
                                <Star size={18} fill={content.bestSellerIds?.includes(product.id) ? '#ca7c29' : 'none'} />
                              </button>
                            </td>
                            <td>
                              <div className="action-buttons">
                                <button
                                  onClick={() => openEditProduct(product)}
                                  className="btn-action btn-edit"
                                  title="Edit"
                                >
                                  <Icon name="edit" size={15} />
                                </button>
                                <button
                                  onClick={() => handleDeleteProduct(product.id)}
                                  className="btn-action btn-delete"
                                  title="Delete"
                                >
                                  <Icon name="trash" size={15} />
                                </button>
                              </div>
                            </td>
                          </tr>
                        ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          )}

          {/* Blog Panel */}
          {activePanel === 'blog' && (
            <div className="panel-blog">
              <div className="panel-header">
                <div className="search-bar">
                  <input
                    type="text"
                    placeholder="Search blog posts..."
                    value={blogSearch}
                    onChange={(e) => setBlogSearch(e.target.value)}
                    className="search-input"
                  />
                </div>
                <button
                  onClick={() => {
                    setEditingBlog(null);
                    setBlogForm({});
                    setShowBlogModal(true);
                  }}
                  className="btn-primary"
                >
                  + New Post
                </button>
              </div>

              {loadingBlogs ? (
                <div className="loading-state">
                  <div className="spinner"></div>
                  <p>Loading blog posts...</p>
                </div>
              ) : blogPosts.length === 0 ? (
                <div className="empty-state-large">
                  <p>No blog posts found</p>
                  <button
                    onClick={() => {
                      setEditingBlog(null);
                      setBlogForm({});
                      setShowBlogModal(true);
                    }}
                    className="btn-primary"
                  >
                    Create First Post
                  </button>
                </div>
              ) : (
                <div className="blog-grid">
                  {blogPosts
                    .filter(b => b.title.toLowerCase().includes(blogSearch.toLowerCase()))
                    .map(blog => (
                      <div key={blog.id} className="blog-card">
                        <div className="blog-card-header">
                          <h3>{blog.title}</h3>
                          <span className={`published-badge ${blog.published ? 'published' : 'draft'}`}>
                            {blog.published ? 'Published' : 'Draft'}
                          </span>
                        </div>
                        <p className="blog-excerpt">{blog.excerpt}</p>
                        <p className="blog-meta">By {blog.author}</p>
                        <div className="blog-actions">
                          <button
                            onClick={() => openEditBlog(blog)}
                            className="btn-action btn-edit"
                          >
                            Edit
                          </button>
                          <button
                            onClick={() => handleDeleteBlog(blog.id)}
                            className="btn-action btn-delete"
                          >
                            <Icon name="trash" size={15} /> Delete
                          </button>
                        </div>
                      </div>
                    ))}
                </div>
              )}
            </div>
          )}

          {/* Stores Panel */}
          {activePanel === 'stores' && (
            <div className="panel-stores">
              <div className="panel-header">
                <div className="search-bar">
                  <input
                    type="text"
                    placeholder="Search stores..."
                    value={storeSearch}
                    onChange={(e) => setStoreSearch(e.target.value)}
                    className="search-input"
                  />
                </div>
                <button
                  onClick={() => {
                    setEditingStore(null);
                    setStoreForm({});
                    setShowStoreModal(true);
                  }}
                  className="btn-primary"
                >
                  + Add Store
                </button>
              </div>

              {loadingStores ? (
                <div className="loading-state">
                  <div className="spinner"></div>
                  <p>Loading stores...</p>
                </div>
              ) : stores.length === 0 ? (
                <div className="empty-state-large">
                  <p>No stores found</p>
                  <button
                    onClick={() => {
                      setEditingStore(null);
                      setStoreForm({});
                      setShowStoreModal(true);
                    }}
                    className="btn-primary"
                  >
                    Create First Store
                  </button>
                </div>
              ) : (
                <div className="stores-grid">
                  {stores
                    .filter(s => s.name.toLowerCase().includes(storeSearch.toLowerCase()))
                    .map(store => (
                      <div key={store.id} className="store-card">
                        <h3>{store.name}</h3>
                        <p className="store-detail"><strong>Address:</strong> {store.address}</p>
                        <p className="store-detail"><strong>City:</strong> {store.city}</p>
                        <p className="store-detail"><strong>Phone:</strong> {store.phone}</p>
                        <p className="store-detail"><strong>Email:</strong> {store.email}</p>
                        <div className="store-actions">
                          <button
                            onClick={() => openEditStore(store)}
                            className="btn-action btn-edit"
                          >
                            Edit
                          </button>
                          <button
                            onClick={() => handleDeleteStore(store.id)}
                            className="btn-action btn-delete"
                          >
                            <Icon name="trash" size={15} /> Delete
                          </button>
                        </div>
                      </div>
                    ))}
                </div>
              )}
            </div>
          )}

          {/* Content Manager Panel — edit text on every page */}
          {activePanel === 'content' && (
            <div className="panel-content">
              <h2>Content Manager</h2>
              <p className="text-gray-600">Edit the text shown on every page of your website.</p>
              <div style={{ maxWidth: '680px', marginTop: '20px', display: 'grid', gap: '14px' }}>
                <h3 style={{ marginTop: '8px' }}>Global</h3>
                <div className="form-group"><label>Announcement Bar</label>
                  <input className="form-input" value={content.announcement} onChange={(e) => updateContent({ announcement: e.target.value })} /></div>
                <div className="form-group"><label>Footer Tagline</label>
                  <input className="form-input" value={content.footerTagline} onChange={(e) => updateContent({ footerTagline: e.target.value })} /></div>

                <h3>Home Page</h3>
                <div className="form-group"><label>Hero Line 1</label>
                  <input className="form-input" value={content.heroLine1} onChange={(e) => updateContent({ heroLine1: e.target.value })} /></div>
                <div className="form-group"><label>Hero Line 2</label>
                  <input className="form-input" value={content.heroLine2} onChange={(e) => updateContent({ heroLine2: e.target.value })} /></div>
                <div className="form-group"><label>Explore Label</label>
                  <input className="form-input" value={content.exploreLabel} onChange={(e) => updateContent({ exploreLabel: e.target.value })} /></div>
                <div className="form-group"><label>Explore Title</label>
                  <input className="form-input" value={content.exploreTitle} onChange={(e) => updateContent({ exploreTitle: e.target.value })} /></div>
                <div className="form-group"><label>Best Sellers Title</label>
                  <input className="form-input" value={content.sellersTitle} onChange={(e) => updateContent({ sellersTitle: e.target.value })} /></div>
                <div className="form-group"><label>Quote Banner Text</label>
                  <textarea className="form-textarea" rows={2} value={content.quoteText} onChange={(e) => updateContent({ quoteText: e.target.value })} /></div>
                <div className="form-group"><label>CTA Headline</label>
                  <input className="form-input" value={content.ctaText} onChange={(e) => updateContent({ ctaText: e.target.value })} /></div>

                <h3>About Page</h3>
                <div className="form-group"><label>Kicker</label>
                  <input className="form-input" value={content.aboutKicker} onChange={(e) => updateContent({ aboutKicker: e.target.value })} /></div>
                <div className="form-group"><label>Hero Title</label>
                  <input className="form-input" value={content.aboutTitle} onChange={(e) => updateContent({ aboutTitle: e.target.value })} /></div>
                <div className="form-group"><label>Hero Lead paragraph</label>
                  <textarea className="form-textarea" rows={3} value={content.aboutLead} onChange={(e) => updateContent({ aboutLead: e.target.value })} /></div>

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>Brand Story Section</p>
                <div className="form-group"><label>Section Title</label>
                  <input className="form-input" value={content.aboutStoryTitle} onChange={(e) => updateContent({ aboutStoryTitle: e.target.value })} /></div>
                <div className="form-group"><label>Paragraph 1</label>
                  <textarea className="form-textarea" rows={3} value={content.aboutStoryBody1} onChange={(e) => updateContent({ aboutStoryBody1: e.target.value })} /></div>
                <div className="form-group"><label>Paragraph 2</label>
                  <textarea className="form-textarea" rows={3} value={content.aboutStoryBody2} onChange={(e) => updateContent({ aboutStoryBody2: e.target.value })} /></div>

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>Why People Choose Xpel Beauty Care (values list)</p>
                {(['aboutValue1','aboutValue2','aboutValue3','aboutValue4','aboutValue5'] as const).map((k,i) => (
                  <div className="form-group" key={k}><label>Value {i+1}</label>
                    <input className="form-input" value={(content as never)[k]} onChange={(e) => updateContent({ [k]: e.target.value })} /></div>
                ))}

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>Brand Pillars</p>
                {([1,2,3,4] as const).map((n) => (
                  <div key={n} style={{background:'#f9f9f9',padding:'12px',borderRadius:'8px',marginBottom:'10px'}}>
                    <div className="form-group"><label>Pillar {n} Title</label>
                      <input className="form-input" value={(content as never)[`pillar${n}Title`]} onChange={(e) => updateContent({ [`pillar${n}Title`]: e.target.value })} /></div>
                    <div className="form-group"><label>Pillar {n} Description</label>
                      <textarea className="form-textarea" rows={2} value={(content as never)[`pillar${n}Desc`]} onChange={(e) => updateContent({ [`pillar${n}Desc`]: e.target.value })} /></div>
                  </div>
                ))}

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>3-Step Plan</p>
                {([1,2,3] as const).map((n) => (
                  <div key={n} style={{background:'#f9f9f9',padding:'12px',borderRadius:'8px',marginBottom:'10px'}}>
                    <div className="form-group"><label>Step {n} Title</label>
                      <input className="form-input" value={(content as never)[`step${n}Title`]} onChange={(e) => updateContent({ [`step${n}Title`]: e.target.value })} /></div>
                    <div className="form-group"><label>Step {n} Description</label>
                      <textarea className="form-textarea" rows={2} value={(content as never)[`step${n}Desc`]} onChange={(e) => updateContent({ [`step${n}Desc`]: e.target.value })} /></div>
                  </div>
                ))}

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>Mission &amp; Vision</p>
                <div className="form-group"><label>Mission Text</label>
                  <textarea className="form-textarea" rows={3} value={content.aboutMission} onChange={(e) => updateContent({ aboutMission: e.target.value })} /></div>
                <div className="form-group"><label>Vision Text</label>
                  <textarea className="form-textarea" rows={3} value={content.aboutVision} onChange={(e) => updateContent({ aboutVision: e.target.value })} /></div>

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>About CTA Banner</p>
                <div className="form-group"><label>CTA Title</label>
                  <input className="form-input" value={content.aboutCtaTitle} onChange={(e) => updateContent({ aboutCtaTitle: e.target.value })} /></div>
                <div className="form-group"><label>CTA Text</label>
                  <textarea className="form-textarea" rows={2} value={content.aboutCtaText} onChange={(e) => updateContent({ aboutCtaText: e.target.value })} /></div>

                <p className="help-text" style={{marginTop:'12px',fontWeight:600}}>Home — Feature Blocks</p>
                {([1,2,3] as const).map((n) => (
                  <div key={n} style={{background:'#f9f9f9',padding:'12px',borderRadius:'8px',marginBottom:'10px'}}>
                    <p style={{fontWeight:600,marginBottom:'8px',fontSize:'0.85rem'}}>Feature Block {n}</p>
                    <div className="form-group"><label>Kicker</label>
                      <input className="form-input" value={(content as never)[`feat${n}Kicker`]} onChange={(e) => updateContent({ [`feat${n}Kicker`]: e.target.value })} /></div>
                    <div className="form-group"><label>Title</label>
                      <input className="form-input" value={(content as never)[`feat${n}Title`]} onChange={(e) => updateContent({ [`feat${n}Title`]: e.target.value })} /></div>
                    <div className="form-group"><label>Body Text</label>
                      <textarea className="form-textarea" rows={2} value={(content as never)[`feat${n}Text`]} onChange={(e) => updateContent({ [`feat${n}Text`]: e.target.value })} /></div>
                    <div className="form-group"><label>Link URL</label>
                      <input className="form-input" value={(content as never)[`feat${n}Href`]} onChange={(e) => updateContent({ [`feat${n}Href`]: e.target.value })} /></div>
                  </div>
                ))}

                <h3 style={{marginTop:'16px'}}>Footer Contact</h3>
                <div className="form-group"><label>Company Name</label>
                  <input className="form-input" value={content.footerCompany} onChange={(e) => updateContent({ footerCompany: e.target.value })} /></div>
                <div className="form-group"><label>Address</label>
                  <input className="form-input" value={content.footerAddress} onChange={(e) => updateContent({ footerAddress: e.target.value })} /></div>
                <div className="form-group"><label>Phone 1</label>
                  <input className="form-input" value={content.footerPhone1} onChange={(e) => updateContent({ footerPhone1: e.target.value })} /></div>
                <div className="form-group"><label>Phone 2</label>
                  <input className="form-input" value={content.footerPhone2} onChange={(e) => updateContent({ footerPhone2: e.target.value })} /></div>
                <div className="form-group"><label>Email</label>
                  <input className="form-input" value={content.footerEmail} onChange={(e) => updateContent({ footerEmail: e.target.value })} /></div>

                <h3>Shop Page</h3>
                <div className="form-group"><label>Title</label>
                  <input className="form-input" value={content.shopTitle} onChange={(e) => updateContent({ shopTitle: e.target.value })} /></div>
                <div className="form-group"><label>Subtitle</label>
                  <input className="form-input" value={content.shopSubtitle} onChange={(e) => updateContent({ shopSubtitle: e.target.value })} /></div>

                <h3>Contact Page</h3>
                <div className="form-group"><label>Title</label>
                  <input className="form-input" value={content.contactTitle} onChange={(e) => updateContent({ contactTitle: e.target.value })} /></div>
                <div className="form-group"><label>Intro</label>
                  <input className="form-input" value={content.contactIntro} onChange={(e) => updateContent({ contactIntro: e.target.value })} /></div>

                <h3>Stores Page</h3>
                <div className="form-group"><label>Title</label>
                  <input className="form-input" value={content.storesTitle} onChange={(e) => updateContent({ storesTitle: e.target.value })} /></div>
                <div className="form-group"><label>Intro</label>
                  <input className="form-input" value={content.storesIntro} onChange={(e) => updateContent({ storesIntro: e.target.value })} /></div>

                <h3>Blog Page</h3>
                <div className="form-group"><label>Title</label>
                  <input className="form-input" value={content.blogTitle} onChange={(e) => updateContent({ blogTitle: e.target.value })} /></div>
                <div className="form-group"><label>Intro</label>
                  <input className="form-input" value={content.blogIntro} onChange={(e) => updateContent({ blogIntro: e.target.value })} /></div>

                <div><button className="btn-primary" onClick={saveContent}>Save All Content</button></div>
              </div>
            </div>
          )}

          {/* Logo, Banner & Media Panel — with uploads */}
          {activePanel === 'media' && (
            <div className="panel-content">
              <h2>Logo, Banner &amp; Media</h2>
              <p className="text-gray-600">Upload your logo, promo banner and homepage carousel slides.</p>
              <div style={{ maxWidth: '680px', marginTop: '20px', display: 'grid', gap: '18px' }}>

                <h3>Site Logo</h3>
                <div style={{ background: '#1B2A3B', padding: '24px', borderRadius: '12px', display: 'flex', justifyContent: 'center' }}>
                  <img src={content.logo} alt="Logo preview" style={{ maxHeight: '60px', maxWidth: '100%', objectFit: 'contain' }}
                    onError={(e) => { (e.target as HTMLImageElement).src = '/images/logo-white.svg'; }} />
                </div>
                <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, 'logo')} />
                <div className="form-group"><label>…or paste a Logo URL</label>
                  <input className="form-input" value={content.logo.startsWith('data:') ? '' : content.logo} onChange={(e) => updateContent({ logo: e.target.value })} placeholder="https://… or images/logo.png" /></div>

                <h3>Promo Banner</h3>
                <p className="help-text">A wide banner image shown on the homepage. Recommended ~1600×500px, under 1.5 MB.</p>
                {content.banner && (
                  <img src={content.banner} alt="Banner preview" style={{ width: '100%', borderRadius: '12px', border: '1px solid #e8e8e8', objectFit: 'cover', maxHeight: '180px' }} />
                )}
                <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, 'banner')} />
                <div className="form-group"><label>…or paste a Banner URL</label>
                  <input className="form-input" value={content.banner.startsWith('data:') ? '' : content.banner} onChange={(e) => updateContent({ banner: e.target.value })} placeholder="https://…" /></div>
                {content.banner && (
                  <div><button className="btn-danger btn-sm" onClick={() => updateContent({ banner: '' })}>Remove Banner</button></div>
                )}

                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '10px', margin: '8px 0 4px' }}>
                  <div>
                    <h3 style={{ margin: 0 }}>Hero Banner Slides</h3>
                    <p className="help-text" style={{ margin: '4px 0 0' }}>Edit the image, all text, button label, button colour and button link for each slide. Click <strong>Save Media</strong> below when done.</p>
                  </div>
                  <button className="btn-primary" onClick={saveContent} style={{ flexShrink: 0 }}>Save Slides</button>
                </div>
                {(content.heroSlides ?? []).map((slide, i) => (
                  <details key={i} style={{ border: '1px solid #e8e8e8', borderRadius: '10px', marginBottom: '12px', overflow: 'hidden' }}>
                    <summary style={{ padding: '14px 18px', cursor: 'pointer', fontWeight: '600', background: '#fafafa', display: 'flex', alignItems: 'center', gap: '10px' }}>
                      <span style={{ background: 'var(--gold-raw)', color: '#fff', borderRadius: '50%', width: '22px', height: '22px', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', fontSize: '12px', fontWeight: '700', flexShrink: 0 }}>{i + 1}</span>
                      <span style={{ flex: 1 }}>Slide {i + 1} — {slide.subLabel || 'untitled'} {slide.headlineLine1}</span>
                      <button
                        type="button"
                        onClick={(e) => { e.preventDefault(); removeHeroSlide(i); }}
                        style={{ background: '#fee2e2', color: '#b91c1c', border: 'none', borderRadius: '6px', padding: '4px 10px', fontSize: '12px', fontWeight: '600', cursor: 'pointer' }}
                      >Delete</button>
                    </summary>
                    <div style={{ padding: '16px 18px', display: 'grid', gap: '10px' }}>
                      {/* Image */}
                      {slide.image && (
                        <img src={slide.image} alt="" style={{ width: '100%', maxHeight: '140px', objectFit: 'cover', borderRadius: '8px' }}
                          onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                      )}
                      <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, { heroSlide: i })} />
                      <div className="form-group"><label>…or paste image URL</label>
                        <input className="form-input" value={slide.image?.startsWith('data:') ? '' : (slide.image ?? '')} onChange={(e) => updateHeroSlide(i, { image: e.target.value })} placeholder="/banner/banner 1.webp" /></div>
                      {/* Overlay colour */}
                      <div className="form-group">
                        <label>Overlay colour (text background)</label>
                        <p className="help-text">Pick a colour, then adjust the opacity number (0 = transparent, 1 = solid) in the rgba field.</p>
                        <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                          <input
                            type="color"
                            value={(() => {
                              const m = (slide.overlayColor ?? '').match(/rgba?\((\d+),\s*(\d+),\s*(\d+)/);
                              if (!m) return '#1c0a02';
                              return '#' + [m[1],m[2],m[3]].map(n => parseInt(n).toString(16).padStart(2,'0')).join('');
                            })()}
                            onChange={(e) => {
                              const r = parseInt(e.target.value.slice(1,3),16);
                              const g = parseInt(e.target.value.slice(3,5),16);
                              const b = parseInt(e.target.value.slice(5,7),16);
                              const currentAlpha = (slide.overlayColor ?? '').match(/[\d.]+\)$/)?.[0]?.replace(')','') ?? '0.88';
                              updateHeroSlide(i, { overlayColor: `rgba(${r},${g},${b},${currentAlpha})` });
                            }}
                            style={{ width: '44px', height: '36px', border: 'none', borderRadius: '6px', cursor: 'pointer', padding: '2px' }}
                          />
                          <input className="form-input" value={slide.overlayColor ?? ''} onChange={(e) => updateHeroSlide(i, { overlayColor: e.target.value })} placeholder="rgba(28,10,2,0.88)" style={{ flex: 1 }} />
                        </div>
                      </div>
                      {/* Layer 1 */}
                      <div className="form-group"><label>Brand lockup (small caps line)</label>
                        <input className="form-input" value={slide.brandLockup ?? ''} onChange={(e) => updateHeroSlide(i, { brandLockup: e.target.value })} placeholder="xbc® | xpel beauty care" /></div>
                      {/* Layer 2 */}
                      <div className="form-group"><label>Sub-range label (bold italic)</label>
                        <input className="form-input" value={slide.subLabel ?? ''} onChange={(e) => updateHeroSlide(i, { subLabel: e.target.value })} placeholder="so fresh" /></div>
                      {/* Layer 3 */}
                      <div className="form-group"><label>Headline — line 1</label>
                        <input className="form-input" value={slide.headlineLine1 ?? ''} onChange={(e) => updateHeroSlide(i, { headlineLine1: e.target.value })} placeholder="Watermelon" /></div>
                      <div className="form-group"><label>Headline — line 2</label>
                        <input className="form-input" value={slide.headlineLine2 ?? ''} onChange={(e) => updateHeroSlide(i, { headlineLine2: e.target.value })} placeholder="Crush" /></div>
                      <div className="form-group"><label>Headline colour (hex)</label>
                        <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                          <input type="color" value={slide.headlineColor ?? '#ffffff'} onChange={(e) => updateHeroSlide(i, { headlineColor: e.target.value })} style={{ width: '44px', height: '36px', border: 'none', borderRadius: '6px', cursor: 'pointer', padding: '2px' }} />
                          <input className="form-input" value={slide.headlineColor ?? ''} onChange={(e) => updateHeroSlide(i, { headlineColor: e.target.value })} placeholder="#7ED957" style={{ flex: 1 }} />
                        </div>
                      </div>
                      {/* Layer 4 */}
                      <div className="form-group"><label>Product descriptor line</label>
                        <input className="form-input" value={slide.descriptor ?? ''} onChange={(e) => updateHeroSlide(i, { descriptor: e.target.value })} placeholder="Complete Hydrating Skincare Collection" /></div>
                      {/* Layer 5 */}
                      <div className="form-group"><label>Benefit line 1</label>
                        <input className="form-input" value={slide.benefits?.[0] ?? ''} onChange={(e) => updateHeroSlideBenefit(i, 0, e.target.value)} placeholder="Deeply hydrates with Hyaluronic Acid" /></div>
                      <div className="form-group"><label>Benefit line 2</label>
                        <input className="form-input" value={slide.benefits?.[1] ?? ''} onChange={(e) => updateHeroSlideBenefit(i, 1, e.target.value)} placeholder="Brightens with Vitamin C + Vitamin E" /></div>
                      <div className="form-group"><label>Benefit line 3</label>
                        <input className="form-input" value={slide.benefits?.[2] ?? ''} onChange={(e) => updateHeroSlideBenefit(i, 2, e.target.value)} placeholder="Soothes with Watermelon Extract" /></div>
                      {/* Layer 6 */}
                      <div className="form-group"><label>Vegan badge text (leave blank to hide)</label>
                        <input className="form-input" value={slide.vegaBadge ?? ''} onChange={(e) => updateHeroSlide(i, { vegaBadge: e.target.value })} placeholder="Natural Vegan Ingredients" /></div>
                      {/* Layer 7 */}
                      <div className="form-group"><label>CTA button label</label>
                        <input className="form-input" value={slide.ctaLabel ?? ''} onChange={(e) => updateHeroSlide(i, { ctaLabel: e.target.value })} placeholder="discover the range" /></div>
                      <div className="form-group"><label>CTA button link</label>
                        <input className="form-input" value={slide.ctaHref ?? ''} onChange={(e) => updateHeroSlide(i, { ctaHref: e.target.value })} placeholder="/shop?cat=body-beauty" /></div>
                      <div className="form-group"><label>CTA button background colour</label>
                        <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                          <input type="color" value={slide.ctaBg ?? '#1B6B2E'} onChange={(e) => updateHeroSlide(i, { ctaBg: e.target.value })} style={{ width: '44px', height: '36px', border: 'none', borderRadius: '6px', cursor: 'pointer', padding: '2px' }} />
                          <input className="form-input" value={slide.ctaBg ?? ''} onChange={(e) => updateHeroSlide(i, { ctaBg: e.target.value })} placeholder="#1B6B2E" style={{ flex: 1 }} />
                        </div>
                      </div>
                      <div className="form-group"><label>CTA button text colour</label>
                        <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
                          <input type="color" value={slide.ctaColor ?? '#ffffff'} onChange={(e) => updateHeroSlide(i, { ctaColor: e.target.value })} style={{ width: '44px', height: '36px', border: 'none', borderRadius: '6px', cursor: 'pointer', padding: '2px' }} />
                          <input className="form-input" value={slide.ctaColor ?? ''} onChange={(e) => updateHeroSlide(i, { ctaColor: e.target.value })} placeholder="#ffffff" style={{ flex: 1 }} />
                        </div>
                      </div>
                    </div>
                  </details>
                ))}

                <button
                  type="button"
                  onClick={addHeroSlide}
                  style={{ display: 'flex', alignItems: 'center', gap: '8px', background: 'var(--gold-raw)', color: '#fff', border: 'none', borderRadius: '8px', padding: '10px 18px', fontWeight: '600', fontSize: '14px', cursor: 'pointer', marginBottom: '24px' }}
                >
                  <span style={{ fontSize: '18px', lineHeight: 1 }}>+</span> Add New Slide
                </button>

                <h3>Category / Range Images (homepage)</h3>
                {content.catImages.map((s, i) => (
                  <div key={i} style={{ display: 'grid', gap: '8px', paddingBottom: '12px', borderBottom: '1px solid #eee' }}>
                    <img src={s} alt={`Range ${i + 1}`} style={{ width: '100%', maxHeight: '110px', objectFit: 'cover', borderRadius: '8px' }}
                      onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                    <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, { arr: 'catImages', i })} />
                    <input className="form-input" value={s.startsWith('data:') ? '' : s} onChange={(e) => updateArrayImage('catImages', i, e.target.value)} placeholder={`Range ${i + 1} URL`} />
                  </div>
                ))}

                <h3>Feature Section Images (homepage)</h3>
                {content.featureImages.map((s, i) => (
                  <div key={i} style={{ display: 'grid', gap: '8px', paddingBottom: '12px', borderBottom: '1px solid #eee' }}>
                    <img src={s} alt={`Feature ${i + 1}`} style={{ width: '100%', maxHeight: '110px', objectFit: 'cover', borderRadius: '8px' }}
                      onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                    <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, { arr: 'featureImages', i })} />
                    <input className="form-input" value={s.startsWith('data:') ? '' : s} onChange={(e) => updateArrayImage('featureImages', i, e.target.value)} placeholder={`Feature ${i + 1} URL`} />
                  </div>
                ))}

                <h3>Home Quote Background</h3>
                <p className="help-text">Background image behind the "True beauty begins with self-care" quote band.</p>
                {content.quoteImage && (
                  <img src={content.quoteImage} alt="" style={{ width: '100%', maxHeight: '120px', objectFit: 'cover', borderRadius: '8px' }}
                    onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                )}
                <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, 'quoteImage')} />
                <input className="form-input" value={content.quoteImage.startsWith('data:') ? '' : content.quoteImage} onChange={(e) => updateContent({ quoteImage: e.target.value })} placeholder="…or paste image URL" />

                <h3>Home CTA Background</h3>
                <p className="help-text">Background image behind the "ready to reveal the beauty within yourself?" section.</p>
                {content.ctaImage && (
                  <img src={content.ctaImage} alt="" style={{ width: '100%', maxHeight: '120px', objectFit: 'cover', borderRadius: '8px' }}
                    onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                )}
                <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, 'ctaImage')} />
                <input className="form-input" value={content.ctaImage.startsWith('data:') ? '' : content.ctaImage} onChange={(e) => updateContent({ ctaImage: e.target.value })} placeholder="…or paste image URL" />

                <h3>About Page — Category Card Images</h3>
                <p className="help-text">The 7 product-category cards on the About page.</p>
                {(['Facial Care','Body Care','Hair Care','Hand Care','Foot Care','Oral Care','Nail Care'] as const).map((label, i) => (
                  <div key={label} style={{ display: 'grid', gap: '6px', padding: '12px', marginBottom: '10px', border: '1px solid #eef0f4', borderRadius: '10px', background: '#fafbfd' }}>
                    <strong style={{ fontSize: '0.85rem' }}>{label}</strong>
                    {content.aboutCatImages?.[i] && (
                      <img src={content.aboutCatImages[i]} alt="" style={{ width: '100%', maxHeight: '100px', objectFit: 'cover', borderRadius: '6px' }}
                        onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                    )}
                    <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, { arr: 'aboutCatImages', i })} />
                    <input className="form-input" value={(content.aboutCatImages?.[i] ?? '').startsWith('data:') ? '' : (content.aboutCatImages?.[i] ?? '')} onChange={(e) => updateArrayImage('aboutCatImages', i, e.target.value)} placeholder={`/banner/Product-${label.replace(' ','-')}.webp`} />
                  </div>
                ))}

                <h3>About Page — CTA Section Background</h3>
                {content.aboutCtaImage && (
                  <img src={content.aboutCtaImage} alt="" style={{ width: '100%', maxHeight: '120px', objectFit: 'cover', borderRadius: '8px', marginBottom: '8px' }}
                    onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                )}
                <input type="file" accept="image/*" className="file-input" onChange={(e) => handleUpload(e, 'aboutCtaImage')} />
                <input className="form-input" value={(content.aboutCtaImage || '').startsWith('data:') ? '' : (content.aboutCtaImage || '')} onChange={(e) => updateContent({ aboutCtaImage: e.target.value })} placeholder="/banner/banner4.png" />

                <h3>Page Banners (image + text)</h3>
                <p className="help-text">Each banner shows on its page with the text overlaid on the left. Upload an image and edit the text.</p>
                {([
                  { key: 'shopHero' as const, label: 'Shop top hero banner' },
                  { key: 'shop' as const, label: 'Shop bottom banner' },
                  { key: 'stores' as const, label: 'Stores page banner' },
                  { key: 'blog' as const, label: 'Blog page banner' },
                  { key: 'contact' as const, label: 'Contact page banner' },
                ]).map(({ key, label }) => {
                  const b = content.banners[key];
                  return (
                    <div key={key} style={{ display: 'grid', gap: '8px', padding: '14px', marginBottom: '12px', border: '1px solid #eef0f4', borderRadius: '12px', background: '#fafbfd' }}>
                      <strong>{label}</strong>
                      {b.image && (
                        <img src={b.image} alt="" style={{ width: '100%', maxHeight: '120px', objectFit: 'cover', borderRadius: '8px' }}
                          onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                      )}
                      <input type="file" accept="image/*" className="file-input" onChange={(e) => uploadBannerImage(e, key)} />
                      <input className="form-input" value={b.image.startsWith('data:') ? '' : b.image} onChange={(e) => updateBanner(key, { image: e.target.value })} placeholder="…or paste image URL (e.g. /banner/Product-Body-Care.webp)" />
                      {key === 'shopHero' && (
                        <input className="form-input" value={b.kicker || ''} onChange={(e) => updateBanner(key, { kicker: e.target.value })} placeholder="Small kicker text (e.g. body & beauty)" />
                      )}
                      <input className="form-input" value={b.title} onChange={(e) => updateBanner(key, { title: e.target.value })} placeholder="Banner title" />
                      <input className="form-input" value={b.text} onChange={(e) => updateBanner(key, { text: e.target.value })} placeholder="Banner text" />
                      {key !== 'shopHero' && (
                        <div style={{ display: 'flex', gap: '8px' }}>
                          <input className="form-input" style={{ flex: 1 }} value={b.cta} onChange={(e) => updateBanner(key, { cta: e.target.value })} placeholder="Button label (optional)" />
                          <input className="form-input" style={{ flex: 1 }} value={b.href} onChange={(e) => updateBanner(key, { href: e.target.value })} placeholder="Button link (e.g. /about)" />
                        </div>
                      )}
                    </div>
                  );
                })}

                <div><button className="btn-primary" onClick={saveContent}>Save Media</button></div>
              </div>
            </div>
          )}

          {/* ── Mega Menu Editor ─────────────────────────────────── */}
          {activePanel === 'mega-menu' && (() => {
            const mm: MegaMenuConfig = content.megaMenu ?? { categories: [], brandGroups: [], feature: { image: '', label: '', title: '', href: '', btnText: '' } };
            const setMm = (patch: Partial<MegaMenuConfig>) => updateContent({ megaMenu: { ...mm, ...patch } });

            return (
              <div className="panel-content">
                <h2>Mega Menu Editor</h2>
                <p className="text-gray-600">Edit the navigation mega menu — categories, brand groups, items and the feature panel. Click <strong>Save Mega Menu</strong> when done.</p>
                <div style={{ textAlign: 'right', marginBottom: '16px' }}>
                  <button className="btn-primary" onClick={saveContent}>Save Mega Menu</button>
                </div>

                {/* ── Section 1: Categories ── */}
                <section style={{ border: '1px solid var(--border)', borderRadius: '10px', padding: '18px', marginBottom: '20px' }}>
                  <h3 style={{ marginTop: 0 }}>Shop by Range (Categories)</h3>
                  <p className="help-text">These appear in the first column of the mega menu. Each entry links to <code>/shop?cat=slug</code>.</p>
                  <table className="data-table" style={{ marginBottom: '12px' }}>
                    <thead><tr><th>Label</th><th>Slug</th><th></th></tr></thead>
                    <tbody>
                      {mm.categories.map((cat, ci) => (
                        <tr key={ci}>
                          <td>
                            <input className="form-input" value={cat.label}
                              onChange={e => { const cats = mm.categories.map((c,i) => i===ci ? {...c, label: e.target.value} : c); setMm({ categories: cats }); }}
                            />
                          </td>
                          <td>
                            <input className="form-input" value={cat.slug}
                              onChange={e => { const cats = mm.categories.map((c,i) => i===ci ? {...c, slug: e.target.value} : c); setMm({ categories: cats }); }}
                              placeholder="e.g. hair-care"
                            />
                          </td>
                          <td>
                            <button className="btn-danger btn-sm" onClick={() => setMm({ categories: mm.categories.filter((_,i) => i!==ci) })}>✕</button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  <button className="btn-secondary btn-sm" onClick={() => setMm({ categories: [...mm.categories, { label: '', slug: '' }] })}>+ Add Category</button>
                </section>

                {/* ── Section 2: Brand Groups ── */}
                <section style={{ border: '1px solid var(--border)', borderRadius: '10px', padding: '18px', marginBottom: '20px' }}>
                  <h3 style={{ marginTop: 0 }}>Brand / Range Groups</h3>
                  <p className="help-text">Each group becomes a column in the mega menu. Items have a display name and a URL (use <code>/shop?brand=Name</code> or any page path).</p>

                  {mm.brandGroups.map((grp, gi) => (
                    <details key={gi} style={{ border: '1px solid #e8e8e8', borderRadius: '8px', marginBottom: '10px', overflow: 'hidden' }}>
                      <summary style={{ padding: '10px 14px', cursor: 'pointer', fontWeight: 600, background: '#fafafa', display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <span style={{ flex: 1 }}>{grp.group || `Group ${gi + 1}`}</span>
                        <button type="button" onClick={e => { e.preventDefault(); if (window.confirm('Delete this group?')) setMm({ brandGroups: mm.brandGroups.filter((_,i) => i!==gi) }); }}
                          style={{ background: '#fee2e2', color: '#b91c1c', border: 'none', borderRadius: '6px', padding: '3px 8px', fontSize: '12px', cursor: 'pointer' }}>Delete group</button>
                      </summary>
                      <div style={{ padding: '14px 16px' }}>
                        <div className="form-group" style={{ marginBottom: '10px' }}>
                          <label>Group heading</label>
                          <input className="form-input" value={grp.group}
                            onChange={e => { const groups = mm.brandGroups.map((g,i) => i===gi ? {...g, group: e.target.value} : g); setMm({ brandGroups: groups }); }}
                            placeholder="e.g. Specialist Ranges"
                          />
                        </div>
                        <table className="data-table" style={{ marginBottom: '10px' }}>
                          <thead><tr><th>Display Name</th><th>Link URL</th><th></th></tr></thead>
                          <tbody>
                            {grp.items.map((item, ii) => (
                              <tr key={ii}>
                                <td>
                                  <input className="form-input" value={item.name}
                                    onChange={e => {
                                      const groups = mm.brandGroups.map((g,i) => i!==gi ? g : { ...g, items: g.items.map((it,j) => j===ii ? {...it, name: e.target.value} : it) });
                                      setMm({ brandGroups: groups });
                                    }}
                                    placeholder="Tea Tree"
                                  />
                                </td>
                                <td>
                                  <input className="form-input" value={item.href}
                                    onChange={e => {
                                      const groups = mm.brandGroups.map((g,i) => i!==gi ? g : { ...g, items: g.items.map((it,j) => j===ii ? {...it, href: e.target.value} : it) });
                                      setMm({ brandGroups: groups });
                                    }}
                                    placeholder="/shop?brand=Tea%20Tree"
                                  />
                                </td>
                                <td>
                                  <button className="btn-danger btn-sm" onClick={() => {
                                    const groups = mm.brandGroups.map((g,i) => i!==gi ? g : { ...g, items: g.items.filter((_,j) => j!==ii) });
                                    setMm({ brandGroups: groups });
                                  }}>✕</button>
                                </td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                        <button className="btn-secondary btn-sm" onClick={() => {
                          const groups = mm.brandGroups.map((g,i) => i!==gi ? g : { ...g, items: [...g.items, { name: '', href: '' }] });
                          setMm({ brandGroups: groups });
                        }}>+ Add Item</button>
                      </div>
                    </details>
                  ))}

                  <button className="btn-secondary" style={{ marginTop: '8px' }} onClick={() => setMm({ brandGroups: [...mm.brandGroups, { group: '', items: [] }] })}>+ Add Group</button>
                </section>

                {/* ── Section 3: Feature Panel ── */}
                <section style={{ border: '1px solid var(--border)', borderRadius: '10px', padding: '18px', marginBottom: '20px' }}>
                  <h3 style={{ marginTop: 0 }}>Feature Panel (right column)</h3>
                  <p className="help-text">The image card shown on the far right of the mega menu.</p>
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '10px' }}>
                    <div className="form-group">
                      <label>Image URL</label>
                      <input className="form-input" value={mm.feature.image}
                        onChange={e => setMm({ feature: { ...mm.feature, image: e.target.value } })}
                        placeholder="/images/brand-tea-tree.webp"
                      />
                      {mm.feature.image && (
                        <img src={mm.feature.image} alt="" style={{ marginTop: '8px', maxHeight: '80px', borderRadius: '6px', objectFit: 'cover' }}
                          onError={e => { (e.target as HTMLImageElement).style.display='none'; }} />
                      )}
                    </div>
                    <div style={{ display: 'grid', gap: '8px' }}>
                      <div className="form-group">
                        <label>Label (small text)</label>
                        <input className="form-input" value={mm.feature.label} onChange={e => setMm({ feature: { ...mm.feature, label: e.target.value } })} placeholder="New Arrivals" />
                      </div>
                      <div className="form-group">
                        <label>Title</label>
                        <input className="form-input" value={mm.feature.title} onChange={e => setMm({ feature: { ...mm.feature, title: e.target.value } })} placeholder="Tea Tree Collection" />
                      </div>
                      <div className="form-group">
                        <label>Button text</label>
                        <input className="form-input" value={mm.feature.btnText} onChange={e => setMm({ feature: { ...mm.feature, btnText: e.target.value } })} placeholder="Shop Now" />
                      </div>
                      <div className="form-group">
                        <label>Button link</label>
                        <input className="form-input" value={mm.feature.href} onChange={e => setMm({ feature: { ...mm.feature, href: e.target.value } })} placeholder="/shop?brand=Tea%20Tree" />
                      </div>
                    </div>
                  </div>
                </section>

                <div style={{ textAlign: 'right' }}>
                  <button className="btn-primary" onClick={saveContent}>Save Mega Menu</button>
                </div>
              </div>
            );
          })()}

          {/* Users Panel */}
          {activePanel === 'users' && (
            <div className="panel-content">
              <h2>User Management</h2>
              <p className="text-gray-600">Add admin users who can log in with their own username and password.</p>

              {/* Add user form */}
              <div style={{ background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: '10px', padding: '20px', margin: '20px 0' }}>
                <h3 style={{ margin: '0 0 14px', fontSize: '15px', fontWeight: 700 }}>Add New User</h3>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))', gap: '10px' }}>
                  <input
                    type="text" placeholder="Username (for login)"
                    value={userForm.username}
                    onChange={(e) => setUserForm({ ...userForm, username: e.target.value })}
                    className="form-input"
                  />
                  <input
                    type="text" placeholder="Full name"
                    value={userForm.name}
                    onChange={(e) => setUserForm({ ...userForm, name: e.target.value })}
                    className="form-input"
                  />
                  <input
                    type="email" placeholder="Email (optional)"
                    value={userForm.email}
                    onChange={(e) => setUserForm({ ...userForm, email: e.target.value })}
                    className="form-input"
                  />
                  <input
                    type="password" placeholder="Password (min 6 chars)"
                    value={userForm.password}
                    onChange={(e) => setUserForm({ ...userForm, password: e.target.value })}
                    className="form-input"
                  />
                  <select
                    value={userForm.role}
                    onChange={(e) => setUserForm({ ...userForm, role: e.target.value as AdminUser['role'] })}
                    className="form-input"
                  >
                    <option>Admin</option>
                    <option>Editor</option>
                    <option>Viewer</option>
                  </select>
                </div>
                <button className="btn-primary" style={{ marginTop: '12px' }} onClick={addUser}>
                  Add User
                </button>
              </div>

              <table className="data-table">
                <thead>
                  <tr>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {adminUsers.length === 0 && (
                    <tr><td colSpan={5} style={{ textAlign: 'center', color: 'var(--text-muted)', padding: '24px' }}>No additional users yet.</td></tr>
                  )}
                  {adminUsers.map((u) => (
                    <tr key={u.id}>
                      <td><code style={{ fontSize: '13px' }}>{u.username || '—'}</code></td>
                      <td>{u.name}</td>
                      <td>{u.email || '—'}</td>
                      <td><span className="badge badge-success">{u.role}</span></td>
                      <td style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
                        <button className="btn-secondary btn-sm" onClick={() => resetUserPassword(u.id)}>
                          Reset Password
                        </button>
                        <button className="btn-danger btn-sm" onClick={() => deleteUser(u.id)}>
                          Remove
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>

              <div style={{ marginTop: '16px', padding: '12px 16px', background: 'var(--bg-card)', border: '1px solid var(--border)', borderRadius: '8px', fontSize: '13px', color: 'var(--text-muted)', lineHeight: 1.6 }}>
                <strong>Note:</strong> The primary admin account (<code>{ADMIN_USER}</code>) is set via environment variables and does not appear in this list. Additional users added here are saved to the cloud and can log in from any device or browser.
              </div>
            </div>
          )}

          {/* Import/Export Panel */}
          {activePanel === 'import-export' && (
            <div className="panel-import-export">
              <div className="import-export-grid">
                <section className="import-export-section">
                  <h2>Import Data</h2>
                  <div className="import-group">
                    <h3>Import Products</h3>
                    <input
                      type="file"
                      accept=".csv"
                      onChange={(e) => handleCSVImport(e, 'products')}
                      className="file-input"
                    />
                    <p className="help-text">CSV format: name, brand, category, description, size</p>
                  </div>
                  <div className="import-group">
                    <h3>Import Stores</h3>
                    <input
                      type="file"
                      accept=".csv"
                      onChange={(e) => handleCSVImport(e, 'stores')}
                      className="file-input"
                    />
                    <p className="help-text">CSV format: name, address, city, state, phone, email, hours</p>
                  </div>
                </section>

                <section className="import-export-section">
                  <h2>Export Data</h2>
                  <div className="export-group">
                    <button
                      onClick={() => {
                        if (products.length > 0) {
                          exportCSV(products, 'products.csv');
                        } else {
                          addToast('No products to export', 'info');
                        }
                      }}
                      className="btn-secondary btn-block"
                    >
                      Export Products
                    </button>
                  </div>
                  <div className="export-group">
                    <button
                      onClick={() => {
                        if (stores.length > 0) {
                          exportCSV(stores, 'stores.csv');
                        } else {
                          addToast('No stores to export', 'info');
                        }
                      }}
                      className="btn-secondary btn-block"
                    >
                      Export Stores
                    </button>
                  </div>
                </section>
              </div>
            </div>
          )}

          {/* Settings / CMS Content Panel */}
          {activePanel === 'settings' && (
            <div className="panel-content">
              <h2>Store Settings</h2>
              <p className="text-gray-600">Contact details, store configuration and brand colours.</p>

              <div style={{ maxWidth: '640px', marginTop: '20px', display: 'grid', gap: '16px' }}>
                <div className="form-group">
                  <label>Contact Email</label>
                  <input className="form-input" value={content.contactEmail} onChange={(e) => updateContent({ contactEmail: e.target.value })} />
                </div>
                <div className="form-group">
                  <label>Contact Phone</label>
                  <input className="form-input" value={content.contactPhone} onChange={(e) => updateContent({ contactPhone: e.target.value })} />
                </div>
                <h3 style={{ marginTop: '8px', marginBottom: '0', display: 'flex', alignItems: 'center', gap: '8px' }}><Palette size={18} /> Brand Colours / Theme</h3>
                <p className="help-text">These colours are applied across the entire website. Click the swatch to open the colour picker.</p>

                {([
                  { key: 'themeAccent' as const,  label: 'Primary Accent Colour',        hint: 'Used for buttons, links, hover highlights and price text. Default: #ca7c29' },
                  { key: 'themeNavy'   as const,  label: 'Secondary / Dark Colour',      hint: 'Used for dark backgrounds and some headings. Default: #1B2A3B' },
                  { key: 'themeBarFrom' as const, label: 'Top Bar Gradient — Start/End', hint: 'The outer colour of the announcement bar gradient. Default: #ca7c29' },
                  { key: 'themeBarMid'  as const, label: 'Top Bar Gradient — Middle',    hint: 'The centre colour of the announcement bar gradient. Default: #6f3716' },
                ] as const).map(({ key, label, hint }) => (
                  <div key={key} className="form-group" style={{ display: 'grid', gap: '6px' }}>
                    <label>{label}</label>
                    <p className="help-text" style={{ margin: 0 }}>{hint}</p>
                    <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
                      <input
                        type="color"
                        value={(content as never)[key] || '#ca7c29'}
                        onChange={(e) => updateContent({ [key]: e.target.value })}
                        style={{ width: '48px', height: '36px', padding: '2px', borderRadius: '6px', border: '1px solid #e0e0e0', cursor: 'pointer', flexShrink: 0 }}
                      />
                      <input
                        className="form-input"
                        style={{ flex: 1, fontFamily: 'monospace' }}
                        value={(content as never)[key] || ''}
                        onChange={(e) => updateContent({ [key]: e.target.value })}
                        placeholder="#ca7c29"
                      />
                      <button
                        className="btn-secondary btn-sm"
                        onClick={() => {
                          const defaults: Record<string, string> = { themeAccent: '#ca7c29', themeNavy: '#1B2A3B', themeBarFrom: '#ca7c29', themeBarMid: '#6f3716' };
                          updateContent({ [key]: defaults[key] });
                        }}
                        title="Reset to default"
                      >Reset</button>
                    </div>
                    <div style={{ height: '28px', borderRadius: '6px', background: (content as never)[key] || '#ca7c29', border: '1px solid #e0e0e0' }} />
                  </div>
                ))}

                <div>
                  <button className="btn-primary" onClick={saveContent}>Save Settings</button>
                </div>
              </div>
            </div>
          )}
        </div>
      </main>

      {/* Product Modal */}
      {showProductModal && (
        <div className="modal-overlay" onClick={() => setShowProductModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h2>{editingProduct ? 'Edit Product' : 'Add New Product'}</h2>
              <button
                onClick={() => setShowProductModal(false)}
                className="modal-close"
              >
                <X size={16} />
              </button>
            </div>

            <div className="modal-body">
              <div className="form-group">
                <label>Product Name *</label>
                <input
                  type="text"
                  value={productForm.name || ''}
                  onChange={(e) => setProductForm({ ...productForm, name: e.target.value })}
                  className="form-input"
                  placeholder="Enter product name"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Brand</label>
                  <ComboSelect
                    value={productForm.brand || ''}
                    options={allBrands}
                    onChange={(v) => setProductForm({ ...productForm, brand: v })}
                    onAddNew={addCustomBrand}
                    placeholder="Enter new brand name"
                  />
                </div>
                <div className="form-group">
                  <label>Category</label>
                  <ComboSelect
                    value={productForm.category || ''}
                    options={allCategories}
                    onChange={(v) => setProductForm({ ...productForm, category: v })}
                    onAddNew={addCustomCategory}
                    placeholder="Enter new category name"
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Size</label>
                <input
                  type="text"
                  value={productForm.size || ''}
                  onChange={(e) => setProductForm({ ...productForm, size: e.target.value })}
                  className="form-input"
                  placeholder="e.g., 100ml"
                />
              </div>

              <div className="form-group">
                <label>Product Image</label>
                <input
                  type="file"
                  accept="image/*"
                  className="file-input"
                  onChange={async (e) => {
                    const file = e.target.files?.[0];
                    if (!file) return;
                    if (file.size > 1.5 * 1024 * 1024) { addToast('Image too large — use one under 1.5 MB', 'error'); return; }
                    const dataUrl = await fileToDataURL(file);
                    setProductForm({ ...productForm, image: dataUrl });
                    addToast('Image loaded — remember to Save', 'info');
                  }}
                />
                <input
                  type="text"
                  value={productForm.image && productForm.image.startsWith('data:') ? '' : (productForm.image || '')}
                  onChange={(e) => setProductForm({ ...productForm, image: e.target.value })}
                  className="form-input"
                  style={{ marginTop: '8px' }}
                  placeholder="…or paste an image URL"
                />
                <p className="help-text">Upload a photo, paste a URL, or pick from your gallery below.</p>

                <button type="button" className="btn-secondary btn-sm" style={{ marginTop: '8px' }}
                  onClick={() => setShowGallery((v) => !v)}>
                  {showGallery ? 'Hide gallery' : `Choose from gallery (${PRODUCT_IMAGES.length})`}
                </button>
                {showGallery && (
                  <div className="img-gallery">
                    {PRODUCT_IMAGES.map((src) => (
                      <button
                        type="button"
                        key={src}
                        className={`img-gallery-item ${productForm.image === src ? 'selected' : ''}`}
                        title={src.replace('/Img/', '')}
                        onClick={() => { setProductForm({ ...productForm, image: src }); }}
                      >
                        <img src={src} alt="" loading="lazy" onError={(e) => { (e.target as HTMLImageElement).style.opacity = '0.2'; }} />
                      </button>
                    ))}
                  </div>
                )}

                {productForm.image && (
                  <img
                    src={productForm.image.startsWith('http') || productForm.image.startsWith('/') ? productForm.image : `/${productForm.image}`}
                    alt="Preview"
                    style={{ marginTop: '10px', maxHeight: '120px', borderRadius: '8px', border: '1px solid #e8e8e8', objectFit: 'contain' }}
                    onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
                  />
                )}
              </div>

              <div className="form-group">
                <label>Description</label>
                <textarea
                  value={productForm.description || ''}
                  onChange={(e) => setProductForm({ ...productForm, description: e.target.value })}
                  className="form-textarea"
                  placeholder="Product description"
                  rows={4}
                ></textarea>
              </div>

              <div className="form-group">
                <label>Key Benefits</label>
                <p className="help-text" style={{ margin: '0 0 6px' }}>One benefit per line — shown as bullet points on the product page.</p>
                <textarea
                  value={productForm.key_benefits || ''}
                  onChange={(e) => setProductForm({ ...productForm, key_benefits: e.target.value })}
                  className="form-textarea"
                  placeholder={"Deeply moisturises skin\nFast-absorbing formula\nSuitable for all skin types"}
                  rows={5}
                ></textarea>
              </div>

              <div className="form-group">
                <label>How to Use</label>
                <p className="help-text" style={{ margin: '0 0 6px' }}>Step-by-step instructions — one step per line.</p>
                <textarea
                  value={productForm.how_to_use || ''}
                  onChange={(e) => setProductForm({ ...productForm, how_to_use: e.target.value })}
                  className="form-textarea"
                  placeholder={"Apply a small amount to clean skin\nMassage gently in circular motions\nRinse thoroughly with warm water"}
                  rows={5}
                ></textarea>
              </div>
            </div>

            <div className="modal-footer">
              <button
                onClick={() => setShowProductModal(false)}
                className="btn-secondary"
              >
                Cancel
              </button>
              <button
                onClick={handleSaveProduct}
                className="btn-primary"
              >
                {editingProduct ? 'Update Product' : 'Create Product'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Blog Modal */}
      {showBlogModal && (
        <div className="modal-overlay" onClick={() => setShowBlogModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h2>{editingBlog ? 'Edit Blog Post' : 'New Blog Post'}</h2>
              <button
                onClick={() => setShowBlogModal(false)}
                className="modal-close"
              >
                <X size={16} />
              </button>
            </div>

            <div className="modal-body">
              <div className="form-group">
                <label>Title *</label>
                <input
                  type="text"
                  value={blogForm.title || ''}
                  onChange={(e) => setBlogForm({ ...blogForm, title: e.target.value })}
                  className="form-input"
                  placeholder="Blog post title"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Author</label>
                  <input
                    type="text"
                    value={blogForm.author || ''}
                    onChange={(e) => setBlogForm({ ...blogForm, author: e.target.value })}
                    className="form-input"
                    placeholder="Author name"
                  />
                </div>
                <div className="form-group">
                  <label>Slug</label>
                  <input
                    type="text"
                    value={blogForm.slug || ''}
                    onChange={(e) => setBlogForm({ ...blogForm, slug: e.target.value })}
                    className="form-input"
                    placeholder="blog-post-slug"
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Excerpt</label>
                <textarea
                  value={blogForm.excerpt || ''}
                  onChange={(e) => setBlogForm({ ...blogForm, excerpt: e.target.value })}
                  className="form-textarea"
                  placeholder="Short excerpt"
                  rows={2}
                ></textarea>
              </div>

              <div className="form-group">
                <label>Content *</label>
                <textarea
                  value={blogForm.content || ''}
                  onChange={(e) => setBlogForm({ ...blogForm, content: e.target.value })}
                  className="form-textarea"
                  placeholder="Full blog post content"
                  rows={6}
                ></textarea>
              </div>

              <div className="form-group">
                <label>Post Image</label>
                {blogForm.image && (
                  <img src={blogForm.image} alt="preview" style={{ width: '100%', maxHeight: '160px', objectFit: 'cover', borderRadius: '8px', marginBottom: '8px', border: '1px solid #e8e8e8' }} />
                )}
                <input
                  type="file"
                  accept="image/*"
                  className="file-input"
                  onChange={async (e) => {
                    const file = e.target.files?.[0];
                    if (!file) return;
                    const dataUrl = await fileToDataURL(file);
                    setBlogForm({ ...blogForm, image: dataUrl });
                  }}
                />
                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginTop: '6px' }}>
                  <span style={{ fontSize: '12px', color: '#888' }}>…or paste URL:</span>
                  <input
                    type="text"
                    value={blogForm.image?.startsWith('data:') ? '' : (blogForm.image || '')}
                    onChange={(e) => setBlogForm({ ...blogForm, image: e.target.value })}
                    className="form-input"
                    style={{ flex: 1 }}
                    placeholder="/banner/Product-Shampoo.webp"
                  />
                </div>
              </div>

              <div className="form-group checkbox">
                <input
                  type="checkbox"
                  id="published"
                  checked={blogForm.published || false}
                  onChange={(e) => setBlogForm({ ...blogForm, published: e.target.checked })}
                />
                <label htmlFor="published">Publish this post</label>
              </div>
            </div>

            <div className="modal-footer">
              <button
                onClick={() => setShowBlogModal(false)}
                className="btn-secondary"
              >
                Cancel
              </button>
              <button
                onClick={handleSaveBlog}
                className="btn-primary"
              >
                {editingBlog ? 'Update Post' : 'Create Post'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Store Modal */}
      {showStoreModal && (
        <div className="modal-overlay" onClick={() => setShowStoreModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h2>{editingStore ? 'Edit Store' : 'Add New Store'}</h2>
              <button
                onClick={() => setShowStoreModal(false)}
                className="modal-close"
              >
                <X size={16} />
              </button>
            </div>

            <div className="modal-body">
              <div className="form-group">
                <label>Store Name *</label>
                <input
                  type="text"
                  value={storeForm.name || ''}
                  onChange={(e) => setStoreForm({ ...storeForm, name: e.target.value })}
                  className="form-input"
                  placeholder="Store name"
                />
              </div>

              <div className="form-group">
                <label>Address *</label>
                <input
                  type="text"
                  value={storeForm.address || ''}
                  onChange={(e) => setStoreForm({ ...storeForm, address: e.target.value })}
                  className="form-input"
                  placeholder="Street address"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>City</label>
                  <input
                    type="text"
                    value={storeForm.city || ''}
                    onChange={(e) => setStoreForm({ ...storeForm, city: e.target.value })}
                    className="form-input"
                    placeholder="City"
                  />
                </div>
                <div className="form-group">
                  <label>State</label>
                  <input
                    type="text"
                    value={storeForm.state || ''}
                    onChange={(e) => setStoreForm({ ...storeForm, state: e.target.value })}
                    className="form-input"
                    placeholder="State"
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Phone *</label>
                  <input
                    type="tel"
                    value={storeForm.phone || ''}
                    onChange={(e) => setStoreForm({ ...storeForm, phone: e.target.value })}
                    className="form-input"
                    placeholder="Phone number"
                  />
                </div>
                <div className="form-group">
                  <label>Email</label>
                  <input
                    type="email"
                    value={storeForm.email || ''}
                    onChange={(e) => setStoreForm({ ...storeForm, email: e.target.value })}
                    className="form-input"
                    placeholder="Email"
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Hours</label>
                <input
                  type="text"
                  value={storeForm.hours || ''}
                  onChange={(e) => setStoreForm({ ...storeForm, hours: e.target.value })}
                  className="form-input"
                  placeholder="Mon-Fri: 9AM-6PM, Sat: 10AM-4PM"
                />
              </div>

              {/* Store logo */}
              <div className="form-group">
                <label>Store Logo / Image</label>
                {storeForm.logo && (
                  <div style={{ marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <img
                      src={storeForm.logo}
                      alt="Store logo preview"
                      style={{ width: '64px', height: '64px', objectFit: 'contain', borderRadius: '8px', border: '1px solid #e8e8e8', background: '#fafafa', padding: '4px' }}
                      onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
                    />
                    <button
                      type="button"
                      className="btn-danger btn-sm"
                      onClick={() => setStoreForm({ ...storeForm, logo: '' })}
                    >Remove</button>
                  </div>
                )}
                <input
                  type="file"
                  accept="image/*"
                  className="file-input"
                  onChange={async (e) => {
                    const file = e.target.files?.[0];
                    if (!file) return;
                    if (file.size > 1.5 * 1024 * 1024) { addToast('Logo too large — use one under 1.5 MB', 'error'); return; }
                    const dataUrl = await fileToDataURL(file);
                    setStoreForm({ ...storeForm, logo: dataUrl });
                  }}
                />
                <input
                  type="url"
                  className="form-input"
                  style={{ marginTop: '6px' }}
                  value={storeForm.logo?.startsWith('data:') ? '' : (storeForm.logo || '')}
                  onChange={(e) => setStoreForm({ ...storeForm, logo: e.target.value })}
                  placeholder="…or paste an image URL"
                />
              </div>
            </div>

            <div className="modal-footer">
              <button
                onClick={() => setShowStoreModal(false)}
                className="btn-secondary"
              >
                Cancel
              </button>
              <button
                onClick={handleSaveStore}
                className="btn-primary"
              >
                {editingStore ? 'Update Store' : 'Create Store'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ── SEO Manager ─────────────────────────────────────────── */}
      {activePanel === 'seo' && (
        <div className="panel-content">
          <h2>SEO Manager</h2>
          <p className="text-gray-600">Control meta titles, descriptions, Open Graph images and more for every page. Changes go live when you click Save.</p>

          <div style={{ maxWidth: '760px', marginTop: '24px', display: 'grid', gap: '28px' }}>

            {/* ── Site-wide settings ── */}
            <section style={{ border: '1px solid #e8e8e8', borderRadius: '12px', padding: '20px' }}>
              <h3 style={{ marginBottom: '16px' }}>Site-Wide Settings</h3>
              <div style={{ display: 'grid', gap: '12px' }}>
                <div className="form-group"><label>Site name (appended to every page title)</label>
                  <input className="form-input" value={content.seo?.siteTitle ?? ''} onChange={(e) => updateContent({ seo: { ...content.seo, siteTitle: e.target.value } })} placeholder="XpelBeauty NG" /></div>
                <div className="form-group"><label>Title separator</label>
                  <input className="form-input" value={content.seo?.titleSeparator ?? ' | '} onChange={(e) => updateContent({ seo: { ...content.seo, titleSeparator: e.target.value } })} placeholder=" | " style={{ maxWidth: '120px' }} /></div>
                <div className="form-group"><label>Default meta description (used when a page has none)</label>
                  <textarea className="form-input" rows={3} value={content.seo?.defaultDescription ?? ''} onChange={(e) => updateContent({ seo: { ...content.seo, defaultDescription: e.target.value } })} /></div>
                <div className="form-group"><label>Default OG image URL (used when a page has no og:image)</label>
                  <input className="form-input" value={content.seo?.defaultOgImage ?? ''} onChange={(e) => updateContent({ seo: { ...content.seo, defaultOgImage: e.target.value } })} placeholder="/banner/Brand_Argan_Oil_V3.webp" /></div>
                <div className="form-group"><label>Twitter / X handle (optional, e.g. @xpelbeautyng)</label>
                  <input className="form-input" value={content.seo?.twitterHandle ?? ''} onChange={(e) => updateContent({ seo: { ...content.seo, twitterHandle: e.target.value } })} placeholder="@xpelbeautyng" /></div>
                <div className="form-group"><label>Google Search Console verification code</label>
                  <input className="form-input" value={content.seo?.googleVerification ?? ''} onChange={(e) => updateContent({ seo: { ...content.seo, googleVerification: e.target.value } })} placeholder="Paste the content= value from Google" /></div>
              </div>
            </section>

            {/* ── Per-page SEO ── */}
            {([
              { key: 'home',    label: 'Home Page',           icon: <Home size={14} /> },
              { key: 'shop',    label: 'Shop / Products Page',icon: <ShoppingBag size={14} /> },
              { key: 'about',   label: 'About Page',          icon: <Info size={14} /> },
              { key: 'contact', label: 'Contact Page',        icon: <Mail size={14} /> },
              { key: 'blog',    label: 'Blog Page',           icon: <FileText size={14} /> },
              { key: 'stores',  label: 'Stores Page',         icon: <MapPin size={14} /> },
            ] as { key: keyof typeof content.seo.pages; label: string; icon: React.ReactNode }[]).map(({ key, label, icon }) => {
              const p = content.seo?.pages?.[key];
              const updatePage = (patch: Partial<import('@/hooks/useSiteContent').SEOPage>) => {
                updateContent({
                  seo: {
                    ...content.seo,
                    pages: { ...content.seo.pages, [key]: { ...content.seo.pages[key], ...patch } },
                  },
                });
              };
              return (
                <details key={key} style={{ border: '1px solid #e8e8e8', borderRadius: '12px', overflow: 'hidden' }}>
                  <summary style={{ padding: '14px 20px', cursor: 'pointer', fontWeight: '600', background: '#fafafa', userSelect: 'none', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    {icon}{label}
                    {p?.title && <span style={{ fontWeight: 400, color: '#888', marginLeft: '10px', fontSize: '13px' }}>{p.title}</span>}
                  </summary>
                  <div style={{ padding: '16px 20px', display: 'grid', gap: '12px' }}>
                    <div className="form-group">
                      <label>Page title <span style={{ color: '#888', fontWeight: 400 }}>(shown as "{p?.title ?? '…'}{content.seo?.titleSeparator ?? ' | '}{content.seo?.siteTitle ?? 'XpelBeauty NG'}")</span></label>
                      <input className="form-input" value={p?.title ?? ''} onChange={(e) => updatePage({ title: e.target.value })} placeholder="e.g. Shop All Products" />
                    </div>
                    <div className="form-group">
                      <label>Meta description <span style={{ color: '#888', fontWeight: 400 }}>(aim for 120–160 characters)</span></label>
                      <textarea className="form-input" rows={3} value={p?.description ?? ''} onChange={(e) => updatePage({ description: e.target.value })} />
                      <p style={{ fontSize: '12px', color: p?.description?.length > 160 ? '#e53e3e' : '#888', marginTop: '4px' }}>{p?.description?.length ?? 0} / 160 characters</p>
                    </div>
                    <div className="form-group">
                      <label>Keywords <span style={{ color: '#888', fontWeight: 400 }}>(comma-separated)</span></label>
                      <input className="form-input" value={p?.keywords ?? ''} onChange={(e) => updatePage({ keywords: e.target.value })} placeholder="e.g. buy shampoo nigeria, argan oil" />
                    </div>
                    <div className="form-group">
                      <label>OG image URL <span style={{ color: '#888', fontWeight: 400 }}>(leave blank to use site default)</span></label>
                      <input className="form-input" value={p?.ogImage ?? ''} onChange={(e) => updatePage({ ogImage: e.target.value })} placeholder="/banner/banner 1.webp" />
                      {p?.ogImage && <img src={p.ogImage} alt="" style={{ marginTop: '8px', maxHeight: '100px', borderRadius: '8px', objectFit: 'cover' }} onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />}
                    </div>
                    <div className="form-group">
                      <label>Robots</label>
                      <select className="form-input" value={p?.robots ?? 'index, follow'} onChange={(e) => updatePage({ robots: e.target.value })} style={{ maxWidth: '260px' }}>
                        <option value="index, follow">index, follow (default — show in Google)</option>
                        <option value="noindex, follow">noindex, follow (hide from Google)</option>
                        <option value="index, nofollow">index, nofollow</option>
                        <option value="noindex, nofollow">noindex, nofollow (hide completely)</option>
                      </select>
                    </div>
                  </div>
                </details>
              );
            })}

            <button className="btn-primary" onClick={saveContent} style={{ alignSelf: 'flex-start', marginTop: '8px' }}>
              Save SEO Settings
            </button>
          </div>
        </div>
      )}

      {/* ── Collections Editor Panel ──────────────────────────── */}
      {activePanel === 'collections' && (
        <div className="panel-section">
          <p style={{ color: 'var(--muted)', fontSize: 14, marginBottom: 20 }}>
            Each collection is a dedicated page at <strong>/collection/[slug]</strong> linked from the mega menu.
            Edit the text, hero image and product filter, then click <strong>Save All Collections</strong>.
          </p>

          {collections.map((col, idx) => (
            <details key={idx} className="mega-menu-group" style={{ marginBottom: 10 }}>
              <summary className="mega-menu-group-summary" style={{ display: 'flex', alignItems: 'center', gap: 10, cursor: 'pointer', padding: '10px 0' }}>
                <span style={{ fontWeight: 600 }}>{col.name || '(Unnamed)'}</span>
                <span style={{ color: 'var(--muted)', fontSize: 12 }}>/collection/{col.slug}</span>
                <span style={{ marginLeft: 'auto', display: 'flex', gap: 8 }}>
                  <a
                    href={`/collection/${col.slug}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="btn-secondary btn-sm"
                    style={{ textDecoration: 'none', fontSize: 11 }}
                    onClick={(e) => e.stopPropagation()}
                  >
                    Preview ↗
                  </a>
                  <button
                    type="button"
                    className="btn-sm"
                    style={{ background: '#fee2e2', color: '#dc2626', border: 'none', borderRadius: 4, padding: '4px 10px', cursor: 'pointer', fontSize: 11 }}
                    onClick={(e) => { e.preventDefault(); deleteCollection(idx); }}
                  >
                    Delete
                  </button>
                </span>
              </summary>

              <div style={{ padding: '16px 0 8px', display: 'flex', flexDirection: 'column', gap: 14 }}>
                {/* Row: Slug + Name */}
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
                  <div className="form-group">
                    <label className="form-label">URL Slug</label>
                    <input
                      className="form-input"
                      value={col.slug}
                      onChange={(e) => updateCollection(idx, { slug: e.target.value.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '') })}
                      placeholder="tea-tree"
                    />
                    <small style={{ color: 'var(--muted)', fontSize: 11 }}>yoursite.com/collection/{col.slug}</small>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Collection Name</label>
                    <input className="form-input" value={col.name} onChange={(e) => updateCollection(idx, { name: e.target.value })} placeholder="Tea Tree" />
                  </div>
                </div>

                {/* Subtitle */}
                <div className="form-group">
                  <label className="form-label">Subtitle / Tagline</label>
                  <input className="form-input" value={col.subtitle} onChange={(e) => updateCollection(idx, { subtitle: e.target.value })} placeholder="Purify & Protect" />
                </div>

                {/* Description */}
                <div className="form-group">
                  <label className="form-label">Description</label>
                  <textarea className="form-input" rows={3} value={col.description} onChange={(e) => updateCollection(idx, { description: e.target.value })} placeholder="A paragraph shown below the hero image…" />
                </div>

                {/* Hero Image */}
                <div className="form-group">
                  <label className="form-label">Hero Image</label>
                  <div style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
                    <input
                      className="form-input"
                      value={col.heroImage}
                      onChange={(e) => updateCollection(idx, { heroImage: e.target.value })}
                      placeholder="/banner/Brand-Tea-Tree.webp"
                      style={{ flex: 1 }}
                    />
                    <label className="btn-secondary btn-sm" style={{ cursor: 'pointer', whiteSpace: 'nowrap' }}>
                      Upload
                      <input type="file" accept="image/*" style={{ display: 'none' }} onChange={(e) => uploadCollectionHero(e, idx)} />
                    </label>
                  </div>
                  {col.heroImage && (
                    <img
                      src={col.heroImage}
                      alt="preview"
                      style={{ marginTop: 8, height: 80, width: '100%', objectFit: 'cover', borderRadius: 6, border: '1px solid var(--border)' }}
                      onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }}
                    />
                  )}
                </div>

                {/* Colors */}
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
                  <div className="form-group">
                    <label className="form-label">Hero Overlay Color</label>
                    <input
                      className="form-input"
                      value={col.overlayColor}
                      onChange={(e) => updateCollection(idx, { overlayColor: e.target.value })}
                      placeholder="rgba(26, 31, 58, 0.82)"
                    />
                    <small style={{ color: 'var(--muted)', fontSize: 11 }}>Use rgba() for transparency — e.g. rgba(26,31,58,0.82)</small>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Accent Color (badge &amp; button)</label>
                    <div style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
                      <input
                        type="color"
                        value={col.accentColor.startsWith('#') ? col.accentColor : '#ca7c29'}
                        onChange={(e) => updateCollection(idx, { accentColor: e.target.value })}
                        style={{ width: 44, height: 36, padding: 2, border: '1px solid var(--border)', borderRadius: 6, cursor: 'pointer', flexShrink: 0 }}
                      />
                      <input
                        className="form-input"
                        value={col.accentColor}
                        onChange={(e) => updateCollection(idx, { accentColor: e.target.value })}
                        placeholder="#ca7c29"
                      />
                    </div>
                  </div>
                </div>

                {/* Filter */}
                <div style={{ display: 'grid', gridTemplateColumns: '200px 1fr', gap: 12, alignItems: 'start' }}>
                  <div className="form-group">
                    <label className="form-label">Product Filter Type</label>
                    <select
                      className="form-input"
                      value={col.filterType}
                      onChange={(e) => updateCollection(idx, { filterType: e.target.value as CollectionConfig['filterType'] })}
                    >
                      <option value="brand">By Brand name</option>
                      <option value="name">By Product name</option>
                      <option value="ids">By Product IDs</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">
                      {col.filterType === 'brand' && 'Brand name (partial match)'}
                      {col.filterType === 'name'  && 'Name keyword (partial match)'}
                      {col.filterType === 'ids'   && 'Product IDs (comma-separated)'}
                    </label>
                    <input
                      className="form-input"
                      value={col.filterValue}
                      onChange={(e) => updateCollection(idx, { filterValue: e.target.value })}
                      placeholder={
                        col.filterType === 'ids'   ? '213, 214, 215, 216' :
                        col.filterType === 'brand' ? 'Tea Tree' : 'Aloe Vera'
                      }
                    />
                    <small style={{ color: 'var(--muted)', fontSize: 11 }}>
                      {col.filterType === 'brand' && 'Shows all products where the brand field contains this text'}
                      {col.filterType === 'name'  && 'Shows all products where the name contains this keyword'}
                      {col.filterType === 'ids'   && 'Shows specific products by their database ID numbers'}
                    </small>
                  </div>
                </div>
              </div>
            </details>
          ))}

          {/* Actions */}
          <div style={{ display: 'flex', gap: 10, marginTop: 16, flexWrap: 'wrap' }}>
            <button type="button" className="btn-secondary" onClick={addCollection}>
              + Add New Collection
            </button>
            <button type="button" className="btn-primary" onClick={saveContent}>
              Save All Collections
            </button>
          </div>
        </div>
      )}

      {/* ── Enquiries Panel ──────────────────────────────────── */}
      {activePanel === 'enquiries' && (() => {
        const filtered = enquiries.filter(e =>
          enquiryFilter === 'all' ? true :
          enquiryFilter === 'new' ? e.status === 'new' :
          e.type === enquiryFilter
        );
        const newCount = enquiries.filter(e => e.status === 'new').length;
        const waNum = content.whatsappNumber || '2348034883603';
        return (
          <div className="panel-section enq-panel">

            {/* ── WhatsApp Settings ── */}
            <div className="enq-wa-settings">
              <div className="enq-wa-header">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="#25D366"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
                <span className="enq-wa-title">WhatsApp Enquiries</span>
              </div>
              <div className="enq-wa-body">
                <div className="enq-wa-row">
                  <label className="enq-wa-label">Enable WhatsApp buttons on product &amp; contact pages</label>
                  <button
                    className={`enq-toggle ${content.whatsappEnabled !== false ? 'on' : 'off'}`}
                    onClick={() => updateContent({ whatsappEnabled: !(content.whatsappEnabled !== false) })}
                  >
                    <span className="enq-toggle-knob" />
                    <span className="enq-toggle-text">{content.whatsappEnabled !== false ? 'ON' : 'OFF'}</span>
                  </button>
                </div>
                <div className="enq-wa-row">
                  <label className="enq-wa-label">WhatsApp number (international format, no +)</label>
                  <div className="enq-wa-input-row">
                    <input
                      className="form-input enq-wa-input"
                      value={content.whatsappNumber || ''}
                      onChange={e => updateContent({ whatsappNumber: e.target.value.replace(/\D/g, '') })}
                      placeholder="e.g. 2348034883603"
                      maxLength={15}
                    />
                    <button className="btn-primary btn-sm" onClick={saveContent}>Save</button>
                  </div>
                  <p className="help-text" style={{ margin: '4px 0 0' }}>Nigeria example: 2348034883603 (234 + number without leading 0)</p>
                </div>
              </div>
            </div>

            {/* ── Summary row ── */}
            <div className="enq-summary">
              {[
                { label: 'Total', value: enquiries.length, color: 'var(--navy, #1B2A3B)' },
                { label: 'New', value: newCount, color: '#dc2626' },
                { label: 'Read', value: enquiries.filter(e => e.status === 'read').length, color: '#6b7280' },
              ].map(m => (
                <div key={m.label} className="enq-metric">
                  <p className="enq-metric-val" style={{ color: m.color }}>{m.value}</p>
                  <p className="enq-metric-label">{m.label}</p>
                </div>
              ))}
              <button className="btn-secondary enq-refresh" onClick={loadEnquiries}>↻ Refresh</button>
            </div>

            {/* ── Filters ── */}
            <div className="enq-filters">
              {(['all', 'new', 'contact', 'product'] as const).map(f => (
                <button
                  key={f}
                  onClick={() => setEnquiryFilter(f)}
                  className={`enq-filter-btn ${enquiryFilter === f ? 'active' : ''}`}
                >{f === 'all' ? 'All' : f === 'new' ? `New (${newCount})` : f.charAt(0).toUpperCase() + f.slice(1)}</button>
              ))}
            </div>

            {/* ── List ── */}
            {loadingEnquiries ? (
              <div className="loading-state"><div className="spinner"></div><p>Loading enquiries…</p></div>
            ) : filtered.length === 0 ? (
              <div className="empty-state-large"><p>{enquiries.length === 0 ? 'No enquiries yet — they will appear here once customers submit a form.' : 'No enquiries match this filter.'}</p></div>
            ) : (
              <div className="enq-list">
                {filtered.map(enq => (
                  <div
                    key={enq.id}
                    className={`enq-card ${enq.status === 'new' ? 'enq-card-new' : ''}`}
                    onClick={() => setExpandedEnquiry(expandedEnquiry === enq.id ? null : enq.id)}
                  >
                    {/* Header row */}
                    <div className="enq-card-top">
                      <div className="enq-card-badges">
                        <span className={`enq-status-badge enq-status-${enq.status}`}>{enq.status}</span>
                        <span className="enq-type-badge">{enq.type === 'product' ? '📦 Product' : '✉️ Contact'}</span>
                      </div>
                      <div className="enq-card-info">
                        <strong className="enq-name">{enq.name || 'Anonymous'}</strong>
                        {enq.email && <span className="enq-email">{enq.email}</span>}
                        {enq.product_name && <span className="enq-product">re: {enq.product_name}</span>}
                      </div>
                      <span className="enq-date">
                        {new Date(enq.created_at).toLocaleDateString('en-NG', { day: 'numeric', month: 'short', year: 'numeric' })}
                        <br />
                        <span style={{ fontSize: 10 }}>{new Date(enq.created_at).toLocaleTimeString('en-NG', { hour: '2-digit', minute: '2-digit' })}</span>
                      </span>
                    </div>

                    {enq.subject && <p className="enq-subject">{enq.subject}</p>}

                    {/* Expanded */}
                    {expandedEnquiry === enq.id && (
                      <div className="enq-expanded" onClick={e => e.stopPropagation()}>
                        <p className="enq-message">{enq.message}</p>
                        <div className="enq-actions">
                          {enq.email && (
                            <a href={`mailto:${enq.email}?subject=Re: ${enq.subject || 'Your Enquiry'}`}
                              className="btn-primary btn-sm" style={{ textDecoration: 'none' }}>
                              ✉ Reply by Email
                            </a>
                          )}
                          <a href={`https://wa.me/${(enq.phone || '').replace(/\D/g, '') || waNum}?text=${encodeURIComponent(`Hi ${enq.name || ''}, thanks for your enquiry${enq.product_name ? ' about ' + enq.product_name : ''}.`)}`}
                            target="_blank" rel="noopener noreferrer" className="enq-wa-reply-btn">
                            Reply on WhatsApp
                          </a>
                          {enq.status === 'new' && (
                            <button className="btn-secondary btn-sm" onClick={() => markEnquiryRead(enq.id)}>Mark as Read</button>
                          )}
                          <button className="enq-delete-btn"
                            onClick={() => { if (confirm('Delete this enquiry?')) deleteEnquiry(enq.id); }}>
                            Delete
                          </button>
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        );
      })()}

      {/* Toast Notifications */}
      <div className="toast-container">
        {toasts.map(toast => (
          <div key={toast.id} className={`toast toast-${toast.type}`}>
            <span className="toast-icon">
              {toast.type === 'success' && <Check size={16} strokeWidth={2.5} />}
              {toast.type === 'error' && <X size={16} strokeWidth={2.5} />}
              {toast.type === 'info' && <Info size={16} strokeWidth={2} />}
            </span>
            <span className="toast-message">{toast.message}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
