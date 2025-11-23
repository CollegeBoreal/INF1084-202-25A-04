# Script utilisateurs2.ps1
# Création de la GPO pour mapper le lecteur Z:

Import-Module GroupPolicy

# Nom du serveur
$Server = $env:COMPUTERNAME

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# Lier la GPO à l’OU Students
$OU = "OU=Students,DC=$Server,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Lettre du lecteur réseau
$DriveLetter = "Z:"
$SharePath = "\\$Server\SharedResources"

# Dossier contenant les scripts
$ScriptFolder = "C:\Scripts"
$ScriptFile = "$ScriptFolder\MapDriveZ.bat"

if (-not (Test-Path $ScriptFolder)) { New-Item -Path $ScriptFolder -ItemType Directory }

# Création du script .bat
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptFile -Value $scriptContent

# Ajouter le script de logon à la GPO
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptFile
