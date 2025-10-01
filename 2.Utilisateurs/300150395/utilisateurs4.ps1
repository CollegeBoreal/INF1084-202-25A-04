# utilisateurs4.ps1
# Mini-projet : création d'utilisateurs et groupe

# Charger utilisateurs1.ps1 pour récupérer les utilisateurs
. .\utilisateurs1.ps1

# Créer un groupe "Etudiants2025"
$Groups = @{
    "Etudiants2025" = @()
}

# Ajouter tous les utilisateurs de "Promo2025" dans le groupe
$Groups["Etudiants2025"] += $Users | Where-Object {$_.OU -eq "Promo2025"}

# Exporter la liste finale en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation

# Afficher les utilisateurs
"Utilisateurs dans Etudiants2025 :"
$Groups["Etudiants2025"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

