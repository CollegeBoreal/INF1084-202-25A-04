# ===========================
# utilisateurs1.ps1
# Configuration & Listage
# ===========================

# Variables d'environnement
$studentNumber   = 300152410
$studentInstance = 0
$netbiosName     = "DC$studentNumber-$studentInstance"          # DC300152410-00
$domainFqdn      = "$netbiosName.local"                         # DC300152410-00.local
$domainDN        = "DC=$netbiosName,DC=local"                   # DC=DC300152410-00,DC=local

# 1) Module AD
Import-Module ActiveDirectory

# 2) Vérifications de base
Get-ADDomain -Server $domainFqdn
Get-ADDomainController -Filter * -Server $domainFqdn |

# 3) Liste des utilisateurs actifs (hors comptes intégrés)
Get-ADUser -Filter * -Server $domainFqdn -Properties Name,SamAccountName,Enabled |
  Where-Object { $_.Enabled -eq $true -and $_.SamAccountName -notin @('Administrator','Guest','krbtgt') } |
  Select-Object Name, SamAccountName, Enabled
