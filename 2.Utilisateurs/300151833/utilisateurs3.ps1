# Exercice 3 : Requêtes et filtres

# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}
)

# Lister tous les utilisateurs dont le nom commence par "B"
Write-Host "`n=== Utilisateurs dont le nom commence par 'B' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom)" -ForegroundColor Green
}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`n=== Utilisateurs dans l'OU 'Stagiaires' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom)" -ForegroundColor Green
}

# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule)
Write-Host "`n=== Utilisateurs dont le prénom contient 'a' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.Prenom -like "*a*"} | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom)" -ForegroundColor Yellow
}