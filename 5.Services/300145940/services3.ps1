# Auteur : 300145940

$serviceName = 'DFSR'

Write-Host '---------------------------'
Write-Host "Service cible : $serviceName"
Write-Host '---------------------------'
Write-Host ''

# État AVANT
Write-Host 'État avant :'
Get-Service -Name $serviceName | Select-Object Name, Status
Write-Host ''

# Arrêt du service
Write-Host 'Arrêt du service...'
Stop-Service -Name $serviceName -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Write-Host 'État après arrêt :'
Get-Service -Name $serviceName | Select-Object Name, Status
Write-Host ''

# Démarrage du service
Write-Host 'Démarrage du service...'
Start-Service -Name $serviceName -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Write-Host 'État final :'
Get-Service -Name $serviceName | Select-Object Name, Status
Write-Host ''
Write-Host '---------------------------'
Write-Host 'Script terminé.'
Write-Host '---------------------------'

