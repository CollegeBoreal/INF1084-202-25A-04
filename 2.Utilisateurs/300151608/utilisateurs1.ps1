# utilisateurs1.ps1
# ========================
# Étape 1 : Création d'objets utilisateurs simulés

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Keller"; Prenom="Marc"; Login="mkeller"; OU="Stagiaires"},
    @{Nom="Boucher"; Prenom="Amira"; Login="aboucher"; OU="Stagiaires"}
)

# Affichage formaté
$Users | ForEach-Object {
    Write-Output "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

