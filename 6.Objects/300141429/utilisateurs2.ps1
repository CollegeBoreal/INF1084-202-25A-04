Import-Module GroupPolicy

# Variables
$GPOName = "MapSharedFolder"
$OU = "OU=Students,DC=DC300141429,DC=local"
$DriveLetter = "Z:"
$SharePath = "\\DC300141429\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# 1. Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) { New-GPO -Name $GPOName }

# 2. Lier la GPO à l’OU Students
New-GPLink -Name $GPOName -Target $OU -Enforced Yes

# 3. Créer un script logon pour mapper Z:
if (-not (Test-Path $ScriptFolder)) { New-Item -ItemType Directory -Path $ScriptFolder }
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Associer le script logon à la GPO (tout sur une seule ligne)
Set-GPRegistryValue -Name $GPOName -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName "LogonScript" -Type String -Value $ScriptPath

# 4. Activer RDP sur le serveur
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# 5. Donner le droit RDP au groupe Students
secedit /export /cfg C:\secpol.cfg
# 👉 Modifier manuellement le fichier pour ajouter "Students" à SeRemoteInteractiveLogonRight
secedit /import /cfg C:\secpol.cfg /db C:\secpol.sdb /overwrite

Write-Host "✅ GPO créée et RDP activé pour le groupe Students."
