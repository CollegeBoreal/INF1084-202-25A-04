# utilisateurs2.ps1

$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\300141570\bootstrap.ps1'
if (-not (Test-Path $bootstrapPath)) {
    Write-Error "bootstrap.ps1 introuvable : $bootstrapPath"
    exit 1
}

. $bootstrapPath

Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

$domain   = Get-ADDomain -Server $domainName
$domainDN = $domain.DistinguishedName

$ouName    = "Students"
$ouDN      = "OU=$ouName,$domainDN"
$groupName = "Students"

$SharedFolder = "C:\SharedResources"
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
}

$shareName = "SharedResources"
if (-not (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name $shareName -Path $SharedFolder -FullAccess "$netbiosName\$groupName" | Out-Null
}

$GPOName = "MapSharedFolder"
$gpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $gpo) {
    $gpo = New-GPO -Name $GPOName
}

New-GPLink -Name $GPOName -Target $ouDN | Out-Null

$DriveLetter  = "Z:"
$SharePath    = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder -Force | Out-Null
}

$ScriptPath    = Join-Path $ScriptFolder "MapDriveZ.bat"
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent -Encoding ASCII

Set-GPRegistryValue -Name $GPOName `
    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" `
    -ValueName "MapDriveZ" `
    -Type String `
    -Value $ScriptPath

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "Partage, GPO (lecteur Z:) et RDP configurés." -ForegroundColor Green
