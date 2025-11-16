. $(Join-Path  'bootstrap.ps1')
Import-Module ActiveDirectory

# Désactiver puis réactiver
Disable-ADAccount -Identity "alice.dupont" -Credential 
Enable-ADAccount  -Identity "alice.dupont" -Credential 

# Lister utilisateurs (hors comptes système) + Export CSV
Get-ADUser -Filter * -Server  -Properties Name,SamAccountName,EmailAddress,Enabled |
Where-Object { .SamAccountName -notin @('Administrator','Guest','krbtgt') } |
Select-Object Name,SamAccountName,EmailAddress,Enabled |
Export-Csv -Path "\TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8
