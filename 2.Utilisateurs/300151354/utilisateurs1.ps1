# ============================
# TP : Simulation Active Directory
# Exercice 1 : Création d’utilisateurs simulés
# ============================

# 1️⃣ Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# 2️⃣ Ajouter 2 nouveaux utilisateurs à la liste
$Users += @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
$Users += @{Nom="Moreau"; Prenom="Lucas"; Login="lmoreau"; OU="Professeurs"}

# 3️⃣ Afficher tous les utilisateurs pour vérification
Write-Host "`nListe complète des utilisateurs simulés :" -ForegroundColor Cyan
$Users | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

