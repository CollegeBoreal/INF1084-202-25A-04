# Recharger les utilisateurs (même liste que ci-dessus)
$Users = @(
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Keller"; Prenom="Marc"; Login="mkeller"; OU="Stagiaires"},
    @{Nom="Boucher"; Prenom="Amira"; Login="aboucher"; OU="Stagiaires"},
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"}
)

Write-Host "`n--- Utilisateurs dont le Nom commence par 'B' ---"
$Users | Where-Object { $_.Nom -like "B*" }

Write-Host "`n--- Utilisateurs dans l'OU 'Stagiaires' ---"
$Users | Where-Object { $_.OU -eq "Stagiaires" }

Write-Host "`n--- Utilisateurs dont le Prénom contient 'a' ---"
$Users | Where-Object { $_.Prenom -match "a" }

