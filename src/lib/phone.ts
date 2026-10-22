/** Show an international Nigerian number (2347060521947) the local way: 0706 052 1947. */
export function formatNgPhone(raw?: string): string {
  const digits = (raw ?? '').replace(/\D/g, '');
  const local = digits.startsWith('234') ? '0' + digits.slice(3) : digits;
  if (local.length !== 11) return raw ?? '';
  return `${local.slice(0, 4)} ${local.slice(4, 7)} ${local.slice(7)}`;
}
