# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
<<<<<<< HEAD
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
=======
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
<<<<<<< HEAD:2.Utilisateurs/300141429/Utilisateur1.ps1

 @{Nom="BARRY"; Prenom="Arona"; Login="barry"; OU="Stagiaires"},
    @{Nom="BALDE"; Prenom="Bineta"; Login="balde"; OU="Stagiaires"}
=======
    @{Nom="Ngue"; Prenom="Taylor"; Login="tngue"; OU="Etudiants"}
>>>>>>> ee92b32cee0fe572e7f1e5d711812d51f4401a21
>>>>>>> ac229c4b274e062f0430679e7905accace76cc65:2.Utilisateurs/300098957/utilisateurs1.ps1
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
