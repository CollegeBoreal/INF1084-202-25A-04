# Fatou2.ps1
# Création des groupes et ajout des utilisateurs

# Importer les utilisateurs
$CSVPath = Join-Path $PSScriptRoot "UsersSimules.csv"
$Users = Import-Csv $CSVPath

# Créer les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object {$_.OU -eq "Stagiaires"}

# Afficher le contenu du groupe
Write-Host "[Contenu du GroupeFormation]"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

