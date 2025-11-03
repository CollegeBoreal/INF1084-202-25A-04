# Définir les utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},
    @{Nom="Tremblay"; Prenom="Marc"; Login="mtremblay"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le prénom contient "a" ou "A"
$Users | Where-Object { $_.Prenom -match "[aA]" } | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}

