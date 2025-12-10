# ===================================================================
# Script : utilisateurs2.ps1
# Auteur : Ismail TRACHE (300150395)
# Objectif : Creer une GPO pour mapper un lecteur reseau et activer RDP
# Domaine : DC300150395-00.local
# ===================================================================

Import-Module GroupPolicy -ErrorAction SilentlyContinue
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# === Variables ===
$GPOName = "MapSharedFolder-300150395"
$OU = "OU=Students,OU=300150395,DC=DC300150395-00,DC=local"
$DriveLetter = "Z:"
$ComputerName = $env:COMPUTERNAME
$SharePath = "\\$ComputerName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$GroupName = "Students"

Write-Host "=== Demarrage du script utilisateurs2.ps1 ==="

# === 1. Creation de la GPO ===
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO '$GPOName' cree."
} else {
    Write-Host "La GPO '$GPOName' existe deja."
}

# === 2. Lien de la GPO a l'OU Students (version SANS ERREURS) ===
$ExistingLinks = (Get-GPInheritance -Target $OU).GpoLinks.DisplayName

if ($ExistingLinks -contains $GPOName) {
    Write-Host "La GPO '$GPOName' est deja liee a l'OU Students."
} else {
    New-GPLink -Name $GPOName -Target $OU | Out-Null
    Write-Host "GPO liee avec succes a l'OU Students."
}

# === 3. Script de mappage du lecteur reseau ===
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script de connexion cree : $ScriptPath"

# === 4. Activation du RDP ===
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP active et pare-feu configure."

# === 5. Donner le droit RDP au groupe Students ===
Write-Host "Configuration du droit RDP pour le groupe Students..."

# 5.1 Recuperer le SID du groupe Students
$GroupSID = (Get-ADGroup $GroupName).SID.Value

# 5.2 Exporter la politique locale
secedit /export /cfg C:\secpol.cfg > $null

# 5.3 Modifier la ligne USER_RIGHTS
(Get-Content C:\secpol.cfg) `
    -replace 'SeRemoteInteractiveLogonRight =.*', "SeRemoteInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-555,$GroupSID" |
    Set-Content C:\secpol.cfg

# 5.4 Appliquer la nouvelle config
secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas USER_RIGHTS /quiet

Write-Host "Le groupe '$GroupName' possede maintenant le droit RDP."

Write-Host "=== Etape 2 terminee : GPO, mapping et RDP configures avec succes. ==="
