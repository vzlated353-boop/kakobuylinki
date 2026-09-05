<template>
  <div
    v-if="!consentGiven"
    id="consent-banner"
    class="consent-overlay"
    role="dialog"
    aria-modal="true"
    aria-labelledby="consent-title"
    aria-describedby="consent-description"
  >
    <div class="consent-banner">
      <div class="consent-icon" aria-hidden="true">&#128274;</div>
      <h3 id="consent-title" class="consent-title">Cookie Consent</h3>
      <p id="consent-description" class="consent-text">
        We use cookies and analytics to improve your experience. By clicking "Accept", you consent to the use of cookies for analytics and advertising purposes. You can manage your preferences at any time.
      </p>
      <div class="consent-buttons">
        <button class="consent-btn consent-deny" type="button" @click="denyConsent">Decline</button>
        <button class="consent-btn consent-accept" type="button" @click="grantConsent">Accept All</button>
      </div>
      <p class="consent-privacy">
        <a href="/privacy-policy/">Privacy Policy</a>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const consentGiven = ref(false)
const analytics = {
  ga4: 'G-N9BCQ2XS4W',
  ads: 'AW-18355431983',
  gtm: 'GTM-P7CCW56D',
  laId: '3QeJ4R8Vu6YpAFhK',
}
let analyticsLoaded = false

onMounted(() => {
  const saved = localStorage.getItem('consentGranted')
  if (saved === 'true' || saved === 'false') {
    consentGiven.value = true
    if (saved === 'true') {
      enableAnalytics()
    }
  }
})

function grantConsent() {
  localStorage.setItem('consentGranted', 'true')
  consentGiven.value = true
  enableAnalytics()
}

function denyConsent() {
  localStorage.setItem('consentGranted', 'false')
  consentGiven.value = true
  prepareGtag()
  updateConsent('denied')
}

function prepareGtag() {
  window.dataLayer = window.dataLayer || []
  window.gtag = window.gtag || function () {
    window.dataLayer.push(arguments)
  }
  window.gtag('consent', 'default', {
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    ad_storage: 'denied',
    analytics_storage: 'denied',
    wait_for_update: 500,
  })
}

function updateConsent(status) {
  if (typeof window.gtag === 'function') {
    window.gtag('consent', 'update', {
      ad_user_data: status,
      ad_personalization: status,
      ad_storage: status,
      analytics_storage: status,
    })
  }
}

function appendScript(id, src, onload) {
  if (document.getElementById(id)) {
    onload?.()
    return
  }

  const script = document.createElement('script')
  script.id = id
  script.async = true
  script.src = src
  if (onload) script.onload = onload
  document.head.appendChild(script)
}

function enableAnalytics() {
  prepareGtag()
  updateConsent('granted')
  if (analyticsLoaded) return
  analyticsLoaded = true

  window.dataLayer.push({ 'gtm.start': new Date().getTime(), event: 'gtm.js' })
  appendScript('gtm-loader', `https://www.googletagmanager.com/gtm.js?id=${analytics.gtm}`)

  appendScript('gtag-loader', `https://www.googletagmanager.com/gtag/js?id=${analytics.ga4}`, () => {
    window.gtag('js', new Date())
    window.gtag('config', analytics.ga4, { anonymize_ip: true })
    window.gtag('config', analytics.ads, { anonymize_ip: true })
  })

  appendScript('la-collect-loader', 'https://sdk.51.la/js-sdk-pro.min.js', () => {
    if (typeof window.LA !== 'undefined' && typeof window.LA.init === 'function') {
      window.LA.init({ id: analytics.laId, ck: analytics.laId })
    }
  })
}
</script>

<style scoped>
.consent-overlay {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 99999;
  padding: 16px;
  background: rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(4px);
}

.consent-banner {
  max-width: 640px;
  margin: 0 auto;
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  text-align: center;
}

.consent-icon {
  font-size: 32px;
  margin-bottom: 8px;
}

.consent-title {
  font-size: 18px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0 0 8px;
}

.consent-text {
  font-size: 14px;
  color: #555;
  line-height: 1.5;
  margin: 0 0 20px;
}

.consent-buttons {
  display: flex;
  gap: 12px;
  justify-content: center;
  margin-bottom: 12px;
}

.consent-btn {
  padding: 10px 28px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  border: none;
  transition: opacity 0.2s ease-out, transform 0.16s ease-out;
}

.consent-btn:hover {
  opacity: 0.85;
}

.consent-btn:active {
  transform: scale(0.97);
}

.consent-btn:focus-visible,
.consent-privacy a:focus-visible {
  outline: 3px solid #0f3460;
  outline-offset: 3px;
}

.consent-deny {
  background: #f0f0f0;
  color: #333;
}

.consent-accept {
  background: #8B0000;
  color: #fff;
}

.consent-privacy {
  font-size: 12px;
  color: #999;
  margin: 0;
}

.consent-privacy a {
  color: #8B0000;
  text-decoration: none;
}

.consent-privacy a:hover {
  text-decoration: underline;
}

@media (prefers-reduced-motion: reduce) {
  .consent-btn {
    transition: none;
  }
}

@media (max-width: 480px) {
  .consent-banner {
    padding: 20px 16px;
  }

  .consent-buttons {
    flex-direction: column;
  }

  .consent-btn {
    width: 100%;
  }
}
</style>
