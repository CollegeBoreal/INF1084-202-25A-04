# ===================================================================
# Script : utilisateurs2.ps1
# Auteur : Chakib Rahmani (300150399)
# Objectif : Creer une GPO pour mapper un lecteur reseau et activer RDP
# Domaine : DC300150399-00.local
# ===================================================================

Import-Module GroupPolicy -ErrorAction SilentlyContinue
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# === Variables ===
$GPOName = "MapSharedFolder-300150399"
$OU = "OU=Students,DC=DC300150399-00,DC=local"
$DriveLetter = "Z:"
$netbiosName = $env:COMPUTERNAME
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

Write-Host "=== Demarrage du script utilisateurs2.ps1 ==="

# === 1. Creation de la GPO ===
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO '$GPOName' creee."
} else {
    Write-Host "La GPO '$GPOName' existe deja."
}

# === 2. Lien de la GPO a l'OU Students ===
try {
    New-GPLink -Name $GPOName -Target $OU -Enforced:$false | Out-Null
    Write-Host "GPO liee a l'OU : $OU"
} catch {
    Write-Host "Attention : verifier que l'OU Students existe dans le domaine."
}

# === 3. Script de mappage du lecteur reseau ===
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script de connexion cree : $ScriptPath"

# === 4. Activation du RDP sur le serveur ===
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "RDP active et pare-feu configure pour les connexions a distance."

Write-Host "=== Etape 2 terminee : GPO et RDP configures avec succes. ==="