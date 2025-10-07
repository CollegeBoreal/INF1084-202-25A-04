# Exercice 1 : Création d'objets utilisateurs simulés
# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    # Ajout de 2 nouveaux utilisateurs
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}
)

# Afficher les utilisateurs
Write-Host "`n=== Liste des utilisateurs ===" -ForegroundColor Cyan
$Users | ForEach-Object { 
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" -ForegroundColor Green
}

Write-Host "`nNombre total d'utilisateurs: $($Users.Count)" -ForegroundColor Yellow