import crypto from 'node:crypto'
import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const root = path.resolve(__dirname, '..')
const outputDir = path.resolve(root, '..', 'kakobuylinki-content-audit')
const internalRootFiles = new Set([
  'ARTICLE_PROMPT_GUIDE.md',
  'BANNED_TERMS.md',
  'BATCH_MODIFICATION_PLAN.md',
  'WEBSITE_POSITIONING.md',
  'flexible-article-generator.md',
  'ideas.md',
  'OPTIMIZATION_AUDIT.md',
])

function readMarkdownFiles(directory) {
  return fs.readdirSync(directory, { withFileTypes: true })
    .filter((entry) => entry.isFile() && entry.name.endsWith('.md'))
    .map((entry) => path.join(directory, entry.name))
}

function removeFrontmatter(content) {
  return content
    .replace(/^\uFEFF/, '')
    .replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n?/, '')
}

function frontmatterValue(content, key) {
  const frontmatter = content.match(/^---\r?\n([\s\S]*?)\r?\n---/)
  if (!frontmatter) return ''
  const match = frontmatter[1].match(new RegExp(`^${key}:\\s*["']?([^\\n"']+)["']?\\s*$`, 'm'))
  return match ? match[1].trim() : ''
}

function getTitle(content, fallback) {
  const frontmatterTitle = frontmatterValue(content, 'title')
  if (frontmatterTitle) return frontmatterTitle
  const h1 = removeFrontmatter(content).match(/^#\s+(.+)$/m)
  return h1 ? h1[1].trim() : fallback
}

function plainText(content) {
  return removeFrontmatter(content)
    .replace(/<script[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]+>/g, ' ')
    .replace(/!\[[^\]]*\]\([^)]*\)/g, ' ')
    .replace(/\[[^\]]*\]\([^)]*\)/g, ' ')
    .replace(/[`*_>#|]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

function words(text) {
  return text.match(/[A-Za-z0-9]+(?:['’-][A-Za-z0-9]+)*/g) || []
}

function countMatches(content, regex) {
  return [...content.matchAll(regex)].length
}

function getIntroFingerprint(content) {
  const text = plainText(content)
  const intro = text.split(/(?<=[.!?])\s+/).slice(0, 3).join(' ').slice(0, 500).toLowerCase()
  return crypto.createHash('sha1').update(intro).digest('hex')
}

function collectPage(filePath) {
  const raw = fs.readFileSync(filePath, 'utf8')
  const relativePath = path.relative(root, filePath).replaceAll(path.sep, '/')
  const body = removeFrontmatter(raw)
  const text = plainText(raw)
  const title = getTitle(raw, path.basename(filePath, '.md'))
  const wordCount = words(text).length
  const h2Count = countMatches(body, /^##\s+/gm)
  const imageCount = countMatches(body, /(?:!\[[^\]]*\]\([^)]*\)|<img\b)/gi)
  const internalLinkCount = countMatches(body, /\]\(\/(?!\/)/g)
  const externalLinkCount = countMatches(body, /https?:\/\//g)
  const ctaCount = countMatches(body, /(docs\.google\.com\/spreadsheets|repsootd\.com)/gi)
  const numericClaimCount = countMatches(text, /\b\d{1,3}(?:,\d{3})*(?:\.\d+)?\+?%?\b/g)
  const replacementCharacterCount = countMatches(raw, /�/g)
  const hasH1 = /^#\s+/m.test(body)
  const firstParagraph = text.slice(0, 600)

  return {
    path: `/${relativePath.replace(/\.md$/, '/').replace(/index\/$/, '')}`,
    file: relativePath,
    title,
    wordCount,
    h2Count,
    imageCount,
    internalLinkCount,
    externalLinkCount,
    ctaCount,
    numericClaimCount,
    replacementCharacterCount,
    hasH1,
    introFingerprint: getIntroFingerprint(raw),
    firstParagraph,
  }
}

function percentile(values, p) {
  if (!values.length) return 0
  const ordered = [...values].sort((a, b) => a - b)
  const index = Math.min(ordered.length - 1, Math.max(0, Math.ceil(ordered.length * p) - 1))
  return ordered[index]
}

function formatNumber(value) {
  return new Intl.NumberFormat('en-US').format(value)
}

const rootPages = readMarkdownFiles(root)
  .filter((filePath) => !internalRootFiles.has(path.basename(filePath)))
const blogPages = readMarkdownFiles(path.join(root, 'blog'))
const pages = [...rootPages, ...blogPages].map(collectPage)
const introGroups = new Map()
for (const page of pages) {
  if (!introGroups.has(page.introFingerprint)) introGroups.set(page.introFingerprint, [])
  introGroups.get(page.introFingerprint).push(page.file)
}
const duplicatedIntroGroups = [...introGroups.values()].filter((group) => group.length > 1)
const duplicatedFiles = new Set(duplicatedIntroGroups.flat())

const lowWordThreshold = 350
const candidates = pages.map((page) => {
  const issues = []
  if (!page.hasH1) issues.push('missing_h1')
  if (page.wordCount < lowWordThreshold) issues.push('thin_content')
  if (!page.imageCount) issues.push('no_image')
  if (page.replacementCharacterCount) issues.push('encoding_character')
  if (duplicatedFiles.has(page.file)) issues.push('duplicated_intro')
  if (page.numericClaimCount >= 8) issues.push('many_numeric_claims')
  if (!page.internalLinkCount) issues.push('no_internal_link')
  return { ...page, issues, priorityScore: issues.length }
}).sort((a, b) => b.priorityScore - a.priorityScore || a.wordCount - b.wordCount)

const summary = {
  pages: pages.length,
  blogPages: blogPages.length,
  rootPages: rootPages.length,
  medianWords: percentile(pages.map((page) => page.wordCount), 0.5),
  p90Words: percentile(pages.map((page) => page.wordCount), 0.9),
  thinContent: pages.filter((page) => page.wordCount < lowWordThreshold).length,
  noImages: pages.filter((page) => page.imageCount === 0).length,
  missingH1: pages.filter((page) => !page.hasH1).length,
  pagesWithReplacementCharacters: pages.filter((page) => page.replacementCharacterCount > 0).length,
  duplicatedIntroGroups: duplicatedIntroGroups.length,
  duplicatedIntroPages: duplicatedFiles.size,
  noInternalLinks: pages.filter((page) => page.internalLinkCount === 0).length,
  totalExternalLinks: pages.reduce((total, page) => total + page.externalLinkCount, 0),
  totalCtas: pages.reduce((total, page) => total + page.ctaCount, 0),
}

const lines = [
  '# Kakobuy 内容审查报告',
  '',
  '本报告由 `pnpm audit:content` 生成。指标用于识别需要人工审核和改写的页面，不等同于对页面质量的最终判断。',
  '',
  '## 内容盘点',
  '',
  '| 指标 | 结果 |',
  '| --- | ---: |',
  `| 可发布页面 | ${formatNumber(summary.pages)} |`,
  `| 博客页面 | ${formatNumber(summary.blogPages)} |`,
  `| 根目录页面 | ${formatNumber(summary.rootPages)} |`,
  `| 文章词数中位数 | ${formatNumber(summary.medianWords)} |`,
  `| 文章词数 P90 | ${formatNumber(summary.p90Words)} |`,
  `| 低于 ${lowWordThreshold} 词的页面 | ${formatNumber(summary.thinContent)} |`,
  `| 无图片的页面 | ${formatNumber(summary.noImages)} |`,
  `| 缺少 H1 的页面 | ${formatNumber(summary.missingH1)} |`,
  `| 含替换字符（�）的页面 | ${formatNumber(summary.pagesWithReplacementCharacters)} |`,
  `| 重复开头内容组 | ${formatNumber(summary.duplicatedIntroGroups)} |`,
  `| 受重复开头影响的页面 | ${formatNumber(summary.duplicatedIntroPages)} |`,
  `| 无内部链接的页面 | ${formatNumber(summary.noInternalLinks)} |`,
  `| 外链总数 | ${formatNumber(summary.totalExternalLinks)} |`,
  `| 转化链接提及总数 | ${formatNumber(summary.totalCtas)} |`,
  '',
  '## 优先人工审核页面',
  '',
  '| 页面 | 词数 | 图片 | 内链 | 风险信号 |',
  '| --- | ---: | ---: | ---: | --- |',
  ...candidates.slice(0, 60).map((page) => `| ${page.file} | ${page.wordCount} | ${page.imageCount} | ${page.internalLinkCount} | ${page.issues.join(', ') || '—'} |`),
  '',
  '## 重复开头内容组（前 20 组）',
  '',
  ...duplicatedIntroGroups.slice(0, 20).map((group, index) => `${index + 1}. ${group.join('；')}`),
  '',
]

fs.mkdirSync(outputDir, { recursive: true })
fs.writeFileSync(path.join(outputDir, 'content-audit.json'), JSON.stringify({ summary, pages: candidates, duplicatedIntroGroups }, null, 2))
fs.writeFileSync(path.join(outputDir, 'content-audit.md'), lines.join('\n'))
console.log(`Audited ${pages.length} publishable Markdown pages.`)
console.log(`Report: ${path.join(outputDir, 'content-audit.md')}`)
