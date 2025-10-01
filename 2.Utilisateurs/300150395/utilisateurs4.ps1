# utilisateurs4.ps1 corrigé

# Charger les utilisateurs depuis le CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer le groupe Etudiants2025 et ajouter les utilisateurs
$Groups = @{
    "Etudiants2025" = $ImportedUsers
}

# Afficher les utilisateurs du groupe
"Utilisateurs dans Etudiants2025 :"
$Groups["Etudiants2025"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exporter le groupe final en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation

