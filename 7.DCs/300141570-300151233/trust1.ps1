Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot
$remoteDnsRoot = "DC300151233-00.local"

Write-Host "Création du trust bidirectionnel :" -ForegroundColor Yellow
Write-Host "  Local  : $localDnsRoot"
Write-Host "  Distant: $remoteDnsRoot"
Write-Host ""

$cmd = "netdom trust $localDnsRoot /domain:$remoteDnsRoot /add /twoway /userO:Administrator /passwordO:* /userD:Administrator /passwordD:* /force"

Write-Host "Commande exécutée :" -ForegroundColor Cyan
Write-Host $cmd -ForegroundColor DarkGray
Write-Host ""

Invoke-Expression $cmd


