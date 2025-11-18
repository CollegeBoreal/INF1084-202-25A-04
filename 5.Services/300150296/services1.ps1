# TP Services AD - Étape 1 : Lister les services Active Directory
# Étudiant : 300150296

Write-Host "=== Liste des services Active Directory ===" -ForegroundColor Green

# Lister tous les services liés à AD
Get-Service | Where-Object {
    $_.DisplayName -like "*Directory*" -or $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} | Sort-Object DisplayName | Format-Table Name, DisplayName, Status -AutoSize

Write-Host "`n=== Vérification des services spécifiques ===" -ForegroundColor Cyan

# Vérifier l'état des services principaux
Get-Service -Name NTDS, ADWS, DFSR | Format-Table Name, DisplayName, Status -AutoSize