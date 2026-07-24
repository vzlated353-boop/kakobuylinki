# Start Shopping 按钮同步需求说明

> 本文档描述 FansBuy 项目已完成的 UI 修改，需同步至所有克隆站点（如 Kakobuy 等）。
> 生成日期：2026-07-23

***

## 一、需求概述

在品类页面（shoes.md、clothes.md、hats.md）的 Spreadsheet 按钮旁，添加 "Start shopping" 按钮。

***

## 二、修改文件清单

共涉及 **4 个文件**：

| 文件                            | 修改类型 |
| ----------------------------- | ---- |
| `.vitepress/theme/custom.css` | 新增样式 |
| `shoes.md`                    | 新增按钮 |
| `clothes.md`                  | 新增按钮 |
| `hats.md`                     | 新增按钮 |

***

## 三、具体修改内容

### 3.1 custom.css — 新增样式

在 `custom.css` 文件末尾追加以下样式代码：

```css
/* ===== Category Page Shopping Button ===== */
.spreadsheet-cta .shopping-btn {
  display: inline-block;
  margin-left: 15px;
  padding: 14px 32px;
  background: #d4af37;
  color: #fff;
  text-decoration: none;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(212, 175, 55, 0.3);
}

.spreadsheet-cta .shopping-btn:hover {
  background: #c4a030;
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
}

@media (max-width: 768px) {
  .spreadsheet-cta .shopping-btn {
    margin-left: 0;
    margin-top: 15px;
    display: block;
  }
}
```

### 3.2 品类页面 — shoes.md / clothes.md / hats.md

在每个品类页面的 `<div class="spreadsheet-cta">` 块中，在 Spreadsheet 按钮的 `</a>` 标签后、`</div>` 标签前，插入 "Start shopping" 按钮。

**修改前：**

```html
<div class="spreadsheet-cta">
  <a :href="spreadsheetLink" target="_blank" class="spreadsheet-btn">
    <span class="btn-icon"></span>
    <span>View {Category} Spreadsheet</span>
    <span class="btn-arrow">→</span>
  </a>
</div>
```

**修改后：**

```html
<div class="spreadsheet-cta">
  <a :href="spreadsheetLink" target="_blank" class="spreadsheet-btn">
    <span class="btn-icon"></span>
    <span>View {Category} Spreadsheet</span>
    <span class="btn-arrow">→</span>
  </a>
  <a href="{SHOPPING_URL}" target="_blank" rel="nofollow" class="shopping-btn">Start shopping</a>
</div>
```

**注意：** `{Category}` 分别为 Shoes / Clothes / Hats，`{SHOPPING_URL}` 需替换为各站点实际链接。

***

## 四、颜色规范

| 元素                    | 颜色值                       | 说明    |
| --------------------- | ------------------------- | ----- |
| "Start shopping" 按钮背景 | `#d4af37`                 | 金色    |
| "Start shopping" 悬停背景 | `#c4a030`                 | 深金色   |
| "Start shopping" 阴影   | `rgba(212, 175, 55, 0.3)` | 金色半透明 |

***

## 六、执行检查清单

在目标站点执行同步时，请逐项确认：

- [ ] `custom.css` 末尾追加了品类页按钮样式（`.spreadsheet-cta .shopping-btn`）
- [ ] `shoes.md` 的 `.spreadsheet-cta` 中添加了 shopping 按钮
- [ ] `clothes.md` 的 `.spreadsheet-cta` 中添加了 shopping 按钮
- [ ] `hats.md` 的 `.spreadsheet-cta` 中添加了 shopping 按钮
- [ ] 所有购物按钮颜色为 `#d4af37`（金色）
- [ ] 所有购物按钮链接指向正确的站点购物 URL
- [ ] 所有购物按钮包含 `target="_blank"` 和 `rel="nofollow"`
- [ ] 运行 `npm run build` 构建成功，无错误

***

## 七、注意事项

1. **不要修改 Spreadsheet 按钮** — Spreadsheet 按钮保持原有样式不变
2. **响应式适配** — CSS 中已包含 768px 断点的响应式样式，确保全量复制
3. **构建验证** — 修改完成后必须运行 `npm run build` 确认无报错

