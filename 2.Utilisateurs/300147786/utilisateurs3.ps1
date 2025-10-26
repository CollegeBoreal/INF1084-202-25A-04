#Lister tous les utilisateurs dont le prénom contient "a" (majuscule ou minuscule)
# Étape 1 : liste d'utilisateurs simulés
$Users = @(
    @{ Prenom = "Alice"; Nom = "Dupont"; OU = "Stagiaires" },
    @{ Prenom = "Bob"; Nom = "Martin"; OU = "Professeurs" },
    @{ Prenom = "Chloé"; Nom = "Tremblay"; OU = "Stagiaires" },
    @{ Prenom = "David"; Nom = "Roy"; OU = "Direction" },
    @{ Prenom = "Marc"; Nom = "Benoit"; OU = "Stagiaires" }
)

# Étape 2 : Filtrer les utilisateurs dont le prénom contient la lettre "a"
$Result = $Users | Where-Object { $_.Prenom -match "a" }

# Étape 3 : Afficher le résultat
$Result

