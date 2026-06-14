$items = @("$env:TEMP\*", "C:\Windows\Temp\*")

Write-Host "--- SYSTEM CLEANUP STARTED ---" -ForegroundColor Yellow
Start-Sleep -Seconds 1

foreach ($path in $items) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path" -ForegroundColor Cyan
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Done!" -ForegroundColor Green
    }
}

Write-Host "`n--- CLEANUP COMPLETE ---" -ForegroundColor Yellow
Write-Host "System is optimized." -ForegroundColor White
Read-Host "Press Enter to exit"