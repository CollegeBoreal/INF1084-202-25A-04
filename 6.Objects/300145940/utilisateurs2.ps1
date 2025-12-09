# utilisateurs2.ps1 – Version modifiée
# Auteur : 300145940

# Définition du chemin vers le script bootstrap
$bootFile = [IO.Path]::Combine(
    $PSScriptRoot, '..','..','4.OUs','300145940','bootstrap.ps1'
)

# Vérification de l'existence du fichier bootstrap
if (!(Test-Path -LiteralPath $bootFile)) {
    Write-Error "Fichier bootstrap non trouvé : $bootFile"
    exit 1
}

# Chargement des paramètres AD depuis bootstrap
. $bootFile

# Modules nécessaires
foreach ($module in @('ActiveDirectory','GroupPolicy')) {
    Import-Module $module -ErrorAction Stop
}

# Variables locales
$folderPath  = 'C:\SharedResources'
$adGroup     = 'Students'
$shareName   = 'SharedResources'

# Création du dossier si absent
if (!(Test-Path -Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
}

# Création du partage SMB si inexistant
$existingShare = Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue
if (-not $existingShare) {
    New-SmbShare -Name $shareName -Path $folderPath -FullAccess $adGroup | Out-Null
}

# Activation des connexions RDP
Set-ItemProperty `
    -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' `
    -Name 'fDenyTSConnections' `
    -Value 0

Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'

