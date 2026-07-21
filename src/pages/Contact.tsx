import { useState } from 'react';
import { Phone, Mail, MessageCircle, MapPin, Clock } from 'lucide-react';
import { useSiteContent } from '@/hooks/useSiteContent';
import { api } from '@/lib/api';
import PromoBanner from '@/components/PromoBanner';
import SEO from '@/components/SEO';

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
const NAME_RE  = /^[\p{L}\s\-'.]+$/u;

function validate(d: { name: string; email: string; subject: string; message: string }) {
  const e: Record<string, string> = {};
  const name = d.name.trim(), email = d.email.trim(), subject = d.subject.trim(), message = d.message.trim();

  if (!name || name.length < 2)
    e.name = 'Please enter your full name (at least 2 characters).';
  else if (name.length > 100)
    e.name = 'Name must be under 100 characters.';
  else if (!NAME_RE.test(name))
    e.name = 'Name can only contain letters, spaces, hyphens, apostrophes and dots.';

  if (!email)
    e.email = 'Email address is required.';
  else if (email.length > 254 || !EMAIL_RE.test(email))
    e.email = 'Please enter a valid email address (e.g. you@example.com).';

  if (!subject || subject.length < 3)
    e.subject = 'Please enter a subject (at least 3 characters).';
  else if (subject.length > 200)
    e.subject = 'Subject must be under 200 characters.';

  if (!message || message.length < 20)
    e.message = `Message is too short — please provide more detail (${message.length}/20 characters).`;
  else if (message.length > 2000)
    e.message = 'Message must be under 2000 characters.';

  return e;
}

const BLANK = { name: '', email: '', subject: '', message: '', hp: '' };

export default function Contact() {
  const content  = useSiteContent();
  const waEnabled = content.whatsappEnabled !== false;
  const WA_NUMBER = content.whatsappNumber || '2348034883603';

  const [formData, setFormData] = useState(BLANK);
  const [errors,   setErrors]   = useState<Record<string, string>>({});
  const [status,   setStatus]   = useState<'idle' | 'sending' | 'done' | 'error'>('idle');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
    // Clear error for this field on change
    if (errors[name]) setErrors(prev => { const n = { ...prev }; delete n[name]; return n; });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const errs = validate(formData);
    if (Object.keys(errs).length > 0) { setErrors(errs); return; }
    setErrors({});
    setStatus('sending');
    try {
      await api.enquiries.create({
        type: 'contact',
        name:    formData.name.trim(),
        email:   formData.email.trim(),
        subject: formData.subject.trim(),
        message: formData.message.trim(),
        status:  'new',
        _hp:     formData.hp,
      });
      setStatus('done');
      setFormData(BLANK);
    } catch {
      setStatus('error');
    }
  };

  const waText = encodeURIComponent('Hi, I have an enquiry for Xpel Beauty NG.');

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <SEO page="contact" />
      <div className="mb-8"><PromoBanner banner={content.banners.contact} /></div>
      <h1 className="text-5xl font-cormorant mb-3">{content.contactTitle}</h1>
      <p className="text-gray-600 mb-8">{content.contactIntro}</p>

      <div className="xp-contact-grid">
        {/* Contact Form */}
        <div className="xp-contact-form-card">
        <h3 className="xp-contact-form-title">Send a message</h3>
        <p className="xp-contact-form-sub">Fill in the form and we'll reply within a few hours.</p>
        {status === 'done' ? (
          <div style={{ padding: '32px', background: '#f0fdf4', borderRadius: '12px', border: '1px solid #bbf7d0', textAlign: 'center' }}>
            <p style={{ fontSize: '24px', marginBottom: '8px' }}>✅</p>
            <h3 style={{ fontWeight: 700, marginBottom: '8px' }}>Message received!</h3>
            <p style={{ color: '#166534' }}>We'll get back to you within a few hours.</p>
            <button
              style={{ marginTop: '16px', padding: '8px 24px', background: 'var(--gold-raw)', color: '#fff', border: 'none', borderRadius: '99px', cursor: 'pointer', fontWeight: 600 }}
              onClick={() => setStatus('idle')}
            >
              Send Another
            </button>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4" noValidate>

            {/* ── Honeypot (invisible to real users, bots fill it) ── */}
            <div style={{ position: 'absolute', left: '-9999px', top: '-9999px', opacity: 0, height: 1, width: 1, overflow: 'hidden', pointerEvents: 'none' }} aria-hidden="true">
              <label htmlFor="website_url">Website</label>
              <input
                type="text"
                id="website_url"
                name="hp"
                value={formData.hp}
                onChange={handleChange}
                tabIndex={-1}
                autoComplete="off"
              />
            </div>

            <div>
              <label className="block font-semibold mb-1">Name <span style={{ color: '#dc2626' }}>*</span></label>
              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
                placeholder="e.g. Adaeze Okafor"
                className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-gold-raw"
                style={errors.name ? { borderColor: '#dc2626' } : {}}
              />
              {errors.name && <p style={{ color: '#dc2626', fontSize: 13, marginTop: 4 }}>{errors.name}</p>}
            </div>

            <div>
              <label className="block font-semibold mb-1">Email <span style={{ color: '#dc2626' }}>*</span></label>
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                placeholder="e.g. you@example.com"
                className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-gold-raw"
                style={errors.email ? { borderColor: '#dc2626' } : {}}
              />
              {errors.email && <p style={{ color: '#dc2626', fontSize: 13, marginTop: 4 }}>{errors.email}</p>}
            </div>

            <div>
              <label className="block font-semibold mb-1">Subject <span style={{ color: '#dc2626' }}>*</span></label>
              <input
                type="text"
                name="subject"
                value={formData.subject}
                onChange={handleChange}
                placeholder="e.g. Product availability question"
                className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-gold-raw"
                style={errors.subject ? { borderColor: '#dc2626' } : {}}
              />
              {errors.subject && <p style={{ color: '#dc2626', fontSize: 13, marginTop: 4 }}>{errors.subject}</p>}
            </div>

            <div>
              <label className="block font-semibold mb-1">Message <span style={{ color: '#dc2626' }}>*</span></label>
              <textarea
                name="message"
                value={formData.message}
                onChange={handleChange}
                placeholder="Tell us what you'd like to know…"
                className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-gold-raw"
                style={errors.message ? { borderColor: '#dc2626' } : {}}
                rows={5}
              />
              {errors.message && <p style={{ color: '#dc2626', fontSize: 13, marginTop: 4 }}>{errors.message}</p>}
            </div>

            {status === 'error' && (
              <p style={{ color: '#dc2626', fontSize: 13 }}>Something went wrong — please try again.</p>
            )}

            <button
              type="submit"
              disabled={status === 'sending'}
              className="w-full py-3 bg-gold-raw text-white rounded-full font-bold uppercase tracking-widest text-sm hover:bg-gold-hover transition"
              style={{ opacity: status === 'sending' ? 0.7 : 1 }}
            >
              {status === 'sending' ? 'Sending…' : 'Send Message'}
            </button>

            {waEnabled && (
              <a
                href={`https://wa.me/${WA_NUMBER}?text=${waText}`}
                target="_blank"
                rel="noopener noreferrer"
                style={{
                  display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px',
                  padding: '12px', border: '2px solid #25D366', borderRadius: '99px',
                  color: '#25D366', fontWeight: 700, fontSize: '14px', textDecoration: 'none',
                  letterSpacing: '0.05em', textTransform: 'uppercase', transition: 'background 0.2s',
                }}
                onMouseEnter={e => (e.currentTarget.style.background = '#f0fdf4')}
                onMouseLeave={e => (e.currentTarget.style.background = 'transparent')}
              >
                <svg width="18" height="18" viewBox="0 0 24 24" fill="#25D366"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
                Chat on WhatsApp
              </a>
            )}
          </form>
        )}
        </div>

        {/* Contact Info — navy panel */}
        <aside className="xp-contact-panel">
          <h3 className="xp-contact-panel-title">Get in touch</h3>
          <p className="xp-contact-panel-sub">
            Have questions? We'd love to hear from you. Reach out through any of the following channels.
          </p>

          <div className="xp-contact-rows">
            <div className="xp-contact-row">
              <span className="xp-contact-row-icon" aria-hidden="true"><Phone size={17} strokeWidth={2} /></span>
              <div>
                <p className="xp-contact-row-label">Phone</p>
                <p className="xp-contact-row-value">
                  {(content.contactPhones ?? []).filter(p => p.trim()).map((phone, i) => (
                    <a key={i} href={`tel:${phone.replace(/\s/g, '')}`} style={{ display: 'block' }}>{phone}</a>
                  ))}
                </p>
              </div>
            </div>

            <div className="xp-contact-row">
              <span className="xp-contact-row-icon" aria-hidden="true"><Mail size={17} strokeWidth={2} /></span>
              <div>
                <p className="xp-contact-row-label">Email</p>
                <p className="xp-contact-row-value">
                  <a href={`mailto:${content.contactEmail}`}>{content.contactEmail}</a>
                </p>
              </div>
            </div>

            {waEnabled && (
              <div className="xp-contact-row">
                <span className="xp-contact-row-icon" aria-hidden="true"><MessageCircle size={17} strokeWidth={2} /></span>
                <div>
                  <p className="xp-contact-row-label">WhatsApp</p>
                  <p className="xp-contact-row-value">
                    <a href={`https://wa.me/${WA_NUMBER}`} target="_blank" rel="noopener noreferrer">
                      Chat with us on WhatsApp
                    </a>
                  </p>
                </div>
              </div>
            )}

            <div className="xp-contact-row">
              <span className="xp-contact-row-icon" aria-hidden="true"><MapPin size={17} strokeWidth={2} /></span>
              <div>
                <p className="xp-contact-row-label">Address</p>
                <p className="xp-contact-row-value">{content.contactAddress}</p>
              </div>
            </div>

            <div className="xp-contact-row">
              <span className="xp-contact-row-icon" aria-hidden="true"><Clock size={17} strokeWidth={2} /></span>
              <div>
                <p className="xp-contact-row-label">Business Hours</p>
                <p className="xp-contact-row-value">{content.contactHours}</p>
              </div>
            </div>
          </div>
        </aside>
      </div>
    </div>
  );
}
