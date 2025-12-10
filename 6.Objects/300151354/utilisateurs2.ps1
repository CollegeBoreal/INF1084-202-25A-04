# ==============================
# utilisateurs2.ps1
# GPO + mapping lecteur Z + script logon
# ==============================

. "$PSScriptRoot\bootstrap.ps1"

Write-Host "`n=== Verification ou creation de la GPO MapSharedFolder ===`n"

$GPOName = "MapSharedFolder"

# Vérifier si la GPO existe déjà
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue

if ($GPO) {
    Write-Host "La GPO '$GPOName' existe deja. Utilisation de la GPO existante."
} else {
    $GPO = New-GPO -Name $GPOName
    Write-Host "GPO '$GPOName' creee avec succes."
}

# ==============================
# Lier la GPO à l'OU Students si le lien n'existe pas déjà
# ==============================

Write-Host "`n=== Verification du lien entre GPO et OU Students ===`n"

$OU = "OU=Students,DC=$netbiosName,DC=local"

# Recuperer tous les liens existants
$existingLinks = (Get-GPInheritance -Target $OU).GpoLinks

# Verifier si le lien existe deja
$linkExists = $false

foreach ($link in $existingLinks) {
    if ($link.DisplayName -eq $GPOName) {
        $linkExists = $true
    }
}

if ($linkExists) {
    Write-Host "La GPO '$GPOName' est deja liee a l'OU Students."
} else {
    New-GPLink -Name $GPOName -Target $OU -Enforced No
    Write-Host "Lien GPO -> OU Students ajoute."
}

# ==============================
# Script Logon
# ==============================

Write-Host "`n=== Creation du script logon pour le lecteur Z ===`n"

$DriveLetter = "Z:"
$SharePath = "\\$netbiosName\SharedResources"

$ScriptFolder = "C:\Scripts"
$ScriptPath = "$ScriptFolder\MapDrive-$DriveLetter.bat"

# Créer le dossier si nécessaire
if (-not (Test-Path $ScriptFolder)) {
    New-Item -ItemType Directory -Path $ScriptFolder
}

# Contenu du script BAT
$scriptContent = "net use $DriveLetter $SharePath /persistent:no"
Set-Content -Path $ScriptPath -Value $scriptContent

Write-Host "Script logon cree : $ScriptPath"

# ==============================
# Associer le script logon à la GPO
# ==============================

Set-GPRegistryValue -Name $GPOName `
                    -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
                    -ValueName "LogonScript" `
                    -Type String `
                    -Value $ScriptPath

Write-Host "`n=== Script termine sans erreur ===`n"

