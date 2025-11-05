# utilisateurs2.ps1
# Objectif : Créer des groupes simulés et y ajouter les utilisateurs de l’OU Stagiaires

. .\utilisateurs1.ps1  # Importer la liste d’utilisateurs du script précédent

$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation"
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les membres du groupe
"=== Membres du GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}
