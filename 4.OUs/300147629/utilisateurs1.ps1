
# Importer le module Active Directory
Import-Module ActiveDirectory
#Permet l'ouverture
. .\bootstrap.ps1

. .\bootstrap.ps1
# Vérifier le domaine et les contrôleurs de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# Lister les utilisateurs existants
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName

