Import-Module ActiveDirectory -ErrorAction Stop

# Domaine local (toi)
$localDomain  = Get-ADDomain
$localDnsRoot = $localDomain.DNSRoot
$localNetbios = $localDomain.NetBIOSName

# Domaine distant (ton partenaire)
$remoteDnsRoot = "DC300151233-00.local"
$remoteNetbios = "DC300151233-00"
$remoteDn      = "DC=DC300151233-00,DC=local"

Write-Host "Domaine local  : $localDnsRoot ($localNetbios)"
Write-Host "Domaine distant: $remoteDnsRoot ($remoteNetbios)"
Write-Host ""

# ️🔐 Identifiants du domaine distant
$credAD2 = Get-Credential -Message "Compte admin du domaine $remoteDnsRoot (ex: Administrator@DC300151233-00.local)"

Write-Host "[1] Test de ping vers le domaine distant..." -ForegroundColor Yellow
Test-Connection -ComputerName $remoteDnsRoot -Count 2 -ErrorAction SilentlyContinue |
    Select-Object Source, Destination, IPv4Address, Bytes, ResponseTime

Write-Host "`n[2] Informations du domaine distant..." -ForegroundColor Yellow
try {
    Get-ADDomain -Server $remoteDnsRoot -Credential $credAD2 |
        Select-Object DNSRoot, NetBIOSName, Forest
}
catch {
    Write-Warning "Impossible de contacter le domaine distant via ADWS : $($_.Exception.Message)"
}

Write-Host "`n[3] Quelques utilisateurs du domaine distant..." -ForegroundColor Yellow
try {
    Get-ADUser -Filter * -Server $remoteDnsRoot -Credential $credAD2 -ResultSetSize 5 |
        Select-Object SamAccountName, Name
}
catch {
    Write-Warning "Impossible de lister les utilisateurs du domaine distant : $($_.Exception.Message)"
}

Write-Host "`n[4] PSDrive AD2 vers le domaine distant..." -ForegroundColor Yellow
if (Get-PSDrive -Name AD2 -ErrorAction SilentlyContinue) {
    Remove-PSDrive AD2 -Force
}
try {
    New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Root $remoteDn -Server $remoteDnsRoot -Credential $credAD2 | Out-Null
    Set-Location AD2:\
    Get-ChildItem
}
catch {
    Write-Warning "Impossible de créer ou d'utiliser le lecteur AD2 : $($_.Exception.Message)"
}
finally {
    Set-Location $PSScriptRoot
}

Write-Host "`nPréparation AD2 terminée." -ForegroundColor Green
