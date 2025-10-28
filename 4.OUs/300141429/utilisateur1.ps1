# ========================================
# TP Active Directory - Partie 1
# Configuration et Listage des utilisateurs
# ========================================

# ÉTAPE 0 : Configuration des variables
$studentNumber = 300141429
$studentInstance = "00"

$domainName = "DC300141429.local"
$netbiosName = "DC300141429"

# ÉTAPE 1 : Vérification de l'environnement
Import-Module ActiveDirectory

Get-ADDomain -Server $domainName
Get-ADDomainController -Filter * -Server $domainName

# ÉTAPE 2 : Liste des utilisateurs du domaine
Get-ADUser -Filter * -Server $domainName -Properties Name, SamAccountName, Enabled |
Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @("Administrator","Guest","krbtgt") } |
Select-Object Name, SamAccountName
