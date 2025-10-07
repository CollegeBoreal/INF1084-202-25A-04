# --- utilisateurs3.ps1 ---
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nora";   Login="nmartin";  OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Amine";  Login="abernard"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le nom commence par "B"
"--- Nom commence par 'B' ---"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs de l'OU "Stagiaires"
"--- OU = 'Stagiaires' ---"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# Exercice 3 : prénom contenant 'a' (insensible à la casse)
"--- Prenom contient 'a' ---"
$Users | Where-Object {$_.Prenom -match 'a'}
