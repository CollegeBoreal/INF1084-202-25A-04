# services1.ps1
# Objectif : Lister les services AD et vérifier leur état

Write-Host "=== Liste des services Active Directory ===" -ForegroundColor Cyan

# Lister tous les services liés à Active Directory
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName | Format-Table Name, DisplayName, Status -AutoSize

Write-Host "`n=== État des services AD principaux ===" -ForegroundColor Yellow

# Vérifier l’état de certains services critiques
Get-Service -Name NTDS, ADWS, DFSR, KDC, Netlogon, IsmServ | Format-Table Name, Status, StartType -AutoSize
