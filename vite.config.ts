import { defineConfig, type Plugin } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// Production builds avoid obvious stack fingerprints: no HTML comments,
// neutral /static/<hash> file names, no console output, no source maps.
const stripHtmlComments = (): Plugin => ({
  name: 'strip-html-comments',
  apply: 'build',
  transformIndexHtml: (html) => html.replace(/<!--[\s\S]*?-->\s*/g, ''),
})

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), stripHtmlComments()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 5173,
    open: true,
  },
  build: {
    sourcemap: false,
    assetsDir: 'static',
    rolldownOptions: {
      output: {
        entryFileNames: 'static/[hash].js',
        chunkFileNames: 'static/[hash].js',
        assetFileNames: 'static/[hash][extname]',
        minify: { compress: { dropConsole: true, dropDebugger: true } },
      },
    },
  },
})
