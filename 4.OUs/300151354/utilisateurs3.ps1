# ============================
# utilisateurs3.ps1
# Rechercher + exporter les utilisateurs
# ============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== 6) Recherche des utilisateurs (prénom commençant par S ou A) ===`n"

Get-ADUser -Filter "GivenName -like 'S*' -or GivenName -like 'A*'" -Properties Name, SamAccountName |
    Select-Object Name, SamAccountName

Write-Host "`n=== 7) Export des utilisateurs dans TP_AD_Users.csv ===`n"

$output = Join-Path $PSScriptRoot "TP_AD_Users.csv"

Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, EmailAddress, Enabled |
    Where-Object { $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
    Select-Object Name, SamAccountName, EmailAddress, Enabled |
    Export-Csv -Path $output -NoTypeInformation -Encoding UTF8

Write-Host "Export terminé : $output"

