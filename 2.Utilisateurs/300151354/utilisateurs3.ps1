# ============================
# TP : Simulation Active Directory
# Exercice 3 : Requêtes et filtres
# ============================

# 1️⃣ Liste d'utilisateurs (reprend les données précédentes)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},
    @{Nom="Moreau"; Prenom="Lucas"; Login="lmoreau"; OU="Professeurs"}
)

# 2️⃣ Lister tous les utilisateurs dont le nom commence par "B"
Write-Host "`n=== Utilisateurs dont le nom commence par 'B' ===" -ForegroundColor Cyan
$Users | Where-Object { $_.Nom -like "B*" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 3️⃣ Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`n=== Utilisateurs dans l'OU 'Stagiaires' ===" -ForegroundColor Cyan
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

# 4️⃣ Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a" (maj/min)
Write-Host "`n=== Utilisateurs dont le prénom contient 'a' (insensible à la casse) ===" -ForegroundColor Cyan
$Users | Where-Object { $_.Prenom -match "(?i)a" } | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

