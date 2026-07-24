# Add Start shopping button to blog articles
$files = Get-ChildItem -Path "D:\kakobuylinki" -Filter "Kakobuy-*.md"

$count = 0
$skipped = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Skip if already has shopping button
    if ($content -match 'class="shopping-btn"') {
        Write-Host "Skipped: $($file.Name)" -ForegroundColor Yellow
        $skipped++
        continue
    }
    
    # Find Spreadsheet link and add button after it
    $pattern = '(<a href="https://docs\.google\.com/spreadsheets/d/10e9euL3y7Bw7GvWUhX2FruG8mJWXz8C7eNwTo69XoQA/edit\?gid=1903531254#gid=1903531254" target="_blank" rel="nofollow">Access Kakobuy Spreadsheet</a>)'
    $replacement = '$1 <a href="https://repsootd.com/" target="_blank" rel="nofollow" class="shopping-btn">Start shopping</a>'
    
    $newContent = $content -replace $pattern, $replacement
    
    if ($newContent -ne $content) {
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8 -NoNewline
        Write-Host "Processed: $($file.Name)" -ForegroundColor Green
        $count++
    }
}

Write-Host "Done! Processed: $count, Skipped: $skipped" -ForegroundColor Cyan
