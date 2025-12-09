O
# Importer le module Active Directory
Import-Module ActiveDirectory

# Définir le nom de domaine
. .\bootstrap.ps1

# Vérifier le domaine
Get-ADDomain -Server $domainName

# Lister les contrôleurs de domaine
Get-ADDomainController -Filter * -Server $domainName     

 # Lister les utilisateurs activés sauf comptes système
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
