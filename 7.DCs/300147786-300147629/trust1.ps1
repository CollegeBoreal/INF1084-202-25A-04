$LocalDomain  = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"

Write-Host "=== Vérification DNS ===" -ForegroundColor Cyan
Resolve-DnsName $RemoteDomain

Write-Host "=== Trust password required ===" -ForegroundColor Cyan
$TrustPassword = Read-Host "Enter trust password (same for both domains)" 

Write-Host "=== Creating TWO-WAY trust (NETDOM) ===" -ForegroundColor Cyan
netdom trust $RemoteDomain /Domain:$LocalDomain /UserD:Administrator /PasswordD:$TrustPassword /UserO:Administrator /PasswordO:$TrustPassword /Add /TwoWay

Write-Host "=== Trust created successfully ===" -ForegroundColor Green

