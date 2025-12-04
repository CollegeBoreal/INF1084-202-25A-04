# ===============================
# CREATE TRUST BETWEEN TWO DOMAINS
# Local Domain: DC300147786-00.local
# Remote Domain: DC300147629-00.local
# ===============================

$LocalDomain  = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"
$RemoteDC     = "DC300147629-00.local"

Write-Host "=== Vérification DNS ===" -ForegroundColor Cyan
Resolve-DnsName $RemoteDC

Write-Host "=== Trust password required ===" -ForegroundColor Cyan
$TrustPassword = Read-Host "Enter trust password" -AsSecureString

Write-Host "=== Creating bidirectional trust ===" -ForegroundColor Cyan
New-ADTrust `
    -Name $RemoteDomain `
    -SourceName $LocalDomain `
    -TargetName $RemoteDomain `
    -TrustType External `
    -Direction Bidirectional `
    -TrustPassword $TrustPassword `
    -Confirm:$false

Write-Host "=== Trust successfully created ===" -ForegroundColor Green

