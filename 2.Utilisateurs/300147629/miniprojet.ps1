# -----------------------------
# Mini-projet : Simulation Active Directory
# -----------------------------

# 1️⃣ Créer 5 utilisateurs simulés dans l’OU "Promo2025"
$UsersPromo2025 = @(
    [PSCustomObject]@{Nom="Martin"; Prenom="Emma"; Login="emartin"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Dubois"; Prenom="Lucas"; Login="ldubois"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Petit"; Prenom="Chloé"; Login="cpetit"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Moreau"; Prenom="Nathan"; Login="nmoreau"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Rousseau"; Prenom="Léa"; Login="lrousseau"; OU="Promo2025"}
)

# 2️⃣ Créer le groupe "Etudiants2025"
$Groups = @{
    "Etudiants2025" = @()
}

# 3️⃣ Ajouter tous les utilisateurs de "Promo2025" dans le groupe
$Groups["Etudiants2025"] += $UsersPromo2025

# 4️⃣ Afficher le contenu du groupe
Write-Host "Contenu du groupe Etudiants2025 :"
$Groups["Etudiants2025"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 5️⃣ Exporter la liste finale du groupe en CSV dans le répertoire actuel
$CsvPath = ".\Etudiants2025.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $CsvPath -NoTypeInformation

Write-Host "`nLe fichier CSV a été créé à l'emplacement : $CsvPath"

