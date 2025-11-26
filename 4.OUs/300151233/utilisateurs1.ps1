# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Liste de tous les utilisateurs du domaine ===" -ForegroundColor Cyan

# Lister tous les utilisateurs actifs (sauf comptes système)
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled, DistinguishedName |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, Enabled, DistinguishedName |
Format-Table -AutoSize

Write-Host "`nNombre total d'utilisateurs:" -ForegroundColor Yellow
(Get-ADUser -Filter * -Server $domainName | Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") }).Count