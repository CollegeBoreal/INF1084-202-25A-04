# utilisateurs1.ps1
# Exercice 1 : Création et affichage d’utilisateurs simulés

# Créer la liste initiale
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajouter 2 nouveaux utilisateurs
$Users += @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"}
$Users += @{Nom="Nguyen"; Prenom="Mai"; Login="mnguyen"; OU="Stagiaires"}

# Afficher tous les utilisateurs
Write-Host "=== Liste des utilisateurs simulés ===" -ForegroundColor Cyan
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Exporter en CSV pour la suite du TP
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation
Write-Host "✅ Fichier exporté : C:\Temp\UsersSimules.csv" -ForegroundColor Green

