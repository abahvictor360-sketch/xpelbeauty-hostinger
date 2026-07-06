import { useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, useLocation } from 'react-router-dom';
import './index.css';
import './App.css';

// Layout components
import Header from './components/layout/Header';
import Footer from './components/layout/Footer';
import { useSiteContent } from './hooks/useSiteContent';

function ScrollToTop() {
  const { pathname } = useLocation();
  useEffect(() => { window.scrollTo(0, 0); }, [pathname]);
  return null;
}

/** Injects admin-chosen theme colours as CSS custom-properties into :root */
function ThemeStyle() {
  const c = useSiteContent();
  // Only render the override tag when admin has customised from defaults
  const accent = c.themeAccent || '#ca7c29';
  const navy   = c.themeNavy   || '#1B2A3B';
  const from   = c.themeBarFrom || accent;
  const mid    = c.themeBarMid  || '#6f3716';
  return (
    <style>{`
      :root {
        --gold-raw:   ${accent};
        --gold:       ${accent};
        --gold-hover: ${accent};
        --navy:       ${navy};
      }
      .top-gradient-bar {
        background: linear-gradient(90deg, ${from} 0%, ${mid} 50%, ${from} 100%) !important;
      }
    `}</style>
  );
}

// Page components
import Home from './pages/Home';
import Shop from './pages/Shop';
import Product from './pages/Product';
import Blog from './pages/Blog';
import BlogPost from './pages/BlogPost';
import About from './pages/About';
import Contact from './pages/Contact';
import Stores from './pages/Stores';
import Admin from './pages/Admin';
import Collection from './pages/Collection';
import Privacy from './pages/Privacy';
import NotFound from './pages/NotFound';

function Layout() {
  const location = useLocation();
  // Admin has its own full-screen chrome — hide the storefront header/footer
  const isAdmin = location.pathname.startsWith('/admin');

  if (isAdmin) {
    return (
      <Routes>
        <Route path="/admin/*" element={<Admin />} />
      </Routes>
    );
  }

  return (
    <div className="flex flex-col min-h-screen">
      <ScrollToTop />
      <ThemeStyle />
      <Header />
      <main className="flex-grow">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/shop" element={<Shop />} />
          <Route path="/collection/:slug" element={<Collection />} />
          <Route path="/product/:id" element={<Product />} />
          <Route path="/blog" element={<Blog />} />
          <Route path="/blog/:slug" element={<BlogPost />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/stores" element={<Stores />} />
          <Route path="/privacy" element={<Privacy />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

function App() {
  return (
    <Router>
      <Layout />
    </Router>
  );
}

export default App;
