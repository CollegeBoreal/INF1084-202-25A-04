# Créer une liste d'utilisateurs simulés
$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Ikram"; Prenom="Sidhoum"; Login="Ikram"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="kkkkkk"; Prenom="kkkkk"; Login="Ilham"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Chemin complet du CSV (dans ton dossier)
$csvPath = "C:\Users\ikram\Developer\INF1084-202-25A-03\2.Utilisateurs\300146418\UsersSimules.csv"

# Exporter correctement vers CSV
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Output "✅ Fichier CSV créé : $csvPath"
