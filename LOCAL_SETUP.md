# 本地修改指南

## 📦 项目结构

```
new-deploy/
├── .vitepress/
│   ├── config.mjs              # VitePress 配置
│   └── theme/
│       ├── components/
│       │   └── ProductGrid.vue  # 商品网格组件（核心）
│       ├── custom.css
│       ├── fashion.css
│       └── index.js
├── index.md                     # 首页
├── package.json                 # 依赖配置
└── ideas.md                     # 设计文档
```

## 🛠️ 本地开发步骤

### 1. 安装依赖
```bash
npm install
```

### 2. 本地开发服务器
```bash
npm run dev
```
然后访问 `http://localhost:5173` (本地开发环境)

### 3. 修改商品数据

编辑 `.vitepress/theme/components/ProductGrid.vue`，找到 `products` 数组：

```javascript
const products = [
  {
    id: 7572864219,
    badge: 'hot',                    // 'new', 'hot', 'value'
    name: 'Ralph Lauren T-shirt',
    price: '$11.37',
    category: 'clothing',
    image: 'https://...',            // 图片 URL
    link: 'https://Kakobuy.com/...'  // 购买链接
  },
  // ... 更多商品
]
```

### 4. 修改分类标签

编辑 `.vitepress/theme/components/ProductGrid.vue`，找到分类按钮：

```html
<button class="filter-btn active">All</button>
<button class="filter-btn">T-Shirts</button>
<button class="filter-btn">Shoes</button>
<!-- 添加或修改分类 -->
```

### 5. 修改网站信息

编辑 `.vitepress/config.mjs`：

```javascript
export default {
  title: 'Best Kakobuy - Fashion Store',  // 网站标题
  description: 'Discover the latest fashion trends',  // 描述
  // ...
}
```

### 6. 构建静态网站
```bash
npm run build
```
输出文件在 `.vitepress/dist/` 目录

## 📤 上传到 GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
```

## 🚀 部署到 Cloudflare Pages

1. 访问 https://dash.cloudflare.com/
2. Workers & Pages → Pages → Create → Connect to Git
3. 选择你的 GitHub 仓库
4. 配置：
   - Build command: `npm run build`
   - Build output directory: `.vitepress/dist`
   - Node.js version: `22`
5. 点击 Save and Deploy

## 📝 常见修改

### 添加新商品
在 `ProductGrid.vue` 的 `products` 数组中添加：
```javascript
{
  id: 新ID,
  badge: 'hot',
  name: '商品名称',
  price: '$价格',
  category: '分类',
  image: '图片URL',
  link: '购买链接'
}
```

### 修改列数
编辑 `ProductGrid.vue` 的 CSS 媒体查询：
```css
@media (min-width: 1201px) and (max-width: 1500px) {
  .waterfall-grid {
    grid-template-columns: repeat(10, 1fr);  /* 修改这个数字 */
  }
}
```

### 修改颜色
编辑 `ProductGrid.vue` 的 CSS：
```css
.badge-hot {
  background-color: #ff8c00;  /* 修改颜色 */
}
```

## ✅ 检查清单

- [ ] 修改了商品数据
- [ ] 修改了分类标签
- [ ] 修改了网站标题
- [ ] 本地测试成功 (`npm run dev`)
- [ ] 构建成功 (`npm run build`)
- [ ] 推送到 GitHub
- [ ] 部署到 Cloudflare Pages

## 🆘 常见问题

**Q: 本地开发时看不到商品？**
A: 确保运行了 `npm install`，然后重新启动开发服务器

**Q: 修改后网站没有更新？**
A: 清除浏览器缓存（Ctrl+Shift+Delete），然后刷新

**Q: 如何添加更多商品？**
A: 在 `ProductGrid.vue` 的 `products` 数组中添加新对象

**Q: 如何修改布局列数？**
A: 编辑 `ProductGrid.vue` 中的 CSS 媒体查询
