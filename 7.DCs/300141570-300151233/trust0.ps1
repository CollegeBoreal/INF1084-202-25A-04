# ================================
# TRUST FINAL - TP INF1084
# Étudiants : Haroune & Partenaire
# ================================

$LocalDomain = "DC300141570.local"          # Haroune's DOMAINE
$RemoteDomain = "DC300151233-00.local"      # Syphax's DOMAINE 

Write-Host "Création du trust bidirectionnel..." -ForegroundColor Cyan
Write-Host "Local domain  : $LocalDomain"
Write-Host "Remote domain : $RemoteDomain`n"

# Commande NETDOM pour créer un trust bidirectionnel
netdom trust $LocalDomain /Domain:$RemoteDomain /UserD:administrator /PasswordD:* /Add /Realm /TwoWay

Write-Host "`nTrust terminé." -ForegroundColor Green
