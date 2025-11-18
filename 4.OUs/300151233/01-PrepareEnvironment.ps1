# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

# Vérifier le domaine et les DC
Write-Host "=== Vérification du domaine ===" -ForegroundColor Cyan
Get-ADDomain -Server $domainName

Write-Host "`n=== Contrôleurs de domaine ===" -ForegroundColor Cyan
Get-ADDomainController -Filter * -Server $domainName