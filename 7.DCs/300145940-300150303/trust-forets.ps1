# trust-forets.ps1
# Groupe : 300145940 - 300150303
# Projet : Relation de confiance entre deux forêts AD

Import-Module ActiveDirectory

# === Forêts et contrôleurs de domaine ===
$ForestLocal   = "DC300145940-0.local"      # ta forêt
$ForestRemote  = "DC300150303-00.local"     # forêt du partenaire
$LocalDC       = "DC300145940-0"            # nom de ton DC
$RemoteDC      = "DC300150303-00"           # nom du DC du partenaire

Write-Host "=== Étape 1 : Crédentiels pour la forêt distante ==="
$credRemote = Get-Credential -Message "Entrez un compte administrateur de la forêt $ForestRemote"

Write-Host "=== Étape 2 : Vérification de la connectivité ==="
Write-Host "Test vers ton DC ($LocalDC) ..."
Test-Connection -ComputerName $LocalDC -Count 2

Write-Host "Test vers le DC distant ($RemoteDC) ..."
Test-Connection -ComputerName $RemoteDC -Count 2

Write-Host "=== Étape 3 : Informations de domaines ==="
Write-Host "`nForêt locale : $ForestLocal"
Get-ADDomain -Server $LocalDC

Write-Host "`nForêt distante : $ForestRemote"
Get-ADDomain -Server $RemoteDC -Credential $credRemote

Write-Host "`n=== Étape 4 : (Exemple) Création du trust (à valider dans le lab) ==="
Write-Host "Utiliser New-ADTrust ici si autorisé par le professeur."
# Exemple INDICATIF (ne pas lancer sans valider) :
# New-ADTrust -Name $ForestRemote `
#             -SourceForest $ForestLocal `
#             -TargetForest $ForestRemote `
#             -Direction Bidirectional `
#             -Forest `
#             -Confirm:$false

Write-Host "`n=== Étape 5 : Vérification des trusts existants ==="
Get-ADTrust -Filter * | Format-Table Name, Direction, TrustType -AutoSize

Write-Host "`n=== Étape 6 : Navigation dans la forêt distante via PSDrive ==="
# Racine AD de la forêt distante : DC=DC300150303-00,DC=local
New-PSDrive -Name ADPARTNER `
            -PSProvider ActiveDirectory `
            -Root "DC=DC300150303-00,DC=local" `
            -Server $RemoteDC `
            -Credential $credRemote `
            -ErrorAction SilentlyContinue | Out-Null

Set-Location ADPARTNER:\DC=DC300150303-00,DC=local

Write-Host "`nUnités organisationnelles de la forêt distante :"
Get-ChildItem

Write-Host "`n=== Étape 7 : Liste d'utilisateurs de la forêt distante ==="
Get-ADUser -Filter * -Server $RemoteDC -Credential $credRemote -ResultSetSize 10 |
    Select-Object Name, SamAccountName

Write-Host "`nScript de vérification du trust terminé."

