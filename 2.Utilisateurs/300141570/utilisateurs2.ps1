# Créer des groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}
# Liste d'utilisateurs simulés
$Users = @(
    @{ Nom = "Alice Dupont"; OU = "Stagiaires" },
    @{ Nom = "Bob Martin"; OU = "Professeurs" },
    @{ Nom = "Chloé Tremblay"; OU = "Stagiaires" },
    @{ Nom = "David Roy"; OU = "Direction" }
)

# Ajouter tous les utilisateurs dont l’OU est "Stagiaires" dans le groupe "GroupeFormation"
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user
    }
}
# Vérifier le contenu du groupe "GroupeFormation"
$Groups["GroupeFormation"]


