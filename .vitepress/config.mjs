import { defineConfig } from 'vitepress'
import { siteConfig } from './theme/site-config.js'

const { seo, brand } = siteConfig

export default defineConfig({
  vite: {
    ssr: {
      noExternal: [],
    },
    build: {
      rollupOptions: {
        external: (id) => id.startsWith('/manus-storage/'),
      },
    },
  },

  title: brand.name,
  description: brand.description,
  lang: 'en-US',

  head: [
    ['script', { async: '', src: `https://www.googletagmanager.com/gtag/js?id=${seo.ga4}` }],
    ['script', {}, `
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', '${seo.ga4}');
    `],
    ['link', { rel: 'icon', type: 'image/png', href: '/favicon.png' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: brand.name }],
    ['meta', { property: 'og:description', content: brand.description }],
    ['meta', { property: 'og:image', content: '/favicon.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['meta', { name: 'twitter:title', content: brand.name }],
    ['meta', { name: 'twitter:description', content: brand.description }],
    ['meta', { name: 'keywords', content: seo.keywords.join(', ') }],
    ['script', { type: 'application/ld+json' }, JSON.stringify({
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      name: brand.name,
      url: seo.hostname,
      description: brand.description,
    })],
    ['script', { charset: 'UTF-8', id: 'LA_COLLECT', src: '//sdk.51.la/js-sdk-pro.min.js' }],
    ['script', {}, 'LA.init({id:"3QeJ4R8Vu6YpAFhK",ck:"3QeJ4R8Vu6YpAFhK"})'],
  ],

  themeConfig: {
    nav: siteConfig.nav,

    notFound: {
      quote: 'The page you are looking for does not exist.',
      linkLabel: 'Back to Home',
      linkUrl: '/',
    },

    docFooter: {
      prev: false,
      next: false,
    },

    lastUpdated: false,
    editLink: undefined,
  },

  sitemap: {
    hostname: seo.hostname,
  },

  ignoreDeadLinks: [
    /^http:\/\/localhost/,
    /^\/Kakobuy-/,
    /^\/is-/,
  ],

  cleanUrls: 'with-subfolders',

  srcExclude: [
    'Kakobuy-article-prompt.md',
    'Kakobuy-internal-link-rules.md',
    'Kakobuy-product-reference.md',
    'Kakobuy-review-report.md',
    'Kakobuy-topic-list.md',
    'flexible-article-generator.md',
    'topic-matrix.md',
    'ideas.md',
    'CONTENT_CHECKLIST.md',
    'LOCAL_SETUP.md',
    'PRODUCT_WORKFLOW.md',
    'WEBSITE_STRUCTURE.md',
  ],
})
