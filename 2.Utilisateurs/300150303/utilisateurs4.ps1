# --- utilisateurs4.ps1 ---
. .\utilisateurs1.ps1

# Exporter les utilisateurs simulés
$Path = "C:\Temp\UsersSimules.csv"
if (-not (Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" }
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "Fichier exporté vers $Path"

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path $Path
Write-Host "Utilisateurs importés :"
$ImportedUsers | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exercice 4 : Créer un groupe ImportGroupe et y ajouter les utilisateurs importés
$Groups = @{}
$Groups["ImportGroupe"] = @($ImportedUsers)

Write-Host "`nMembres du groupe ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
