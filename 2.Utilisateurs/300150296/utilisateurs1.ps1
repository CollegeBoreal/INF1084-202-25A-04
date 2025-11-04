$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Bouanani"; Prenom="Youba"; Login="ybouanani"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"}
)

Write-Host "=== Liste des utilisateurs ===" -ForegroundColor Green
$Users | ForEach-Object { 
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}