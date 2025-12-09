# services1.ps1 - Ismail Trache 300150395
# Objectif : Lister tous les services liés a Active Directory et verifier leur etat.

Write-Host "=== Liste des services Active Directory ===" -ForegroundColor Cyan

# Lister tous les services lies à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Write-Host "`n=== Etat des services principaux ===" -ForegroundColor Cyan

# Verifier l’etat de certains services cles
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ | Format-Table Name, Status, DisplayName -AutoSize
