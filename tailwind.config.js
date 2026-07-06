/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        gold: {
          DEFAULT: '#ca7c29',
          raw: '#ca7c29',
          hover: '#b36b1f',
        },
        navy: '#1a1f3a',
        dark: '#0f1117',
      },
      fontFamily: {
        cormorant: ['Cormorant Garamond', 'serif'],
        jost: ['Jost', 'sans-serif'],
        inter: ['Jost', 'sans-serif'], // alias kept for backwards compat
      },
      backgroundImage: {
        'gradient-gold': 'linear-gradient(90deg, #ca7c29 0%, #a5621a 50%, #ca7c29 100%)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
