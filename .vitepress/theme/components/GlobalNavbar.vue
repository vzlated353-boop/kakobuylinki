<template>
  <nav class="global-navbar">
    <div class="navbar-container">
      <a href="/" class="navbar-brand">{{ brand.logoText }}</a>

      <div class="navbar-menu">
        <a
          v-for="item in nav"
          :key="item.link"
          :href="item.link"
          class="nav-item"
          :class="{ active: isActive(item.link) }"
        >
          {{ item.text }}
        </a>
      </div>

      <a :href="links.spreadsheet" target="_blank" class="nav-cta">Spreadsheet</a>
    </div>
  </nav>
</template>

<script setup>
import { siteConfig } from '../site-config.js'
import { useData } from 'vitepress'
import { computed } from 'vue'

const brand = siteConfig.brand
const nav = siteConfig.nav
const links = siteConfig.links

const { page } = useData()

function isActive(link) {
  if (link === '/') return page.value?.relativePath === 'index.md'
  const path = page.value?.relativePath?.replace(/\.md$/, '') || ''
  return path === link.replace(/^\//, '') || path.startsWith(link.replace(/^\//, '') + '/')
}
</script>

<style scoped>
.global-navbar {
  background: white;
  border-bottom: 1px solid #e0e0e0;
  position: sticky;
  top: 0;
  z-index: 100;
}

.navbar-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 60px;
}

.navbar-brand {
  font-size: 24px;
  font-weight: 700;
  color: #d4af37;
  text-decoration: none;
  margin-right: 30px;
  transition: color 0.3s ease;
}

.navbar-brand:hover {
  color: #8b0000;
}

.navbar-menu {
  display: flex;
  gap: 15px;
  flex: 1;
  align-items: center;
  overflow-x: auto;
}

.nav-item {
  font-size: 14px;
  color: #666;
  text-decoration: none;
  font-weight: 500;
  white-space: nowrap;
  padding: 8px 0;
  border-bottom: 2px solid transparent;
  transition: all 0.3s ease;
}

.nav-item:hover,
.nav-item.active {
  color: #d4af37;
  border-bottom-color: #d4af37;
}

.nav-cta {
  background-color: #8b0000;
  color: white;
  padding: 8px 20px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.nav-cta:hover {
  background-color: #a00000;
  transform: translateY(-2px);
}

@media (max-width: 1024px) {
  .navbar-menu { gap: 10px; }
  .nav-item { font-size: 13px; }
  .nav-cta { padding: 8px 15px; font-size: 13px; }
}

@media (max-width: 768px) {
  .navbar-container { padding: 0 15px; height: 50px; }
  .navbar-brand { font-size: 20px; margin-right: 15px; }
  .navbar-menu { gap: 8px; }
  .nav-item { font-size: 12px; padding: 6px 0; }
  .nav-cta { padding: 6px 12px; font-size: 12px; }
}

@media (max-width: 480px) {
  .navbar-container { padding: 0 10px; height: 45px; }
  .navbar-brand { font-size: 18px; margin-right: 10px; }
  .navbar-menu { gap: 5px; }
  .nav-item { font-size: 11px; padding: 5px 0; }
  .nav-cta { padding: 5px 10px; font-size: 11px; }
}
</style>
