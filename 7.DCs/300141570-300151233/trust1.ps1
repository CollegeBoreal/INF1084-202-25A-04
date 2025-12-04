Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot

$remoteDnsRoot = "CDC300151233-00.local"

Write-Host "Création du trust entre :"
Write-Host "  Local  : $localDnsRoot"
Write-Host "  Distant: $remoteDnsRoot"
Write-Host ""

$cmd = "netdom trust $localDnsRoot /domain:$remoteDnsRoot /add /twoway /userO:Administrator /passwordO:* /userD:Administrator /passwordD:* /force"

Write-Host "Commande exécutée :" -ForegroundColor Yellow
Write-Host $cmd -ForegroundColor DarkGray
Write-Host ""

Invoke-Expression $cmd

Write-Host "`nSi le message 'The command completed successfully.' est apparu, le trust est créé." -ForegroundColor Green





