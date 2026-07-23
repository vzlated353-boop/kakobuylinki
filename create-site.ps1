<#
.SYNOPSIS
    Multi Brand SEO Website Generator

.DESCRIPTION
    Clone FansBuy project into a new independent brand website.
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$Brand = "",

    [Parameter(Mandatory = $false)]
    [string]$Keyword = "",

    [Parameter(Mandatory = $false)]
    [string]$Domain = "",

    [Parameter(Mandatory = $false)]
    [string]$Repository = "",

    [Parameter(Mandatory = $false)]
    [string]$GA_ID = "",

    [Parameter(Mandatory = $false)]
    [string]$GTM_ID = "",

    [Parameter(Mandatory = $false)]
    [string]$SearchConsole = "",

    [Parameter(Mandatory = $false)]
    [string]$OutputDir = ""
)

$ErrorActionPreference = "Stop"
$startTime = Get-Date

$SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$OldBrand = "FansBuy"
$OldKeyword = "fansbuy"
$OldDomain = "bestfansbuy.com"

$TextExtensions = @(".md", ".vue", ".js", ".mjs", ".css", ".html", ".json", ".yaml", ".yml", ".toml", ".txt", ".xml")

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMsg = "[$timestamp] [$Level] $Message"
    $color = switch ($Level) {
        "ERROR" { "Red" }
        "WARN"  { "Yellow" }
        "OK"    { "Green" }
        "STEP"  { "Cyan" }
        default { "White" }
    }
    Write-Host $logMsg -ForegroundColor $color
    if (Test-Path $logFile) {
        Add-Content -Path $logFile -Value $logMsg -Encoding UTF8
    }
}

# Interactive input if params not provided
if ($Brand -eq "" -or $Keyword -eq "" -or $Domain -eq "") {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Multi Brand SEO Website Generator v2.0" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    $Brand = Read-Host "Brand (e.g. Kakobuy)"
    if ($Brand -eq "") { Write-Host "Brand is required."; exit 1 }
    $Keyword = Read-Host "Keyword (e.g. kakobuy) [$($Brand.ToLower())]"
    if ($Keyword -eq "") { $Keyword = $Brand.ToLower() }
    $Domain = Read-Host "Domain (e.g. bestkakobuy.com) [best$Keyword.com]"
    if ($Domain -eq "") { $Domain = "best$Keyword.com" }
    $Repository = Read-Host "Repository name [$Keyword-spreadsheet]"
    if ($Repository -eq "") { $Repository = "$Keyword-spreadsheet" }
    $GA_ID = Read-Host "GA Measurement ID (optional)"
    $GTM_ID = Read-Host "GTM ID (optional)"
    $SearchConsole = Read-Host "Search Console code (optional)"
    $OutputDir = Read-Host "Output directory [D:\sites\$Repository]"
    if ($OutputDir -eq "") { $OutputDir = "D:\sites\$Repository" }

    Write-Host ""
    Write-Host "Config:" -ForegroundColor Green
    Write-Host "  Brand: $Brand"
    Write-Host "  Keyword: $Keyword"
    Write-Host "  Domain: $Domain"
    Write-Host "  Repository: $Repository"
    Write-Host "  Output: $OutputDir"
    Write-Host ""

    $confirm = Read-Host "Start? (Y/n)"
    if ($confirm -eq "n" -or $confirm -eq "N") { exit 0 }
}

# Build keyword variant map
$KeywordMap = @{}
$KeywordMap["fansbuy"] = $Keyword.ToLower()
$KeywordMap["Fansbuy"] = $Brand
$KeywordMap["FANSBUY"] = $Keyword.ToUpper()
$KeywordMap["fans_buy"] = $Keyword.ToLower()
$KeywordMap["Fans_Buy"] = $Brand
$KeywordMap["FANS_BUY"] = $Keyword.ToUpper()
$KeywordMap["fans-buy"] = $Keyword.ToLower()
$KeywordMap["Fans-Buy"] = $Brand
$KeywordMap["FANS-BUY"] = $Keyword.ToUpper()

# Validate source
if (-not (Test-Path $SourceDir)) {
    Write-Log "Source dir not found: $SourceDir" "ERROR"
    exit 1
}

# Check output dir
if (Test-Path $OutputDir) {
    Write-Host "Warning: Output dir exists: $OutputDir" -ForegroundColor Yellow
    $confirm = Read-Host "Overwrite? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") { exit 0 }
    Remove-Item -Path $OutputDir -Recurse -Force
}

New-Item -Path $OutputDir -ItemType Directory -Force | Out-Null
$logFile = Join-Path $OutputDir "generator.log"
New-Item -Path $logFile -ItemType File -Force | Out-Null

Write-Log "=========================================" "STEP"
Write-Log "Source: $SourceDir" "INFO"
Write-Log "Target: $OutputDir" "INFO"
Write-Log "Brand: $Brand / Keyword: $Keyword / Domain: $Domain" "INFO"
Write-Log "=========================================" "STEP"

# Step 1: Copy files
Write-Log "Step 1/6: Copying files..." "STEP"

$robocopyArgs = @(
    $SourceDir,
    $OutputDir,
    "/E",
    "/XD", "node_modules", ".git", "dist",
    "/XF", "package-lock.json", "generator.log",
    "/NFL", "/NDL", "/NJH", "/NJS", "/NC", "/NS", "/NP"
)
& robocopy @robocopyArgs | Out-Null

if ($LASTEXITCODE -gt 7) {
    Write-Log "Copy failed!" "ERROR"
    exit 1
}

$copiedFiles = (Get-ChildItem $OutputDir -Recurse -File -Exclude "generator.log").Count
Write-Log "  Copied $copiedFiles files" "OK"

# Step 2: Rename files
Write-Log "Step 2/6: Renaming files..." "STEP"

$renamedFiles = 0
$allFiles = Get-ChildItem $OutputDir -Recurse -File -Exclude "generator.log"

foreach ($file in $allFiles) {
    $newName = $file.Name
    $sortedKeys = ($KeywordMap.Keys | Sort-Object { $_.Length } -Descending)
    foreach ($oldKey in $sortedKeys) {
        $newKey = $KeywordMap[$oldKey]
        if ($newName -like "*$oldKey*") {
            $newName = $newName -replace [regex]::Escape($oldKey), $newKey
        }
    }
    if ($newName -ne $file.Name) {
        $newPath = Join-Path $file.DirectoryName $newName
        Rename-Item -Path $file.FullName -NewName $newName -Force
        $renamedFiles++
    }
}

Write-Log "  Renamed $renamedFiles files" "OK"

# Step 3: Replace content
Write-Log "Step 3/6: Replacing content..." "STEP"

$modifiedFiles = 0
$allFiles = Get-ChildItem $OutputDir -Recurse -File -Exclude "generator.log" |
    Where-Object { $TextExtensions -contains $_.Extension.ToLower() }

foreach ($file in $allFiles) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $originalContent = $content

        $content = $content -replace [regex]::Escape($OldDomain), $Domain

        $sortedKeys = ($KeywordMap.Keys | Sort-Object { $_.Length } -Descending)
        foreach ($oldKey in $sortedKeys) {
            $newKey = $KeywordMap[$oldKey]
            $content = $content -replace [regex]::Escape($oldKey), $newKey
        }

        $content = $content -replace [regex]::Escape("$OldKeyword%20"), "$Keyword-"
        $content = $content -replace [regex]::Escape("%20$OldKeyword"), "-$Keyword"

        if ($content -ne $originalContent) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            $modifiedFiles++
        }
    }
    catch {
        Write-Log "  Skip binary: $($file.Name)" "WARN"
    }
}

Write-Log "  Modified $modifiedFiles files" "OK"

# Step 4: Fix internal links
Write-Log "Step 4/6: Fixing internal links..." "STEP"

$linkFixed = 0
$mdFiles = Get-ChildItem $OutputDir -Recurse -Filter "*.md" -File

foreach ($file in $mdFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content

    $linkPattern = '\[([^\]]+)\]\((/[^)]+)\)'
    $linkMatches = [regex]::Matches($content, $linkPattern)

    foreach ($match in $linkMatches) {
        $anchor = $match.Groups[1].Value
        $url = $match.Groups[2].Value

        if ($url -match '^https?://') { continue }

        $newUrl = $url
        $sortedKeys = ($KeywordMap.Keys | Sort-Object { $_.Length } -Descending)
        foreach ($oldKey in $sortedKeys) {
            $newKey = $KeywordMap[$oldKey]
            $newUrl = $newUrl -replace [regex]::Escape($oldKey), $newKey
        }

        if ($newUrl -ne $url) {
            $content = $content.Replace($match.Value, "[$anchor]($newUrl)")
        }
    }

    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $linkFixed++
    }
}

Write-Log "  Fixed $linkFixed files" "OK"

# Step 5: Generate config files
Write-Log "Step 5/6: Generating config files..." "STEP"

# analytics.config.json
$analyticsJson = "{`n  `"GA_ID`": `"$GA_ID`",`n  `"GTM_ID`": `"$GTM_ID`",`n  `"SEARCH_CONSOLE`": `"$SearchConsole`",`n  `"CLARITY_ID`": `"`"`n}"
Set-Content -Path (Join-Path $OutputDir "analytics.config.json") -Value $analyticsJson -Encoding UTF8

# tracking.json
$trackingJson = "{`n  `"google_ads`": `"`",`n  `"facebook`": `"`",`n  `"reddit`": `"`"`n}"
Set-Content -Path (Join-Path $OutputDir "tracking.json") -Value $trackingJson -Encoding UTF8

# deploy-config.json
$deployJson = "{`n  `"name`": `"$Brand Spreadsheet`",`n  `"domain`": `"$Domain`",`n  `"github`": `"$Repository`",`n  `"build`": `"npm run build`",`n  `"output`": `"dist`"`n}"
Set-Content -Path (Join-Path $OutputDir "deploy-config.json") -Value $deployJson -Encoding UTF8

# site.config.json
$genTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$siteJson = "{`n  `"brand`": `"$Brand`",`n  `"keyword`": `"$Keyword`",`n  `"domain`": `"$Domain`",`n  `"repository`": `"$Repository`",`n  `"ga_id`": `"$GA_ID`",`n  `"generated_at`": `"$genTime`"`n}"
Set-Content -Path (Join-Path $OutputDir "site.config.json") -Value $siteJson -Encoding UTF8

Write-Log "  Generated 4 config files" "OK"

# Step 6: Generate helper scripts
Write-Log "Step 6/6: Generating helper scripts..." "STEP"

# setup-github.ps1
$setupContent = @'
param([Parameter(Mandatory=$true)][string]$RepositoryUrl)
Write-Host ""
Write-Host "Initializing GitHub repo..." -ForegroundColor Cyan
if (-not (Test-Path ".git")) {
    git init
    git branch -M main
}
git remote remove origin 2>$null
git remote add origin $RepositoryUrl
git add .
git commit -m "Initial commit"
git push -u origin main
Write-Host "Done! Pushed to: $RepositoryUrl" -ForegroundColor Green
'@
Set-Content -Path (Join-Path $OutputDir "setup-github.ps1") -Value $setupContent -Encoding UTF8

# check-site.ps1
$checkContent = @'
param([string]$OldKeyword="fansbuy",[string]$OldBrand="FansBuy",[string]$OldDomain="bestfansbuy.com")
Write-Host ""
Write-Host "Checking site..." -ForegroundColor Cyan
$errors = @()
$warnings = @()

Write-Host "1. Checking old brand残留..." -ForegroundColor Yellow
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
'@
Set-Content -Path (Join-Path $OutputDir "check-site.ps1") -Value $checkContent -Encoding UTF8

# README.md
$readmeLines = @(
    "# $Brand",
    "",
    "> $Brand product guides and shopping resources",
    "",
    "## Site Info",
    "",
    "- **Domain**: $Domain",
    "- **Repository**: $Repository",
    "- **Generated**: $genTime",
    "",
    "## Quick Start",
    "",
    "    npm install",
    "    npm run dev",
    "",
    "## Build",
    "",
    "    npm run build",
    ""
)
$readmeContent = $readmeLines -join "`n"
Set-Content -Path (Join-Path $OutputDir "README.md") -Value $readmeContent -Encoding UTF8

Write-Log "  Generated setup-github.ps1, check-site.ps1, README.md" "OK"

# Done
$endTime = Get-Date
$duration = ($endTime - $startTime).TotalSeconds

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  DONE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Output: $OutputDir" -ForegroundColor White
Write-Host "Files copied: $copiedFiles" -ForegroundColor White
Write-Host "Files renamed: $renamedFiles" -ForegroundColor White
Write-Host "Files modified: $modifiedFiles" -ForegroundColor White
Write-Host "Links fixed: $linkFixed" -ForegroundColor White
Write-Host "Time: $([math]::Round($duration, 1))s" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd $OutputDir" -ForegroundColor Gray
Write-Host "  2. npm install" -ForegroundColor Gray
Write-Host "  3. .\check-site.ps1" -ForegroundColor Gray
Write-Host "  4. .\setup-github.ps1 -RepositoryUrl https://github.com/your-user/$Repository" -ForegroundColor Gray
Write-Host ""
