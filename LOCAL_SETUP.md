# ±¾µØÐÞ¸ÄÖ¸ÄÏ

## — ÏîÄ¿½á¹¹

```
new-deploy/
©À©¤©¤ .vitepress/
©¦   ©À©¤©¤ config.mjs              # VitePress ÅäÖÃ
©¦   ©¸©¤©¤ theme/
©¦       ©À©¤©¤ components/
©¦       ©¦   ©¸©¤©¤ ProductGrid.vue  # ÉÌÆ·Íø¸ñ×é¼þ£¨ºËÐÄ£©
©¦       ©À©¤©¤ custom.css
©¦       ©À©¤©¤ fashion.css
©¦       ©¸©¤©¤ index.js
©À©¤©¤ index.md                     # Ê×Ò³
©À©¤©¤ package.json                 # ÒÀÀµÅäÖÃ
©¸©¤©¤ ideas.md                     # Éè¼ÆÎÄµµ
```

## —? ±¾µØ¿ª·¢²½Öè

### 1. °²×°ÒÀÀµ
```bash
npm install
```

### 2. ±¾µØ¿ª·¢·þÎñÆ÷
```bash
npm run dev
```
È»ºó·ÃÎÊ `http://localhost:5173` (±¾µØ¿ª·¢»·¾³)

### 3. ÐÞ¸ÄÉÌÆ·Êý¾Ý

±à¼­ `.vitepress/theme/components/ProductGrid.vue`£¬ÕÒµ½ `products` Êý×é£º

```javascript
const products = [
  {
    id: 7572864219,
    badge: 'hot',                    // 'new', 'hot', 'value'
    name: 'Ralph Lauren T-shirt',
    price: '$11.37',
    category: 'clothing',
    image: 'https://...',            // Í¼Æ¬ URL
    link: 'https://Kakobuy.com/...'  // ¹ºÂòÁ´½Ó
  },
  // ... ¸ü¶àÉÌÆ·
]
```

### 4. ÐÞ¸Ä·ÖÀà±êÇ©

±à¼­ `.vitepress/theme/components/ProductGrid.vue`£¬ÕÒµ½·ÖÀà°´Å¥£º

```html
<button class="filter-btn active">All</button>
<button class="filter-btn">T-Shirts</button>
<button class="filter-btn">Shoes</button>
<!-- Ìí¼Ó»òÐÞ¸Ä·ÖÀà -->
```

### 5. ÐÞ¸ÄÍøÕ¾ÐÅÏ¢

±à¼­ `.vitepress/config.mjs`£º

```javascript
export default {
  title: 'Best Kakobuy - Fashion Store',  // ÍøÕ¾±êÌâ
  description: 'Discover the latest fashion trends',  // ÃèÊö
  // ...
}
```

### 6. ¹¹½¨¾²Ì¬ÍøÕ¾
```bash
npm run build
```
Êä³öÎÄ¼þÔÚ `.vitepress/dist/` Ä¿Â¼

## — ÉÏ´«µ½ GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/ÄãµÄÓÃ»§Ãû/²Ö¿âÃû.git
git push -u origin main
```

## — ²¿Êðµ½ Cloudflare Pages

1. ·ÃÎÊ https://dash.cloudflare.com/
2. Workers & Pages → Pages → Create → Connect to Git
3. Ñ¡ÔñÄãµÄ GitHub ²Ö¿â
4. ÅäÖÃ£º
   - Build command: `npm run build`
   - Build output directory: `.vitepress/dist`
   - Node.js version: `22`
5. µã»÷ Save and Deploy

## — ³£¼ûÐÞ¸Ä

### Ìí¼ÓÐÂÉÌÆ·
ÔÚ `ProductGrid.vue` µÄ `products` Êý×éÖÐÌí¼Ó£º
```javascript
{
  id: ÐÂID,
  badge: 'hot',
  name: 'ÉÌÆ·Ãû³Æ',
  price: '$¼Û¸ñ',
  category: '·ÖÀà',
  image: 'Í¼Æ¬URL',
  link: '¹ºÂòÁ´½Ó'
}
```

### ÐÞ¸ÄÁÐÊý
±à¼­ `ProductGrid.vue` µÄ CSS Ã½Ìå²éÑ¯£º
```css
@media (min-width: 1201px) and (max-width: 1500px) {
  .waterfall-grid {
    grid-template-columns: repeat(10, 1fr);  /* ÐÞ¸ÄÕâ¸öÊý×Ö */
  }
}
```

### ÐÞ¸ÄÑÕÉ«
±à¼­ `ProductGrid.vue` µÄ CSS£º
```css
.badge-hot {
  background-color: #ff8c00;  /* ÐÞ¸ÄÑÕÉ« */
}
```

## ? ¼ì²éÇåµ¥

- [ ] ÐÞ¸ÄÁËÉÌÆ·Êý¾Ý
- [ ] ÐÞ¸ÄÁË·ÖÀà±êÇ©
- [ ] ÐÞ¸ÄÁËÍøÕ¾±êÌâ
- [ ] ±¾µØ²âÊÔ³É¹¦ (`npm run dev`)
- [ ] ¹¹½¨³É¹¦ (`npm run build`)
- [ ] ÍÆËÍµ½ GitHub
- [ ] ²¿Êðµ½ Cloudflare Pages

## — ³£¼ûÎÊÌâ

**Q: ±¾µØ¿ª·¢Ê±¿´²»µ½ÉÌÆ·£¿**
A: È·±£ÔËÐÐÁË `npm install`£¬È»ºóÖØÐÂÆô¶¯¿ª·¢·þÎñÆ÷

**Q: ÐÞ¸ÄºóÍøÕ¾Ã»ÓÐ¸üÐÂ£¿**
A: Çå³ýä¯ÀÀÆ÷»º´æ£¨Ctrl+Shift+Delete£©£¬È»ºóË¢ÐÂ

**Q: ÈçºÎÌí¼Ó¸ü¶àÉÌÆ·£¿**
A: ÔÚ `ProductGrid.vue` µÄ `products` Êý×éÖÐÌí¼ÓÐÂ¶ÔÏó

**Q: ÈçºÎÐÞ¸Ä²¼¾ÖÁÐÊý£¿**
A: ±à¼­ `ProductGrid.vue` ÖÐµÄ CSS Ã½Ìå²éÑ¯
