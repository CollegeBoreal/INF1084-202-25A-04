# ----------------------------------------
# Mini-projet : Simulation utilisateurs et groupe
# ----------------------------------------

# Chemin du dossier pour le CSV
$csvFolder = "C:\Users\ikram\Developer\INF1084-202-25A-03\2.Utilisateurs\300146418"
$csvPath = "$csvFolder\Etudiants2025.csv"

# 1️⃣ Créer 5 utilisateurs simulés dans l'OU "Promo2025"
$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Ikram"; Prenom="Sidhoum"; Login="Ikram"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Nabila"; Prenom="Ilham"; Login="Ilham"; OU="Promo2025"}
)

# 2️⃣ Créer un groupe "Etudiants2025" (simulation = tableau)
$Etudiants2025 = @()

# 3️⃣ Ajouter tous les utilisateurs de "Promo2025" dans le groupe
foreach ($user in $Users) {
    if ($user.OU -eq "Promo2025") {
        $Etudiants2025 += $user
    }
}

# 4️⃣ Afficher le contenu du groupe
Write-Output "=== Groupe 'Etudiants2025' ==="
$Etudiants2025 | ForEach-Object {
    Write-Output "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 5️⃣ Créer le CSV automatiquement
# Crée le dossier si nécessaire
if (-not (Test-Path $csvFolder)) {
    New-Item -ItemType Directory -Path $csvFolder | Out-Null
}

# Exporter le groupe en CSV
$Etudiants2025 | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
Write-Output "✅ Fichier CSV créé : $csvPath"
