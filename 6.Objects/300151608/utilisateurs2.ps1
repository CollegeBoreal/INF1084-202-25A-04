# utilisateurs2.ps1
# TP 6.Objects - GPO pour mappage du lecteur Z:
# Étudiant : 30015160

Import-Module ActiveDirectory
Import-Module GroupPolicy

# 1. Nom de la GPO
$GPOName = "MapSharedFolder"

# 2. Créer la GPO si elle n'existe pas
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO $GPOName créée."
} else {
    Write-Host "GPO $GPOName existe déjà."
}

# 3. Lier la GPO à l'OU Students
# On suit le modèle du README : OU=Students,DC=$netbiosName,DC=local
$OU = "OU=Students,DC=$netbiosName,DC=local"

if (-not (Get-GPInheritance -Target $OU -ErrorAction SilentlyContinue)) {
    Write-Host "Attention : vérifie que l'OU Students existe bien à ce chemin : $OU"
}

New-GPLink -Name $GPOName -Target $OU -Enforced:$false
Write-Host "GPO $GPOName liée à l'OU $OU."

# 4. Créer un script de logon pour mapper le lecteur Z:
$DriveLetter = "Z:"
$SharePath   = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath   = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent -Encoding ASCII

Write-Host "Script de logon créé : $ScriptPath"

# 5. Associer le script à la GPO (clé de registre type exemple README)
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

Write-Host "Script de logon associé à la GPO $GPOName."
