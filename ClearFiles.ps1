# Header
Write-Host "--- Advanced Cleanup Tool ---" -ForegroundColor Cyan

# 1. Cleaning Temp Folders
Write-Host "n[Cleaning Temporary Files]" -ForegroundColor Yellow
$tempPaths = @($env:TEMP, "C:\Windows\Temp", "C:\Windows\Prefetch")

foreach ($path in $tempPaths) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path" -ForegroundColor Gray
        Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# 2. Empting Recycle Bin (Universal Method)
Write-Host "n[Emptying Recycle Bin]" -ForegroundColor Yellow
$Shell = New-Object -ComObject Shell.Application
$Bin = $Shell.NameSpace(0xA)
$Bin.Items() | ForEach-Object { $_.InvokeVerb("delete") }
Write-Host "Recycle Bin processed." -ForegroundColor Green

Write-Host "`n--- Cleanup Complete ---" -ForegroundColor Cyan
Write-Host "Press any key to exit..." -ForegroundColor White
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")