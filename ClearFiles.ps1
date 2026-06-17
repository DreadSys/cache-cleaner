# Elite System Cleanup Utility
# Author: DevOps Learner
Write-Host "--- Initiating Elite System Cleanup ---" -ForegroundColor Cyan

$startSpace = [math]::round((Get-PSDrive C).Free / 1MB, 2)

# 1. Clean Temp folders
$paths = @(
    "$env:TEMP\*",
    "C:\Windows\Temp\*",
    "C:\Windows\Prefetch\*"
)

foreach ($path in $paths) {
    Write-Host "Processing: $path" -ForegroundColor Yellow
    Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Empty Recycle Bin
Write-Host "Purging Recycle Bin..." -ForegroundColor Yellow
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# 3. Network Cache Flush
Write-Host "Flushing DNS and Network Cache..." -ForegroundColor Yellow
Clear-DnsClientCache | Out-Null

# 4. Windows Update Cleanup
Write-Host "Cleaning Windows Update Cache..." -ForegroundColor Yellow
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv

# 5. Browser Cache Purge
$browserPaths = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*",
    "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache\*"
)

foreach ($path in $browserPaths) {
    if (Test-Path $path) {
        Write-Host "Purging Browser Cache: $path" -ForegroundColor Yellow
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

$endSpace = [math]::round((Get-PSDrive C).Free / 1MB, 2)
$freed = $endSpace - $startSpace

Write-Host "---------------------------------------" -ForegroundColor Green
Write-Host "Cleanup Complete!" -ForegroundColor Green
Write-Host "Total space recovered: $freed MB" -ForegroundColor Cyan
Write-Host "System is now optimized." -ForegroundColor Green
Pause