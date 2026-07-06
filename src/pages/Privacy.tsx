export default function Privacy() {
  return (
    <div style={{ maxWidth: '860px', margin: '0 auto', padding: '64px 24px 80px' }}>
      <span className="section-label">legal</span>
      <h1 className="section-title section-title-anim" style={{ marginBottom: '24px' }}>
        privacy policy
      </h1>

      <div style={{ color: 'var(--dark)', fontSize: '15px', lineHeight: 1.8 }}>
        <p style={{ marginBottom: '20px' }}>
          Xpel Beauty NG is committed to protecting your
          privacy. This policy explains how we collect, use and safeguard your personal
          information when you use our website.
        </p>

        <h2 style={{ fontFamily: "'Cormorant Garamond', serif", fontSize: '26px', margin: '28px 0 12px' }}>
          Information We Collect
        </h2>
        <p style={{ marginBottom: '20px' }}>
          We may collect your name, email address, phone number and delivery address when
          you place an order, make an enquiry, or contact us. We only collect information
          necessary to provide our products and services.
        </p>

        <h2 style={{ fontFamily: "'Cormorant Garamond', serif", fontSize: '26px', margin: '28px 0 12px' }}>
          How We Use Your Information
        </h2>
        <p style={{ marginBottom: '20px' }}>
          Your information is used to process orders, respond to enquiries, improve our
          services and, with your consent, send you updates about our products and offers.
        </p>

        <h2 style={{ fontFamily: "'Cormorant Garamond', serif", fontSize: '26px', margin: '28px 0 12px' }}>
          Data Security
        </h2>
        <p style={{ marginBottom: '20px' }}>
          We implement appropriate security measures to protect your personal data against
          unauthorised access, alteration or disclosure.
        </p>

        <h2 style={{ fontFamily: "'Cormorant Garamond', serif", fontSize: '26px', margin: '28px 0 12px' }}>
          Contact Us
        </h2>
        <p>
          If you have any questions about this Privacy Policy, please contact us at{' '}
          <a href="mailto:info@xpelbeauty.com" style={{ color: 'var(--gold-raw)' }}>
            info@xpelbeauty.com
          </a>{' '}
          or call 08034883603.
        </p>
      </div>
    </div>
  );
}
