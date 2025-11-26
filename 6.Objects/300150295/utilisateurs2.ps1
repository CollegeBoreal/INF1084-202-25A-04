# utilisateurs2.ps1

# Script pour créer une GPO pour mapper le lecteur réseau Z: automatiquement

# ID Boreal : 300150295

# Importer le module GroupPolicy (si nécessaire)

Import-Module GroupPolicy

# Nom de la GPO

$GPOName = "MapSharedFolder"

# Créer la GPO si elle n'existe pas déjà

if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
New-GPO -Name $GPOName
}

# Lier la GPO à l'OU "Students"

$OU = "OU=Students,DC=DC300150295-00,DC=local"
New-GPLink -Name $GPOName -Target $OU -ErrorAction SilentlyContinue

# Créer un dossier pour le script logon

$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) {
New-Item -ItemType Directory -Path $ScriptFolder
}

# Créer le script logon pour mapper le lecteur Z:

$DriveLetter = "Z:"
$SharePath = "\DC300150295-00\SharedResources"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Lier le script logon à la GPO

Set-GPRegistryValue -Name $GPOName `    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System"`
-ValueName "LogonScript" `    -Type String`
-Value $ScriptPath

Write-Host "GPO $GPOName créée et script logon configuré avec succès !"
