# ===============================
# CREATE TRUST BETWEEN TWO DOMAINS
# Local Domain: DC300147786-00.local
# Remote Domain: DC300147629-00.local
# ===============================

$LocalDomain = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"
$RemoteDC = "DC300147629-00.local"

Write-Host "=== Vérification DNS ===" -ForegroundColor Cyan
Resolve-DnsName $RemoteDC

Write-Host "=== Demande du mot de passe du trust ===" -ForegroundColor Cyan
$TrustPassword = Read-Host "Entrez un mot de passe sécurisé pour le Trust" -AsSecureString

Write-Host "=== Création du Trust sortant ===" -ForegroundColor Cyan
New-ADDomainTrust `
    -Name $RemoteDomain `
    -Source $LocalDomain `
    -Target $RemoteDomain `
    -TrustPassword $TrustPassword `
    -TrustDirection Bidirectional `
    -TrustType External `
    -Confirm:$false

Write-Host "=== Trust créé avec succès ===" -ForegroundColor Green

