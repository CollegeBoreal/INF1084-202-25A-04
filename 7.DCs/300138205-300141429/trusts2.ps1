# trust2.ps1
# Script de validation du trust entre DC300141429.local et DC300138205.local

# 1. Charger les identifiants pour le domaine distant
$cred = Get-Credential

# 2. Vérifier la résolution DNS et la connectivité
Write-Host "=== Test de connectivité vers le domaine distant ==="
Test-Connection -ComputerName DC300138205.local -Count 2

# 3. Vérifier les informations du domaine local
Write-Host "=== Informations du domaine local ==="
Get-ADDomain

# 4. Vérifier les informations du domaine distant via le trust
Write-Host "=== Informations du domaine distant ==="
Get-ADDomain -Server DC300138205.local -Credential $cred

# 5. Lister les utilisateurs du domaine distant
Write-Host "=== Liste des utilisateurs du domaine distant ==="
Get-ADUser -Filter * -Server DC300138205.local -Credential $cred | Select-Object SamAccountName, DistinguishedName

# 6. Vérifier l’état du trust
Write-Host "=== Vérification du trust ==="
Get-ADTrust -Filter *

# 7. Test d’accès croisé (exemple : montage de partage)
Write-Host "=== Test d’accès à une ressource distante ==="
net use \\DC300138205\SharedResources /user:DC300138205.local\administrator *

