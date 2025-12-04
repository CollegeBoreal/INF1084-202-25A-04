# trust2.ps1 - Vérification du trust entre les deux forêts

Import-Module ActiveDirectory -ErrorAction Stop

$localDomain   = Get-ADDomain
$localDnsRoot  = $localDomain.DNSRoot
$remoteDnsRoot = "CDC300151233-00.local"

Write-Host "Vérification du trust depuis $localDnsRoot vers $remoteDnsRoot" -ForegroundColor Cyan

Write-Host "`n[1] Liste des trusts connus (Get-ADTrust)..." -ForegroundColor Yellow
Get-ADTrust -Filter * | Select-Object Name,Direction,ForestTransitive,TrustType

Write-Host "`n[2] Détails du trust vers la forêt distante (si présent)..." -ForegroundColor Yellow
try {
    Get-ADTrust -Identity $remoteDnsRoot | Format-List *
} catch {
    Write-Host "Aucun objet de trust trouvé pour $remoteDnsRoot via Get-ADTrust." -ForegroundColor Red
}

Write-Host "`n[3] Vérification via nltest /domain_trusts..." -ForegroundColor Yellow
nltest /domain_trusts

Write-Host "`n[4] Test de DC accessible dans la forêt distante..." -ForegroundColor Yellow
nltest /dsgetdc:$remoteDnsRoot

Write-Host "`nVérification du trust terminée." -ForegroundColor Green
