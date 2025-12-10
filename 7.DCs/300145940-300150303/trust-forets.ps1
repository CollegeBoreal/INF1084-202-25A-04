# ================================
# SCRIPT TRUST DE FORÊTS - TP INF1084
# Étudiants : Haroune & Partenaire
# ================================

$LocalDomain = "DC300145940-0.local"        # TON DOMAINE
$RemoteDomain = "DC300150303-00.local"      # DOMAINE PARTENAIRE

Write-Host "=== Étape 1 : Récapitulatif ===" -ForegroundColor Cyan
Write-Host "Domaine local   : $LocalDomain"
Write-Host "Domaine distant : $RemoteDomain"
Write-Host ""

# ================================
Write-Host "=== Étape 2 : Vérification de la connectivité ===" -ForegroundColor Cyan

Write-Host "`nTest vers le DC local ($LocalDomain)..."
Test-Connection -ComputerName $LocalDomain -Count 2

Write-Host "`nTest vers le DC distant ($RemoteDomain)..."
Test-Connection -ComputerName $RemoteDomain -Count 2

# ================================
Write-Host "`n=== Étape 3 : Informations de domaines ===" -ForegroundColor Cyan

Write-Host "`nForêt locale : $LocalDomain"
Get-ADDomain

Write-Host "`nForêt distante : $RemoteDomain"
Get-ADDomain -Server $RemoteDomain

# ================================
Write-Host "`n=== Étape 4 : Création du trust de forêt bidirectionnel ===" -ForegroundColor Cyan

netdom trust $LocalDomain /Domain:$RemoteDomain /UserD:administrator /PasswordD:* /Add /TwoWay /Realm

Write-Host "`nTrust forêts terminé." -ForegroundColor Green
