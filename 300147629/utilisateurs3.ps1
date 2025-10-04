# utilisateurs3.ps1
# Exercice 3 : I'm here

# Liste des utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

# Lister les utilisateurs dont le prénom contient "a" (maj/min)
$Users | Where-Object { $_.Prenom -match "a" }
