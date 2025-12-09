# utilisateurs0.ps1
# Auteur : 300145940

# Construction du chemin vers le script bootstrap
$bootstrapFile = [System.IO.Path]::Combine(
    $PSScriptRoot,
    '..', '..',
    '4.OUs',
    '300145940',
    'bootstrap.ps1'
)

# Vérifie la présence du fichier bootstrap
if (-not (Test-Path -LiteralPath $bootstrapFile)) {
    Write-Error "Fichier bootstrap introuvable : $bootstrapFile"
    exit 1
}

# Charge la configuration du domaine
. $bootstrapFile

# Import des modules nécessaires
'ActiveDirectory','GroupPolicy' | ForEach-Object {
    Import-Module -Name $_ -ErrorAction Stop
}

# Affichage des informations de domaine
Write-Host ("Domaine (FQDN) : {0}" -f $domainName)
Write-Host ("Nom NetBIOS    : {0}" -f $netbiosName)

# Affiche les détails du domaine AD
Get-ADDomain -Server $domainName

