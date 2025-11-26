# services4.ps1
# Objectif : Arrêter, vérifier et redémarrer un service AD (exemple : DFSR)

Write-Host "=== Arrêt du service DFSR ===" -ForegroundColor Yellow
Stop-Service -Name DFSR -Force

Start-Sleep -Seconds 3
(Get-Service -Name DFSR).Status

Write-Host "=== Redémarrage du service DFSR ===" -ForegroundColor Cyan
Start-Service -Name DFSR

Start-Sleep -Seconds 3
Get-Service -Name DFSR | Format-Table Name, Status, StartType -AutoSize

Write-Host "✅ Service DFSR redémarré avec succès." -ForegroundColor Green
