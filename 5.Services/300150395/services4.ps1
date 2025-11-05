# services4.ps1 - Ismail Trache 300150395
# Objectif : Arrêter et redémarrer le service DFSR (Distributed File System Replication)

Write-Host "=== Vérification de l'état initial du service DFSR ===" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Arrêt du service DFSR... ===" -ForegroundColor Yellow
Stop-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nÉtat après arrêt :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Redémarrage du service DFSR... ===" -ForegroundColor Yellow
Start-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nÉtat final :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`nService DFSR redémarré avec succès !" -ForegroundColor Green
