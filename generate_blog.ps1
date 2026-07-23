# Generate complete BlogPage.vue with all unconfigured articles

# Already configured 42 articles (do not add again)
$configured = @(
    'fansbuy for beginners', 'fansbuy how to use', 'fansbuy getting started',
    'fansbuy account setup', 'fansbuy shipping guide', 'fansbuy payment guide',
    'fansbuy sneakers', 'fansbuy clothes', 'fansbuy hoodies', 'fansbuy t-shirts',
    'fansbuy bags', 'fansbuy accessories',
    'fansbuy nike', 'fansbuy jordan', 'fansbuy adidas', 'fansbuy chrome hearts',
    'fansbuy essentials', 'fansbuy palm angels',
    'fansbuy budget picks', 'fansbuy coupon', 'fansbuy best deals',
    'fansbuy cheap sneakers', 'fansbuy budget hoodies', 'fansbuy save money',
    'is fansbuy legit', 'fansbuy legit check', 'fansbuy qc photos',
    'fansbuy reviews', 'fansbuy reddit', 'fansbuy vs kakobuy',
    'fansbuy spreadsheet', 'fansbuy spreadsheet best', 'fansbuy spreadsheet 2026',
    'fansbuy spreadsheet nike', 'fansbuy spreadsheet jordan', 'fansbuy spreadsheet link',
    'fansbuy uk', 'fansbuy canada', 'fansbuy australia', 'fansbuy europe',
    'fansbuy polska', 'fansbuy international shipping'
)

# Function to convert filename to title case
function ConvertTo-Title($name) {
    $words = $name -split ' '
    $result = @()
    foreach ($word in $words) {
        if ($word.Length -gt 0) {
            $result += $word.Substring(0,1).ToUpper() + $word.Substring(1)
        }
    }
    return ($result -join ' ')
}

# Function to generate link
function ConvertTo-Link($name) {
    return '/' + ($name -replace ' ', '%20') + '/'
}

# Function to generate excerpt based on topic
function Get-Excerpt($name) {
    $lower = $name.ToLower()
    
    # Getting Started
    if ($lower -match 'guide|tutorial|walkthrough|beginner|start|first|account|order|purchase|registration|onboarding|dashboard') {
        return "Complete guide to help you get started with Fansbuy platform and make your first purchase successfully."
    }
    
    # Shoes
    if ($lower -match 'shoes|sneakers|boots|cleats|slides|heels|footwear|air force|air max|running|basketball|soccer|football|golf|hiking|tennis|casual|streetwear') {
        return "Comprehensive guide to shoes available on Fansbuy with quality data, sizing tips, and buyer reviews."
    }
    
    # Clothing
    if ($lower -match 'clothes|clothing|hoodie|t-shirt|shirt|pants|jeans|shorts|jacket|tracksuit|sweatpants|vest|polo|dress|hat|cap') {
        return "Explore clothing options on Fansbuy with quality comparisons, sizing guides, and style recommendations."
    }
    
    # Bags & Accessories
    if ($lower -match 'bag|backpack|handbag|purse|wallet|accessories|sunglasses|watch|jewelry|belt|socks|gloves|earrings|glasses') {
        return "Quality bags and accessories guide with product comparisons and buyer satisfaction data."
    }
    
    # Brands
    if ($lower -match 'nike|jordan|adidas|yeezy|new balance|asics|vans|puma|reebok|converse|stussy|supreme|bape|trapstar|corteiz|gallery dept|denim tears|hellstar|sp5der|vlone|amiri|casablanca|vivienne westwood|essentials|chrome hearts|north face|canada goose|moncler|carhartt|gymshark|youngla|eric emanuel|ea7|mertra|lacoste|ralph lauren|polo ralph|oakley|venum|juicy couture|alo|arcteryx|ed hardy|nocta') {
        return "Complete brand guide on Fansbuy with product range, quality data, and pricing information."
    }
    
    if ($lower -match 'louis vuitton|gucci|prada|dior|chanel|balenciaga|versace|valentino|fendi|givenchy|burberry|miu miu|celine|alexander mcqueen|cartier|audemars piguet|tissot|coach|michael kors|louboutin|hermes|rolex|off white|rick owens|tommy hilfiger|kenzo|isabel marant|lanvin|ysl|zara|ami|amiri') {
        return "Luxury brand collection on Fansbuy with quality verification and authenticity information."
    }
    
    # Save Money
    if ($lower -match 'budget|cheap|save money|coupon|deal|discount|sale|bargain|value|affordable|cost effective|wholesale|bulk') {
        return "Money-saving guide with budget-friendly products, discount strategies, and shopping tips."
    }
    
    # Trust & Safety
    if ($lower -match 'legit|trust|safety|quality|qc|review|verified|authentic|original|scam|fake|secure|payment|refund|return|warranty|protection|privacy') {
        return "Trust and safety guide covering quality verification, user reviews, and platform reliability."
    }
    
    # Spreadsheet
    if ($lower -match 'spreadsheet') {
        return "Spreadsheet resource guide with product data, quality information, and download links."
    }
    
    # Regional
    if ($lower -match 'uk|canada|australia|europe|polska|poland|romania|asia|africa|latin america|middle east|oceania|international|worldwide|global|shipping') {
        return "Regional shipping guide with delivery options, customs information, and local payment methods."
    }
    
    # Product Guides
    if ($lower -match 'electronics|airpods|iphone|ipad|phone|dyson|jbl|tech|gadget|collectible|lego|hot wheels|cosmetics|makeup|fragrance|perfume') {
        return "Product guide covering electronics, gadgets, and specialty items available on Fansbuy."
    }
    
    if ($lower -match 'sports|gear|basketball|football|soccer|golf|tennis|running|gym|mma|motocross|motorcycle|mtb|outdoor|fishing') {
        return "Sports and outdoor gear guide with equipment recommendations and quality data."
    }
    
    # Platform Comparisons
    if ($lower -match 'vs|comparison|alternative|competitor') {
        return "Platform comparison guide covering pricing, shipping, quality, and service differences."
    }
    
    # Community
    if ($lower -match 'discord|instagram|telegram|tiktok|reddit|community|social') {
        return "Community guide covering social platforms, user discussions, and engagement tips."
    }
    
    # Batch & Quality
    if ($lower -match 'batch|quality|best batch|2025|2026') {
        return "Batch quality guide with version comparisons, quality ratings, and buyer recommendations."
    }
    
    # Default
    return "Comprehensive guide covering product information, quality data, and shopping tips on Fansbuy."
}

# Define all unconfigured articles by category
$gettingStarted = @(
    'fansbuy account creation', 'fansbuy account security', 'fansbuy balance guide',
    'fansbuy beginner guide', 'fansbuy complete guide', 'fansbuy complete platform guide',
    'fansbuy dashboard guide', 'fansbuy essential guide', 'fansbuy first order',
    'fansbuy first purchase tips', 'fansbuy free guide', 'fansbuy new user guide',
    'fansbuy onboarding', 'fansbuy order guide', 'fansbuy ordering process',
    'fansbuy purchase guide', 'fansbuy registration guide', 'fansbuy start here',
    'fansbuy step by step', 'fansbuy tutorial', 'fansbuy walkthrough'
)

$topCategoriesShoes = @(
    'fansbuy air force 1', 'fansbuy air max', 'fansbuy asics', 'fansbuy basketball shoes',
    'fansbuy big size shoes', 'fansbuy big sizes', 'fansbuy casual shoes', 'fansbuy cleats',
    'fansbuy crocs', 'fansbuy daily wear shoes', 'fansbuy dc shoes', 'fansbuy dior b30',
    'fansbuy football boots', 'fansbuy football shoes', 'fansbuy golf shoes',
    'fansbuy hiking shoes', 'fansbuy junior shoes', 'fansbuy junior sizes',
    'fansbuy kids shoes', 'fansbuy kids sizes', 'fansbuy kobe 6', 'fansbuy kobe',
    'fansbuy men shoes', 'fansbuy new balance 9060', 'fansbuy new balance',
    'fansbuy nike air force 1', 'fansbuy nike air max', 'fansbuy nike tn',
    'fansbuy outdoor shoes', 'fansbuy running shoes', 'fansbuy shoes 2026',
    'fansbuy shoes', 'fansbuy slides', 'fansbuy sneakers 2026', 'fansbuy sneakers guide',
    'fansbuy soccer shoes', 'fansbuy streetwear shoes', 'fansbuy tennis shoes',
    'fansbuy vapormax', 'fansbuy vans', 'fansbuy women shoes', 'fansbuy women sizes',
    'fansbuy xxl shoes', 'fansbuy xxl sizes'
)

$topCategoriesClothing = @(
    'fansbuy clothes 2026', 'fansbuy clothing guide', 'fansbuy fall clothes',
    'fansbuy fashion clothes', 'fansbuy girls clothes', 'fansbuy gym clothes',
    'fansbuy hats', 'fansbuy headwear', 'fansbuy hoodie guide', 'fansbuy hoodie',
    'fansbuy jackets', 'fansbuy jeans guide', 'fansbuy jeans', 'fansbuy jorts',
    'fansbuy kids clothes', 'fansbuy men clothes', 'fansbuy pants', 'fansbuy polo shirt',
    'fansbuy polo', 'fansbuy shirt', 'fansbuy shirts', 'fansbuy shorts',
    'fansbuy spring clothes', 'fansbuy summer clothes', 'fansbuy sweatpants',
    'fansbuy tech fleece', 'fansbuy tracksuit guide', 'fansbuy tracksuit',
    'fansbuy t-shirt guide', 'fansbuy t-shirt', 'fansbuy vest', 'fansbuy winter clothes',
    'fansbuy women clothes'
)

$topCategoriesAccessories = @(
    'fansbuy accessories guide', 'fansbuy backpack', 'fansbuy bags guide', 'fansbuy belt',
    'fansbuy budget accessories', 'fansbuy budget bags', 'fansbuy caps', 'fansbuy cheap accessories',
    'fansbuy cheap bags', 'fansbuy coach bag', 'fansbuy earrings', 'fansbuy glasses',
    'fansbuy gloves', 'fansbuy handbag', 'fansbuy hats guide', 'fansbuy jewelry',
    'fansbuy lv bag', 'fansbuy mobile accessories', 'fansbuy phone accessories',
    'fansbuy phone case', 'fansbuy purse', 'fansbuy socks', 'fansbuy sunglasses',
    'fansbuy wallet', 'fansbuy watches guide', 'fansbuy watches', 'fansbuy watch'
)

$popularBrandsSports = @(
    'fansbuy adidas guide', 'fansbuy adidas superstar', 'fansbuy alo', 'fansbuy arcteryx',
    'fansbuy bape', 'fansbuy carhartt', 'fansbuy corteiz', 'fansbuy denim tears',
    'fansbuy ed hardy', 'fansbuy eric emanuel', 'fansbuy gallery dept', 'fansbuy gymshark',
    'fansbuy hellstar', 'fansbuy juicy couture', 'fansbuy lacoste', 'fansbuy mertra',
    'fansbuy nocta', 'fansbuy oakley', 'fansbuy polo ralph lauren', 'fansbuy ralph lauren',
    'fansbuy sp5der', 'fansbuy spider', 'fansbuy stussy', 'fansbuy trapstar',
    'fansbuy true religion', 'fansbuy venum', 'fansbuy vlone', 'fansbuy youngla'
)

$popularBrandsLuxury = @(
    'fansbuy alexander mcqueen', 'fansbuy ami', 'fansbuy amiri', 'fansbuy audemars piguet',
    'fansbuy balenciaga slides', 'fansbuy balenciaga track', 'fansbuy balenciaga',
    'fansbuy burberry hoodie', 'fansbuy burberry', 'fansbuy cartier', 'fansbuy casablanca',
    'fansbuy celine', 'fansbuy chanel', 'fansbuy dior', 'fansbuy fendi', 'fansbuy givenchy',
    'fansbuy gucci', 'fansbuy hermes', 'fansbuy isabel marant', 'fansbuy kenzo',
    'fansbuy lanvin', 'fansbuy louis vuitton', 'fansbuy louboutin', 'fansbuy lv skate',
    'fansbuy michael kors', 'fansbuy miu miu', 'fansbuy moncler', 'fansbuy off white',
    'fansbuy prada', 'fansbuy rick owens', 'fansbuy rolex', 'fansbuy tissot',
    'fansbuy tommy hilfiger', 'fansbuy valentino', 'fansbuy versace', 'fansbuy victoria secret',
    'fansbuy vivienne westwood', 'fansbuy ysl', 'fansbuy zara'
)

$popularBrandsOther = @(
    'fansbuy alpha industries', 'fansbuy canada goose', 'fansbuy cdg', 'fansbuy coach',
    'fansbuy cp company', 'fansbuy diesel', 'fansbuy ea7', 'fansbuy jbl speaker',
    'fansbuy jbl', 'fansbuy jeremy scott', 'fansbuy kukirin', 'fansbuy labubu',
    'fansbuy north face', 'fansbuy supreme hoodie', 'fansbuy supreme', 'fansbuy the north face',
    'fansbuy timberland', 'fansbuy ugg lowmel', 'fansbuy yeezy'
)

$saveMoney = @(
    'fansbuy affordable fashion', 'fansbuy affordable luxury', 'fansbuy bargain guide',
    'fansbuy best alternative', 'fansbuy best value', 'fansbuy budget batch',
    'fansbuy budget clothes', 'fansbuy budget guide', 'fansbuy budget luxury',
    'fansbuy budget shopping', 'fansbuy budget shoes', 'fansbuy budget sneakers',
    'fansbuy budget streetwear', 'fansbuy budget t-shirts', 'fansbuy cheap clothes',
    'fansbuy cheap finds', 'fansbuy cheap hoodies', 'fansbuy cheap luxury',
    'fansbuy cheap shoes', 'fansbuy cheap streetwear', 'fansbuy cheap t-shirts',
    'fansbuy cheapest products', 'fansbuy cost effective', 'fansbuy coupon code',
    'fansbuy coupon guide', 'fansbuy deal hunter', 'fansbuy discount guide',
    'fansbuy free shipping', 'fansbuy holiday deals', 'fansbuy low price guide',
    'fansbuy luxury finds', 'fansbuy money saving tips', 'fansbuy premium quality',
    'fansbuy sale guide', 'fansbuy seasonal deals', 'fansbuy shopping hacks',
    'fansbuy shopping tips', 'fansbuy summer deals', 'fansbuy value shopping',
    'fansbuy winter deals', 'fansbuy wholesale guide'
)

$trustSafety = @(
    'fansbuy authentic check', 'fansbuy buyer protection', 'fansbuy buyer tips',
    'fansbuy common mistakes', 'fansbuy credit card safety', 'fansbuy customer reviews',
    'fansbuy data security', 'fansbuy fake check', 'fansbuy good quality',
    'fansbuy high quality', 'fansbuy legit check guide', 'fansbuy legit guide',
    'fansbuy legitimacy', 'fansbuy original guide', 'fansbuy original products',
    'fansbuy packaging guide', 'fansbuy payment safety', 'fansbuy paypal guide',
    'fansbuy privacy guide', 'fansbuy qc guide', 'fansbuy quality check',
    'fansbuy quality control', 'fansbuy quality guide', 'fansbuy quality verification',
    'fansbuy refund guide', 'fansbuy reliable', 'fansbuy return policy',
    'fansbuy review guide', 'fansbuy safe shopping', 'fansbuy safety guide',
    'fansbuy scam check', 'fansbuy secure payment', 'fansbuy seller ratings',
    'fansbuy trust guide', 'fansbuy trustpilot reviews', 'fansbuy trustpilot',
    'fansbuy trustworthy', 'fansbuy user reviews', 'fansbuy verified products',
    'fansbuy verified sellers', 'fansbuy warranty guide'
)

$spreadsheetTools = @(
    'fansbuy spreadsheet #1', 'fansbuy spreadsheet 10 000', 'fansbuy spreadsheet 10000',
    'fansbuy spreadsheet 10k', 'fansbuy spreadsheet 15000', 'fansbuy spreadsheet 20000',
    'fansbuy spreadsheet 2024', 'fansbuy spreadsheet 2025 best batch',
    'fansbuy spreadsheet 2025 cheap', 'fansbuy spreadsheet 2025 polska',
    'fansbuy spreadsheet 2025 reddit', 'fansbuy spreadsheet 2025 women',
    'fansbuy spreadsheet 2025', 'fansbuy spreadsheet 2026 best batch',
    'fansbuy spreadsheet 2026 budget', 'fansbuy spreadsheet 2026 polska',
    'fansbuy spreadsheet 2026 summer', 'fansbuy spreadsheet 2026 tiktok',
    'fansbuy spreadsheet 2026 with qc', 'fansbuy spreadsheet 2026 women',
    'fansbuy spreadsheet 2026', 'fansbuy spreadsheet 3000', 'fansbuy spreadsheet 4000',
    'fansbuy spreadsheet 5000', 'fansbuy spreadsheet 6000+', 'fansbuy spreadsheet 8000',
    'fansbuy spreadsheet accessories', 'fansbuy spreadsheet adidas',
    'fansbuy spreadsheet archive fashion', 'fansbuy spreadsheet archive',
    'fansbuy spreadsheet bags', 'fansbuy spreadsheet best quality',
    'fansbuy spreadsheet best sellers', 'fansbuy spreadsheet big size',
    'fansbuy spreadsheet clothing', 'fansbuy spreadsheet com', 'fansbuy spreadsheet community',
    'fansbuy spreadsheet discord', 'fansbuy spreadsheet docs', 'fansbuy spreadsheet download',
    'fansbuy spreadsheet electronics', 'fansbuy spreadsheet excel', 'fansbuy spreadsheet fashion',
    'fansbuy spreadsheet female', 'fansbuy spreadsheet findindex', 'fansbuy spreadsheet for girls',
    'fansbuy spreadsheet for kids', 'fansbuy spreadsheet formula', 'fansbuy spreadsheet free',
    'fansbuy spreadsheet google docs', 'fansbuy spreadsheet google sheets',
    'fansbuy spreadsheet google', 'fansbuy spreadsheet hoodies', 'fansbuy spreadsheet hub',
    'fansbuy spreadsheet junior clothing', 'fansbuy spreadsheet junior fashion',
    'fansbuy spreadsheet junior shoes', 'fansbuy spreadsheet junior',
    'fansbuy spreadsheet kids clothing', 'fansbuy spreadsheet kids fashion',
    'fansbuy spreadsheet kids shoes', 'fansbuy spreadsheet kids', 'fansbuy spreadsheet legit',
    'fansbuy spreadsheet linktree', 'fansbuy spreadsheet list', 'fansbuy spreadsheet luxury',
    'fansbuy spreadsheet maker', 'fansbuy spreadsheet men',
    'fansbuy spreadsheet men''s accessories', 'fansbuy spreadsheet men''s bags',
    'fansbuy spreadsheet men''s clothing', 'fansbuy spreadsheet men''s fashion',
    'fansbuy spreadsheet men''s shoes', 'fansbuy spreadsheet men''s',
    'fansbuy spreadsheet new', 'fansbuy spreadsheet org', 'fansbuy spreadsheet outdoor',
    'fansbuy spreadsheet plus size', 'fansbuy spreadsheet premium quality',
    'fansbuy spreadsheet qc photos', 'fansbuy spreadsheet qc',
    'fansbuy spreadsheet reddit 2025', 'fansbuy spreadsheet reddit 2026',
    'fansbuy spreadsheet reddit', 'fansbuy spreadsheet reviews', 'fansbuy spreadsheet shoes',
    'fansbuy spreadsheet site', 'fansbuy spreadsheet sneakers', 'fansbuy spreadsheet sports',
    'fansbuy spreadsheet streetwear', 'fansbuy spreadsheet telegram',
    'fansbuy spreadsheet template', 'fansbuy spreadsheet the best',
    'fansbuy spreadsheet trending', 'fansbuy spreadsheet t-shirts',
    'fansbuy spreadsheet ultimate', 'fansbuy spreadsheet update', 'fansbuy spreadsheet v2',
    'fansbuy spreadsheet verified', 'fansbuy spreadsheet watches', 'fansbuy spreadsheet website',
    'fansbuy spreadsheet with photos', 'fansbuy spreadsheet with qc photos',
    'fansbuy spreadsheet with qc reddit', 'fansbuy spreadsheet with qc',
    'fansbuy spreadsheet with reviews', 'fansbuy spreadsheet with sales',
    'fansbuy spreadsheet women 2026', 'fansbuy spreadsheet women',
    'fansbuy spreadsheet women''s accessories', 'fansbuy spreadsheet women''s bags',
    'fansbuy spreadsheet women''s clothing', 'fansbuy spreadsheet women''s fashion',
    'fansbuy spreadsheet women''s shoes', 'fansbuy spreadsheet women''s',
    'fansbuy spreadsheet xxl'
)

$regionalInternational = @(
    'fansbuy africa shipping', 'fansbuy asia shipping', 'fansbuy australia guide',
    'fansbuy canada guide', 'fansbuy eu shipping', 'fansbuy euro shipping',
    'fansbuy global shipping', 'fansbuy international', 'fansbuy latin america shipping',
    'fansbuy middle east shipping', 'fansbuy oceania shipping', 'fansbuy poland guide',
    'fansbuy poland', 'fansbuy polska 2026', 'fansbuy polska guide',
    'fansbuy romania guide', 'fansbuy romania', 'fansbuy uk guide',
    'fansbuy us shipping', 'fansbuy worldwide shipping',
    'fansbuy consolidation guide', 'fansbuy delivery guide', 'fansbuy economy shipping',
    'fansbuy ems shipping', 'fansbuy express shipping', 'fansbuy shipping costs',
    'fansbuy shipping methods', 'fansbuy shipping options', 'fansbuy shipping times'
)

# Other uncategorized articles - split into new categories
$productGuides = @(
    'fansbuy airpods', 'fansbuy apple watch', 'fansbuy basketball gear',
    'fansbuy collectibles', 'fansbuy cosmetics', 'fansbuy dress', 'fansbuy dyson',
    'fansbuy electronics guide', 'fansbuy electronics', 'fansbuy fishing gear',
    'fansbuy football gear', 'fansbuy football jersey', 'fansbuy football kits',
    'fansbuy football t-shirt', 'fansbuy footwear', 'fansbuy fragrance',
    'fansbuy golf gear', 'fansbuy gym gear', 'fansbuy heels', 'fansbuy hot wheels',
    'fansbuy ipad', 'fansbuy iphone case', 'fansbuy iphone', 'fansbuy jacket guide',
    'fansbuy jacket', 'fansbuy lego', 'fansbuy makeup', 'fansbuy mma gear',
    'fansbuy motocross gear', 'fansbuy motorcycle gear', 'fansbuy mtb gear',
    'fansbuy outdoor gear', 'fansbuy perfume', 'fansbuy phone', 'fansbuy purple jeans',
    'fansbuy room decor', 'fansbuy running gear', 'fansbuy size chart',
    'fansbuy size conversion', 'fansbuy size guide', 'fansbuy sizing chart',
    'fansbuy sizing guide', 'fansbuy soccer gear', 'fansbuy sports clothes',
    'fansbuy sports gear', 'fansbuy tech gadgets', 'fansbuy tennis gear',
    'fansbuy underwear'
)

$platformComparisons = @(
    'fansbuy alternatives', 'fansbuy alternative', 'fansbuy best sellers',
    'fansbuy bulk buying', 'fansbuy comparison guide', 'fansbuy competitor comparison',
    'fansbuy everything you need to know', 'fansbuy exchange guide', 'fansbuy for resellers',
    'fansbuy how to buy', 'fansbuy how to order', 'fansbuy how to use 2026',
    'fansbuy platform comparison', 'fansbuy platform guide', 'fansbuy plus size',
    'fansbuy profit guide', 'fansbuy reselling guide', 'fansbuy reselling tips',
    'fansbuy seller guide', 'fansbuy shopping guide', 'fansbuy vs hoobuy',
    'fansbuy vs litbuy', 'fansbuy vs oopbuy', 'fansbuy vs pandabuy', 'fansbuy vs usfans',
    'fansbuy with photos', 'fansbuy with qc photos', 'fansbuy with qc reddit',
    'fansbuy with qc', 'fansbuy with reviews', 'fansbuy with sales', 'fansbuy yupoo'
)

$communitySocial = @(
    'fansbuy community guide', 'fansbuy discord community', 'fansbuy discord',
    'fansbuy instagram', 'fansbuy reddit 2025', 'fansbuy reddit 2026',
    'fansbuy reddit guide', 'fansbuy reddit reviews', 'fansbuy tiktok',
    'fansbuy telegram guide', 'fansbuy telegram'
)

$batchQuality = @(
    'fansbuy batch comparison', 'fansbuy batch guide', 'fansbuy batch quality',
    'fansbuy batch tracker', 'fansbuy batch version', 'fansbuy best batch',
    'fansbuy best quality', 'fansbuy 2025 best batch', 'fansbuy 2026 best batch',
    'fansbuy unboxing', 'fansbuy warehouse guide'
)

# Remove duplicates and configured articles
function Get-UniqueArticles($articles) {
    $unique = @()
    foreach ($article in $articles) {
        if ($article -notin $configured -and $article -notin $unique) {
            $unique += $article
        }
    }
    return $unique
}

$gettingStarted = Get-UniqueArticles $gettingStarted
$topCategoriesShoes = Get-UniqueArticles $topCategoriesShoes
$topCategoriesClothing = Get-UniqueArticles $topCategoriesClothing
$topCategoriesAccessories = Get-UniqueArticles $topCategoriesAccessories
$popularBrandsSports = Get-UniqueArticles $popularBrandsSports
$popularBrandsLuxury = Get-UniqueArticles $popularBrandsLuxury
$popularBrandsOther = Get-UniqueArticles $popularBrandsOther
$saveMoney = Get-UniqueArticles $saveMoney
$trustSafety = Get-UniqueArticles $trustSafety
$spreadsheetTools = Get-UniqueArticles $spreadsheetTools
$regionalInternational = Get-UniqueArticles $regionalInternational
$productGuides = Get-UniqueArticles $productGuides
$platformComparisons = Get-UniqueArticles $platformComparisons
$communitySocial = Get-UniqueArticles $communitySocial
$batchQuality = Get-UniqueArticles $batchQuality

# Generate article object
function New-ArticleObject($name) {
    $title = ConvertTo-Title $name
    $link = ConvertTo-Link $name
    $excerpt = Get-Excerpt $name
    return "      {
        title: '$title',
        excerpt: '$excerpt',
        link: '$link',
      }"
}

# Generate series
function New-Series($name, $articles) {
    if ($articles.Count -eq 0) { return "" }
    $articleObjects = $articles | ForEach-Object { New-ArticleObject $_ }
    $articlesStr = $articleObjects -join ",`n"
    return "  {
    name: '$name',
    articles: [
$articlesStr
    ],
  }"
}

# Build complete articleSeries
$series = @()
$series += New-Series "Getting Started" $gettingStarted
$series += New-Series "Top Categories - Shoes" $topCategoriesShoes
$series += New-Series "Top Categories - Clothing" $topCategoriesClothing
$series += New-Series "Top Categories - Accessories" $topCategoriesAccessories
$series += New-Series "Popular Brands - Sports" $popularBrandsSports
$series += New-Series "Popular Brands - Luxury" $popularBrandsLuxury
$series += New-Series "Popular Brands - Other" $popularBrandsOther
$series += New-Series "Save Money" $saveMoney
$series += New-Series "Trust & Safety" $trustSafety
$series += New-Series "Spreadsheet & Tools" $spreadsheetTools
$series += New-Series "Regional & International" $regionalInternational
$series += New-Series "Product Guides" $productGuides
$series += New-Series "Platform Comparisons" $platformComparisons
$series += New-Series "Community & Social" $communitySocial
$series += New-Series "Batch & Quality" $batchQuality

$seriesStr = ($series | Where-Object { $_ -ne "" }) -join ",`n"

# Read existing BlogPage.vue
$vuePath = "d:\fansbuy\finsbuy-main\.vitepress\theme\components\BlogPage.vue"
$content = Get-Content $vuePath -Raw

# Replace articleSeries section
$newScript = @"
<script setup>
const articleSeries = [
$seriesStr
]

const recommendedSeries = [
  {
    name: 'Getting Started',
    articles: [
      { title: 'Fansbuy for Beginners', link: '/fansbuy%20for%20beginners/' },
      { title: 'How to Use', link: '/fansbuy%20how%20to%20use/' },
      { title: 'Shipping Guide', link: '/fansbuy%20shipping%20guide/' },
    ],
  },
  {
    name: 'Top Categories',
    articles: [
      { title: 'Sneakers', link: '/fansbuy%20sneakers/' },
      { title: 'Hoodies', link: '/fansbuy%20hoodies/' },
      { title: 'Clothes', link: '/fansbuy%20clothes/' },
    ],
  },
  {
    name: 'Popular Brands',
    articles: [
      { title: 'Nike', link: '/fansbuy%20nike/' },
      { title: 'Jordan', link: '/fansbuy%20jordan/' },
      { title: 'Adidas', link: '/fansbuy%20adidas/' },
    ],
  },
  {
    name: 'Save Money',
    articles: [
      { title: 'Budget Picks', link: '/fansbuy%20budget%20picks/' },
      { title: 'Coupon', link: '/fansbuy%20coupon/' },
      { title: 'Best Deals', link: '/fansbuy%20best%20deals/' },
    ],
  },
  {
    name: 'Trust & Safety',
    articles: [
      { title: 'Is Fansbuy Legit?', link: '/is%20fansbuy%20legit/' },
      { title: 'Legit Check', link: '/fansbuy%20legit%20check/' },
      { title: 'QC Photos', link: '/fansbuy%20qc%20photos/' },
    ],
  },
  {
    name: 'Spreadsheet',
    articles: [
      { title: 'Spreadsheet Guide', link: '/fansbuy%20spreadsheet/' },
      { title: 'Best Products', link: '/fansbuy%20spreadsheet%20best/' },
      { title: '2026 Updates', link: '/fansbuy%20spreadsheet%202026/' },
    ],
  },
]
</script>
"@

# Extract template and style
$templateMatch = [regex]::Match($content, '(?s)<template>.*?</template>')
$styleMatch = [regex]::Match($content, '(?s)<style scoped>.*?</style>')

$template = $templateMatch.Value
$style = $styleMatch.Value

# Combine new content
$newContent = @"
$template

$newScript

$style
"@

# Write to file
$newContent | Out-File -FilePath $vuePath -Encoding UTF8 -NoNewline

Write-Host "BlogPage.vue generated successfully!"
Write-Host "Total series: $(($series | Where-Object { $_ -ne '' }).Count)"
Write-Host "Getting Started: $($gettingStarted.Count) articles"
Write-Host "Top Categories - Shoes: $($topCategoriesShoes.Count) articles"
Write-Host "Top Categories - Clothing: $($topCategoriesClothing.Count) articles"
Write-Host "Top Categories - Accessories: $($topCategoriesAccessories.Count) articles"
Write-Host "Popular Brands - Sports: $($popularBrandsSports.Count) articles"
Write-Host "Popular Brands - Luxury: $($popularBrandsLuxury.Count) articles"
Write-Host "Popular Brands - Other: $($popularBrandsOther.Count) articles"
Write-Host "Save Money: $($saveMoney.Count) articles"
Write-Host "Trust & Safety: $($trustSafety.Count) articles"
Write-Host "Spreadsheet & Tools: $($spreadsheetTools.Count) articles"
Write-Host "Regional & International: $($regionalInternational.Count) articles"
Write-Host "Product Guides: $($productGuides.Count) articles"
Write-Host "Platform Comparisons: $($platformComparisons.Count) articles"
Write-Host "Community & Social: $($communitySocial.Count) articles"
Write-Host "Batch & Quality: $($batchQuality.Count) articles"
