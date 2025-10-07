# utilisateurs4.ps1
# Exercice 4 : Import et création d’un groupe avec les utilisateurs importés

# Importer le fichier CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer un groupe "ImportGroupe"
$Groups = @{}
$Groups["ImportGroupe"] = @()

# Ajouter tous les utilisateurs importés au groupe
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher les membres du groupe
Write-Host "=== Membres du groupe ImportGroupe ===" -ForegroundColor Cyan
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

