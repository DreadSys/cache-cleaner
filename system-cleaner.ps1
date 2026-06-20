[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Clear-Host
Write-Host "--- Cleaning Started ---" -ForegroundColor Cyan

$folders = @("C:\Windows\Temp", "$env:LOCALAPPDATA\Temp")

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        $items = Get-ChildItem -Path $folder -Recurse -ErrorAction SilentlyContinue
        $count = 0
        foreach ($item in $items) {
            try {
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
                $count++
            } catch { }
        }
        Write-Host "[OK] Cleaned $folder - $count items removed." -ForegroundColor Green
    }
}
Write-Host "--- Clean-Up Finished ---" -ForegroundColor Cyan
Read-Host "Press Enter to exit"