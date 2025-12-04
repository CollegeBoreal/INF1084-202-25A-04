Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot          # DC300141570.local
$remoteDnsRoot = "DC300151233-00.local"        # domaine de ton partenaire

Write-Host "Création du trust bidirectionnel :" -ForegroundColor Yellow
Write-Host "  Local  : $localDnsRoot"
Write-Host "  Distant: $remoteDnsRoot"
Write-Host ""

# ✅ VERSION CORRIGÉE AVEC /d: AU LIEU DE /domain:
$cmd = "netdom trust $localDnsRoot /d:$remoteDnsRoot /add /twoway /userO:Administrator /passwordO:* /userD:Administrator /passwordD:* /force"

Write-Host "Commande exécutée :" -ForegroundColor Cyan
Write-Host $cmd -ForegroundColor DarkGray
Write-Host ""

Invoke-Expression $cmd
