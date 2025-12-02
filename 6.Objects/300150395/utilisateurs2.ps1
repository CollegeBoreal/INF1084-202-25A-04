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
$OU = "OU=Students,DC=DC300150395-00,DC=local"
$DriveLetter = "Z:"
$netbiosName = $env:COMPUTERNAME
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$GroupName = "Students"

Write-Host "=== Demarrage du script utilisateurs2.ps1 ==="

# === 1. Création de la GPO ===
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO '$GPOName' creee."
} else {
    Write-Host "La GPO '$GPOName' existe deja."
}

# === 2. Lien de la GPO à l'OU Students ===
try {
    New-GPLink -Name $GPOName -Target $OU -Enforced:$false | Out-Null
    Write-Host "GPO liee à l'OU : $OU"
} catch {
    Write-Host "Attention : vérifier que l'OU Students existe dans le domaine."
}

# === 3. Script de mappage du lecteur reseau ===
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script de connexion créé : $ScriptPath"

# === 4. Activation du RDP ===
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP activé et pare-feu configuré."

# === 5. Donner le droit RDP au groupe 'Students' ===
Write-Host "Configuration du droit RDP pour le groupe Students..."

# Exporter la politique locale
secedit /export /cfg C:\secpol.cfg > $null

# Modifier la ligne SeRemoteInteractiveLogonRight
(Get-Content C:\secpol.cfg) `
    -replace 'SeRemoteInteractiveLogonRight =.*', "SeRemoteInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-555,$GroupName" |
    Set-Content C:\secpol.cfg

# Importer la modification
secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas USER_RIGHTS /quiet

Write-Host "Le groupe '$GroupName' est maintenant autorisé à utiliser RDP."

Write-Host "=== Étape 2 terminée : GPO, mappage et RDP configurés avec succès. ==="
