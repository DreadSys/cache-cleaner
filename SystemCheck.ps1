# Header
Write-Host "--- Detailed System Health Report ---" -ForegroundColor Cyan

# 1. Hardware Details
Write-Host "n[Hardware Components]" -ForegroundColor Yellow

$cpu = Get-CimInstance Win32_Processor
Write-Host "Processor    : $($cpu.Name)"

$gpu = Get-CimInstance Win32_VideoController
Write-Host "Video Card   : $($gpu.Name)"

$board = Get-CimInstance Win32_BaseBoard
Write-Host "Motherboard  : $($board.Manufacturer) $($board.Product)"

# 2. System Integrity Check
Write-Host "n[Integrity Check]" -ForegroundColor Yellow
Write-Host "Running system scan... please wait."

$sfcResult = sfc /scannow 2>&1

if ($sfcResult -match "did not find any integrity violations") {
    Write-Host "Status: All system files are perfect. Everything is OK!" -ForegroundColor Green
} else {
    Write-Host "Status: Issues found! Please review the scan output above." -ForegroundColor Red
}

Write-Host "`n--- Report Complete ---" -ForegroundColor Cyan