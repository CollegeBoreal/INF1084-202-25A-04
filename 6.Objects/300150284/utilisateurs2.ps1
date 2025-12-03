
############################################################
# Script : utilisateurs2.ps1
# Objectif : Créer la GPO MapSharedFolder + script logon + map Z:
############################################################

Import-Module GroupPolicy

# 1️⃣ Variables
$GPOName = "MapSharedFolder"
$netbiosName = "DC300141429"   # <<< ADAPTE ICI
$OU = "OU=Students,DC=300141429,DC=local"

# 2️⃣ Créer la GPO
New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# 3️⃣ Lier la GPO à l’OU Students
New-GPLink -Name $GPOName -Target $OU

# 4️⃣ Créer un script de logon pour mapper le lecteur Z:
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# 5️⃣ Associer le script logon à la GPO
Set-GPRegistryValue -Name $GPOName `
  -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -ValueName "LogonScript" `
  -Type String `
  -Value $ScriptPath

Write-Host "📜 GPO + mapping du lecteur réseau configurés."

############################################################
# BONUS : Activer RDP pour les membres du groupe Students
############################################################

# Autoriser RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

# Activer firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "🖥️ RDP activé avec succès."
