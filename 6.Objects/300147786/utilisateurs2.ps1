. .bootstrap.ps1
Write-Output "Bootstrap importé. NetBIOS = $netbiosName"

$GPOName = "MapSharedFolder"

Write-Output "Création de la GPO : $GPOName"
New-GPO -Name $GPOName

# OU Students
$OU = "OU=Students,DC=$netbiosName,DC=local"

Write-Output "Lien de la GPO sur : $OU"
New-GPLink -Name $GPOName -Target $OU

# Mappage lecteur - Utiliser l'IP pour éviter les problèmes DNS
$DriveLetter = "Z:"
# Note: Utiliser l'adresse IP du serveur pour plus de fiabilité
$ServerIP = "10.7.236.225"
$SharePath = "\\$ServerIP\SharedResources"

# Script logon
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive.bat"

if (-not (Test-Path $ScriptFolder)) {
    Write-Output "Création du dossier scripts : $ScriptFolder"
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

Write-Output "Création du script logon pour le mappage lecteur Z"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Output "Lien du script logon à la GPO"
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

Write-Output "Script utilisateurs2.ps1 terminé."
