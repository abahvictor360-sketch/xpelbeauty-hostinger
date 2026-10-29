import { Link } from 'react-router-dom';
import { MapPin, Phone, Mail, MessageCircle } from 'lucide-react';
import { useSiteContent } from '@/hooks/useSiteContent';
import { officeMapUrl } from '@/lib/map';
import { formatNgPhone } from '@/lib/phone';
import './Footer.css';

export default function Footer() {
  const currentYear = new Date().getFullYear();
  const content = useSiteContent();

  return (
    <footer className="site-footer">
      <div className="footer-top">
        <div>
          <img
            src={content.footerLogo || content.logo}
            alt="Xpel Beauty NG"
            style={{ height: '60px', width: 'auto', display: 'block' }}
            onError={(e) => { (e.target as HTMLImageElement).src = '/images/logo-xpel-beauty-ng.svg'; }}
          />
          <div className="footer-tagline">{content.footerTagline}</div>
        </div>
      </div>

      <div className="footer-grid">
        <div>
          <span className="footer-col-heading">our products</span>
          <Link to="/catalogue" className="footer-link">
            Full Catalogue
          </Link>
          <Link to="/shop?cat=body-beauty" className="footer-link">
            Body & Beauty
          </Link>
          <Link to="/shop?cat=hair-care" className="footer-link">
            Hair Care
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

          <div className="footer-contact-row">
            <span className="footer-contact-icon" aria-hidden="true"><MapPin size={15} strokeWidth={2} /></span>
            <p className="footer-address">
              {content.footerCompany}
              <br />
              <a
                href={officeMapUrl(content)}
                target="_blank"
                rel="noopener noreferrer"
                className="footer-address-link"
              >
                {content.footerAddress}
              </a>
            </p>
          </div>

          {(content.footerPhone1 || content.footerPhone2) && (
            <div className="footer-contact-row">
              <span className="footer-contact-icon" aria-hidden="true"><Phone size={15} strokeWidth={2} /></span>
              <div>
                {content.footerPhone1 && (
                  <a href={`tel:${content.footerPhone1.replace(/\s/g, '')}`} className="footer-link">
                    {content.footerPhone1}
                  </a>
                )}
                {content.footerPhone2 && (
                  <a href={`tel:${content.footerPhone2.replace(/\s/g, '')}`} className="footer-link">
                    {content.footerPhone2}
                  </a>
                )}
              </div>
            </div>
          )}

          {content.whatsappEnabled !== false && content.whatsappNumber && (
            <div className="footer-contact-row">
              <span className="footer-contact-icon" aria-hidden="true"><MessageCircle size={15} strokeWidth={2} /></span>
              <a href={`https://wa.me/${content.whatsappNumber.replace(/\D/g, '')}`} target="_blank" rel="noopener noreferrer"
                className="footer-link" aria-label={`WhatsApp ${formatNgPhone(content.whatsappNumber)}`}>
                WhatsApp: {formatNgPhone(content.whatsappNumber)}
              </a>
            </div>
          )}

          {content.footerEmail && (
            <div className="footer-contact-row">
              <span className="footer-contact-icon" aria-hidden="true"><Mail size={15} strokeWidth={2} /></span>
              <a href={`mailto:${content.footerEmail}`} className="footer-link">
                {content.footerEmail}
              </a>
            </div>
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
