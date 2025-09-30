# Créer une liste d'utilisateurs simulés
$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
    [PSCustomObject]@{Nom="Siga"; Prenom="Diarra" ; Login="sidiarra"; OU="Stagiaire"},
    [PSCustomObject]@{Nom="Jude"; Prenom="Belligham" ; Login="jubellingham"; OU="Stagiaire"}
            
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
