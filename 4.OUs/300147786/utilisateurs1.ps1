# ÉTAPE 1 : Vérification de l'environnement
Import-Module ActiveDirectory

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# ÉTAPE 2 : Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
