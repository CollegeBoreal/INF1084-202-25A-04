# ======================================================
# TP Active Directory - Étudiant : 300150395
# Fichier : utilisateur3.ps1
# Objectif : Requêtes et filtres sur les utilisateurs
# ======================================================

# Liste d’utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; OU="Stagiaires"},
    @{Nom="Isma"; Prenom="Isma"; OU="Etudiant"},
    @{Nom="Diallo"; Prenom="Hakin"; OU="Menuisier"}
)

# Lister les utilisateurs dont le nom commence par "B"
Write-Host "`nUtilisateurs dont le nom commence par 'B' :"
$Users | Where-Object { $_.Nom -like "B*" }

# Lister les utilisateurs dont le prénom contient "a"
Write-Host "`nUtilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" }

# Lister les utilisateurs de l’OU "Stagiaires"
Write-Host "`nUtilisateurs dans l’OU 'Stagiaires' :"
$Users | Where-Object { $_.OU -eq "Stagiaires" }

