<template>
  <div class="subcategory-nav">
    <div class="sub-nav-inner">
      <a
        v-for="sub in subcategories"
        :key="sub.id"
        :href="sub.link"
        class="sub-nav-btn"
        :class="{ active: isActive(sub.link) }"
      >
        {{ sub.name }}
      </a>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useData } from 'vitepress'

const props = defineProps({
  subcategories: {
    type: Array,
    required: true,
  },
})

const { page } = useData()

function isActive(link) {
  return page.value?.relativePath?.replace(/\.md$/, '') === link.replace(/^\//, '')
}
</script>

<style scoped>
.subcategory-nav {
  margin: 24px 0 32px;
}

.sub-nav-inner {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.sub-nav-btn {
  display: inline-block;
  padding: 10px 22px;
  border: 1.5px solid #ddd;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #555;
  text-decoration: none;
  background: #fff;
  transition: all 0.2s ease;
  cursor: pointer;
}

.sub-nav-btn:hover {
  border-color: #8B0000;
  color: #8B0000;
  background: #fff5f5;
}

.sub-nav-btn.active {
  background: #8B0000;
  color: #fff;
  border-color: #8B0000;
}

@media (max-width: 768px) {
  .sub-nav-btn {
    padding: 8px 16px;
    font-size: 13px;
  }
}

@media (max-width: 480px) {
  .sub-nav-inner {
    gap: 8px;
  }

  .sub-nav-btn {
    padding: 7px 14px;
    font-size: 12px;
  }
}
</style>
