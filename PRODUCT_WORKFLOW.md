# Kakobuy ÉÌÆ·ÉÏ´«¹¤×÷Á÷

±¾ÎÄµµËµÃ÷ÈçºÎÍ¨¹ý Git ¹¤×÷Á÷×Ô¶¯»¯ÉÏ´«ÉÌÆ·µ½ Kakobuy ÍøÕ¾¡£

---

## — ¹¤×÷Á÷¸ÅÊö

```
1. ´´½¨ÉÌÆ·Êý¾ÝÎÄ¼þ (products.json)
   ¡ý
2. Ìá½»µ½ Git ²Ö¿â
   ¡ý
3. ×Ô¶¯½Å±¾½âÎöÊý¾Ý
   ¡ý
4. ¸üÐÂ HomePage.vue
   ¡ý
5. ×Ô¶¯ÍÆËÍµ½ GitHub
   ¡ý
6. Cloudflare ×Ô¶¯²¿Êð
```

---

## — µÚÒ»²½£ºÉÌÆ·Êý¾Ý¸ñÊ½

### ´´½¨ `products.json` ÎÄ¼þ

ÔÚÏîÄ¿¸ùÄ¿Â¼´´½¨ `products.json` ÎÄ¼þ£¬°´ÒÔÏÂ¸ñÊ½Ìí¼ÓÉÌÆ·£º

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

### ×Ö¶ÎËµÃ÷

| ×Ö¶Î | ÀàÐÍ | ËµÃ÷ | Ê¾Àý |
|------|------|------|------|
| `id` | Êý×Ö | ÉÌÆ·Î¨Ò» ID | `1001` |
| `name` | ×Ö·û´® | ÉÌÆ·Ãû³Æ | `"Nike Air Max 90"` |
| `price` | ×Ö·û´® | ¼Û¸ñ£¨´ø»õ±Ò·ûºÅ£© | `"$89.99"` |
| `primaryCategory` | ×Ö·û´® | Ò»¼¶·ÖÀà | `"Shoes"`, `"Clothing"`, `"Watches"` |
| `secondaryCategory` | ×Ö·û´® | ¶þ¼¶·ÖÀà | `"Nike Air Max 95"`, `"T-shirt"` |
| `image` | ×Ö·û´® | Í¼Æ¬ URL | `"https://..."` |
| `link` | ×Ö·û´® | ¹ºÂòÁ´½Ó | `"https://Kakobuy.com/..."` |
| `badge` | ×Ö·û´® | »ÕÕÂ£¨¿ÉÑ¡£© | `"hot"`, `"new"`, `"value"`, »ò¿Õ×Ö·û´® |

### ÓÐÐ§µÄÒ»¼¶·ÖÀà

- `Clothing`
- `Pants`
- `Shoes`
- `Watches`
- `Accessories`

---

## — µÚ¶þ²½£ºÌá½»µ½ Git

### 2.1 ¿ËÂ¡»ò½øÈëÏîÄ¿Ä¿Â¼

```bash
cd /path/to/finsbuy
```

### 2.2 Ìí¼Ó»ò¸üÐÂ `products.json`

```bash
# Èç¹ûÊÇÐÂÎÄ¼þ
git add products.json

# Èç¹ûÊÇÐÞ¸ÄÏÖÓÐÎÄ¼þ
git add products.json
```

### 2.3 Ìá½»¸ü¸Ä

```bash
git commit -m "Add products: Nike Air Max 90, Adidas Ultraboost, Supreme T-Shirt"
```

### 2.4 ÍÆËÍµ½ GitHub

```bash
git push origin main
```

---

## — µÚÈý²½£º×Ô¶¯»¯½Å±¾

### Ê¹ÓÃ Node.js ½Å±¾×Ô¶¯¸üÐÂ HomePage.vue

´´½¨ `scripts/update-products.js` ÎÄ¼þ£º

```javascript
const fs = require('fs');
const path = require('path');

// ¶ÁÈ¡ products.json
const productsFile = path.join(__dirname, '../products.json');
const productsData = JSON.parse(fs.readFileSync(productsFile, 'utf8'));

// ¶ÁÈ¡ HomePage.vue
const homePageFile = path.join(__dirname, '../.vitepress/theme/components/HomePage.vue');
let homePageContent = fs.readFileSync(homePageFile, 'utf8');

// Éú³É products Êý×é´úÂë
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

// Ìæ»» HomePage.vue ÖÐµÄ products Êý×é
const productsArrayRegex = /const products = \[([\s\S]*?)\]/;
const newProductsArray = `const products = [\n${productsCode}\n]`;

homePageContent = homePageContent.replace(productsArrayRegex, newProductsArray);

// Ð´Èë¸üÐÂºóµÄ HomePage.vue
fs.writeFileSync(homePageFile, homePageContent, 'utf8');

console.log(`? ÒÑ¸üÐÂ ${productsData.products.length} ¸öÉÌÆ·`);
```

### ÔËÐÐ½Å±¾

```bash
node scripts/update-products.js
```

---

## — µÚËÄ²½£ºÍêÕûµÄ×Ô¶¯»¯¹¤×÷Á÷

### ´´½¨ `scripts/deploy.sh` ½Å±¾

```bash
#!/bin/bash

echo "— ¿ªÊ¼ Kakobuy ÉÌÆ·²¿ÊðÁ÷³Ì..."

# 1. ¼ì²é products.json ÊÇ·ñ´æÔÚ
if [ ! -f "products.json" ]; then
  echo "? ´íÎó: products.json ÎÄ¼þ²»´æÔÚ"
  exit 1
fi

echo "? ¼ì²âµ½ products.json"

# 2. ÔËÐÐ¸üÐÂ½Å±¾
echo "— ¸üÐÂÉÌÆ·Êý¾Ý..."
node scripts/update-products.js

if [ $? -ne 0 ]; then
  echo "? ½Å±¾Ö´ÐÐÊ§°Ü"
  exit 1
fi

# 3. ¼ì²éÊÇ·ñÓÐ¸ü¸Ä
if git diff --quiet .vitepress/theme/components/HomePage.vue; then
  echo "—  Ã»ÓÐ¼ì²âµ½ÉÌÆ·Êý¾Ý±ä»¯"
  exit 0
fi

# 4. Ìá½»¸ü¸Ä
echo "— Ìá½»¸ü¸Äµ½ Git..."
git add .vitepress/theme/components/HomePage.vue
git commit -m "Update products from products.json"

# 5. ÍÆËÍµ½ GitHub
echo "— ÍÆËÍµ½ GitHub..."
git push origin main

if [ $? -eq 0 ]; then
  echo "? ²¿Êð³É¹¦£¡"
  echo "— ÍøÕ¾½«ÔÚ 1-2 ·ÖÖÓÄÚ¸üÐÂ"
else
  echo "? ÍÆËÍÊ§°Ü"
  exit 1
fi
```

### Ê¹½Å±¾¿ÉÖ´ÐÐ

```bash
chmod +x scripts/deploy.sh
```

### ÔËÐÐ²¿Êð

```bash
./scripts/deploy.sh
```

---

## — ¹¤×÷Á÷Ê¾Àý

### ³¡¾°£ºÌí¼Ó 3 ¸öÐÂÉÌÆ·

#### ²½Öè 1£º±à¼­ `products.json`

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

#### ²½Öè 2£ºÔËÐÐ²¿Êð½Å±¾

```bash
./scripts/deploy.sh
```

#### ²½Öè 3£º×Ô¶¯»¯Á÷³Ì

```
? ¼ì²âµ½ products.json
? ¸üÐÂÉÌÆ·Êý¾Ý (3 ¸öÉÌÆ·)
? ¼ì²âµ½ HomePage.vue ±ä»¯
? Ìá½»: "Update products from products.json"
? ÍÆËÍµ½ GitHub
? ²¿Êð³É¹¦£¡
— ÍøÕ¾½«ÔÚ 1-2 ·ÖÖÓÄÚ¸üÐÂ
```

---

## — °²È«½¨Òé

### 1. ±£»¤ GitHub ·ÃÎÊÁîÅÆ

²»ÒªÔÚ½Å±¾ÖÐÓ²±àÂë PAT¡£Ê¹ÓÃ»·¾³±äÁ¿£º

```bash
export GITHUB_TOKEN="your_token_here"
git push https://${GITHUB_TOKEN}@github.com/vzlated353-boop/finsbuy.git main
```

### 2. ÑéÖ¤ÉÌÆ·Êý¾Ý

ÔÚ½Å±¾ÖÐÌí¼ÓÊý¾ÝÑéÖ¤£º

```javascript
function validateProduct(product) {
  const required = ['id', 'name', 'price', 'primaryCategory', 'secondaryCategory', 'image', 'link'];
  for (let field of required) {
    if (!product[field]) {
      throw new Error(`È±ÉÙ±ØÐè×Ö¶Î: ${field}`);
    }
  }
}
```

### 3. ´íÎó´¦Àí

Ìí¼ÓÏêÏ¸µÄ´íÎóÈÕÖ¾ºÍÍ¨Öª»úÖÆ¡£

---

## — API ¼¯³É£¨¿ÉÑ¡£©

Èç¹ûÄãÏëÈÃÆäËûÏµÍ³Í¨¹ý API ÉÏ´«ÉÌÆ·£¬¿ÉÒÔ´´½¨Ò»¸ö¼òµ¥µÄ Node.js API£º

### ´´½¨ `api/upload-product.js`

```javascript
const express = require('express');
const fs = require('fs');
const app = express();

app.use(express.json());

app.post('/api/products/add', (req, res) => {
  const product = req.body;

  // ÑéÖ¤
  if (!product.id || !product.name || !product.price) {
    return res.status(400).json({ error: 'È±ÉÙ±ØÐè×Ö¶Î' });
  }

  // ¶ÁÈ¡ÏÖÓÐÊý¾Ý
  const productsFile = 'products.json';
  let data = JSON.parse(fs.readFileSync(productsFile, 'utf8'));

  // Ìí¼ÓÐÂÉÌÆ·
  data.products.push(product);

  // ±£´æ
  fs.writeFileSync(productsFile, JSON.stringify(data, null, 2), 'utf8');

  res.json({ success: true, message: 'ÉÌÆ·ÒÑÌí¼Ó' });
});

app.listen(3000, () => console.log('API ÔËÐÐÔÚ http://localhost:3000'));
```

---

## ? ¼ì²éÇåµ¥

- [ ] ´´½¨ `products.json` ÎÄ¼þ
- [ ] ´´½¨ `scripts/update-products.js` ½Å±¾
- [ ] ´´½¨ `scripts/deploy.sh` ½Å±¾
- [ ] ²âÊÔ½Å±¾ÊÇ·ñÕý³£ÔËÐÐ
- [ ] ÑéÖ¤ GitHub ÍÆËÍ³É¹¦
- [ ] È·ÈÏ Cloudflare ×Ô¶¯²¿Êð
- [ ] ÔÚÍøÕ¾ÉÏ¿´µ½ÐÂÉÌÆ·

---

## — ¹ÊÕÏÅÅ³ý

### ÎÊÌâ 1£º½Å±¾ÕÒ²»µ½ products.json

**½â¾ö·½°¸**£ºÈ·±£ `products.json` ÔÚÏîÄ¿¸ùÄ¿Â¼

```bash
ls -la products.json
```

### ÎÊÌâ 2£ºGitHub ÍÆËÍÊ§°Ü

**½â¾ö·½°¸**£º¼ì²é PAT ÁîÅÆÊÇ·ñÓÐÐ§

```bash
git push origin main --verbose
```

### ÎÊÌâ 3£ºÍøÕ¾Ã»ÓÐ¸üÐÂ

**½â¾ö·½°¸**£º
1. ¼ì²é Cloudflare Pages ¹¹½¨ÈÕÖ¾
2. Çå³ýä¯ÀÀÆ÷»º´æ
3. µÈ´ý 1-2 ·ÖÖÓ

---

## — Ö§³Ö

ÈçÓÐÎÊÌâ£¬Çë¼ì²é£º
1. `products.json` ¸ñÊ½ÊÇ·ñÕýÈ·
2. Ò»¼¶·ÖÀàºÍ¶þ¼¶·ÖÀàÊÇ·ñÓÐÐ§
3. Í¼Æ¬ URL ÊÇ·ñ¿É·ÃÎÊ
4. ¹ºÂòÁ´½ÓÊÇ·ñÓÐÐ§

---

**×îºó¸üÐÂ**£º2024 Äê 7 ÔÂ 14 ÈÕ
