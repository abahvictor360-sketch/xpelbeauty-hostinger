/** Office location: the "Xpel Beauty Trade fair" Google Maps listing and links built from it. */
export const DEFAULT_OFFICE_PIN = { lat: 6.4607962, lng: 3.2508844 };
export const DEFAULT_OFFICE_MAP_URL =
  'https://www.google.com/maps/place/Xpel+Beauty+Trade+fair/@6.4607962,3.2508844,17z/data=!4m6!3m5!1s0x103b870024370df9:0x21cb46f8945bd1a9!8m2!3d6.4607962!4d3.2508844!16s%2Fg%2F11zf3k39wp';
export const OFFICE_PLACE_NAME = 'Xpel Beauty Trade fair';

export function officePin(c: { officeLat?: number; officeLng?: number }) {
  const lat = Number(c.officeLat), lng = Number(c.officeLng);
  return Number.isFinite(lat) && Number.isFinite(lng) && (lat || lng) ? { lat, lng } : DEFAULT_OFFICE_PIN;
}

/** Google Maps listing (name, photos, reviews); falls back to the bare pin. */
export function officeMapUrl(c: { officeMapUrl?: string; officeLat?: number; officeLng?: number }) {
  const u = (c.officeMapUrl ?? '').trim();
  return /^https:\/\/(www\.)?google\.[a-z.]+\/maps\//.test(u) ? u : c.officeMapUrl === undefined ? DEFAULT_OFFICE_MAP_URL : mapsPinUrl(officePin(c));
}

export const mapsPinUrl = (p: { lat: number; lng: number }) =>
  `https://www.google.com/maps/search/?api=1&query=${p.lat},${p.lng}`;

export const mapsDirectionsUrl = (p: { lat: number; lng: number }) =>
  `https://www.google.com/maps/dir/?api=1&destination=${p.lat},${p.lng}`;

/** Keyless embed centred on the listing, labelled with its name. */
export const mapsEmbedUrl = (p: { lat: number; lng: number }, name = OFFICE_PLACE_NAME) =>
  `https://maps.google.com/maps?q=${encodeURIComponent(name)}&ll=${p.lat},${p.lng}&z=17&output=embed`;
