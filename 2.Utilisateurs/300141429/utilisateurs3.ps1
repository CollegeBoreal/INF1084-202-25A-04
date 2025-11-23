Write-Host "`n--- Script utilisateurs3.ps1 : Requêtes et filtres ---"

# Créer une liste d'utilisateurs (autonome)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Diallo"; Prenom="Moussa"; Login="mdiallo"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

Write-Host "`n--- Utilisateurs dont le prénom contient 'a' ---"
$Users | Where-Object { $_.Prenom -match "[aA]" } | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

Write-Host "`n--- Utilisateurs dont le nom commence par 'B' ---"
$Users | Where-Object { $_.Nom -like "B*" } | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

Write-Host "`n--- Utilisateurs dans l'OU 'Stagiaires' ---"
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

