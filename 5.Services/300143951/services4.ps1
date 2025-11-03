# Vérifier si exécuté en tant qu'administrateur
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ce script nécessite des droits administrateur !"
    exit
}

# Arrêter le service
Write-Host "Arrêt du service DFSR..." -ForegroundColor Yellow
Stop-Service -Name DFSR -Force -ErrorAction SilentlyContinue

# Attendre que le service s'arrête
Start-Sleep -Seconds 2

# Vérifier l'état
$status = (Get-Service -Name DFSR).Status
Write-Host "État du service: $status" -ForegroundColor Cyan

# Redémarrer le service
Write-Host "Démarrage du service DFSR..." -ForegroundColor Yellow
Start-Service -Name DFSR

# Vérifier le nouveau statut
$newStatus = (Get-Service -Name DFSR).Status
Write-Host "Nouveau statut: $newStatus" -ForegroundColor Green
