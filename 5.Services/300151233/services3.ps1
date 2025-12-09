# Services3.ps1 - Exporter les logs AD en CSV
# Auteur: 300151233

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  EXPORT DES LOGS AD EN CSV" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

$logPath = "C:\Logs"
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory | Out-Null
    Write-Host "Dossier C:\Logs créé" -ForegroundColor Green
}

$csvFile = "$logPath\ADLogs.csv"

Write-Host "Export en cours..." -ForegroundColor Yellow

try {
    Get-WinEvent -LogName "Directory Service" -MaxEvents 50 | 
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Export-Csv -Path $csvFile -NoTypeInformation -Encoding UTF8
    
    Write-Host "Export réussi: $csvFile" -ForegroundColor Green
    
    $fileInfo = Get-Item $csvFile
    Write-Host "Taille: $([math]::Round($fileInfo.Length / 1KB, 2)) KB" -ForegroundColor White
    
} catch {
    Write-Host "Erreur: $_" -ForegroundColor Red
}
