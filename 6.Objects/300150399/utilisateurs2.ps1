# TP 6.Objects - Script utilisateurs2.ps1
# Etudiant : Rahmani Chakib (300150399)
# Objectif : Créer une GPO qui servira au mappage du lecteur Z: pour les utilisateurs

Import-Module ActiveDirectory
Import-Module GroupPolicy

# Nom de la GPO
$GpoName = "MapSharedFolder-300150399"

# Récupérer le DN du domaine (ex: DC=DC300150399-00,DC=local)
$domainDN = (Get-ADDomain).DistinguishedName

# Cible : le conteneur Users, car tes comptes Etudiant1 / Etudiant2 sont dedans
$target = "CN=Users,$domainDN"

Write-Host "Domaine : $domainDN"
Write-Host "Cible GPO : $target"

# 1) Créer (ou récupérer) la GPO
$gpo = Get-GPO -Name $GpoName -ErrorAction SilentlyContinue
if (-not $gpo) {
    Write-Host "Création de la GPO $GpoName..."
    $gpo = New-GPO -Name $GpoName -Comment "Mappage Z: vers \\DC300150399-00\SharedResources"
} else {
    Write-Host "La GPO $GpoName existe déjà, on la réutilise."
}

# 2) Lier la GPO au conteneur Users
Write-Host "Lien de la GPO sur $target..."
New-GPLink -Name $GpoName -Target $target -Enforced:$false -LinkEnabled Yes | Out-Null

# 3) Créer le script batch de mappage dans C:\Scripts
$scriptFolder = "C:\Scripts"
if (-not (Test-Path $scriptFolder)) {
    New-Item -ItemType Directory -Path $scriptFolder | Out-Null
}

$scriptPath = Join-Path $scriptFolder "MapDrive-Z.bat"

Write-Host "Création du script $scriptPath ..."

@"
@echo off
net use Z: \\DC300150399-00\SharedResources /persistent:no
"@ | Set-Content -Path $scriptPath -Encoding ASCII

Write-Host "Script créé. Tu dois maintenant l'attacher à la GPO dans la console GPMC."