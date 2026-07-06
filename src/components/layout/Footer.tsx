import { Link } from 'react-router-dom';
import { useSiteContent } from '@/hooks/useSiteContent';
import './Footer.css';

export default function Footer() {
  const currentYear = new Date().getFullYear();
  const content = useSiteContent();

  return (
    <footer className="site-footer">
      <div className="footer-top">
        <div>
          <img
            src="/images/logo-xpel-beauty-ng-white.svg"
            alt="Xpel Beauty NG"
            style={{ height: '60px', width: 'auto', display: 'block' }}
            onError={(e) => {
              const img = e.target as HTMLImageElement;
              img.src = '/images/logo-white.svg';
            }}
          />
          <div className="footer-tagline">{content.footerTagline}</div>
        </div>
      </div>

      <div className="footer-grid">
        <div>
          <span className="footer-col-heading">our products</span>
          <Link to="/shop?cat=body-beauty" className="footer-link">
            Body & Beauty
          </Link>
          <Link to="/shop?cat=hair-care" className="footer-link">
            Hair Care
          </Link>
          <Link to="/shop?cat=travel-health" className="footer-link">
            Travel & Health
          </Link>
          <Link to="/shop?cat=home" className="footer-link">
            Home
          </Link>
          <Link to="/shop?cat=gifting" className="footer-link">
            Gifting
          </Link>
        </div>

        <div>
          <span className="footer-col-heading">information</span>
          <Link to="/" className="footer-link">
            Home
          </Link>
          <Link to="/about" className="footer-link">
            About
          </Link>
          <Link to="/stores" className="footer-link">
            Stores
          </Link>
          <Link to="/contact" className="footer-link">
            Contact
          </Link>
          <Link to="/privacy" className="footer-link">
            Privacy Policy
          </Link>
        </div>

        <div>
          <span className="footer-col-heading">contact</span>
          <p className="footer-address">
            {content.footerCompany}
            <br />
            {content.footerAddress}
          </p>
          {content.footerPhone1 && (
            <a href={`tel:${content.footerPhone1.replace(/\s/g, '')}`} className="footer-link" style={{ marginTop: '12px' }}>
              {content.footerPhone1}
            </a>
          )}
          {content.footerPhone2 && (
            <a href={`tel:${content.footerPhone2.replace(/\s/g, '')}`} className="footer-link">
              {content.footerPhone2}
            </a>
          )}
          {content.footerEmail && (
            <a href={`mailto:${content.footerEmail}`} className="footer-link">
              {content.footerEmail}
            </a>
          )}
        </div>
      </div>

      <hr className="footer-divider" />

      <div className="footer-bottom">
        <span className="footer-copy">
          © Xpel Beauty NG {currentYear} · All Rights Reserved
        </span>
      </div>
    </footer>
  );
}
