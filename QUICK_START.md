# Admin Dashboard - Quick Start Guide

## Access the Admin Dashboard

```bash
# Start development server
npm run dev

# Navigate to
http://localhost:5173/admin
```

## Dashboard Overview

### Sidebar Navigation (Left)
- **📊 Overview** - Dashboard metrics and activity
- **📦 Products** - Product inventory management
- **🛒 Orders** - Order viewing and tracking
- **📝 Blog** - Blog post creation and management
- **🏪 Stores** - Store location management
- **📈 Analytics** - Customer analytics (coming soon)
- **🎟️ Coupons** - Discount management (coming soon)
- **👥 Users** - Admin user management (coming soon)
- **📥 Import/Export** - Data import/export tools
- **⚙️ Settings** - Site configuration (coming soon)

### Supabase Connection Status
- Green dot = Connected to Supabase
- Red dot = Connection failed
- Shows in sidebar footer

---

## Main Features

### 📊 Dashboard Overview
Shows key metrics:
- Total Products count
- Total Orders count
- Total Blog Posts count
- Total Stores count
- Recent orders (latest 5)
- Popular products (first 5)

### 📦 Product Manager
**View Products:**
- Data table with all products
- Search by product name
- See price, stock, category, brand

**Add Product:**
1. Click "➕ Add Product" button
2. Fill in product details:
   - Product Name (required)
   - Brand
   - Category
   - Price in Naira (required)
   - Stock quantity (required)
   - Size (optional)
   - Description
   - Image URL
3. Click "Create Product"

**Edit Product:**
1. Click ✏️ icon next to product
2. Modify any fields
3. Click "Update Product"

**Delete Product:**
1. Click 🗑️ icon next to product
2. Confirm deletion
3. Product is removed

### 🛒 Order Management
- View all customer orders
- See order status (Pending, Processing, Shipped, Delivered, Cancelled)
- Search by customer email
- View order total and date
- Click "🔄 Refresh" to reload

### 📝 Blog Manager
**View Blog Posts:**
- Grid layout showing all posts
- See title, excerpt, author
- Shows if published or draft
- Search by title

**Add Blog Post:**
1. Click "➕ New Post"
2. Fill details:
   - Title (required)
   - Content (required)
   - Author (optional)
   - Excerpt (optional)
   - Slug (optional)
   - Image URL (optional)
3. Check "Publish this post" to publish
4. Click "Create Post"

### 🏪 Store Manager
**View Stores:**
- Card layout showing all store locations
- See address, city, phone, email
- Search by store name

**Add Store:**
1. Click "➕ Add Store"
2. Fill details:
   - Store Name (required)
   - Address (required)
   - City (optional)
   - State (optional)
   - Phone (required)
   - Email (optional)
   - Hours (optional)
3. Click "Create Store"

### 📥 Import/Export
**Import Data:**
1. Upload CSV file for Products or Stores
2. CSV must have proper headers
3. System automatically imports

**Export Data:**
1. Click export button for desired data
2. CSV file downloads automatically

---

## Notifications

### Success (Green) ✓
- Product created successfully
- Updates and deletions confirmed

### Error (Red) ✕
- Failed to load/save data
- CSV format errors

### Info (Blue) ℹ
- General information

All notifications auto-dismiss after 4 seconds.

---

## Common Tasks

### Create a New Product
1. Click "Products" → Click "➕ Add Product"
2. Enter Name, Price, Stock (required)
3. Click "Create Product"
4. See success notification

### Search Products
1. Click "Products"
2. Type in search box
3. Table filters in real-time

### Export Products to CSV
1. Click "Import/Export"
2. Click "📊 Export Products"
3. File downloads automatically

### Publish a Blog Post
1. Click "Blog" → Click "➕ New Post"
2. Enter title and content (required)
3. Check "Publish this post"
4. Click "Create Post"

---

## Tips

- **Required fields** are marked with *
- **Delete operations** require confirmation
- **Search is real-time** as you type
- **CSV files** can bulk import products/stores
- **Mobile friendly** - responsive design included

---

**Status:** ✅ Production Ready
**Documentation:** See TEST_REPORT.md, DELIVERABLES.md, ADMIN_DASHBOARD_SUMMARY.md
