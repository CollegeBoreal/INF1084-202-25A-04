# utilisateurs2.ps1
# TP 6.Objects - Création d'une GPO pour mapper le lecteur réseau

# Charger les modules nécessaires
Import-Module ActiveDirectory
Import-Module GroupPolicy

# Nom du contrôleur de domaine
$netbiosName = $env:COMPUTERNAME

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# Lier la GPO à l’OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Drive à mapper
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

# Dossier contenant le script de logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# Créer le dossier Scripts si n’existe pas
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Créer le script Logon
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Ajouter le script au Logon Script de la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
