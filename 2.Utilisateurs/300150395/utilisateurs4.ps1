$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Promo2025"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Promo2025"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Promo2025"},
    @{Nom="Trache"; Prenom="Ismail"; Login="Tismail"; OU="Promo2025"},
    @{Nom="Nemouss"; Prenom="Latif"; Login="Nlatif"; OU="Promo2025"}
)

# Exporter les utilisateurs en CSV
$Users | Export-Csv -Path "C:\Temp\UsersPromo2025.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersPromo2025.csv"

# Créer un groupe Etudiants2025 et ajouter tous les utilisateurs importés
$Groups = @{
    "Etudiants2025" = $ImportedUsers
}

# Exporter la liste finale du groupe
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation

