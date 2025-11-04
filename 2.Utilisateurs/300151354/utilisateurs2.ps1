# ============================
# TP : Simulation Active Directory
# Exercice 2 : Création de groupes simulés
# ============================

# 1️⃣ Liste d'utilisateurs (reprend les données de l'exercice 1)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},
    @{Nom="Moreau"; Prenom="Lucas"; Login="lmoreau"; OU="Professeurs"}
)

# 2️⃣ Création de groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# 3️⃣ Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation"
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# 4️⃣ Vérification de l’ajout
Write-Host "`n=== Membres du GroupeFormation ===" -ForegroundColor Cyan
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

Write-Host "`n=== Membres du ProfesseursAD ===" -ForegroundColor Yellow
$Groups["ProfesseursAD"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}

