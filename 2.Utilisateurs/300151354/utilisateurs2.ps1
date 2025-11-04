# =============================
# 2️⃣ Création de groupes simulés
# =============================

# 1️⃣ Création d'une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Louis"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)

# 2️⃣ Création de groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# 3️⃣ Exercice 2 : Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans "GroupeFormation"
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user
    }
}

# 4️⃣ Vérifier le contenu du groupe
Write-Host "📘 Membres du GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}



