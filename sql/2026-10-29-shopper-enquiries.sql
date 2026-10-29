-- Xpel Beauty NG (2026-10-29): Shoppers can ask about products and where to buy, alongside trade enquiries. Hostinger / MySQL.
-- Updates site text, banners and SEO; your other settings are kept. Safe to run more than once.
UPDATE `site_content` SET `data` = JSON_SET(`data`,
  '$.aboutStoryBody1', 'Xpel Beauty Care makes personal care, beauty and household products, from shampoo and face wash to toothpaste and hand wash. Xpel Beauty NG is the exclusive distributor of Xpel Beauty Care in Nigeria. We sell in bulk to distributors and retailers, and shoppers buy our products in their stores. Anyone can ask us about a product or where to find it.',
  '$.contactIntro', 'We sell in bulk to distributors, wholesalers and retailers. Tell us your business name, location and the products you want to stock, and our sales team will get back to you. Shoppers are welcome too: ask us about any product or where to buy it near you.',
  '$.storesIntro', 'Find a store near you that sells Xpel Beauty Care. Can''t see your area? Message us on WhatsApp and we will point you to the nearest stockist.',
  '$.banners.contact.text', 'Trade enquiries, product questions and where to buy.',
  '$.seo.defaultDescription', 'Exclusive Nigerian distributor of Xpel Beauty Care. We supply distributors and retailers in 22 states, and shoppers can buy our products at 600+ stores.',
  '$.seo.pages.home.description', 'Exclusive Nigerian distributor of Xpel Beauty Care. We supply 180+ hair, skin, body and home care products to distributors and retailers. Shoppers can buy at 600+ stores.',
  '$.seo.pages.home.keywords', 'xpel beauty distributor nigeria, wholesale beauty products nigeria, beauty products distributor nigeria, wholesale cosmetics lagos, bulk hair care products nigeria, where to buy xpel beauty care, xpel beauty near me, xpel beauty care nigeria, tea tree products nigeria, argan oil products nigeria',
  '$.seo.pages.stores.title', 'Where to Buy Xpel Beauty Care Near You in Nigeria',
  '$.seo.pages.stores.description', 'Find a store near you that sells Xpel Beauty Care. More than 600 supermarkets, pharmacies and beauty stores in Lagos, Abuja, Port Harcourt and 19 more states.',
  '$.seo.pages.stores.keywords', 'where to buy xpel beauty care, xpel beauty near me, xpel beauty stockists nigeria, xpel beauty care lagos store, xpel beauty abuja, buy xpel tea tree face wash, xpel beauty port harcourt',
  '$.seo.pages.contact.description', 'Contact Xpel Beauty NG in Lagos. Distributor and wholesale enquiries, product questions, and help finding a store that sells Xpel Beauty Care near you.',
  '$.seo.pages.contact.keywords', 'contact xpel beauty nigeria, become a distributor nigeria, xpel beauty wholesale enquiry, xpel beauty product question, where to buy xpel beauty care, xpel beauty customer care') WHERE `id` = 1;
