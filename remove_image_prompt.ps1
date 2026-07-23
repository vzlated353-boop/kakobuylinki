# PowerShell script to remove Image Prompt module from markdown files

$files = @(
    "fansbuy underwear.md",
    "fansbuy sunglasses.md",
    "fansbuy belt.md",
    "fansbuy gym clothes.md",
    "fansbuy sports clothes.md",
    "fansbuy sports gear.md",
    "fansbuy handbag.md",
    "fansbuy purse.md",
    "fansbuy bags guide.md",
    "fansbuy wallet.md",
    "fansbuy accessories guide.md",
    "fansbuy women shoes.md",
    "fansbuy jackets.md",
    "fansbuy heels.md",
    "fansbuy outdoor shoes.md",
    "fansbuy hiking shoes.md",
    "fansbuy shirts.md",
    "fansbuy shirt.md",
    "fansbuy headwear.md",
    "fansbuy winter clothes.md",
    "fansbuy summer clothes.md",
    "fansbuy caps.md",
    "fansbuy girls clothes.md",
    "fansbuy dress.md",
    "fansbuy hats guide.md",
    "fansbuy kids clothes.md",
    "fansbuy vest.md",
    "fansbuy hats.md",
    "fansbuy backpack.md",
    "fansbuy men clothes.md",
    "fansbuy hoodie.md",
    "fansbuy polo.md",
    "fansbuy t-shirt guide.md",
    "fansbuy t-shirt.md",
    "fansbuy hoodie guide.md",
    "fansbuy shorts.md",
    "fansbuy jacket.md",
    "fansbuy jorts.md",
    "fansbuy pants.md",
    "fansbuy purple jeans.md",
    "fansbuy sweatpants.md",
    "fansbuy polo shirt.md",
    "fansbuy jeans guide.md",
    "fansbuy tracksuit guide.md",
    "fansbuy tracksuit.md",
    "fansbuy xxl shoes.md",
    "fansbuy big size shoes.md",
    "fansbuy fashion clothes.md",
    "fansbuy streetwear.md",
    "fansbuy junior shoes.md",
    "fansbuy clothing guide.md",
    "fansbuy kids shoes.md",
    "fansbuy clothes 2026.md",
    "fansbuy clothes.md",
    "fansbuy men shoes.md",
    "fansbuy sneakers guide.md",
    "fansbuy footwear.md",
    "fansbuy shoes.md",
    "fansbuy shoes 2026.md",
    "fansbuy cleats.md",
    "fansbuy tennis shoes.md",
    "fansbuy running shoes.md",
    "fansbuy football boots.md",
    "fansbuy slides.md",
    "fansbuy football shoes.md",
    "fansbuy fashion sneakers.md",
    "fansbuy football t-shirt.md",
    "fansbuy sneakers 2026.md",
    "fansbuy soccer shoes.md",
    "fansbuy streetwear shoes.md",
    "fansbuy basketball shoes.md",
    "fansbuy daily wear shoes.md",
    "fansbuy football jersey.md",
    "fansbuy golf shoes.md",
    "fansbuy casual shoes.md",
    "fansbuy international shipping.md",
    "fansbuy tracking guide.md",
    "fansbuy ems shipping.md",
    "fansbuy economy shipping.md",
    "fansbuy express shipping.md",
    "fansbuy ultimate guide.md",
    "fansbuy essential guide.md",
    "fansbuy shopping tips.md",
    "fansbuy buyer tips.md",
    "fansbuy common mistakes.md",
    "fansbuy packaging guide.md",
    "fansbuy first purchase tips.md",
    "fansbuy unboxing.md",
    "fansbuy shipping costs.md",
    "fansbuy how to use 2026.md",
    "fansbuy walkthrough.md",
    "fansbuy tutorial.md",
    "fansbuy onboarding.md",
    "fansbuy shipping times.md",
    "fansbuy start here.md",
    "fansbuy everything you need to know.md",
    "fansbuy complete platform guide.md",
    "fansbuy beginner guide.md",
    "fansbuy complete guide.md",
    "fansbuy step by step.md"
)

$baseDir = "d:\fansbuy\finsbuy-main"

foreach ($file in $files) {
    $filePath = Join-Path $baseDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        
        # Read the file content
        $content = Get-Content -Path $filePath -Raw -Encoding UTF8
        
        # Find the Image Prompt module start
        # Looking for "## Image Prompt" or "**Image Prompt:**" or "**Aspect Ratio:**"
        $pattern = '(?s)^(.*?)(?:## Image Prompt for This Article|\*\*Image Prompt:\*\*|\*\*Aspect Ratio:\*\*).*'
        
        if ($content -match $pattern) {
            $newContent = $matches[1].TrimEnd()
            
            # Ensure file ends with proper newline
            if ($newContent -notmatch '\n$') {
                $newContent += "`n"
            }
            
            # Write back to file
            Set-Content -Path $filePath -Value $newContent -Encoding UTF8 -NoNewline
            
            Write-Host "  ✓ Removed Image Prompt module" -ForegroundColor Green
        } else {
            Write-Host "  - No Image Prompt module found" -ForegroundColor Yellow
        }
    } else {
        Write-Host "File not found: $file" -ForegroundColor Red
    }
}

Write-Host "`nCompleted processing all files." -ForegroundColor Cyan
