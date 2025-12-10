# TP Active Directory - Partie 1
# Vérification du domaine et des utilisateurs

. .\bootstrap.ps1
Import-Module ActiveDirectory

# Vérifier le domaine et le contrôleur de domaine
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# Lister les utilisateurs actifs (hors comptes systèmes)
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName


