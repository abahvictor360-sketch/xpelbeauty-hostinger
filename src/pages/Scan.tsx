import { useCallback, useState, lazy, Suspense } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ScanBarcode, Search, RotateCcw } from 'lucide-react';
import { api } from '@/lib/api';
import { useSiteContent } from '@/hooks/useSiteContent';
import SEO from '@/components/SEO';
import type { Product } from '@/types';

// Pulls in @zxing (~500kB) — code-split so it's only fetched when scanning starts.
const BarcodeScanner = lazy(() => import('@/components/BarcodeScanner'));

type LookupState =
  | { kind: 'idle' }
  | { kind: 'looking'; code: string }
  | { kind: 'not-found'; code: string }
  | { kind: 'error'; code: string; message: string };

export default function Scan() {
  const content = useSiteContent();
  const navigate = useNavigate();
  const [scannerOpen, setScannerOpen] = useState(false);
  const [manualCode, setManualCode] = useState('');
  const [state, setState] = useState<LookupState>({ kind: 'idle' });

  const lookup = useCallback(async (code: string) => {
    const trimmed = code.trim();
    if (!trimmed) return;
    setScannerOpen(false);
    setState({ kind: 'looking', code: trimmed });
    try {
      const product: Product = await api.products.getByBarcode(trimmed);
      navigate(`/product/${product.id}`);
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Something went wrong';
      if (message.toLowerCase().includes('no product')) {
        setState({ kind: 'not-found', code: trimmed });
      } else {
        setState({ kind: 'error', code: trimmed, message });
      }
    }
  }, [navigate]);

  const enabled = content.barcodeScannerEnabled !== false;

  if (!enabled) {
    return (
      <div className="xp-scan-page">
        <SEO
          page="shop"
          overrides={{ fullTitle: 'Scan a Barcode | Xpel Beauty NG', robots: 'noindex, follow' }}
        />
        <div className="xp-scan-disabled">
          <ScanBarcode size={40} strokeWidth={1.5} />
          <h1>Barcode scanning is currently unavailable</h1>
          <p>You can still find any product from our full catalogue.</p>
          <Link to="/shop" className="about-cta-btn">Browse all products</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="xp-scan-page">
      <SEO
        page="shop"
        overrides={{
          fullTitle: 'Scan a Barcode | Xpel Beauty NG',
          description: 'Scan any Xpel Beauty product barcode to instantly view its details.',
          robots: 'noindex, follow',
        }}
      />

      <div className="xp-scan-hero">
        <span className="section-label">find a product</span>
        <h1 className="xp-scan-title">Scan a barcode</h1>
        <p className="xp-scan-sub">
          Point your camera at the barcode on any Xpel Beauty product to jump straight to its page —
          or type the code in by hand.
        </p>
      </div>

      <div className="xp-scan-panel">
        {state.kind === 'idle' && (
          <button type="button" className="xp-scan-start-btn" onClick={() => setScannerOpen(true)}>
            <ScanBarcode size={20} strokeWidth={1.75} />
            Open camera scanner
          </button>
        )}

        {state.kind === 'looking' && (
          <div className="xp-scan-status">
            <div className="xp-scan-spinner" aria-hidden="true" />
            <p>Looking up barcode {state.code}…</p>
          </div>
        )}

        {state.kind === 'not-found' && (
          <div className="xp-scan-status xp-scan-status-warn">
            <p><strong>No product found</strong> for barcode “{state.code}”.</p>
            <p className="xp-scan-status-sub">Double-check the code, or try scanning again.</p>
            <button type="button" className="xp-scan-retry-btn" onClick={() => setState({ kind: 'idle' })}>
              <RotateCcw size={15} strokeWidth={2} /> Try again
            </button>
          </div>
        )}

        {state.kind === 'error' && (
          <div className="xp-scan-status xp-scan-status-warn">
            <p><strong>Couldn't complete the lookup.</strong></p>
            <p className="xp-scan-status-sub">{state.message}</p>
            <button type="button" className="xp-scan-retry-btn" onClick={() => setState({ kind: 'idle' })}>
              <RotateCcw size={15} strokeWidth={2} /> Try again
            </button>
          </div>
        )}

        <div className="xp-scan-divider"><span>or enter it manually</span></div>

        <form
          className="xp-scan-manual"
          onSubmit={(e) => { e.preventDefault(); lookup(manualCode); }}
        >
          <input
            type="text"
            inputMode="numeric"
            placeholder="Enter barcode number"
            value={manualCode}
            onChange={(e) => setManualCode(e.target.value)}
            aria-label="Barcode number"
          />
          <button type="submit" disabled={!manualCode.trim() || state.kind === 'looking'}>
            <Search size={16} strokeWidth={2} />
            Look up
          </button>
        </form>
      </div>

      {scannerOpen && (
        <Suspense fallback={<div className="xp-scanner-overlay"><div className="xp-scan-spinner" /></div>}>
          <BarcodeScanner
            title="Scan a product barcode"
            onDetect={lookup}
            onClose={() => setScannerOpen(false)}
          />
        </Suspense>
      )}
    </div>
  );
}
