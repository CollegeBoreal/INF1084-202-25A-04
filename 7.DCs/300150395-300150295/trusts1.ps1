# =============================================
# Script : trust2.ps1 (Adapté pour Ismail)
# Objectif : Mettre en place un trust bidirectionnel entre deux domaines AD
# =============================================

# === 1. Récupération des informations d'accès au domaine distant ===
Write-Host "=== 1. Récupération des informations d'accès au domaine distant ===" -ForegroundColor Cyan

$PeerDomain = "DC300150295-00.local"
$LocalDomain = "DC300150395-00.local"
$PeerDC = "10.7.236.229"        
$LocalDC = "10.7.236.233"       

$credPeer = Get-Credential -Message "Identifiants administrateur du domaine $PeerDomain requis"

# === 2. Test de disponibilité du DC distant ===
Write-Host "=== 2. Test de disponibilité du contrôleur de domaine distant ===" -ForegroundColor Cyan
Test-Connection -ComputerName $PeerDC -Count 2

# === 3. Consultation du domaine distant ===
Write-Host "=== 3. Consultation du domaine distant ===" -ForegroundColor Cyan
Get-ADDomain -Server $PeerDC -Credential $credPeer
Get-ADUser -Filter * -Server $PeerDC -Credential $credPeer

# === 4. Montée d’un lecteur Active Directory virtuel ===
Write-Host "=== 4. Exploration de l'AD distant ===" -ForegroundColor Cyan
New-PSDrive -Name "AD2" -PSProvider ActiveDirectory -Root "DC=DC300150295-00,DC=local" -Server $PeerDC -Credential $credPeer | Out-Null
Set-Location "AD2:\DC=DC300150295-00,DC=local"
Get-ChildItem

# === 5. Mise en place du trust bidirectionnel ===
Write-Host "=== 5. Création du trust ===" -ForegroundColor Cyan

$PeerPassword = $credPeer.GetNetworkCredential().Password

netdom TRUST $PeerDomain `
    /Domain:$LocalDomain `
    /UserD:"Administrator" `
    /PasswordD:$PeerPassword `
    /UserO:"Administrator" `
    /PasswordO:$PeerPassword `
    /Add `
    /TwoWay

# === 6. Vérifications ===
Write-Host "=== 6. Vérifications du trust ===" -ForegroundColor Cyan

netdom trust $PeerDomain /Domain:$LocalDomain /Verify
Resolve-DnsName $PeerDomain
nltest /domain_trusts

Write-Host "=== Trust configuré avec succès ===" -ForegroundColor Green
