# ============================
# Script utilisateurs1.ps1
# Création groupe + utilisateurs + partage SMB
# Belkacem Medjkoune - 300150385
# ============================

# Nom du groupe à utiliser pour le partage
$GroupName = "Students"

# Dossier à partager
$SharedFolder = "C:\SharedResources"

# -- Création du dossier partagé --
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
    Write-Host "[OK] Dossier partagé créé : $SharedFolder"
} else {
    Write-Host "[INFO] Le dossier partagé existe déjà."
}

# -- Vérifier / créer le groupe AD --
$Group = Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue

if (-not $Group) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Groupe accès dossier partagé et RDP"
    Write-Host "[OK] Groupe AD créé : $GroupName"
} else {
    Write-Host "[INFO] Groupe $GroupName déjà présent dans l'annuaire."
}

# -- Liste d'utilisateurs à créer --
$Users = @("Etudiant1", "Etudiant2")

foreach ($User in $Users) {

    # Vérifier si l'utilisateur existe déjà
    $ExistingUser = Get-ADUser -Filter "SamAccountName -eq '$User'" -ErrorAction SilentlyContinue

    if (-not $ExistingUser) {
        New-ADUser -Name $User `
                   -SamAccountName $User `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true

        Write-Host "[OK] Utilisateur créé : $User"
    }
    else {
        Write-Host "[INFO] Utilisateur $User existe déjà."
    }

    # Ajouter au groupe même si existant
    Add-ADGroupMember -Identity $GroupName -Members $User -ErrorAction SilentlyContinue
    Write-Host "[OK] $User ajouté au groupe $GroupName"
}

# -- Partage SMB --
$ShareName = "SharedResources"

if (-not (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name $ShareName -Path $SharedFolder -FullAccess $GroupName
    Write-Host "[OK] Partage SMB créé : $ShareName"
}
else {
    Write-Host "[INFO] Le partage SMB '$ShareName' existe déjà."
}

Write-Host "`n--- Script terminé ---"
