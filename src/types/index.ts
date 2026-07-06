/* Product Types */
export interface Product {
  id: number;
  name: string;
  brand: string;
  category: string;
  price: number;
  stock: number;
  image: string;
  description: string;
  size?: string;
  key_benefits?: string;
  how_to_use?: string;
  created_at?: string;
  updated_at?: string;
}

/* Blog Types */
export interface BlogPost {
  id: number;
  title: string;
  slug: string;
  content: string;
  excerpt: string;
  image: string;
  author: string;
  created_at: string;
  updated_at: string;
  published: boolean;
}

/* Store Types */
export interface Store {
  id: number;
  name: string;
  address: string;
  city: string;
  state: string;
  phone: string;
  email: string;
  hours: string;
  logo?: string;       // URL or base64 data URL for the store's logo/image
  latitude?: number;
  longitude?: number;
  created_at?: string;
}

