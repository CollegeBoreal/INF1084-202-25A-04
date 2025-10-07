# 1?? Cr�ation d�objets utilisateurs simul�s

# Cr�er une liste d'utilisateurs simul�s
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Exercice : Ajouter 2 nouveaux utilisateurs � la liste et v�rifier qu�ils s�affichent correctement.
