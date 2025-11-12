# --- utilisateurs2.ps1 ---
# Importer les utilisateurs du script précédent
. .\utilisateurs1.ps1

# Création de groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation"
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Vérifier le contenu du groupe
Write-Host "Utilisateurs dans GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
