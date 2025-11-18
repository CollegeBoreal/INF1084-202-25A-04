# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Recherche des utilisateurs dont le prénom commence par 'A' ===" -ForegroundColor Cyan

Get-ADUser -Filter "GivenName -like 'A*'" -Server $domainName -Properties Name, SamAccountName |
Select-Object Name, SamAccountName |
Format-Table -AutoSize
