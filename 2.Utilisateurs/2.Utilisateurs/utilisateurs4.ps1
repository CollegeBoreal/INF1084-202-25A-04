# 4️⃣ Export et import CSV

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers

# 🧠 Exercice 4 :
# Importer le fichier CSV et créer un groupe "ImportGroupe" en ajoutant tous les utilisateurs importés.


# 5️⃣ Mini-projet : simulation complète

# Créer 5 utilisateurs simulés dans l’OU "Promo2025"
$Promo2025 = @(
    @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Promo2025"},
    @{Nom="Nguyen"; Prenom="Alex"; Login="anguyen"; OU="Promo2025"},
    @{Nom="Tremblay"; Prenom="Luc"; Login="ltremblay"; OU="Promo2025"},
    @{Nom="Garcia"; Prenom="Lina"; Login="lgarcia"; OU="Promo2025"},
    @{Nom="Bouchard"; Prenom="Noah"; Login="nbouchard"; OU="Promo2025"}
)

# Créer un groupe "Etudiants2025"
$Groups["Etudiants2025"] = @()

# Ajouter tous les utilisateurs de "Promo2025" dans le groupe
$Promo2025 | ForEach-Object { $Groups["Etudiants2025"] += $_ }

# Exporter la liste finale du groupe en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation
