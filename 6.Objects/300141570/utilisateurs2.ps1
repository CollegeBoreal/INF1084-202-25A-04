# utilisateurs2.ps1
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\300141570\bootstrap.ps1'

if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Bootstrap introuvable à l'emplacement : $bootstrapPath"
    exit 1
}

. $bootstrapPath

Import-Module ActiveDirectory
Import-Module GroupPolicy

$SharedFolder = "C:\SharedResources"
$groupName = "Students"

if (-not (Test-Path $SharedFolder)) { New-Item -Path $SharedFolder -ItemType Directory | Out-Null }

if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $groupName
}

# Activer RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
