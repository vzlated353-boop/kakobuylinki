param([string]$OldKeyword="fansbuy",[string]$OldBrand="FansBuy",[string]$OldDomain="bestfansbuy.com")
Write-Host ""
Write-Host "Checking site..." -ForegroundColor Cyan
$errors = @()
$warnings = @()

Write-Host "1. Checking old brand娈嬬暀..." -ForegroundColor Yellow
$files = Get-ChildItem *.md,*.vue,*.js,*.mjs -Recurse -File -ErrorAction SilentlyContinue
foreach ($f in $files) {
    try {
        $c = Get-Content $f.FullName -Raw -Encoding UTF8 -ErrorAction Stop
        if ($c -match $OldKeyword -or $c -match $OldBrand -or $c -match $OldDomain) {
            $warnings += " $($f.Name) has old brand"
        }
    } catch {}
}
if ($warnings.Count -eq 0) { Write-Host "  OK: No old brand found" -ForegroundColor Green }
else { foreach ($w in $warnings) { Write-Host "  $w" -ForegroundColor Yellow } }

Write-Host "2. Checking key files..." -ForegroundColor Yellow
foreach ($rf in @("package.json",".vitepress\config.mjs","index.md","analytics.config.json")) {
    if (Test-Path $rf) { Write-Host "  OK: $rf" -ForegroundColor Green }
    else { $errors += "Missing: $rf"; Write-Host "  FAIL: $rf" -ForegroundColor Red }
}

Write-Host "3. Checking npm..." -ForegroundColor Yellow
if (Test-Path "node_modules") { Write-Host "  OK: node_modules exists" -ForegroundColor Green }
else { Write-Host "  Need: npm install" -ForegroundColor Yellow }

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
if ($errors.Count -eq 0) { Write-Host "PASSED!" -ForegroundColor Green }
else { Write-Host "FAILED: $($errors.Count) errors" -ForegroundColor Red; foreach ($e in $errors) { Write-Host "  $e" -ForegroundColor Red } }
Write-Host "========================================" -ForegroundColor Cyan
if ($errors.Count -gt 0) { exit 1 }
