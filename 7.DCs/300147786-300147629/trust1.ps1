$LocalDomain  = "DC300147786-00.local"
$RemoteDomain = "DC300147629-00.local"

Write-Host "=== Vérification DNS ===" -ForegroundColor Cyan
Resolve-DnsName $RemoteDomain

Write-Host "=== Trust password required ===" -ForegroundColor Cyan
$TrustPassword = Read-Host "Enter trust password (same for both domains)" 

Write-Host "=== Creating TWO-WAY trust (NETDOM) ===" -ForegroundColor Cyan
netdom trust DC300147786-00.local /Domain:DC300147629-00.local /UserD:administrator /PasswordD:* /Add /Realm /TwoWay


Write-Host "=== Trust created successfully ===" -ForegroundColor Green

