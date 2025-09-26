# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer le groupe ImportGroupe et ajouter les utilisateurs importés
$Groups["ImportGroupe"] = @()
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher le groupe ImportGroupe
Write-Host "`n--- ImportGroupe ---"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
