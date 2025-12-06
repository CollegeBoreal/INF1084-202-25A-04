# ==============================
# utilisateurs2.ps1
# GPO + Mapping Drive Z:
# ==============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== Création de la GPO ===`n"

$GPOName = "MapSharedFolder"
New-GPO -Name $GPOName

# Lier à l'OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"
New-GPLink -Name $GPOName -Target $OU

# ==============================
# Script Logon
# ==============================

Write-Host "`n=== Création du script logon ===`n"

$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Host "Script créé : $ScriptPath"

# Associer via GPO (clé registre utilisateur)
Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath

Write-Host "Script logon appliqué à la GPO."

