Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot
$localNetbios  = $localDomain.NetBIOSName

$remoteDnsRoot = "CDC300151233-00.local"
$remoteNetbios = "CDC300151233-00"

Write-Host "Domaine local  : $localDnsRoot ($localNetbios)"
Write-Host "Domaine distant: $remoteDnsRoot ($remoteNetbios)"

$credAD2 = Get-Credential -Message "Entrez un compte administrateur de $remoteDnsRoot (ex: $remoteNetbios\Administrator)"

Write-Host "`n[1] Test de connectivité vers AD2 (ping)..."
Test-Connection -ComputerName $remoteDnsRoot -Count 2

Write-Host "`n[2] Informations du domaine AD2..."
Get-ADDomain -Server $remoteDnsRoot -Credential $credAD2 | Select-Object DNSRoot,NetBIOSName,Forest

Write-Host "`n[3] Quelques utilisateurs dans AD2..."
Get-ADUser -Filter * -Server $remoteDnsRoot -Credential $credAD2 -ResultSetSize 5 |
    Select-Object SamAccountName, Name

Write-Host "`n[4] PSDrive AD2: vers la forêt distante..."
if (-not (Get-PSDrive -Name AD2 -ErrorAction SilentlyContinue)) {
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $remoteDnsRoot -Credential $credAD2 | Out-Null
}

Set-Location AD2:\
Get-ChildItem
Set-Location $PSScriptRoot

Write-Host "`nPréparation AD2 terminée." -ForegroundColor Green
