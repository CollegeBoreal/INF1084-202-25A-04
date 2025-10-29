# ======================================================
# TP Active Directory - Étudiant : 300150395
# Fichier : utilisateur1.ps1
# Objectif : Création d’utilisateurs simulés
# ======================================================

# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Isma"; Prenom="Isma"; Login="iisma"; OU="Etudiant"},
    @{Nom="Diallo"; Prenom="Hakin"; Login="hdiallo"; OU="Menuisier"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

