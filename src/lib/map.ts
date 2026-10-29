/** Office map pin (Trade Fair International Market, Lagos) and Google Maps links built from it. */
export const DEFAULT_OFFICE_PIN = { lat: 6.460998746759591, lng: 3.2509487683946046 };

export function officePin(c: { officeLat?: number; officeLng?: number }) {
  const lat = Number(c.officeLat), lng = Number(c.officeLng);
  return Number.isFinite(lat) && Number.isFinite(lng) && (lat || lng) ? { lat, lng } : DEFAULT_OFFICE_PIN;
}

export const mapsPinUrl = (p: { lat: number; lng: number }) =>
  `https://www.google.com/maps/search/?api=1&query=${p.lat},${p.lng}`;

export const mapsDirectionsUrl = (p: { lat: number; lng: number }) =>
  `https://www.google.com/maps/dir/?api=1&destination=${p.lat},${p.lng}`;

/** Keyless embed: works without a Google Maps API key. */
export const mapsEmbedUrl = (p: { lat: number; lng: number }) =>
  `https://maps.google.com/maps?q=${p.lat},${p.lng}&z=17&output=embed`;
