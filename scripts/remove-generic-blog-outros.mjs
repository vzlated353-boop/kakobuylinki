import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const blogDirectory = path.resolve(__dirname, '..', 'blog')
const genericOutro = /\r?\n{1,4}Choosing the right [^\r\n]*?If you want to explore more curated collections across multiple brands and categories, visit the \[Kakobuy Spreadsheet\]\(https:\/\/kakobuylinki\.com\/\) homepage for additional shopping resources and regularly updated product guides\.\s*$/

let updatedFiles = 0
for (const entry of fs.readdirSync(blogDirectory, { withFileTypes: true })) {
  if (!entry.isFile() || !entry.name.endsWith('.md')) continue

  const filePath = path.join(blogDirectory, entry.name)
  const original = fs.readFileSync(filePath, 'utf8')
  const cleaned = original.replace(genericOutro, '\n')

  if (cleaned !== original) {
    fs.writeFileSync(filePath, cleaned)
    updatedFiles += 1
  }
}

console.log(`Removed generic blog outros from ${updatedFiles} file(s).`)
