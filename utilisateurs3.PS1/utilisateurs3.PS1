# =========================================================
# Script : utilisateurs3.ps1
# Description : Requêtes et filtres sur la liste d'utilisateurs
# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
# =========================================================

# 1. Créer une liste d'utilisateurs simulés
$users = @(
    @{Nom="Dupont";     Prenom="Alice";    Login="adupont";      OU="Stagiaires"},
    @{Nom="Lemoine";    Prenom="Sarah";    Login="slemoine";     OU="Stagiaires"},
    @{Nom="Benali";     Prenom="Karim";    Login="kbenali";      OU="Stagiaires"},
    @{Nom="Saoudi";     Prenom="Allaoua";  Login="asaoudi";      OU="Stagiaires"},
    @{Nom="Boukacouma"; Prenom="Mahmoud";  Login="mboukacouma";  OU="Stagiaires"}
)

# 2. Exercice 3 : filtrer les utilisateurs dont le prénom contient "a" (majuscule ou minuscule)
$usersWithA = $users | Where-Object { $_.Prenom -match "a" }

# 3. Afficher les résultats
Write-Output "`nUtilisateurs dont le prénom contient 'a' :"
$usersWithA | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

