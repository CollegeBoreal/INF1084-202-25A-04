$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Trache"; Prenom="Ismail"; Login="Tismail"; OU="Stagiaires"},
    @{Nom="Nemouss"; Prenom="Latif"; Login="Nlatif"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# Lister tous les utilisateurs dont le prénom contient "a" (insensible à la casse)
$Users | Where-Object {$_.Prenom -match "a"}

