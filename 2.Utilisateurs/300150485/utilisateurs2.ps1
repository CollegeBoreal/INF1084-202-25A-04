# 2?? Cr�ation de groupes simul�s

# Cr�er des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur � un groupe
$Groups["GroupeFormation"] += @{Nom="Dupont"; Prenom="Alice"; OU="Stagiaires"}

# Exercice : Ajouter tous les utilisateurs dont l�OU = "Stagiaires" dans "GroupeFormation".
