# Services1.ps1 - Lister les services Active Directory
# Auteur: 300151233

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  LISTE DES SERVICES ACTIVE DIRECTORY" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

Write-Host "=== Tous les services Active Directory ===" -ForegroundColor Yellow

Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName | 
Format-Table Name, DisplayName, Status, StartType -AutoSize

Write-Host "
=== Services AD critiques ===" -ForegroundColor Yellow

try {
    Get-Service -Name NTDS, ADWS, DFSR | 
    Select-Object Name, DisplayName, Status, StartType |
    Format-Table -AutoSize
} catch {
    Write-Host "Erreur: $_" -ForegroundColor Red
}

Write-Host "
=== Résumé ===" -ForegroundColor Green
$running = (Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Where-Object {$_.Status -eq "Running"}).Count

$total = (Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
}).Count

Write-Host "Services en cours: $running / $total" -ForegroundColor Green
