# Script : trusts1.ps1
# Création du trust forestier bidirectionnel entre :
# 1) DC300151292-00.local
# 2) DC300150268-40.local

# === Variables ===
$Forest1 = "DC300151292-00.local"
$Forest2 = "DC300150268-40.local"

$DC1 = "DC300151292.DC300151292-00.local"
$DC2 = "VM01.DC300150268-40.local"

$Admin1 = "administrator"
$Admin2 = "administrator"

Import-Module ActiveDirectory

# === Authentification ===
Write-Host "Identifiants AD1 (Amine)" -ForegroundColor Yellow
$credAD1 = Get-Credential -Message "administrator pour DC300151292-00.local"

Write-Host "Identifiants AD2 (Kemiche)" -ForegroundColor Yellow
$credAD2 = Get-Credential -Message "administrator pour DC300150268-40.local"

# === Test réseau et DNS ===
Write-Host "`n--- Test vers AD2 ---" -ForegroundColor Cyan
Test-Connection -ComputerName $DC2 -Count 2
Resolve-DnsName $DC2

# === Lecture du domaine AD2 ===
Write-Host "`n--- Informations du domaine de Kemiche ---" -ForegroundColor Cyan
Get-ADDomain -Server $DC2 -Credential $credAD2

Write-Host "`n--- Liste d'utilisateurs AD2 ---" -ForegroundColor Cyan
Get-ADUser -Filter * -Server $DC2 -Credential $credAD2 | Select -First 10 Name

# === PSDrive AD2 ===
Write-Host "`n--- Création PSDrive AD2: ---" -ForegroundColor Cyan
New-PSDrive -Name AD2 -PSProvider ActiveDirectory -Server $DC2 -Root "" -Credential $credAD2
Set-Location AD2:\
Get-ChildItem

# === Création du Trust ===
Write-Host "`n--- Création du trust bidirectionnel ---" -ForegroundColor Green
$CreateTrust = @"
netdom trust $Forest1 /domain:$Forest2 /UserD:$Admin1 /PasswordD:* /UserO:$Admin2 /PasswordO:* /Add /Twoway /ForestTransitive
"@
cmd.exe /c $CreateTrust

Write-Host "`nFIN DU SCRIPT trusts1.ps1" -ForegroundColor Green
