// ============================================================
// Kakobuy Site Configuration
// Change keywords here to adapt this template to any other site.
// ============================================================

export const siteConfig = {

  // ---- Brand ----
  brand: {
    name: 'Kakobuy',
    tagline: 'Your Trusted Fashion & Lifestyle Guide',
    description: 'Comprehensive guides on shoes, clothing, hats and more. Quality specs, pricing insights, and logistics info — all in one place.',
    primaryColor: '#8B0000',
    accentColor: '#d4af37',
    logoText: 'Kakobuy',
  },

  // ---- Navigation ----
  nav: [
    { text: 'Home', link: '/' },
    { text: 'Shoes', link: '/shoes' },
    { text: 'Clothes', link: '/clothes' },
    { text: 'Hats', link: '/hats' },
    { text: 'About', link: '/about' },
    { text: 'Blog', link: '/blog' },
  ],

  // ---- Main Categories ----
  // Two-level navigation only: Home -> Category page (shoes/clothes/hats).
  // No third-level subcategory pages.
  categories: [
    {
      id: 'shoes',
      name: 'Shoes',
      icon: '👟',
      description: 'Explore the world of sneakers, boots, and casual footwear. From iconic silhouettes to hidden gems.',
    },
    {
      id: 'clothes',
      name: 'Clothes',
      icon: '👕',
      description: 'From streetwear essentials to premium outerwear. Discover styles, fabrics, and fits.',
    },
    {
      id: 'hats',
      name: 'Hats',
      icon: '🧢',
      description: 'Complete your look with caps, beanies, and bucket hats. Style meets function.',
    },
  ],

  // ---- External Links ----
  // Change these URLs to point to your own resources.
  links: {
    spreadsheet: 'https://docs.google.com/spreadsheets/d/10e9euL3y7Bw7GvWUhX2FruG8mJWXz8C7eNwTo69XoQA/edit?gid=2068242972#gid=2068242972',
    contact: 'mailto:hello@Kakobuy.com',
  },

  // ---- SEO Defaults ----
  seo: {
    hostname: 'https://Kakobuylinki.com',
    title: 'Kakobuy - Fashion & Lifestyle Guide',
    description: 'Comprehensive guides on shoes, clothing, hats. Quality specs, pricing, logistics info.',
    keywords: ['fashion guide', 'shoes', 'clothing', 'hats', 'streetwear', 'sneakers'],
    ga4: 'G-XTJTTBZTPM',
  },

  // ---- Announcement Bar ----
  announcement: 'New category guides added weekly. Stay tuned!',

  // ---- Shared Content Templates ----
  // These are reused across category pages. Modify here to update all pages at once.
  content: {

    // Quality specifications shown on every category page
    qualitySpecs: [
      { label: 'Material', value: 'Premium-grade materials sourced from verified suppliers' },
      { label: 'Craftsmanship', value: 'Factory-direct production with strict QC standards' },
      { label: 'Authenticity', value: '1:1 quality comparison with retail references' },
      { label: 'Packaging', value: 'Original-style packaging with tags and accessories' },
    ],

    // Pricing info template
    pricingInfo: {
      currency: 'USD',
      range: '$15 - $120',
      note: 'Prices vary by brand, model, and batch. Refer to the spreadsheet for the latest pricing.',
    },

    // Logistics info template
    logisticsInfo: [
      { label: 'Processing Time', value: '3-5 business days after order confirmation' },
      { label: 'Shipping Methods', value: 'Standard (15-25 days), Express (7-12 days), EMS (10-15 days)' },
      { label: 'Tracking', value: 'Full tracking provided for all shipments' },
      { label: 'Insurance', value: 'Available for high-value orders' },
    ],

    // Batch/lot info template
    batchInfo: [
      { label: 'Batch Updates', value: 'New batches released weekly based on factory production cycles' },
      { label: 'Version Tracking', value: 'Each batch is labeled with a version code for quality reference' },
      { label: 'QC Photos', value: 'Quality check photos available before shipping for every batch' },
    ],

    // FAQ template (shared across all category pages)
    faq: [
      {
        q: 'How do I find the latest products?',
        a: 'Check our spreadsheet for the most up-to-date product listings, prices, and links. It is updated regularly with new arrivals and batch information.',
      },
      {
        q: 'What does "batch" or "lot" mean?',
        a: 'A batch refers to a specific production run from a factory. Different batches may have slight variations in materials, stitching, or details. We track batch versions so you know exactly what you are getting.',
      },
      {
        q: 'How is quality verified?',
        a: 'Every product goes through a quality check process. QC photos are taken before shipping, and we compare each item against retail references to ensure accuracy.',
      },
      {
        q: 'Can I request a specific product?',
        a: 'Yes! Reach out to us through the contact page with the product name or image, and we will help you find the best available option.',
      },
      {
        q: 'What if I receive a defective item?',
        a: 'Contact us immediately with photos of the issue. We work with suppliers to arrange replacements or refunds for defective products.',
      },
      {
        q: 'Do you ship internationally?',
        a: 'Yes, we ship worldwide. Shipping times and costs vary by destination. Express options are available for faster delivery.',
      },
    ],
  },
}
