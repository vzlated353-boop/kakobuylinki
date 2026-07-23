<template>
  <div class="table-page">
    <div class="table-header">
      <h1>{{ title }}</h1>
      <p class="table-desc">{{ description }}</p>
      <a :href="backLink" class="back-link">&larr; Back to {{ backLabel }}</a>
    </div>

    <!-- Buying Tips -->
    <section v-if="buyingTips?.length" class="content-section">
      <h2>Buying Tips</h2>
      <div class="tips-grid">
        <div v-for="tip in buyingTips" :key="tip.tip" class="tip-card">
          <h3>{{ tip.tip }}</h3>
          <p>{{ tip.detail }}</p>
        </div>
      </div>
    </section>

    <!-- Quality Check -->
    <section v-if="qualityCheck?.length" class="content-section">
      <h2>Quality Checklist</h2>
      <ul class="checklist">
        <li v-for="item in qualityCheck" :key="item">
          <span class="check-icon">&#10003;</span>
          <span>{{ item }}</span>
        </li>
      </ul>
    </section>

    <!-- Data Table -->
    <div class="table-wrapper">
      <table class="data-table">
        <thead>
          <tr>
            <th>#</th>
            <th>Product Name</th>
            <th>Brand</th>
            <th>Price</th>
            <th>Batch</th>
            <th>Link</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(row, index) in tableData" :key="index">
            <td>{{ index + 1 }}</td>
            <td>{{ row.name }}</td>
            <td>{{ row.brand }}</td>
            <td>{{ row.price }}</td>
            <td>{{ row.batch }}</td>
            <td>
              <a v-if="row.link" :href="row.link" target="_blank" class="table-link">View</a>
              <span v-else class="table-link-disabled">N/A</span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Table Note -->
    <div class="table-note">
      <p><strong>Note:</strong> This table is a sample structure. Replace the data in the script section with your actual product information. Prices and availability are subject to change. Always refer to the spreadsheet for the latest data.</p>
    </div>

    <!-- FAQ -->
    <section v-if="faq?.length" class="content-section">
      <h2>Frequently Asked Questions</h2>
      <div class="faq-list">
        <div v-for="(item, index) in faq" :key="index" class="faq-item">
          <button class="faq-question" @click="toggleFaq(index)">
            <span>{{ item.q }}</span>
            <span class="faq-arrow" :class="{ open: openFaq === index }">&#9662;</span>
          </button>
          <div v-show="openFaq === index" class="faq-answer">
            <p>{{ item.a }}</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { siteConfig } from '../site-config.js'

const props = defineProps({
  title: { type: String, required: true },
  description: { type: String, default: '' },
  backLink: { type: String, default: '/' },
  backLabel: { type: String, default: 'Categories' },
  tableData: {
    type: Array,
    default: () => [],
  },
  buyingTips: {
    type: Array,
    default: () => [],
  },
  qualityCheck: {
    type: Array,
    default: () => [],
  },
  faq: {
    type: Array,
    default: () => [],
  },
})

const links = siteConfig.links
const openFaq = ref(-1)

function toggleFaq(index) {
  openFaq.value = openFaq.value === index ? -1 : index
}
</script>

<style scoped>
.table-page {
  max-width: 1100px;
  margin: 0 auto;
  padding: 40px 20px;
}

.table-header {
  margin-bottom: 32px;
}

.table-header h1 {
  font-size: 32px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 10px;
}

.table-desc {
  font-size: 16px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 16px;
}

.back-link {
  display: inline-block;
  font-size: 14px;
  color: #8B0000;
  text-decoration: none;
  font-weight: 500;
}

.back-link:hover {
  text-decoration: underline;
}

/* Content Sections */
.content-section {
  margin: 40px 0;
}

.content-section h2 {
  font-size: 24px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #8B0000;
  display: inline-block;
}

/* Tips Grid */
.tips-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
  margin: 24px 0;
}

.tip-card {
  background: #fafafa;
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 24px;
  transition: all 0.2s ease;
}

.tip-card:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.08);
  transform: translateY(-2px);
}

.tip-card h3 {
  font-size: 16px;
  font-weight: 600;
  color: #8B0000;
  margin-bottom: 10px;
}

.tip-card p {
  font-size: 14px;
  color: #555;
  line-height: 1.6;
  margin: 0;
}

/* Checklist */
.checklist {
  list-style: none;
  padding: 0;
  margin: 20px 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 12px;
}

.checklist li {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 14px 18px;
  background: #fafafa;
  border: 1px solid #eee;
  border-radius: 10px;
  font-size: 14px;
  color: #333;
  line-height: 1.5;
}

.check-icon {
  color: #8B0000;
  font-weight: 700;
  font-size: 16px;
  flex-shrink: 0;
  margin-top: 1px;
}

/* Table */
.table-wrapper {
  overflow-x: auto;
  border: 1px solid #eee;
  border-radius: 12px;
  margin: 24px 0;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}

.data-table thead {
  background: #f8f8f8;
}

.data-table th {
  padding: 14px 16px;
  text-align: left;
  font-weight: 600;
  color: #333;
  border-bottom: 2px solid #e0e0e0;
  white-space: nowrap;
}

.data-table td {
  padding: 12px 16px;
  border-bottom: 1px solid #f0f0f0;
  color: #555;
}

.data-table tbody tr:hover {
  background: #fafafa;
}

.data-table tbody tr:last-child td {
  border-bottom: none;
}

.table-link {
  color: #8B0000;
  text-decoration: none;
  font-weight: 500;
}

.table-link:hover {
  text-decoration: underline;
}

.table-link-disabled {
  color: #bbb;
}

/* Note */
.table-note {
  background: #fff8e1;
  border: 1px solid #ffe082;
  border-radius: 10px;
  padding: 16px 20px;
  margin: 24px 0;
}

.table-note p {
  font-size: 13px;
  color: #6d4c00;
  line-height: 1.6;
  margin: 0;
}

/* FAQ */
.faq-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin: 20px 0;
}

.faq-item {
  border: 1px solid #eee;
  border-radius: 10px;
  overflow: hidden;
}

.faq-question {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #fafafa;
  border: none;
  cursor: pointer;
  font-size: 15px;
  font-weight: 500;
  color: #333;
  text-align: left;
  transition: background 0.2s;
}

.faq-question:hover {
  background: #f0f0f0;
}

.faq-arrow {
  font-size: 12px;
  transition: transform 0.2s;
  color: #999;
}

.faq-arrow.open {
  transform: rotate(90deg);
}

.faq-answer {
  padding: 0 20px 16px;
  background: #fff;
}

.faq-answer p {
  font-size: 14px;
  color: #555;
  line-height: 1.7;
  margin: 0;
}

@media (max-width: 768px) {
  .table-header h1 { font-size: 24px; }
  .data-table th, .data-table td { padding: 10px 12px; font-size: 13px; }
  .tips-grid { grid-template-columns: 1fr; }
  .checklist { grid-template-columns: 1fr; }
}
</style>
