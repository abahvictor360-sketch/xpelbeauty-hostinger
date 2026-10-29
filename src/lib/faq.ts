/** Homepage FAQ. Shared by the page and the prerender, so the FAQPage schema is in the static HTML. */
export const HOME_FAQS: Array<{ q: string; a: string }> = [
  {
    q: 'Is Xpel Beauty NG a wholesaler or a retailer?',
    a: 'Xpel Beauty NG is a B2B business and the exclusive distributor of Xpel Beauty Care in Nigeria. We sell in bulk to distributors, wholesalers and retailers, and shoppers buy our products from those stores.',
  },
  {
    q: 'How do I become an Xpel Beauty Care distributor or stockist?',
    a: 'Send a trade enquiry on the Contact page or message us on WhatsApp. Tell us your business name, your location and the products you want to stock, and our sales team will get back to you.',
  },
  {
    q: 'Can I buy Xpel Beauty products directly as an individual?',
    a: 'We supply businesses, not individual shoppers. You can buy any of our products at more than 600 supermarkets, pharmacies and beauty stores across Nigeria. The Stores page lists them by state and city.',
  },
  {
    q: 'Which parts of Nigeria do you supply?',
    a: 'We supply distributors and retailers in 22 states, including Lagos, Abuja and Port Harcourt. Our office is at Trade Fair International Market, Lagos.',
  },
  {
    q: 'What products can distributors stock?',
    a: 'Hair care, skin and body care, oral care, nail and foot care, makeup essentials, men\'s grooming and home essentials, from shampoos, face washes and body creams to toothpaste, mouthwash and hand wash. The full range is in the shop and the printable catalogue.',
  },
  {
    q: 'What ingredients do Xpel Beauty products use?',
    a: 'Each range is built around one key ingredient, such as argan oil, tea tree, aloe vera, vitamin C, neem oil or coconut. Every product page lists what it does and how to use it, and many ranges carry a vegan mark.',
  },
];

export function faqPageJsonLd() {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: HOME_FAQS.map((f) => ({ '@type': 'Question', name: f.q, acceptedAnswer: { '@type': 'Answer', text: f.a } })),
  };
}
