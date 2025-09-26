# Définir la liste des utilisateurs
$Users = @(
    @{ Name = "Alice Dupont"; Login = "adupont"; OU = "Stagiaires" }
    @{ Name = "Sarah Lemoine"; Login = "slemoine"; OU = "Stagiaires" }
    @{ Name = "Karim Benali"; Login = "kbenali"; OU = "Stagiaires" }
    @{ Name = "Kahina Zerkani"; Login = "kzerkani"; OU = "Stagiaires" }
    @{ Name = "Lina Zergui"; Login = "lzergui"; OU = "Stagiaires" }
)
# Créer des groupes (vides au départ)
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter uniquement les utilisateurs dont l'OU = "Stagiaires"
$Groups["GroupeFormation"] = $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Vérifier le contenu du groupe
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

