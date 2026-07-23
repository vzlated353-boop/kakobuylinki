# Read BlogPage.vue and extract configured links
$vueContent = Get-Content 'd:\fansbuy\finsbuy-main\.vitepress\theme\components\BlogPage.vue' -Raw

# Extract all link values
$pattern = "link:\s*'([^']+)'"
$matches = [regex]::Matches($vueContent, $pattern)

$configuredFiles = @()
foreach ($match in $matches) {
    $link = $match.Groups[1].Value
    # Decode URL and convert to filename
    $decoded = [System.Web.HttpUtility]::UrlDecode($link)
    $clean = $decoded -replace '^/', '' -replace '/$', ''
    $filename = $clean + '.md'
    $configuredFiles += $filename
}

$configuredFiles = $configuredFiles | Sort-Object -Unique

# Get all article files
$excludeNames = @(
    'fansbuy-article-prompt.md',
    'fansbuy-internal-link-rules.md',
    'fansbuy-product-reference.md',
    'fansbuy-review-report.md',
    'fansbuy-topic-list.md'
)

$allFiles = Get-ChildItem -Path 'd:\fansbuy\finsbuy-main' -Filter '*.md' -File | 
    Where-Object { 
        ($_.Name -like 'fansbuy*.md' -or $_.Name -like 'is fansbuy*.md') -and 
        $_.Name -notin $excludeNames 
    } | 
    ForEach-Object { $_.Name } | 
    Sort-Object

# Find unconfigured files
$unconfigured = $allFiles | Where-Object { $_ -notin $configuredFiles }

# Output to file
$output = @()
$output += "=== ARTICLE CONFIGURATION REPORT ==="
$output += ""
$output += "Total article files: $($allFiles.Count)"
$output += "Configured in BlogPage.vue: $($configuredFiles.Count)"
$output += "Unconfigured articles: $($unconfigured.Count)"
$output += ""
$output += "=== CONFIGURED FILES ($($configuredFiles.Count)) ==="
$output += $configuredFiles
$output += ""
$output += "=== UNCONFIGURED FILES ($($unconfigured.Count)) ==="
$output += $unconfigured

$output | Out-File -FilePath 'd:\fansbuy\finsbuy-main\article_report.txt' -Encoding UTF8

Write-Host "Report generated: article_report.txt"
Write-Host "Total: $($allFiles.Count), Configured: $($configuredFiles.Count), Unconfigured: $($unconfigured.Count)"
