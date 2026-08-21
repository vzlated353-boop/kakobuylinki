import { defineConfig } from 'vitepress'
import { siteConfig } from './theme/site-config.js'
import { indexableBlogPaths, missingBlogPaths, noindexRelativePaths } from './indexing-policy.mjs'

const { seo, brand } = siteConfig

function pathFromRelativePath(relativePath) {
  const path = relativePath.replace(/\.md$/, '').replace(/index$/, '')
  return `/${path}`.replace(/\/{2,}/g, '/').replace(/\/$/, '') || '/'
}

function normalizedPath(urlOrPath) {
  const pathname = /^https?:\/\//.test(urlOrPath)
    ? new URL(urlOrPath).pathname
    : urlOrPath
  return `/${pathname}`.replace(/\/{2,}/g, '/').replace(/\/index\/?$/, '').replace(/\/$/, '') || '/'
}

const noindexPaths = new Set([...noindexRelativePaths].map(pathFromRelativePath))
const retiredBlogRedirects = new Map([
  ['/blog/kakobuy-casual', '/blog/kakobuy-streetwear/'],
  ['/blog/kakobuy-spreadsheet', '/'],
  ['/blog/kakobuy-summer', '/blog/kakobuy-summer-clothes/'],
  ['/blog/kakobuy-winter', '/blog/kakobuy-winter-clothes/'],
])

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
    ['link', { rel: 'icon', type: 'image/png', href: '/favicon.png' }],
    ['link', { rel: 'preload', as: 'image', href: '/images/hero-1200w.webp', fetchpriority: 'high' }],
    ['link', { rel: 'preconnect', href: 'https://www.googletagmanager.com', crossorigin: '' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: seo.title }],
    ['meta', { property: 'og:description', content: seo.description }],
    ['meta', { property: 'og:image', content: '/favicon.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['meta', { name: 'twitter:title', content: seo.title }],
    ['meta', { name: 'twitter:description', content: seo.description }],
    ['meta', { name: 'keywords', content: seo.keywords.join(', ') }],
    ['script', { type: 'application/ld+json' }, JSON.stringify({
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      name: brand.name,
      url: seo.hostname,
      description: brand.description,
    })],
    // Conversion events are sent only after the visitor has granted analytics consent.
    ['script', {}, `
      (function() {
        function sendTracking(eventName, sendTo) {
          if (localStorage.getItem('consentGranted') === 'true' && typeof window.gtag === 'function') {
            window.gtag('event', 'conversion', {
              'send_to': sendTo,
              'value': 1.0,
              'currency': 'USD'
            });
            window.gtag('event', eventName, {
              'event_category': 'button_click',
              'event_label': eventName,
              'value': 1.0
            });
          }
        }
        function bindTracking() {
          document.querySelectorAll('a.cta-spreadsheet, a[href*="docs.google.com/spreadsheets"]').forEach(function(el) {
            if (!el.dataset.tracked) {
              el.dataset.tracked = '1';
              el.addEventListener('click', function() {
                var name = el.classList.contains('cta-spreadsheet') ? 'spreadsheet_button_click' : 'spreadsheet_link_click';
                sendTracking(name, 'AW-18355431983/oXBcCNidqtgcEK_UxrBE');
              });
            }
          });
          document.querySelectorAll('a.cta-shopping, .shopping-btn, a[href*="repsootd.com"]').forEach(function(el) {
            if (!el.dataset.tracked) {
              el.dataset.tracked = '1';
              el.addEventListener('click', function() {
                sendTracking('shopping_button_click', 'AW-18355431983/-z_fCNWdqtgcEK_UxrBE');
              });
            }
          });
        }
        function startTracking() {
          bindTracking();
          var observer = new MutationObserver(bindTracking);
          observer.observe(document.body, { childList: true, subtree: true });
        }
        if (document.readyState === 'loading') {
          document.addEventListener('DOMContentLoaded', startTracking, { once: true });
        } else {
          startTracking();
        }
      })();
    `],
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
    transformItems: (items) => items.filter((item) => !noindexPaths.has(normalizedPath(item.url))),
  },

  // VitePress validates raw Markdown links before transformHtml retires known missing links.
  // The dedicated coverage policy and production-output checks below remain the source of truth for blog link quality.
  ignoreDeadLinks: [
    /^\/blog\//,
    /^http:\/\/localhost/,
    /^\/Kakobuy-/,
    /^\/is-/,
    (link) => missingBlogPaths.has(normalizedPath(link)),
  ],

  cleanUrls: 'with-subfolders',

  // Retire links to blog URLs that have no source page. The anchor text remains readable, but it is no longer emitted as a crawlable 404 link.
  transformHtml(code) {
    return code.replace(/<a\b([^>]*?)href=(["'])([^"']+)\2([^>]*)>([\s\S]*?)<\/a>/gi, (match, before, quote, href, after, content) => {
      const missingPath = normalizedPath(href)
      if (!missingBlogPaths.has(missingPath)) return match
      const redirectTarget = retiredBlogRedirects.get(missingPath)
      if (redirectTarget) return `<a${before}href="${redirectTarget}"${after}>${content}</a>`
      return `<span class="retired-link" data-retired-url="${href}">${content}</span>`
    })
  },

  // Generate canonical URLs and protect low-value pages from indexing until rewritten.
  transformPageData(pageData) {
    const pagePath = pathFromRelativePath(pageData.relativePath)
    const canonicalUrl = `${seo.hostname}${pagePath}`
    pageData.frontmatter.head = pageData.frontmatter.head || []
    pageData.frontmatter.head.push(
      ['link', { rel: 'canonical', href: canonicalUrl }]
    )
    if (noindexRelativePaths.has(pageData.relativePath)) {
      pageData.frontmatter.head.push(
        ['meta', { name: 'robots', content: 'noindex,follow' }]
      )
    }
    return pageData
  },

  srcExclude: [
    // Root-level internal documents (should not be indexed)
    'ARTICLE_PROMPT_GUIDE.md',
    'BANNED_TERMS.md',
    'BATCH_MODIFICATION_PLAN.md',
    'WEBSITE_POSITIONING.md',
    'flexible-article-generator.md',
    'ideas.md',
    // Blog-level internal documents
    'blog/kakobuy-article-prompt.md',
    'blog/kakobuy-internal-link-rules.md',
    'blog/kakobuy-product-reference.md',
    'blog/kakobuy-review-report.md',
    'blog/kakobuy-topic-list.md',
    'blog/flexible-article-generator.md',
    'blog/topic-matrix.md',
    'blog/ideas.md',
    'blog/content-checklist.md',
    'blog/local-setup.md',
    'blog/product-workflow.md',
    'blog/website-structure.md',
  ],
})
