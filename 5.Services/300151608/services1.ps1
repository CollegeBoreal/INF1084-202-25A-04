# TP 5.Services - Étudiant : 300151608
# Script 1 — Vérification des services Active Directory

Write-Host "==== Liste des services Active Directory ====" -ForegroundColor Cyan

# 1️⃣ Lister les services liés au rôle AD DS
Get-Service |
Where-Object {
    $_.DisplayName -like "*Directory*" -or
    $_.Name -match "NTDS|ADWS|DFSR|kdc|Netlogon|IsmServ"
} |
Sort-Object DisplayName |
Select-Object Status, Name, DisplayName

Write-Host "`n==== État des services critiques (NTDS / ADWS / DFSR) ====" -ForegroundColor Yellow

# 2️⃣ Vérifier les services essentiels
Get-Service -Name NTDS, ADWS, DFSR |
Select-Object Status, Name, DisplayName

