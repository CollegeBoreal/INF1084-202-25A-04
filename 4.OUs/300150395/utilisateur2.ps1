# ======================================================
# TP Active Directory - Étudiant : 300150395
# Fichier : utilisateur2.ps1
# Objectif : Création et gestion de groupes simulés
# ======================================================

# Liste d'utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; OU="Stagiaires"},
    @{Nom="Isma"; Prenom="Isma"; OU="Etudiant"},
    @{Nom="Diallo"; Prenom="Hakin"; OU="Menuisier"}
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs dont l’OU = "Stagiaires"
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += "$($user.Prenom) $($user.Nom)"
    }
}

# Afficher le contenu du groupe
Write-Host "Membres du groupe GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object { Write-Host "- $_" }

