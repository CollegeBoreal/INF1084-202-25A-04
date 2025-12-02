# utilisateurs0.ps1
# TP 6.Objects - Préparation du domaine
# Étudiant : 300141570

# Charger le bootstrap du dossier 4.OUs
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\bootstrap.ps1'
if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Impossible de trouver le fichier bootstrap.ps1 à l'emplacement : $bootstrapPath"
    exit 1
}

. $bootstrapPath   # dot-sourcing

# Charger les modules nécessaires
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

Write-Host "=============================" -ForegroundColor Cyan
Write-Host " TP 6.Objects - Préparation " -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

Write-Host "Domaine FQDN : $domainName"
Write-Host "NetBIOS      : $netbiosName"

# Afficher quelques infos de domaine
Get-ADDomain -Server $domainName | Format-List Name, DNSRoot, NetBIOSName
