# trust1.ps1 - Création d'une relation de confiance entre les deux forêts

Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot
$localNetbios  = $localDomain.NetBIOSName

$remoteDnsRoot = "CDC300151233-00.local"
$remoteNetbios = "CDC300151233-00"

Write-Host "Forêt locale  : $localDnsRoot ($localNetbios)" -ForegroundColor Cyan
Write-Host "Forêt distante: $remoteDnsRoot ($remoteNetbios)" -ForegroundColor Cyan

$localAdminUPN  = "Administrator@$localDnsRoot"
$remoteAdminUPN = "Administrator@$remoteDnsRoot"

$pwdLocal  = Read-Host -AsSecureString "Mot de passe pour $localAdminUPN"
$pwdRemote = Read-Host -AsSecureString "Mot de passe pour $remoteAdminUPN"

$ptrLocal  = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwdLocal)
$ptrRemote = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwdRemote)

$plainLocal  = [Runtime.InteropServices.Marshal]::PtrToStringAuto($ptrLocal)
$plainRemote = [Runtime.InteropServices.Marshal]::PtrToStringAuto($ptrRemote)

[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptrLocal)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptrRemote)

$cmd = @"
netdom trust $localDnsRoot /domain:$remoteDnsRoot /userD:$remoteAdminUPN /passwordD:$plainRemote /userO:$localAdminUPN /passwordO:$plainLocal /add /twoway /forest /force
"@

Write-Host "`nCommande exécutée :" -ForegroundColor Yellow
Write-Host $cmd -ForegroundColor DarkGray

Invoke-Expression $cmd

$plainLocal  = $null
$plainRemote = $null

Write-Host "`nCréation du trust terminée (si aucune erreur rouge n'est apparue)." -ForegroundColor Green

