# ========================================
# TP Active Directory - Partie 1
# Configuration et Listage des utilisateurs
# ========================================

# ÉTAPE 1 : Vérification de l'environnement
Import-Module ActiveDirectory

$domainName = "DC300150395-00.local"

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# ÉTAPE 2 : Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
