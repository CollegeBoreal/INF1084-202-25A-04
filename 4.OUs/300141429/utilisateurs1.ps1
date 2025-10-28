# script1_ListUsers.ps1

# Variables étudiant
$studentNumber = 300141429
$studentInstance = 00

$domainName = "DC300141429.local"

# Importer le module Active Directory
Import-Module ActiveDirectory

# Lister les utilisateurs activés sauf comptes système
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

