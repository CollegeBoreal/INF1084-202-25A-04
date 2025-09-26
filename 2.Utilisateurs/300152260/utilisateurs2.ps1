# Créer 5 utilisateurs simulés pour Promo2025
$Promo2025 = @(
    @{Nom="Ahmed"; Prenom="Ali"; Login="aali"; OU="Promo2025"},
    @{Nom="Brahim"; Prenom="Sara"; Login="sbrahim"; OU="Promo2025"},
    @{Nom="Karim"; Prenom="Nadia"; Login="knadia"; OU="Promo2025"},
    @{Nom="Fatima"; Prenom="Youssef"; Login="fyoussef"; OU="Promo2025"},
    @{Nom="Mounir"; Prenom="Leila"; Login="mleila"; OU="Promo2025"}
)

# Afficher les utilisateurs de Promo2025
Write-Host "`n--- Utilisateurs Promo2025 ---"
$Promo2025 | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }
