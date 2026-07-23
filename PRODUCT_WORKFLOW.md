# Kakobuy 商品上传工作流

本文档说明如何通过 Git 工作流自动化上传商品到 Kakobuy 网站。

---

## 📋 工作流概述

```
1. 创建商品数据文件 (products.json)
   ↓
2. 提交到 Git 仓库
   ↓
3. 自动脚本解析数据
   ↓
4. 更新 HomePage.vue
   ↓
5. 自动推送到 GitHub
   ↓
6. Cloudflare 自动部署
```

---

## 🔧 第一步：商品数据格式

### 创建 `products.json` 文件

在项目根目录创建 `products.json` 文件，按以下格式添加商品：

```json
{
  "products": [
    {
      "id": 1001,
      "name": "Nike Air Max 90",
      "price": "$89.99",
      "primaryCategory": "Shoes",
      "secondaryCategory": "Nike Air Max 95",
      "image": "https://example.com/nike-air-max-90.jpg",
      "link": "https://Kakobuy.com/item-1001",
      "badge": "hot"
    },
    {
      "id": 1002,
      "name": "Adidas Ultraboost",
      "price": "$129.99",
      "primaryCategory": "Shoes",
      "secondaryCategory": "Adidas",
      "image": "https://example.com/adidas-ultraboost.jpg",
      "link": "https://Kakobuy.com/item-1002",
      "badge": "new"
    },
    {
      "id": 1003,
      "name": "Supreme T-Shirt",
      "price": "$45.00",
      "primaryCategory": "Clothing",
      "secondaryCategory": "T-shirt",
      "image": "https://example.com/supreme-tshirt.jpg",
      "link": "https://Kakobuy.com/item-1003",
      "badge": ""
    }
  ]
}
```

### 字段说明

| 字段 | 类型 | 说明 | 示例 |
|------|------|------|------|
| `id` | 数字 | 商品唯一 ID | `1001` |
| `name` | 字符串 | 商品名称 | `"Nike Air Max 90"` |
| `price` | 字符串 | 价格（带货币符号） | `"$89.99"` |
| `primaryCategory` | 字符串 | 一级分类 | `"Shoes"`, `"Clothing"`, `"Watches"` |
| `secondaryCategory` | 字符串 | 二级分类 | `"Nike Air Max 95"`, `"T-shirt"` |
| `image` | 字符串 | 图片 URL | `"https://..."` |
| `link` | 字符串 | 购买链接 | `"https://Kakobuy.com/..."` |
| `badge` | 字符串 | 徽章（可选） | `"hot"`, `"new"`, `"value"`, 或空字符串 |

### 有效的一级分类

- `Clothing`
- `Pants`
- `Shoes`
- `Watches`
- `Accessories`

---

## 📤 第二步：提交到 Git

### 2.1 克隆或进入项目目录

```bash
cd /path/to/finsbuy
```

### 2.2 添加或更新 `products.json`

```bash
# 如果是新文件
git add products.json

# 如果是修改现有文件
git add products.json
```

### 2.3 提交更改

```bash
git commit -m "Add products: Nike Air Max 90, Adidas Ultraboost, Supreme T-Shirt"
```

### 2.4 推送到 GitHub

```bash
git push origin main
```

---

## 🤖 第三步：自动化脚本

### 使用 Node.js 脚本自动更新 HomePage.vue

创建 `scripts/update-products.js` 文件：

```javascript
const fs = require('fs');
const path = require('path');

// 读取 products.json
const productsFile = path.join(__dirname, '../products.json');
const productsData = JSON.parse(fs.readFileSync(productsFile, 'utf8'));

// 读取 HomePage.vue
const homePageFile = path.join(__dirname, '../.vitepress/theme/components/HomePage.vue');
let homePageContent = fs.readFileSync(homePageFile, 'utf8');

// 生成 products 数组代码
const productsCode = productsData.products.map(product => {
  return `  {
    id: ${product.id},
    badge: '${product.badge}',
    name: '${product.name}',
    price: '${product.price}',
    primaryCategory: '${product.primaryCategory}',
    secondaryCategory: '${product.secondaryCategory}',
    image: '${product.image}',
    link: '${product.link}'
  }`;
}).join(',\n');

// 替换 HomePage.vue 中的 products 数组
const productsArrayRegex = /const products = \[([\s\S]*?)\]/;
const newProductsArray = `const products = [\n${productsCode}\n]`;

homePageContent = homePageContent.replace(productsArrayRegex, newProductsArray);

// 写入更新后的 HomePage.vue
fs.writeFileSync(homePageFile, homePageContent, 'utf8');

console.log(`✓ 已更新 ${productsData.products.length} 个商品`);
```

### 运行脚本

```bash
node scripts/update-products.js
```

---

## 🔄 第四步：完整的自动化工作流

### 创建 `scripts/deploy.sh` 脚本

```bash
#!/bin/bash

echo "🚀 开始 Kakobuy 商品部署流程..."

# 1. 检查 products.json 是否存在
if [ ! -f "products.json" ]; then
  echo "❌ 错误: products.json 文件不存在"
  exit 1
fi

echo "✓ 检测到 products.json"

# 2. 运行更新脚本
echo "📝 更新商品数据..."
node scripts/update-products.js

if [ $? -ne 0 ]; then
  echo "❌ 脚本执行失败"
  exit 1
fi

# 3. 检查是否有更改
if git diff --quiet .vitepress/theme/components/HomePage.vue; then
  echo "ℹ️  没有检测到商品数据变化"
  exit 0
fi

# 4. 提交更改
echo "📤 提交更改到 Git..."
git add .vitepress/theme/components/HomePage.vue
git commit -m "Update products from products.json"

# 5. 推送到 GitHub
echo "🔗 推送到 GitHub..."
git push origin main

if [ $? -eq 0 ]; then
  echo "✅ 部署成功！"
  echo "🌐 网站将在 1-2 分钟内更新"
else
  echo "❌ 推送失败"
  exit 1
fi
```

### 使脚本可执行

```bash
chmod +x scripts/deploy.sh
```

### 运行部署

```bash
./scripts/deploy.sh
```

---

## 📋 工作流示例

### 场景：添加 3 个新商品

#### 步骤 1：编辑 `products.json`

```json
{
  "products": [
    {
      "id": 2001,
      "name": "Dior B30 Sneaker",
      "price": "$750.00",
      "primaryCategory": "Shoes",
      "secondaryCategory": "Dior B30",
      "image": "https://example.com/dior-b30.jpg",
      "link": "https://Kakobuy.com/item-2001",
      "badge": "hot"
    },
    {
      "id": 2002,
      "name": "Rolex Submariner",
      "price": "$12000.00",
      "primaryCategory": "Watches",
      "secondaryCategory": "Rolex Watches",
      "image": "https://example.com/rolex.jpg",
      "link": "https://Kakobuy.com/item-2002",
      "badge": "value"
    },
    {
      "id": 2003,
      "name": "Gucci Leather Belt",
      "price": "$450.00",
      "primaryCategory": "Accessories",
      "secondaryCategory": "Belt",
      "image": "https://example.com/gucci-belt.jpg",
      "link": "https://Kakobuy.com/item-2003",
      "badge": ""
    }
  ]
}
```

#### 步骤 2：运行部署脚本

```bash
./scripts/deploy.sh
```

#### 步骤 3：自动化流程

```
✓ 检测到 products.json
✓ 更新商品数据 (3 个商品)
✓ 检测到 HomePage.vue 变化
✓ 提交: "Update products from products.json"
✓ 推送到 GitHub
✅ 部署成功！
🌐 网站将在 1-2 分钟内更新
```

---

## 🔐 安全建议

### 1. 保护 GitHub 访问令牌

不要在脚本中硬编码 PAT。使用环境变量：

```bash
export GITHUB_TOKEN="your_token_here"
git push https://${GITHUB_TOKEN}@github.com/vzlated353-boop/finsbuy.git main
```

### 2. 验证商品数据

在脚本中添加数据验证：

```javascript
function validateProduct(product) {
  const required = ['id', 'name', 'price', 'primaryCategory', 'secondaryCategory', 'image', 'link'];
  for (let field of required) {
    if (!product[field]) {
      throw new Error(`缺少必需字段: ${field}`);
    }
  }
}
```

### 3. 错误处理

添加详细的错误日志和通知机制。

---

## 🔗 API 集成（可选）

如果你想让其他系统通过 API 上传商品，可以创建一个简单的 Node.js API：

### 创建 `api/upload-product.js`

```javascript
const express = require('express');
const fs = require('fs');
const app = express();

app.use(express.json());

app.post('/api/products/add', (req, res) => {
  const product = req.body;

  // 验证
  if (!product.id || !product.name || !product.price) {
    return res.status(400).json({ error: '缺少必需字段' });
  }

  // 读取现有数据
  const productsFile = 'products.json';
  let data = JSON.parse(fs.readFileSync(productsFile, 'utf8'));

  // 添加新商品
  data.products.push(product);

  // 保存
  fs.writeFileSync(productsFile, JSON.stringify(data, null, 2), 'utf8');

  res.json({ success: true, message: '商品已添加' });
});

app.listen(3000, () => console.log('API 运行在 http://localhost:3000'));
```

---

## ✅ 检查清单

- [ ] 创建 `products.json` 文件
- [ ] 创建 `scripts/update-products.js` 脚本
- [ ] 创建 `scripts/deploy.sh` 脚本
- [ ] 测试脚本是否正常运行
- [ ] 验证 GitHub 推送成功
- [ ] 确认 Cloudflare 自动部署
- [ ] 在网站上看到新商品

---

## 🆘 故障排除

### 问题 1：脚本找不到 products.json

**解决方案**：确保 `products.json` 在项目根目录

```bash
ls -la products.json
```

### 问题 2：GitHub 推送失败

**解决方案**：检查 PAT 令牌是否有效

```bash
git push origin main --verbose
```

### 问题 3：网站没有更新

**解决方案**：
1. 检查 Cloudflare Pages 构建日志
2. 清除浏览器缓存
3. 等待 1-2 分钟

---

## 📞 支持

如有问题，请检查：
1. `products.json` 格式是否正确
2. 一级分类和二级分类是否有效
3. 图片 URL 是否可访问
4. 购买链接是否有效

---

**最后更新**：2024 年 7 月 14 日
