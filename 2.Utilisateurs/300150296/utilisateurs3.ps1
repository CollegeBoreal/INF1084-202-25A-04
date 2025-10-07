# Script utilisateurs3.ps1
# Filtrage des utilisateurs

# Recréer la liste des utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule)
$Users | Where-Object { $_.Prenom -match "a" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

