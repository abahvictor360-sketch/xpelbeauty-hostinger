import { Link } from 'react-router-dom';
import SEO from '@/components/SEO';

export default function NotFound() {
  return (
    <div
      style={{
        minHeight: '60vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        textAlign: 'center',
        padding: '80px 24px',
      }}
    >
      <SEO
        page="home"
        overrides={{
          fullTitle: 'Page Not Found | Xpel Beauty NG',
          description: "Sorry, the page you're looking for doesn't exist or has been moved. Browse Xpel Beauty NG's full range of hair, skin and body care products instead.",
          robots: 'noindex, follow',
        }}
      />
      <span className="section-label">error 404</span>
      <h1
        className="section-title"
        style={{ fontSize: '64px', margin: '8px 0 4px' }}
      >
        page not found
      </h1>
      <p style={{ color: 'var(--muted)', fontSize: '15px', maxWidth: '440px', lineHeight: 1.7 }}>
        Sorry, the page you're looking for doesn't exist or has been moved.
      </p>
      <Link
        to="/"
        style={{
          display: 'inline-block',
          marginTop: '28px',
          padding: '14px 42px',
          borderRadius: '9999px',
          background: 'var(--gold-raw)',
          color: 'white',
          fontSize: '13px',
          fontWeight: 600,
          textTransform: 'uppercase',
          letterSpacing: '1.5px',
          textDecoration: 'none',
        }}
      >
        Back to Home
      </Link>
    </div>
  );
}
