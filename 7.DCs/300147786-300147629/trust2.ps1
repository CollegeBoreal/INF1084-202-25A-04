# ===============================
# VERIFY TRUST BETWEEN TWO DOMAINS
# Local Domain: DC300147786-00.local
# Remote Domain: DC300147629-00.local
# ===============================

$LocalDomain = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"

Write-Host "=== Vérification de l'existence du Trust ===" -ForegroundColor Cyan
Get-ADDomainTrust -Identity $LocalDomain

Write-Host "=== Test de la relation ===" -ForegroundColor Cyan
Get-ADDomainTrust -Identity $LocalDomain | Test-ADDomainTrust

Write-Host "=== Test complet terminé ===" -ForegroundColor Green

