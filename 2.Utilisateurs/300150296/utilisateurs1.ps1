# ============================================
# Exercice 1 : Création d'objets utilisateurs simulés
# ============================================

# Créer une liste d'utilisateurs simulés (les 3 de base)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

Write-Host "`n=== Utilisateurs de base ===" -ForegroundColor Cyan
$Users | ForEach-Object { 
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}

# ✅ AJOUT DE 2 NOUVEAUX UTILISATEURS (Exercice 1)
$Users += @{Nom="Martin"; Prenom="Jean"; Login="jmartin"; OU="Stagiaires"}
$Users += @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}

Write-Host "`n=== Tous les utilisateurs (avec les 2 nouveaux) ===" -ForegroundColor Green
$Users | ForEach-Object { 
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}

Write-Host "`n✅ Total : $($Users.Count) utilisateurs créés" -ForegroundColor Yellow