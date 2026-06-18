# Advanced System Cleanup Utility
# Optimized for deep performance and storage recovery
Write-Host "--- Initiating Advanced System Cleanup ---" -ForegroundColor Cyan

$startSpace = [math]::round((Get-PSDrive C).Free / 1MB, 2)

# 1. Aggressive Temp Cleanup
$paths = @(
    "$env:TEMP\*",
    "C:\Windows\Temp\*",
    "C:\Windows\Prefetch\*",
    "C:\Windows\SoftwareDistribution\Download\*"
)

foreach ($path in $paths) {
    Write-Host "Purging: $path" -ForegroundColor Yellow
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Network and System Cache
Write-Host "Clearing DNS and Windows Update Cache..." -ForegroundColor Yellow
Clear-DnsClientCache | Out-Null
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv

# 3. Browser Cache Purge (Extended)
$browserPaths = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*.default-release\cache2\*"
)

foreach ($path in $browserPaths) {
    if (Test-Path $path) {
        Write-Host "Purging Browser Cache: $path" -ForegroundColor Yellow
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# 4. Recycle Bin
Write-Host "Emptying Recycle Bin..." -ForegroundColor Yellow
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

$endSpace = [math]::round((Get-PSDrive C).Free / 1MB, 2)
$freed = $endSpace - $startSpace

Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Deep Cleanup Complete!" -ForegroundColor Green
Write-Host "Total space recovered: $freed MB" -ForegroundColor Cyan
Write-Host "System is now fully optimized." -ForegroundColor Green
Pause