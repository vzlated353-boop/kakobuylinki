import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const root = path.resolve(__dirname, '..')
const supportedExtensions = new Set(['.md', '.vue', '.html'])
const ignoredDirectories = new Set(['.git', 'node_modules', 'dist'])

function walk(directory) {
  const entries = fs.readdirSync(directory, { withFileTypes: true })
  return entries.flatMap((entry) => {
    const fullPath = path.join(directory, entry.name)
    if (entry.isDirectory()) {
      return ignoredDirectories.has(entry.name) ? [] : walk(fullPath)
    }
    return supportedExtensions.has(path.extname(entry.name)) ? [fullPath] : []
  })
}

function addSafetyTokens(relValue) {
  const tokens = new Set(relValue.split(/\s+/).filter(Boolean))
  tokens.add('noopener')
  tokens.add('noreferrer')
  return [...tokens].join(' ')
}

function hardenAnchors(content) {
  return content.replace(/<a\b([^>]*)>/gi, (full, attributes) => {
    if (!/\btarget=(['"])_blank\1/i.test(attributes)) return full

    const relMatch = attributes.match(/\brel=(['"])(.*?)\1/i)
    if (relMatch) {
      const quote = relMatch[1]
      const replacement = `rel=${quote}${addSafetyTokens(relMatch[2])}${quote}`
      return `<a${attributes.replace(relMatch[0], replacement)}>`
    }

    return `<a${attributes} rel="noopener noreferrer">`
  })
}

let updatedFiles = 0
let updatedLinks = 0

for (const filePath of walk(root)) {
  const original = fs.readFileSync(filePath, 'utf8')
  const hardened = hardenAnchors(original)
  if (hardened !== original) {
    updatedLinks += (hardened.match(/\brel=(['"])[^'"]*\bnoopener\b[^'"]*\1/gi) || []).length - (original.match(/\brel=(['"])[^'"]*\bnoopener\b[^'"]*\1/gi) || []).length
    fs.writeFileSync(filePath, hardened)
    updatedFiles += 1
  }
}

console.log(`Hardened ${updatedLinks} link attribute(s) across ${updatedFiles} file(s).`)
