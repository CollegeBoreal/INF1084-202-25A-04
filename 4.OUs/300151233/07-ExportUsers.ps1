# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Export des utilisateurs en CSV ===" -ForegroundColor Cyan

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path ".\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé : TP_AD_Users.csv" -ForegroundColor Green
