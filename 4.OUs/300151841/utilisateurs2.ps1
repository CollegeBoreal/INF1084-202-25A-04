# utilisateurs2.ps1
# Modification d'Alice et affichage des utilisateurs

. "$PSScriptRoot\bootstrap.ps1"

# Modifier Alice
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie"

# Lister les utilisateurs actifs (hors comptes système)
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName, Enabled

