# ======================================================
# TP Active Directory - Étudiant : 300150395
# Fichier : utilisateur4.ps1
# Objectif : Exportation et importation CSV des utilisateurs
# ======================================================

# Définir des utilisateurs comme objets
$Users = @(
    [PSCustomObject]@{ Nom="Dupont"; Prenom="Alice"; OU="Stagiaires" }
    [PSCustomObject]@{ Nom="Diallo"; Prenom="Ibrahima"; OU="Professeurs" }
    [PSCustomObject]@{ Nom="Isma"; Prenom="Isma"; OU="Stagiaires" }
)

# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

# Exporter les utilisateurs simulés
$csvPath = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
Write-Host "`n✅ Utilisateurs exportés vers $csvPath"

# Importer depuis le CSV
$ImportedUsers = Import-Csv -Path $csvPath

# Créer un groupe ImportGroupe
$ImportGroupe = @()
$ImportGroupe += $ImportedUsers

Write-Host "`nMembres du groupe ImportGroupe :"
$ImportGroupe | Format-Table Nom, Prenom, OU
