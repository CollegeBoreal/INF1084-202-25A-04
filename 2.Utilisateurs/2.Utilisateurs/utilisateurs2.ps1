# 2️⃣ Création de groupes simulés

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont

# 🧠 Exercice 2 :
# Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation".
