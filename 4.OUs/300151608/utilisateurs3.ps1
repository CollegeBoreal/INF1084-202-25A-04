. "$(Join-Path $PSScriptRoot 'bootstrap.ps1')"
Import-Module ActiveDirectory

# Désactiver puis réactiver le compte de l'utilisateur Alice Dupont
Disable-ADAccount -Identity "alice.dupont" -Credential $cred
Enable-ADAccount  -Identity "alice.dupont" -Credential $cred

# Lister les utilisateurs (hors comptes système) et exporter vers un CSV
Get-ADUser -Filter * -Server $domainName -Properties Name,SamAccountName,EmailAddress,Enabled |
Where-Object { $_.SamAccountName -notin @('Administrator','Guest','krbtgt') } |
Select-Object Name,SamAccountName,EmailAddress,Enabled |
Export-Csv -Path "$PSScriptRoot\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
