# TP Services AD - Étape 4 : Arrêter et redémarrer un service
# Étudiant : 300150296

Write-Host "=== Gestion du service DFSR ===" -ForegroundColor Green

# Afficher l'état initial
Write-Host "`nÉtat initial du service DFSR :" -ForegroundColor Cyan
Get-Service -Name DFSR | Format-Table Name, DisplayName, Status -AutoSize

# Arrêter le service
Write-Host "`nArrêt du service DFSR..." -ForegroundColor Yellow
Stop-Service -Name DFSR -Force

# Vérifier l'état après arrêt
Write-Host "`nÉtat après arrêt :" -ForegroundColor Red
(Get-Service -Name DFSR).Status

# Attendre 2 secondes
Start-Sleep -Seconds 2

# Redémarrer le service
Write-Host "`nRedémarrage du service DFSR..." -ForegroundColor Yellow
Start-Service -Name DFSR

# Vérifier l'état final
Write-Host "`nÉtat final :" -ForegroundColor Green
Get-Service -Name DFSR | Format-Table Name, DisplayName, Status -AutoSize

Write-Host "`n✅ Opération terminée avec succès" -ForegroundColor Green