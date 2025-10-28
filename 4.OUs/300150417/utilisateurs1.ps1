# Étape 0 : Configuration du domaine
$studentNumber = 300150417
$studentInstance = "00"

$domainName = "DC$studentNumber-$studentInstance.local"
$netbiosName = "DC$studentNumber-$studentInstance"

# Étape 1 : Vérification de l'environnement
Import-Module ActiveDirectory
Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# Étape 2 : Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
