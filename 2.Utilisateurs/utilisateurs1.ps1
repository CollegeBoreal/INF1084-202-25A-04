<<<<<<< HEAD
# utilisateurs1.ps1

$Users= @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
@{Nom="Lamine"; Prenom="balde"; Login="lbalde"; OU="Stagiaires"},                                                    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
@{Nom="Rafiou"; Prenom="Diallo"; Login="Rdiallo"; OU="Stagiaires"}
=======
#créer une liste d'utilisateur simulés
$Users = @( 
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="durk"; Prenom="Smurkio"; Login="lil"; OU="Stagiaires"},
    @{Nom="Moussa"; Prenom="Sow"; Login="soul"; OU="Stagiaires"}
>>>>>>> 70ba2db080456304b99321e887fe230bb7f9714b
)
#Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"}

<<<<<<< HEAD
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
                                    
               
=======
 
>>>>>>> 70ba2db080456304b99321e887fe230bb7f9714b
