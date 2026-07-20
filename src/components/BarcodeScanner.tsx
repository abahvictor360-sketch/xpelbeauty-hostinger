import { useEffect, useRef, useState } from 'react';
import { BrowserMultiFormatReader } from '@zxing/browser';
import { BarcodeFormat, DecodeHintType, NotFoundException } from '@zxing/library';
import { X, Camera } from 'lucide-react';
import './BarcodeScanner.css';

interface BarcodeScannerProps {
  /** Called once with the decoded value when a barcode is successfully read. */
  onDetect: (code: string) => void;
  /** Called when the user dismisses the scanner (close button / backdrop). */
  onClose: () => void;
  /** Optional heading shown above the viewfinder. */
  title?: string;
}

const HINTS = new Map();
HINTS.set(DecodeHintType.POSSIBLE_FORMATS, [
  BarcodeFormat.EAN_13,
  BarcodeFormat.EAN_8,
  BarcodeFormat.UPC_A,
  BarcodeFormat.UPC_E,
  BarcodeFormat.CODE_128,
  BarcodeFormat.CODE_39,
  BarcodeFormat.QR_CODE,
]);

/** Camera-driven barcode scanner. Renders a viewfinder overlay and calls
 *  onDetect with the first successfully decoded value. Stops the camera
 *  stream on unmount so nothing keeps recording in the background. */
export default function BarcodeScanner({ onDetect, onClose, title }: BarcodeScannerProps) {
  const videoRef = useRef<HTMLVideoElement>(null);
  const readerRef = useRef<BrowserMultiFormatReader | null>(null);
  const controlsRef = useRef<{ stop: () => void } | null>(null);
  const detectedRef = useRef(false);
  const [status, setStatus] = useState<'starting' | 'scanning' | 'denied' | 'unsupported'>('starting');

  useEffect(() => {
    detectedRef.current = false;

    if (!navigator.mediaDevices?.getUserMedia) {
      setStatus('unsupported');
      return;
    }

    const reader = new BrowserMultiFormatReader(HINTS);
    readerRef.current = reader;
    let cancelled = false;

    reader
      .decodeFromVideoDevice(undefined, videoRef.current!, (result, err) => {
        if (cancelled || detectedRef.current) return;
        if (result) {
          detectedRef.current = true;
          onDetect(result.getText());
        } else if (err && !(err instanceof NotFoundException)) {
          // Non-"nothing found this frame" errors are ignored; decoding keeps retrying.
        }
      })
      .then((controls) => {
        if (cancelled) { controls.stop(); return; }
        controlsRef.current = controls;
        setStatus('scanning');
      })
      .catch((err: unknown) => {
        if (cancelled) return;
        const name = err instanceof Error ? err.name : '';
        setStatus(name === 'NotAllowedError' || name === 'NotFoundError' ? 'denied' : 'unsupported');
      });

    return () => {
      cancelled = true;
      controlsRef.current?.stop();
      controlsRef.current = null;
    };
  }, [onDetect]);

  return (
    <div className="xp-scanner-overlay" role="dialog" aria-modal="true" aria-label={title || 'Scan barcode'}>
      <div className="xp-scanner-card">
        <div className="xp-scanner-header">
          <span className="xp-scanner-title">{title || 'Scan a barcode'}</span>
          <button type="button" className="xp-scanner-close" onClick={onClose} aria-label="Close scanner">
            <X size={18} strokeWidth={2} />
          </button>
        </div>

        <div className="xp-scanner-viewport">
          <video ref={videoRef} className="xp-scanner-video" muted playsInline />
          {status === 'scanning' && (
            <div className="xp-scanner-frame" aria-hidden="true">
              <span className="xp-scanner-corner xp-scanner-corner-tl" />
              <span className="xp-scanner-corner xp-scanner-corner-tr" />
              <span className="xp-scanner-corner xp-scanner-corner-bl" />
              <span className="xp-scanner-corner xp-scanner-corner-br" />
              <span className="xp-scanner-laser" />
            </div>
          )}

          {status === 'starting' && (
            <div className="xp-scanner-state">
              <Camera size={28} strokeWidth={1.5} />
              <p>Starting camera…</p>
            </div>
          )}

          {status === 'denied' && (
            <div className="xp-scanner-state">
              <Camera size={28} strokeWidth={1.5} />
              <p>Camera access was denied or no camera is available.</p>
              <p className="xp-scanner-state-sub">Allow camera access, or type the barcode in manually below.</p>
            </div>
          )}

          {status === 'unsupported' && (
            <div className="xp-scanner-state">
              <Camera size={28} strokeWidth={1.5} />
              <p>This browser doesn't support camera scanning.</p>
              <p className="xp-scanner-state-sub">Type the barcode in manually below.</p>
            </div>
          )}
        </div>

        <p className="xp-scanner-hint">
          {status === 'scanning' ? 'Point the camera at a barcode' : ' '}
        </p>
      </div>
    </div>
  );
}
