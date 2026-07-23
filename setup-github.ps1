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
