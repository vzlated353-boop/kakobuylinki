import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { missingBlogPaths, noindexRelativePaths } from '../.vitepress/indexing-policy.mjs'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const root = path.resolve(__dirname, '..')
const dist = path.join(root, '.vitepress', 'dist')
const hostname = 'https://kakobuylinki.com'

function pagePath(relativePath) {
  const pathname = relativePath.replace(/\.md$/, '').replace(/index$/, '')
  return `/${pathname}`.replace(/\/{2,}/g, '/').replace(/\/$/, '') || '/'
}

function pageFile(relativePath) {
  const pathname = pagePath(relativePath)
  return pathname === '/'
    ? path.join(dist, 'index.html')
    : path.join(dist, `${pathname.slice(1)}.html`)
}

function collectHtmlFiles(directory) {
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const entryPath = path.join(directory, entry.name)
    if (entry.isDirectory()) return collectHtmlFiles(entryPath)
    return entry.name.endsWith('.html') ? [entryPath] : []
  })
}

const errors = []
const sitemap = fs.readFileSync(path.join(dist, 'sitemap.xml'), 'utf8')
for (const relativePath of noindexRelativePaths) {
  const url = `${hostname}${pagePath(relativePath)}`
  if (sitemap.includes(`<loc>${url}</loc>`)) {
    errors.push(`Noindex URL remains in sitemap: ${url}`)
  }
  const htmlPath = pageFile(relativePath)
  const html = fs.readFileSync(htmlPath, 'utf8')
  if (!/name="robots" content="noindex,follow"/.test(html)) {
    errors.push(`Noindex directive missing: ${relativePath}`)
  }
}

for (const htmlPath of collectHtmlFiles(dist)) {
  const html = fs.readFileSync(htmlPath, 'utf8')
  for (const match of html.matchAll(/<a\b[^>]*\bhref="([^"]+)"[^>]*>/gi)) {
    const href = match[1].replace(/\/index\/?$/, '').replace(/\/$/, '')
    if (missingBlogPaths.has(href)) {
      errors.push(`Missing blog URL is still an anchor: ${href} in ${path.relative(dist, htmlPath)}`)
    }
  }
}

console.log(`Noindex pages checked: ${noindexRelativePaths.size}`)
console.log(`Known missing blog paths checked: ${missingBlogPaths.size}`)
console.log(`Errors found: ${errors.length}`)
if (errors.length) {
  for (const error of errors) console.log(`  ${error}`)
  process.exit(1)
}
console.log('Indexing policy verification passed.')
