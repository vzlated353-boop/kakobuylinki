# Extract links from BlogPage.vue
$vueContent = Get-Content 'd:\fansbuy\finsbuy-main\.vitepress\theme\components\BlogPage.vue' -Raw
$links = [regex]::Matches($vueContent, "link:\s*'([^']+)'") | ForEach-Object { $_.Groups[1].Value }

# Convert URL-encoded paths to filenames
$configuredFiles = $links | ForEach-Object {
    $decoded = [System.Web.HttpUtility]::UrlDecode($_)
    $clean = $decoded -replace '^/', '' -replace '/$', ''
    $clean + '.md'
} | Sort-Object -Unique

# Get all article files (excluding spec files)
$excludeNames = @("fansbuy-article-prompt.md","fansbuy-internal-link-rules.md","fansbuy-product-reference.md","fansbuy-review-report.md","fansbuy-topic-list.md")
$allFiles = Get-ChildItem -Path "d:\fansbuy\finsbuy-main" -Filter "*.md" -File | Where-Object {
    ($_.Name -like "fansbuy*.md" -or $_.Name -like "is fansbuy*.md") -and $_.Name -notin $excludeNames
} | ForEach-Object { $_.Name } | Sort-Object

# Find unconfigured files
$unconfigured = $allFiles | Where-Object { $_ -notin $configuredFiles }

# Output results
Write-Host "=== SUMMARY ==="
Write-Host "Total article files: $($allFiles.Count)"
Write-Host "Configured in BlogPage.vue: $($configuredFiles.Count)"
Write-Host "Unconfigured articles: $($unconfigured.Count)"
Write-Host ""
Write-Host "=== UNCONFIGURED FILES ==="
$unconfigured | ForEach-Object { Write-Host $_ }
