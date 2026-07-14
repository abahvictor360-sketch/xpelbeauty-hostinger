/** SSR-safe origin: real origin in the browser, VITE_SITE_URL (or '') during prerender. */
export function siteOrigin(): string {
  if (typeof window !== 'undefined') return window.location.origin;
  return (import.meta.env.VITE_SITE_URL as string | undefined) ?? '';
}
