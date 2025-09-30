# --- Liste d'utilisateurs simulés ---
$Users = @(
    @{Nom="Dupont";   Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine";  Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";   Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Nzinga";   Prenom="Paul";   Login="pnzinga";  OU="Stagiaires"},
    @{Nom="Kouyaté";  Prenom="Fatou";  Login="fkouyate"; OU="Stagiaires"}
)

# --- Afficher les utilisateurs ---
$Users | ForEach-Object { 
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}

# --- Exporter en CSV ---
$Users | Export-Csv -Path ".\UsersSimules.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Liste exportée vers UsersSimules.csv"

# --- Exporter en JSON (optionnel) ---
$Users | ConvertTo-Json -Depth 3 | Out-File -FilePath ".\UsersSimules.json" -Encoding UTF8
Write-Host "Liste exportée vers UsersSimules.json"

