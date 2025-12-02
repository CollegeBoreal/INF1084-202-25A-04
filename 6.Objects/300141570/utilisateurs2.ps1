# utilisateurs2.ps1
# TP 6.Objects - Partage, GPO et RDP
# Étudiant : 300141570

# Charger le bootstrap
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\bootstrap.ps1'
if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Impossible de trouver le fichier bootstrap.ps1 à l'emplacement : $bootstrapPath"
    exit 1
}
. $bootstrapPath

Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

$domain     = Get-ADDomain -Server $domainName
$domainDN   = $domain.DistinguishedName
$ouName     = "Students"
$ouDN       = "OU=$ouName,$domainDN"
$groupName  = "Students"

#Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
    Write-Host "Dossier créé : $SharedFolder" -ForegroundColor Green
} else {
    Write-Host "Dossier déjà existant : $SharedFolder" -ForegroundColor Yellow
}

#Créer le partage SMB
$shareName = "SharedResources"
if (-not (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name $shareName -Path $SharedFolder -FullAccess $groupName | Out-Null
    Write-Host "Partage SMB '$shareName' créé pour le groupe '$groupName'." -ForegroundColor Green
} else {
    Write-Host "Partage SMB '$shareName' existe déjà." -ForegroundColor Yellow
}

#Créer une GPO pour mapper le lecteur Z:
$GPOName = "MapSharedFolder"
$gpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $gpo) {
    $gpo = New-GPO -Name $GPOName
    Write-Host "GPO créée : $GPOName" -ForegroundColor Green
} else {
    Write-Host "GPO '$GPOName' existe déjà." -ForegroundColor Yellow
}

# Lier la GPO à l'OU Students
New-GPLink -Name $GPOName -Target $ouDN -Enforced:$false -ErrorAction SilentlyContinue | Out-Null
Write-Host "GPO '$GPOName' liée à $ouDN" -ForegroundColor Cyan

#Créer un script de logon pour mapper Z:
$DriveLetter = "Z:"
$SharePath   = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}

$ScriptPath = Join-Path $ScriptFolder "MapDrive-$($DriveLetter.TrimEnd(':')).bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent -Encoding ASCII

Write-Host "Script de logon créé : $ScriptPath" -ForegroundColor Green

# Associer le script de logon via GPO (User Configuration / Windows Settings / Scripts)
Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -ValueName "LogonScript" `
    -Type String `
    -Value $ScriptPath

Write-Host "Script de logon enregistré dans la GPO '$GPOName'." -ForegroundColor Cyan

#Activer RDP sur le serveur
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP activé et règle de firewall Remote Desktop activée." -ForegroundColor Green

Write-Host ""
Write-Host "⚠ Pour donner le droit 'SeRemoteInteractiveLogonRight' au groupe Students," -ForegroundColor Yellow
Write-Host "  tu peux utiliser secedit comme dans l'exemple du TP ou le faire via la stratégie locale." -ForegroundColor Yellow
