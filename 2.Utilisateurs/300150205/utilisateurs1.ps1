﻿# Créer une liste d'utilisateurs simulés avec des objets personnalisés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Ngue"; Prenom="Taylor"; Login="tngue"; OU="Etudiants"},  
    @{Nom="Nguetsa"; Prenom="joyce"; Login="joyngue"; OU="Etudiants"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

