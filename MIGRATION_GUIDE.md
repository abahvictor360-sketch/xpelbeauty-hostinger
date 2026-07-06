# Xpel Beauty NG - Vanilla to React Migration Guide

## Project Overview

This is the React + Vite conversion of the Xpel Beauty NG e-commerce platform. The original vanilla HTML/CSS/JavaScript implementation has been migrated to a modern React stack while preserving all functionality and the Supabase backend.

## What's Changed

### Technology Stack
- **Before**: Vanilla HTML, CSS, JavaScript
- **After**: React 19, Vite, TypeScript, Tailwind CSS, Zustand, React Router

### Key Improvements
1. **Component-Based Architecture**: Reusable, maintainable components
2. **State Management**: Centralized cart state with Zustand
3. **Type Safety**: Full TypeScript support
4. **Build Performance**: Vite for faster development and builds
5. **Styling**: Tailwind CSS for utility-first CSS
6. **Routing**: React Router v6 for client-side navigation

## Project Structure

```
xpel-react/
├── src/
│   ├── components/
│   │   └── layout/
│   │       ├── Header.tsx      # Navigation header with search and cart
│   │       ├── Header.css      # Header styles
│   │       ├── Footer.tsx      # Site footer
│   │       └── Footer.css      # Footer styles
│   ├── hooks/
│   │   ├── useProducts.ts      # Product fetching and CRUD
│   │   ├── useBlog.ts          # Blog post operations
│   │   └── useStores.ts        # Store locations
│   ├── lib/
│   │   └── supabase.ts         # Supabase client setup
│   ├── pages/
│   │   ├── Home.tsx            # Landing page
│   │   ├── Shop.tsx            # Product listing with filters
│   │   ├── Product.tsx         # Product detail page
│   │   ├── Cart.tsx            # Shopping cart
│   │   ├── Checkout.tsx        # Checkout form
│   │   ├── ThankYou.tsx        # Order confirmation
│   │   ├── Blog.tsx            # Blog listing
│   │   ├── BlogPost.tsx        # Individual blog post
│   │   ├── About.tsx           # About page
│   │   ├── Contact.tsx         # Contact form
│   │   ├── Stores.tsx          # Store locations
│   │   └── Admin.tsx           # Admin dashboard
│   ├── store/
│   │   └── cartStore.ts        # Zustand cart state management
│   ├── types/
│   │   └── index.ts            # TypeScript type definitions
│   ├── App.tsx                 # Main app with routing
│   ├── App.css                 # App styles
│   ├── index.css               # Global styles
│   └── main.tsx                # React entry point
├── .env                        # Environment variables (Supabase credentials)
├── .env.example                # Example environment file
├── vite.config.ts              # Vite configuration
├── tailwind.config.js          # Tailwind CSS configuration
├── postcss.config.js           # PostCSS configuration
├── tsconfig.json               # TypeScript configuration
└── package.json                # Dependencies and scripts
```

## Installation & Setup

### Prerequisites
- Node.js 18+ and npm
- Supabase account with configured database

### Local Development

1. **Install Dependencies**
```bash
cd xpel-react
npm install
```

2. **Configure Environment Variables**
Copy `.env.example` to `.env` and update with your Supabase credentials:
```bash
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

3. **Start Development Server**
```bash
npm run dev
```

The app will be available at `http://localhost:5173`

### Production Build

```bash
npm run build
npm run preview
```

## Migration Details

### Data Model & Supabase

The Supabase backend remains completely unchanged. All tables and their schemas are preserved:

#### Products Table
```sql
CREATE TABLE products (
  id BIGINT PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT,
  category TEXT,
  price NUMERIC,
  stock INT,
  image TEXT,
  description TEXT,
  size TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

#### Blog Posts Table
```sql
CREATE TABLE blog_posts (
  id BIGINT PRIMARY KEY,
  title TEXT NOT NULL,
  slug TEXT UNIQUE,
  content TEXT,
  excerpt TEXT,
  image TEXT,
  author TEXT,
  published BOOLEAN,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

#### Stores Table
```sql
CREATE TABLE stores (
  id BIGINT PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT,
  city TEXT,
  state TEXT,
  phone TEXT,
  email TEXT,
  hours TEXT,
  latitude NUMERIC,
  longitude NUMERIC,
  created_at TIMESTAMP
);
```

#### Orders Table (New)
```sql
CREATE TABLE orders (
  id BIGINT PRIMARY KEY,
  customer_name TEXT NOT NULL,
  customer_email TEXT,
  customer_phone TEXT,
  items JSONB,
  subtotal NUMERIC,
  tax NUMERIC,
  shipping NUMERIC,
  total NUMERIC,
  status TEXT,
  payment_method TEXT,
  delivery_address TEXT,
  notes TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

### Custom React Hooks

#### useProducts(category?)
Fetches products from Supabase, optionally filtered by category.

```typescript
const { products, loading, error } = useProducts('Hair Care');
```

#### useBlogPosts()
Fetches all published blog posts ordered by date.

```typescript
const { posts, loading, error } = useBlogPosts();
```

#### useBlogPost(slug)
Fetches a single blog post by slug.

```typescript
const { post, loading, error } = useBlogPost('my-blog-post');
```

#### useStores()
Fetches all store locations.

```typescript
const { stores, loading, error } = useStores();
```

### State Management

#### Cart Store (Zustand)
Cart state is persisted to localStorage using Zustand middleware.

```typescript
import { useCart } from '@/store/cartStore';

const cart = useCart();
cart.addItem({ id: 1, name: 'Product', price: 5000, qty: 1 });
const total = cart.getTotal();
```

### Routing

All pages are routed using React Router v6:

```typescript
/                    - Home page
/shop                - Product listing
/product/:id         - Product detail
/cart                - Shopping cart
/checkout            - Checkout form
/thank-you           - Order confirmation
/blog                - Blog listing
/blog/:slug          - Blog post
/about               - About page
/contact             - Contact form
/stores              - Store locations
/admin               - Admin dashboard
```

## Key Features Implemented

### Completed
- [x] Component-based page structure
- [x] React Router navigation
- [x] Cart state management with Zustand
- [x] Product listing and filtering
- [x] Product detail page
- [x] Cart functionality (add, remove, update qty)
- [x] Checkout form
- [x] Blog listing and posts
- [x] Store locations
- [x] About and Contact pages
- [x] Admin dashboard scaffold
- [x] Header with navigation and cart badge
- [x] Footer with links
- [x] Tailwind CSS styling
- [x] TypeScript support
- [x] Environment variable configuration
- [x] Build configuration

### To Do / Next Steps
- [ ] Complete admin dashboard functionality
  - [ ] Product management panel
  - [ ] Blog management panel
  - [ ] Store management panel
  - [ ] Order management
  - [ ] Analytics dashboard
  - [ ] CSV import/export
- [ ] Order creation and persistence
- [ ] Email notifications for orders
- [ ] Search functionality
- [ ] Product reviews and ratings
- [ ] Wishlist/favorites
- [ ] User authentication
- [ ] Payment gateway integration (Paystack, Flutterwave)
- [ ] Image optimization
- [ ] SEO optimization (meta tags, sitemap)
- [ ] Testing (Jest, React Testing Library)
- [ ] Error boundary components

## CSS & Styling

### Tailwind CSS
The project uses Tailwind CSS for utility-first styling. All original Xpel Beauty design tokens are preserved:

**Color Variables:**
- `--gold-raw: #ca7c29`
- `--navy: #1B2A3B`
- `--dark: #1A1A1A`
- `--light-bg: #F5F5F5`

**Fonts:**
- Cormorant Garamond (serif) - Headings
- Inter (sans-serif) - Body text

### Custom CSS Files
- `src/index.css` - Global styles and Tailwind directives
- `src/App.css` - App-specific styles
- `src/components/layout/Header.css` - Header styles
- `src/components/layout/Footer.css` - Footer styles

## Environment Variables

Create a `.env` file in the project root:

```
VITE_SUPABASE_URL=https://jfzhjbqdxrxbxxbgyesl.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

Variables must be prefixed with `VITE_` to be accessible in the browser.

## Building & Deployment

### Development Build
```bash
npm run dev
```

### Production Build
```bash
npm run build
```

This creates optimized production files in the `dist/` directory.

### Preview Production Build
```bash
npm run preview
```

### Deployment Options

#### Vercel (Recommended for React apps)
```bash
npm i -g vercel
vercel
```

#### Netlify
```bash
npm i -g netlify-cli
netlify deploy --prod --dir=dist
```

#### GitHub Pages
Update `vite.config.ts` with base path and deploy `dist/` folder.

#### Traditional Hosting
Upload contents of `dist/` folder to your web server.

## Troubleshooting

### Common Issues

**Module not found errors**
- Ensure all imports use the `@/` path alias
- Check that file extensions are correct (.tsx for React components)

**Tailwind classes not applied**
- Ensure files are included in `tailwind.config.js` content array
- Rebuild CSS with `npm run dev`

**Supabase connection issues**
- Verify `.env` file has correct credentials
- Check Supabase project is active
- Ensure CORS is configured in Supabase settings

**Build errors**
- Run `npm install` to ensure all dependencies are installed
- Check TypeScript errors with `npx tsc --noEmit`
- Clear node_modules and reinstall if issues persist

## Performance Optimization

### Already Implemented
- Code splitting via Vite
- Lazy loading with React Router
- Image optimization recommendations
- CSS purging with Tailwind
- Minified production build

### Recommended Further Improvements
- Image lazy loading on product grid
- Pagination for product/blog lists
- React.memo for expensive components
- Service worker for offline capability
- CDN for static assets

## Security Considerations

- Supabase credentials are exposed in frontend (anon key only - this is expected)
- Use Supabase Row Level Security (RLS) policies for data protection
- Validate all user input on backend
- Use environment variables for sensitive data
- Enable HTTPS in production
- Configure CORS properly in Supabase

## Version Control

The project is configured with:
- `.gitignore` - Excludes node_modules, dist, .env, etc.
- `.env.example` - Template for environment variables
- GitHub-ready structure

## Support & Maintenance

### Development
For local development, use TypeScript for type safety and ESLint for code quality.

### Updates
To update dependencies:
```bash
npm update
npm audit fix
```

### Testing
Testing infrastructure is ready to be added:
```bash
npm install --save-dev vitest @testing-library/react @testing-library/jest-dom
```

## Additional Resources

- [Vite Documentation](https://vite.dev)
- [React Documentation](https://react.dev)
- [React Router Documentation](https://reactrouter.com)
- [Tailwind CSS Documentation](https://tailwindcss.com)
- [Zustand Documentation](https://github.com/pmndrs/zustand)
- [Supabase Documentation](https://supabase.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org)

## License

Same license as original Xpel Beauty NG project.
