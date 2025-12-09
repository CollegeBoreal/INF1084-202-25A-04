# Exercice 1 - Liste des utilisateurs

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajout de deux utilisateurs
$Users += @{Nom="Tahar"; Prenom="Aroua"; Login="atahar"; OU="Stagiaires"}
$Users += @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}

# Affichage
foreach ($u in $Users) {
    Write-Output "$($u.Prenom) $($u.Nom) - $($u.Login) - $($u.OU)"
}
