# utilisateurs3.ps1
# Exercice 3 : Requêtes et filtres

# Importer la liste depuis le CSV
$Users = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Filtrer les utilisateurs dont le prénom contient "a"
$Resultats = $Users | Where-Object { $_.Prenom -match "a" }

# Afficher le résultat
Write-Host "=== Utilisateurs dont le prénom contient 'a' ===" -ForegroundColor Cyan
$Resultats | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

