const API_BASE = (import.meta.env.VITE_API_BASE as string) || '/api';
const TOKEN    = (import.meta.env.VITE_API_TOKEN as string) || '';

async function apiFetch(path: string, options: RequestInit = {}) {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...(options.method && options.method !== 'GET' ? { 'X-Admin-Token': TOKEN } : {}),
  };

  let res: Response;
  try {
    res = await fetch(`${API_BASE}${path}`, { ...options, headers });
  } catch {
    // fetch() itself threw — network unreachable, CORS block, DNS failure, offline, etc.
    throw new Error(`Could not reach the server (${API_BASE}${path}). Check your connection and try again.`);
  }

  if (!res.ok) {
    let msg = `Server error (HTTP ${res.status}) from ${path}`;
    try {
      const body = await res.clone().json();
      if (body?.error) msg = body.error;
    } catch {
      try {
        const text = (await res.text()).trim();
        if (text) msg = `HTTP ${res.status}: ${text.slice(0, 160)}`;
      } catch { /* keep default msg */ }
    }
    throw new Error(msg);
  }

  try {
    return await res.json();
  } catch {
    throw new Error(`Received an invalid response from ${path}.`);
  }
}

export const api = {
  products: {
    getAll:      (category?: string) =>
      apiFetch(category ? `/products.php?category=${encodeURIComponent(category)}` : '/products.php'),
    getAllAdmin:  ()                   => apiFetch('/products.php?admin=1'),
    getById:     (id: number)         => apiFetch(`/products.php?id=${id}`),
    getByBarcode:(code: string)       => apiFetch(`/products.php?barcode=${encodeURIComponent(code)}`),
    create:      (data: object)       => apiFetch('/products.php',        { method: 'POST', body: JSON.stringify(data) }),
    update:      (id: number, data: object) =>
      apiFetch('/products.php', { method: 'PUT',  body: JSON.stringify({ id, ...data }) }),
    delete:      (id: number)         => apiFetch(`/products.php?id=${id}`, { method: 'DELETE' }),
    bulkInsert:  (rows: object[])     =>
      apiFetch('/products.php?bulk=1', { method: 'POST', body: JSON.stringify(rows) }),
  },

  blog: {
    getAll:      (admin = false) => apiFetch(`/blog.php${admin ? '?admin=1' : ''}`),
    getBySlug:   (slug: string)  => apiFetch(`/blog.php?slug=${encodeURIComponent(slug)}`),
    create:      (data: object)  => apiFetch('/blog.php', { method: 'POST', body: JSON.stringify(data) }),
    update:      (id: number, data: object) =>
      apiFetch('/blog.php', { method: 'PUT', body: JSON.stringify({ id, ...data }) }),
    delete:      (id: number)    => apiFetch(`/blog.php?id=${id}`, { method: 'DELETE' }),
  },

  stores: {
    getAll:  ()                          => apiFetch('/stores.php'),
    create:  (data: object)              => apiFetch('/stores.php', { method: 'POST', body: JSON.stringify(data) }),
    update:  (id: number, data: object)  =>
      apiFetch('/stores.php', { method: 'PUT', body: JSON.stringify({ id, ...data }) }),
    delete:  (id: number)                => apiFetch(`/stores.php?id=${id}`, { method: 'DELETE' }),
  },

  enquiries: {
    getAll:       ()                           => apiFetch('/enquiries.php'),
    create:       (data: object)               => apiFetch('/enquiries.php', { method: 'POST', body: JSON.stringify(data) }),
    updateStatus: (id: number, status: string) =>
      apiFetch('/enquiries.php', { method: 'PUT', body: JSON.stringify({ id, status }) }),
    delete:       (id: number)                 => apiFetch(`/enquiries.php?id=${id}`, { method: 'DELETE' }),
  },

  siteContent: {
    get:   ()              => apiFetch('/site_content.php'),
    save:  (data: object)  => apiFetch('/site_content.php', { method: 'POST', body: JSON.stringify(data) }),
    patch: (data: object)  => apiFetch('/site_content.php', { method: 'PUT',  body: JSON.stringify(data) }),
  },
};

export default api;
