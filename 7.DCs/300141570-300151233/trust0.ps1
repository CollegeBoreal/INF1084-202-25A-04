# trust0.ps1 - Préparation et tests d'accès à la forêt AD2

Import-Module ActiveDirectory -ErrorAction Stop

$localDomain  = Get-ADDomain
$localDnsRoot = $localDomain.DNSRoot
$localNetbios = $localDomain.NetBIOSName

$remoteDnsRoot  = "CDC300151233-00.local"
$remoteNetbios  = "CDC300151233-00"

Write-Host "Domaine local  : $localDnsRoot ($localNetbios)" -ForegroundColor Cyan
Write-Host "Domaine distant: $remoteDnsRoot ($remoteNetbios)" -ForegroundColor Cyan

$credAD2 = Get-Credential -Message "Entrez le compte administrateur de $remoteDnsRoot (ex: Administrator)"

Write-Host "`n[1] Test de connectivité vers AD2 (ping DNSRoot)..." -ForegroundColor Yellow
Test-Connection -ComputerName $remoteDnsRoot -Count 2

Write-Host "`n[2] Informations du domaine AD2..." -ForegroundColor Yellow
Get-ADDomain -Server $remoteDnsRoot -Credential $credAD2 | Select-Object DNSRoot,NetBIOSName,Forest

Write-Host "`n[3] Exemple d'utilisateurs dans AD2..." -ForegroundColor Yellow
Get-ADUser -Filter * -Server $remoteDnsRoot -Credential $credAD2 -ResultSetSize 5 |
    Select-Object SamAccountName, Name

Write-Host "`n[4] Navigation PSDrive dans AD2..." -ForegroundColor Yellow
if (-not (Get-PSDrive -Name AD2 -ErrorAction SilentlyContinue)) {
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $remoteDnsRoot -Credential $credAD2 | Out-Null
}
Set-Location AD2:\
Get-ChildItem

Set-Location $PSScriptRoot

Write-Host "`nPréparation et tests AD2 terminés." -ForegroundColor Green
