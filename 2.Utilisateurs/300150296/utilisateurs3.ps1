# Exercice 3 : Requêtes et filtres
# Étudiant : 300150296

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Bouanani"; Prenom="Youba"; Login="ybouanani"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Professeurs"}
)

Write-Host "=== Noms commençant par 'B' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}

Write-Host "`n=== OU 'Stagiaires' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}

Write-Host "`n=== Prénom contenant 'a' ===" -ForegroundColor Yellow
$Users | Where-Object {$_.Prenom -like "*a*"} | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}