# utilisateurs4.ps1
# Objectif : Exporter et importer les utilisateurs simulés

. .\utilisateurs1.ps1  # Importer la liste d'utilisateurs

# Exporter en CSV
$path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $path -NoTypeInformation
Write-Host "Fichier exporté vers $path"

# Importer depuis le CSV
$ImportedUsers = Import-Csv -Path $path
Write-Host "=== Utilisateurs importés ==="
$ImportedUsers

# Créer un groupe ImportGroupe et y ajouter les utilisateurs importés
$Groups = @{"ImportGroupe" = @()}
$Groups["ImportGroupe"] += $ImportedUsers

"=== Membres du groupe ImportGroupe ==="
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
