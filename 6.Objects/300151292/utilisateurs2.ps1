# utilisateurs2.ps1
# TP : GPO pour map le lecteur réseau

Import-Module GroupPolicy
Import-Module ActiveDirectory

$netbiosName = $env:COMPUTERNAME

# Nom de la GPO
$GPOName = "MapSharedFolder"

# Créer la GPO
New-GPO -Name $GPOName -ErrorAction SilentlyContinue

# OU cible
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# Paramètres du lecteur
$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

# Script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\Map-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

# Ajouter script dans la GPO
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath
