<template>
  <div class="home-page">
    <!-- Hero Section -->
    <section class="hero">
      <div class="hero-bg">
        <picture>
          <source srcset="/images/hero-480w.webp 480w, /images/hero-768w.webp 768w, /images/hero-1200w.webp 1200w" sizes="100vw" type="image/webp">
          <img src="/images/hero-1200w.webp" alt="Men's fashion streetwear collection featuring hoodies, sneakers and urban style" fetchpriority="high" loading="eager" decoding="async" width="1200" height="675">
        </picture>
      </div>
      <div class="hero-overlay"></div>
      <div class="hero-inner">
        <h1 class="hero-title">Kakobuy Men's Fashion Finds</h1>
        <p class="hero-subtitle">10,000+ Clothing, Sneakers &amp; Accessories</p>
        <p class="hero-desc">Explore organized fashion categories on Kakobuy including sneakers, hoodies, jackets and accessories. Updated collections with easy product discovery.</p>
        <!-- CTA Buttons -->
        <div class="hero-cta-group">
          <div class="hero-cta-item">
            <span class="cta-label">Full Catalog</span>
            <a href="https://docs.google.com/spreadsheets/d/10e9euL3y7Bw7GvWUhX2FruG8mJWXz8C7eNwTo69XoQA/edit?gid=1903531254#gid=1903531254" target="_blank" rel="nofollow noopener noreferrer" class="cta-btn cta-spreadsheet">Access Spreadsheet</a>
          </div>
          <div class="hero-cta-item">
            <span class="cta-label">Fast Selection</span>
            <a href="https://repsootd.com/" target="_blank" rel="nofollow noopener noreferrer" class="cta-btn cta-shopping">Start Shopping</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Explore Categories -->
    <section class="categories-section">
      <div class="container">
        <h2 class="section-title">Explore Categories</h2>
        <p class="section-desc">Browse curated men's fashion categories with detailed guides, sizing tips, and product information.</p>
        <div class="category-grid">
          <a
            v-for="cat in categories"
            :key="cat.id"
            :href="`/${cat.id}/`"
            class="category-card"
          >
            <div class="cat-icon">{{ cat.icon }}</div>
            <h3>{{ cat.name }}</h3>
            <p>{{ cat.description }}</p>
          </a>
        </div>
      </div>
    </section>

    <!-- How It Works -->
    <section class="how-it-works">
      <div class="container">
        <h2 class="section-title">How It Works</h2>
        <p class="section-desc">Find your next fashion piece in four simple steps.</p>
        <div class="steps-grid">
          <div class="step-card">
            <div class="step-number">1</div>
            <h3>Browse Categories</h3>
            <p>Explore organized fashion categories from sneakers and hoodies to bags and accessories.</p>
          </div>
          <div class="step-card">
            <div class="step-number">2</div>
            <h3>Find Products</h3>
            <p>Discover curated collections with pricing references, material details, and style information.</p>
          </div>
          <div class="step-card">
            <div class="step-number">3</div>
            <h3>Check Details</h3>
            <p>Review product specifications, sizing guides, and quality information before making a decision.</p>
          </div>
          <div class="step-card">
            <div class="step-number">4</div>
            <h3>Start Shopping</h3>
            <p>Access the full spreadsheet catalog or jump directly to curated shopping collections.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Why Choose Us -->
    <section class="why-section">
      <div class="container">
        <h2 class="section-title">Why Choose Us</h2>
        <div class="why-grid">
          <div class="why-card">
            <div class="why-icon">&#10003;</div>
            <h3>10,000+ Fashion Finds</h3>
            <p>Extensive catalog covering sneakers, clothing, accessories, and more across all major style categories.</p>
          </div>
          <div class="why-card">
            <div class="why-icon">&#10003;</div>
            <h3>Updated Collections</h3>
            <p>Regularly refreshed product listings with the latest trends, new arrivals, and seasonal picks.</p>
          </div>
          <div class="why-card">
            <div class="why-icon">&#10003;</div>
            <h3>Organized Categories</h3>
            <p>Clear category structure makes it easy to find exactly what you are looking for without endless searching.</p>
          </div>
          <div class="why-card">
            <div class="why-icon">&#10003;</div>
            <h3>Easy Product Search</h3>
            <p>Standardized product information with pricing, materials, and specifications for quick comparison.</p>
          </div>
          <div class="why-card">
            <div class="why-icon">&#10003;</div>
            <h3>Global Access</h3>
            <p>Shopping resources available worldwide with shipping options for US, UK, EU, Australia, and more.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq-section">
      <div class="container">
        <h2 class="section-title">Frequently Asked Questions</h2>
        <div class="faq-list">
          <details class="faq-item" open>
            <summary>What is the fashion spreadsheet?</summary>
            <p>The fashion spreadsheet is a curated product directory that organizes thousands of men's fashion items into easy-to-browse categories. It includes pricing references, material details, and style information for sneakers, clothing, accessories, and more.</p>
          </details>
          <details class="faq-item">
            <summary>How often are collections updated?</summary>
            <p>Our collections are regularly updated with new arrivals, seasonal picks, and trending items. We review and refresh product listings to ensure accuracy and keep up with the latest fashion trends.</p>
          </details>
          <details class="faq-item">
            <summary>How can I find products?</summary>
            <p>Browse by category using the navigation above, or access the full spreadsheet catalog for detailed product listings. Each category page provides an overview with pricing references and key specifications.</p>
          </details>
          <details class="faq-item">
            <summary>How do I check product details?</summary>
            <p>Each product listing includes standardized information: pricing references, material composition, available sizes, and design features. Use our sizing guides for fit recommendations across different brands and styles.</p>
          </details>
          <details class="faq-item">
            <summary>How does shopping work?</summary>
            <p>Click "Start Shopping" to access curated fashion collections, or use the spreadsheet to browse the full catalog. All purchasing happens through external shopping resources with independent checkout.</p>
          </details>
          <details class="faq-item">
            <summary>Do you support international users?</summary>
            <p>Yes. Our fashion directory serves users worldwide with shopping resources and shipping options for the US, UK, EU, Australia, Canada, and other regions. Check our regional guides for location-specific information.</p>
          </details>
        </div>
      </div>
    </section>

    <!-- Featured Articles / Blog -->
    <section class="blog-section">
      <div class="container">
        <h2 class="section-title">Featured Guides</h2>
        <div class="article-nav-grid">
          <div v-for="group in visibleGuideGroups" :key="group.title" class="article-nav-group">
            <h3 class="group-title">{{ group.title }}</h3>
            <ul class="article-nav-list">
              <li v-for="article in group.articles" :key="article.link">
                <a :href="article.link">{{ article.title }}</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { siteConfig } from '../site-config.js'
import { indexableBlogPaths } from '../../indexing-policy.mjs'

const categories = siteConfig.categories
const guideGroups = [
  { title: 'Getting Started', articles: [
    { title: 'Kakobuy Spreadsheet for Beginners', link: '/blog/kakobuy-for-beginners/' },
    { title: 'How to Use the Spreadsheet', link: '/blog/kakobuy-how-to-use/' },
    { title: 'Shipping Guide', link: '/blog/kakobuy-shipping-guide/' },
    { title: 'Payment Guide', link: '/blog/kakobuy-payment-guide/' },
  ] },
  { title: 'Top Categories', articles: [
    { title: 'Sneakers Guide', link: '/blog/kakobuy-sneakers/' },
    { title: 'Hoodies Guide', link: '/blog/kakobuy-hoodies/' },
    { title: 'T-Shirts Guide', link: '/blog/kakobuy-t-shirts/' },
    { title: 'Bags Guide', link: '/blog/kakobuy-bags/' },
  ] },
  { title: 'Style Guides', articles: [
    { title: 'Streetwear Guide', link: '/blog/kakobuy-streetwear/' },
    { title: 'Casual Wear Guide', link: '/blog/kakobuy-casual/' },
    { title: 'Winter Clothing Guide', link: '/blog/kakobuy-winter/' },
    { title: 'Summer Essentials Guide', link: '/blog/kakobuy-summer/' },
  ] },
  { title: 'Save Money', articles: [
    { title: 'Coupon Codes & Discounts', link: '/blog/kakobuy-coupon/' },
    { title: 'Best Deals & Seasonal Sales', link: '/blog/kakobuy-best-deals/' },
    { title: 'Budget Sneaker Picks', link: '/blog/kakobuy-cheap-sneakers/' },
    { title: 'Money-Saving Tips', link: '/blog/kakobuy-save-money/' },
  ] },
  { title: 'Trust & Safety', articles: [
    { title: 'Is Kakobuy Legit?', link: '/is-Kakobuy-legit/' },
    { title: 'Legit Check Guide', link: '/blog/kakobuy-legit-check/' },
    { title: 'QC Photos Guide', link: '/blog/kakobuy-qc-photos/' },
    { title: 'User Reviews', link: '/blog/kakobuy-reviews/' },
  ] },
  { title: 'Regional Guides', articles: [
    { title: 'UK Shipping Guide', link: '/blog/kakobuy-uk/' },
    { title: 'Canada Guide', link: '/blog/kakobuy-canada/' },
    { title: 'Australia Guide', link: '/blog/kakobuy-australia/' },
    { title: 'Europe Guide', link: '/blog/kakobuy-europe/' },
  ] },
]

function isIndexableGuide(article) {
  if (!article.link.startsWith('/blog/')) return true
  return indexableBlogPaths.has(article.link.replace(/\/$/, ''))
}

const visibleGuideGroups = computed(() => guideGroups
  .map((group) => ({ ...group, articles: group.articles.filter(isIndexableGuide) }))
  .filter((group) => group.articles.length > 0))
</script>

<style scoped>
.home-page {
  min-height: 100vh;
}

.container {
  max-width: 1100px;
  margin: 0 auto;
  padding: 0 20px;
}

/* ===== Hero ===== */
.hero {
  position: relative;
  min-height: 600px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero-bg {
  position: absolute;
  inset: 0;
  z-index: 0;
}

.hero-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(26,26,46,0.85) 0%, rgba(15,52,96,0.75) 100%);
  z-index: 1;
}

.hero-inner {
  position: relative;
  z-index: 2;
  max-width: 700px;
  margin: 0 auto;
  padding: 80px 20px;
  text-align: center;
}

.hero-title {
  font-size: 52px;
  font-weight: 800;
  color: #d4af37;
  margin-bottom: 12px;
  letter-spacing: -1px;
  line-height: 1.15;
}

.hero-subtitle {
  font-size: 22px;
  color: #fff;
  font-weight: 500;
  margin-bottom: 16px;
}

.hero-desc {
  font-size: 16px;
  color: rgba(255,255,255,0.8);
  line-height: 1.7;
  max-width: 560px;
  margin: 0 auto 32px;
}

/* CTA Group */
.hero-cta-group {
  display: flex;
  justify-content: center;
  gap: 32px;
  flex-wrap: wrap;
}

.hero-cta-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.cta-label {
  font-size: 12px;
  font-weight: 600;
  color: rgba(255,255,255,0.6);
  text-transform: uppercase;
  letter-spacing: 1.5px;
}

.cta-btn {
  display: inline-block;
  padding: 16px 36px;
  border-radius: 12px;
  font-size: 17px;
  font-weight: 700;
  text-decoration: none;
  text-align: center;
  transition: all 0.3s ease;
  letter-spacing: 0.3px;
  line-height: 1.4;
}

.cta-spreadsheet {
  background: #8B0000;
  color: #ffffff;
  box-shadow: 0 4px 15px rgba(139, 0, 0, 0.4);
}

.cta-spreadsheet:hover {
  background: #a00000;
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(139, 0, 0, 0.5);
}

.cta-shopping {
  background: #d4af37;
  color: #ffffff;
  box-shadow: 0 4px 12px rgba(212, 175, 55, 0.4);
}

.cta-shopping:hover {
  background: #c4a030;
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(212, 175, 55, 0.5);
}

/* ===== Section Common ===== */
.section-title {
  text-align: center;
  font-size: 28px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 16px;
}

.section-desc {
  text-align: center;
  font-size: 16px;
  color: #666;
  line-height: 1.7;
  max-width: 640px;
  margin: 0 auto 40px;
}

/* ===== Categories ===== */
.categories-section {
  padding: 64px 0;
  background: #fff;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.category-card {
  display: block;
  background: #fafafa;
  border: 1px solid #eee;
  border-radius: 16px;
  padding: 28px 24px;
  text-decoration: none;
  transition: all 0.3s ease;
  text-align: center;
}

.category-card:hover {
  box-shadow: 0 8px 30px rgba(0,0,0,0.08);
  transform: translateY(-4px);
  border-color: #d4af37;
}

.cat-icon {
  font-size: 36px;
  margin-bottom: 12px;
}

.category-card h3 {
  font-size: 18px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 8px;
}

.category-card p {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin: 0;
}

/* ===== How It Works ===== */
.how-it-works {
  padding: 64px 0;
  background: #fff;
}

.steps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 24px;
}

.step-card {
  background: #fafafa;
  border: 1px solid #eee;
  border-radius: 16px;
  padding: 28px 22px;
  text-align: center;
  transition: all 0.3s ease;
}

.step-card:hover {
  box-shadow: 0 8px 30px rgba(0,0,0,0.08);
  transform: translateY(-4px);
  border-color: #d4af37;
}

.step-number {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 44px;
  height: 44px;
  background: linear-gradient(135deg, #1a1a2e, #0f3460);
  color: #d4af37;
  border-radius: 50%;
  font-size: 20px;
  font-weight: 800;
  margin-bottom: 16px;
}

.step-card h3 {
  font-size: 17px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 10px;
}

.step-card p {
  font-size: 14px;
  color: #555;
  line-height: 1.7;
  margin: 0;
}

/* ===== Why Choose Us ===== */
.why-section {
  padding: 64px 0;
  background: #f8f9fa;
}

.why-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.why-card {
  background: #fff;
  border: 1px solid #eee;
  border-radius: 16px;
  padding: 28px 24px;
  transition: all 0.3s ease;
}

.why-card:hover {
  box-shadow: 0 8px 30px rgba(0,0,0,0.08);
  transform: translateY(-4px);
  border-color: #d4af37;
}

.why-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #1a1a2e, #0f3460);
  color: #d4af37;
  border-radius: 50%;
  font-size: 18px;
  font-weight: 800;
  margin-bottom: 14px;
}

.why-card h3 {
  font-size: 17px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 8px;
}

.why-card p {
  font-size: 14px;
  color: #555;
  line-height: 1.7;
  margin: 0;
}

/* ===== FAQ ===== */
.faq-section {
  padding: 64px 0;
  background: #fff;
}

.faq-list {
  max-width: 800px;
  margin: 0 auto;
  display: grid;
  gap: 16px;
}

.faq-item {
  background: #fafafa;
  border: 1px solid #eee;
  border-radius: 12px;
  overflow: hidden;
  transition: border-color 0.2s ease-out, box-shadow 0.2s ease-out;
}

.faq-item:hover,
.faq-item:focus-within {
  box-shadow: 0 4px 16px rgba(0,0,0,0.06);
  border-color: #d4af37;
}

.faq-item summary {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 20px 22px;
  color: #1a1a1a;
  cursor: pointer;
  font-size: 16px;
  font-weight: 700;
  list-style: none;
}

.faq-item summary::-webkit-details-marker {
  display: none;
}

.faq-item summary::after {
  color: #8b0000;
  content: '+';
  font-size: 24px;
  font-weight: 400;
  line-height: 1;
}

.faq-item[open] summary::after {
  content: '−';
}

.faq-item summary:focus-visible {
  outline: 3px solid #0f3460;
  outline-offset: -3px;
}

.faq-item p {
  padding: 0 22px 22px;
  margin: 0;
  color: #555;
  font-size: 14px;
  line-height: 1.7;
}

/* ===== Blog / Featured Articles ===== */
.blog-section {
  padding: 64px 0;
  background: #f8f9fa;
}

.article-nav-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
}

.article-nav-group {
  background: #fff;
  border: 1px solid #eee;
  border-radius: 16px;
  padding: 24px 22px;
}

.group-title {
  font-size: 16px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 14px;
  padding-bottom: 10px;
  border-bottom: 2px solid #d4af37;
}

.article-nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.article-nav-list li {
  margin-bottom: 8px;
}

.article-nav-list a {
  font-size: 14px;
  color: #555;
  text-decoration: none;
  line-height: 1.5;
  transition: all 0.3s ease;
  display: block;
  padding: 4px 8px;
  border-radius: 6px;
}

.article-nav-list a:hover {
  color: #8b0000;
  background: rgba(139, 0, 0, 0.05);
  padding-left: 14px;
}

/* ===== Keyboard and motion accessibility ===== */
.cta-btn:focus-visible,
.category-card:focus-visible,
.article-nav-list a:focus-visible {
  outline: 3px solid #0f3460;
  outline-offset: 4px;
}

@media (prefers-reduced-motion: reduce) {
  .cta-btn,
  .category-card,
  .step-card,
  .why-card,
  .faq-item,
  .article-nav-list a {
    transition: none;
  }

  .cta-btn:hover,
  .category-card:hover,
  .step-card:hover,
  .why-card:hover {
    transform: none;
  }
}

/* ===== Responsive ===== */
@media (max-width: 768px) {
  .hero { min-height: 500px; }
  .hero-inner { padding: 60px 20px; }
  .hero-title { font-size: 34px; }
  .hero-subtitle { font-size: 18px; }
  .hero-cta-group { gap: 20px; }
  .cta-btn { padding: 14px 28px; font-size: 15px; }
  .section-title { font-size: 24px; }
  .category-grid { grid-template-columns: 1fr; }
  .steps-grid { grid-template-columns: repeat(2, 1fr); }
  .why-grid { grid-template-columns: 1fr; }
  .article-nav-grid { grid-template-columns: 1fr; }
}

@media (max-width: 480px) {
  .hero-title { font-size: 28px; }
  .hero-cta-group { flex-direction: column; align-items: center; }
  .trending-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
  .trending-info { padding: 12px 14px; }
  .trending-info h3 { font-size: 13px; }
}
</style>
