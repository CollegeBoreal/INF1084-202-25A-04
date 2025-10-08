# 2?? Création de groupes simulés

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += @{Nom="Dupont"; Prenom="Alice"; OU="Stagiaires"}

# Exercice : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation".
