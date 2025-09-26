# Fatou3.ps1
# Requêtes et import/export CSV

# Importer les utilisateurs
$CSVPath = Join-Path $PSScriptRoot "UsersSimules.csv"
$Users = Import-Csv $CSVPath

# Utilisateurs dont le nom commence par B
Write-Host "[Utilisateurs dont le nom commence par B]"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Utilisateurs dans OU "Stagiaires"
Write-Host "[Utilisateurs dans l'OU Stagiaires]"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Utilisateurs dont le prénom contient "a"
Write-Host "[Utilisateurs dont le prénom contient 'a']"
$Users | Where-Object {$_.Prenom -match "a"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Export CSV final pour vérification
$ExportPath = Join-Path $PSScriptRoot "UsersSimules_Export.csv"
$Users | Export-Csv -Path $ExportPath -NoTypeInformation

# Importer pour créer ImportGroupe
$ImportedUsers = Import-Csv -Path $ExportPath
$ImportGroupe = @()
$ImportGroupe += $ImportedUsers

Write-Host "[Contenu du groupe ImportGroupe]"
$ImportGroupe | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

