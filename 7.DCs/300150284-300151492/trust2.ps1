# ================================================================
# Script de validation du Trust entre :
#   Domaine local   : DC300150284-00.local  (Mohamed)
#   Domaine distant : DC300151492-00.local  (Hacen)
#
# Étudiants :
#   - Hacen (300151492)
#   - Mohamed (300150284)
#
# Date : 9 décembre 2024
# ================================================================

# 1. Charger les identifiants pour le domaine distant
Write-Host "=== Chargement des identifiants du domaine distant (Hacen) ==="
$cred = Get-Credential# Mise à jour Aroua - 10/12/2025



# Définition des domaines
$LocalDomain   = "DC300150284-00.local"       # Mohamed
$RemoteDomain  = "DC300151492-00.local"       # Hacen

# Définition des DC
$LocalDC   = "DC9999999990.DC300150284-00.local"  # Mohamed (machine locale)
$RemoteDC  = "DC300151492.DC300151492-00.local"   # Hacen (machine distante)

# 2. Vérification DNS et connectivité réseau
Write-Host "`n=== Test de connectivité vers le domaine distant ($RemoteDomain) ==="
Test-Connection -ComputerName $RemoteDC -Count 2

# 3. Informations du domaine local (Mohamed)
Write-Host "`n=== Informations du domaine local ($LocalDomain) ==="
Get-ADDomain

# 4. Informations du domaine distant (Hacen)
Write-Host "`n=== Informations du domaine distant ($RemoteDomain) ==="
Get-ADDomain -Server $RemoteDC -Credential $cred

# 5. Lister les utilisateurs du domaine distant
Write-Host "`n=== Liste des utilisateurs du domaine distant ($RemoteDomain) ==="
Get-ADUser -Filter * -Server $RemoteDC -Credential $cred `
    | Select-Object SamAccountName, DistinguishedName

# 6. Vérifier l’état du Trust
Write-Host "`n=== Vérification du Trust configuré ==="
Get-ADTrust -Filter *

# 7. Test d'accès SMB vers une ressource distante
Write-Host "`n=== Test d'accès SMB vers le domaine distant ==="
net use \\$RemoteDC\SharedResources /user:"$RemoteDomain\administrator" *

Write-Host "`n=== Fin du script ==="
