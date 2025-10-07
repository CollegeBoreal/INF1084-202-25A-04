# utilisateurs2.ps1
# Exercice 2 : Création de groupes simulés

# Importer la liste depuis le CSV
$Users = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dont l’OU = "Stagiaires"
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les membres du groupe
Write-Host "=== Membres de GroupeFormation ===" -ForegroundColor Cyan
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) ($($_.Login))" }

