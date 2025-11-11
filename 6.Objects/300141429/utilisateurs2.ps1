# ===================================================================
# Script : utilisateurs2.ps1
# Objectif : Creer une GPO pour mapper un lecteur reseau et activer RDP
# Auteur : Arona
# ===================================================================

# Importer les modules
Import-Module GroupPolicy -ErrorAction SilentlyContinue
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Variables
$GPOName = "MapSharedFolder"
$OU = "OU=Students,DC=collegeboreal,DC=local"   # Adapter selon ton domaine
$DriveLetter = "Z:"
$netbiosName = $env:COMPUTERNAME
$SharePath = "\\$netbiosName\SharedResources"
$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# 1. Creer la GPO
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    New-GPO -Name $GPOName | Out-Null
    Write-Host "GPO '$GPOName' creee."
} else {
    Write-Host "La GPO '$GPOName' existe deja."
}

# 2. Lier la GPO a l'OU Students
if ($OU) {
    New-GPLink -Name $GPOName -Target $OU -Enforced:$false
    Write-Host "GPO liee a l'OU $OU."
} else {
    Write-Host "Verifie le nom de ton OU et ton domaine avant d'executer le script."
}

# 3. Creer le script de mappage du lecteur reseau
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder | Out-Null
}
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent
Write-Host "Script logon cree : $ScriptPath"

# 4. Activer RDP sur la machine
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
                 -Name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "RDP active et pare-feu configure."

Write-Host "Etape 2 terminee : GPO et RDP configures avec succes."

