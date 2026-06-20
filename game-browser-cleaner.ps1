[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host
Write-Host "--- Starting Total System Cleanup ---" -ForegroundColor Cyan

# List of paths for cache cleanup
$targetFolders = @(
    "C:\Windows\Temp",
    "$env:LOCALAPPDATA\Temp",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache",
    "C:\Program Files (x86)\Steam\appcache",
    "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache"
)

# 1. Clean folders
foreach ($folder in $targetFolders) {
    if (Test-Path $folder) {
        Write-Host "Processing: $folder" -ForegroundColor Yellow
        $items = Get-ChildItem -Path $folder -Recurse -ErrorAction SilentlyContinue
        $count = 0
        
        foreach ($item in $items) {
            try {
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
                $count++
            } catch {
                # Silently skip locked files
            }
        }
        Write-Host "[OK] Cleaned $folder ($count items removed)." -ForegroundColor Green
    }
}

# 2. Automatically clear Recycle Bin without confirmation
try {
    Clear-RecycleBin -Force -ErrorAction Stop
    Write-Host "[OK] Recycle Bin cleared successfully." -ForegroundColor Green
} catch {
    Write-Host "[!] Could not clear Recycle Bin (or it is already empty)." -ForegroundColor Red
}

Write-Host "--- Total Cleanup Finished ---" -ForegroundColor Cyan
Read-Host "Press Enter to exit"