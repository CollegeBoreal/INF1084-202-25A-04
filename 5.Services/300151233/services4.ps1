# Services4.ps1 - Arrêt et redémarrage du service DFSR
# Auteur: 300151233

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  GESTION DU SERVICE DFSR" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

Write-Host "=== État initial ===" -ForegroundColor Yellow
(Get-Service -Name DFSR).Status

Write-Host "
=== Arrêt du service ===" -ForegroundColor Yellow
Stop-Service -Name DFSR
Start-Sleep -Seconds 2
(Get-Service -Name DFSR).Status

Write-Host "
=== Redémarrage ===" -ForegroundColor Yellow
Start-Service -Name DFSR
Start-Sleep -Seconds 2
(Get-Service -Name DFSR).Status

Write-Host "
Service redémarré avec succès" -ForegroundColor Green
