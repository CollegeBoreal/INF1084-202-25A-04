# services4.ps1 - Ismail Trache 300150395
# Objectif : Arreter et redemarrer le service DFSR (Distributed File System Replication)

Write-Host "=== Verification de l'etat initial du service DFSR ===" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Arret du service DFSR... ===" -ForegroundColor Yellow
Stop-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nEtat apres arret :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`n=== Redemarrage du service DFSR... ===" -ForegroundColor Yellow
Start-Service -Name DFSR
Start-Sleep -Seconds 3

Write-Host "`nEtat final :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, Status -AutoSize

Write-Host "`nService DFSR redemarre avec succes !" -ForegroundColor Green
