# services1.ps1 - Ismail Trache 300150395
# Objectif : Lister tous les services liés à Active Directory et vérifier leur état.

Write-Host "=== Liste des services Active Directory ===" -ForegroundColor Cyan

# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName

Write-Host "`n=== État des services principaux ===" -ForegroundColor Cyan

# Vérifier l’état de certains services clés
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ | Format-Table Name, Status, DisplayName -AutoSize
