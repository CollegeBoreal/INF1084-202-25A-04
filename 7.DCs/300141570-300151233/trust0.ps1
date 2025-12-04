Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot
$localNetbios  = $localDomain.NetBIOSName

$remoteDnsRoot = "DC300151233-00.local"
$remoteNetbios = "DC300151233-00"

Write-Host "Domaine local  : $localDnsRoot ($localNetbios)"
Write-Host "Domaine distant: $remoteDnsRoot ($remoteNetbios)"
Write-Host ""

$credAD2 = Get-Credential -Message "Entrez un compte administrateur de $remoteDnsRoot"

Write-Host "[1] Test de ping vers le domaine distant..."
Test-Connection -ComputerName $remoteDnsRoot -Count 2

Write-Host "`n[2] Informations du domaine distant..."
Get-ADDomain -Server $remoteDnsRoot -Credential $credAD2 |
    Select-Object DNSRoot, NetBIOSName, Forest

Write-Host "`n[3] Quelques utilisateurs du domaine distant..."
Get-ADUser -Filter * -Server $remoteDnsRoot -Credential $credAD2 -ResultSetSize 5 |
    Select-Object SamAccountName, Name

Write-Host "`n[4] PSDrive AD2 vers le domaine distant..."
if (-not (Get-PSDrive -Name AD2 -ErrorAction SilentlyContinue)) {
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $remoteDnsRoot -Credential $credAD2 | Out-Null
}

try {
    Set-Location AD2:\
    Get-ChildItem
} catch {
    Write-Host "Impossible d'accéder à AD2:`n$_" -ForegroundColor Red
} finally {
    Set-Location $PSScriptRoot
}

Write-Host "`nPréparation AD2 terminée." -ForegroundColor Green
