#!/bin/bash

set -e

echo ""
echo "🚀 FansBuy 商品部署流程"
echo "========================"
echo ""

# 1. 检查 products.json 是否存在
if [ ! -f "products.json" ]; then
  echo "❌ 错误: products.json 文件不存在"
  echo ""
  echo "请先创建 products.json 文件，格式参考:"
  echo "  https://github.com/vzlated353-boop/finsbuy/blob/main/PRODUCT_WORKFLOW.md"
  echo ""
  exit 1
fi

echo "✓ 检测到 products.json"

# 2. 检查 Node.js 是否安装
if ! command -v node &> /dev/null; then
  echo "❌ 错误: 未找到 Node.js"
  echo "请先安装 Node.js: https://nodejs.org/"
  exit 1
fi

echo "✓ Node.js 已安装"

# 3. 运行更新脚本
echo ""
echo "📝 更新商品数据..."
node scripts/update-products.js

if [ $? -ne 0 ]; then
  echo "❌ 脚本执行失败"
  exit 1
fi

# 4. 检查是否有更改
echo ""
echo "🔍 检查文件变化..."

if git diff --quiet .vitepress/theme/components/HomePage.vue; then
  echo "ℹ️  没有检测到商品数据变化"
  exit 0
fi

echo "✓ 检测到 HomePage.vue 变化"

# 5. 提交更改
echo ""
echo "📤 提交更改到 Git..."

git add .vitepress/theme/components/HomePage.vue

# 获取商品数量
PRODUCT_COUNT=$(grep -o '"id":' products.json | wc -l)

git commit -m "Update products: Add/update $PRODUCT_COUNT items from products.json"

if [ $? -ne 0 ]; then
  echo "❌ 提交失败"
  exit 1
fi

echo "✓ 提交成功"

# 6. 推送到 GitHub
echo ""
echo "🔗 推送到 GitHub..."

# 使用 GITHUB_TOKEN 环境变量（如果设置）
if [ -n "$GITHUB_TOKEN" ]; then
  git push https://${GITHUB_TOKEN}@github.com/vzlated353-boop/finsbuy.git main
else
  git push origin main
fi

if [ $? -eq 0 ]; then
  echo "✓ 推送成功"
  echo ""
  echo "✅ 部署成功！"
  echo ""
  echo "📊 统计:"
  echo "  - 商品数量: $PRODUCT_COUNT"
  echo "  - 提交信息: Update products: Add/update $PRODUCT_COUNT items from products.json"
  echo ""
  echo "🌐 网站更新:"
  echo "  - Cloudflare Pages 将在 1-2 分钟内自动部署"
  echo "  - 访问 https://bestfansbuy.com/ 查看最新商品"
  echo ""
else
  echo "❌ 推送失败"
  echo ""
  echo "可能的原因:"
  echo "  1. GitHub 认证失败 - 检查 PAT 令牌"
  echo "  2. 网络连接问题 - 检查网络"
  echo "  3. 分支不存在 - 确保 main 分支存在"
  echo ""
  exit 1
fi
