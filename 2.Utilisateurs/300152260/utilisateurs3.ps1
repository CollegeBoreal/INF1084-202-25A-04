# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dont OU = "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher le groupe GroupeFormation
Write-Host "`n--- GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }