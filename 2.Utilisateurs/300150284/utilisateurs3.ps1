# utilisateurs3.ps1
# Matricule: 300150284
$Matricule = "300150284"
$ExportDir = "C:\TP_AD_$Matricule"
$csvPath = Join-Path $ExportDir "UsersSimules_$Matricule.csv"

# Charger $Users si besoin
if (-not $Users) {
    if (Test-Path $csvPath) {
        $Users = Import-Csv -Path $csvPath
        Write-Host "Users importés depuis $csvPath"
    } else {
        Write-Error "Fichier $csvPath manquant. Lance utilisateurs1.ps1 d'abord."
        return
    }
}

# Requêtes exemple
Write-Host "`n-- Noms commençant par B --"
$Users | Where-Object { $_.Nom -like "B*" } | Format-Table -AutoSize

Write-Host "`n-- Utilisateurs dans OU 'Stagiaires' --"
$Users | Where-Object { $_.OU -eq "Stagiaires" } | Format-Table -AutoSize

# Exercice 3 : prénoms contenant "a" (insensible à la casse)
Write-Host "`n-- Prénoms contenant 'a' (maj/min insensible) --"
$Users | Where-Object { $_.Prenom -match 'a' } | Format-Table -AutoSize

# Exercice 4 : importer CSV (ici on ré-importe) et créer ImportGroupe
$ImportedUsers = Import-Csv -Path $csvPath
$Groups = $Groups ?? @{}     # si $Groups existe déjà, on le garde ; sinon on crée
$Groups["ImportGroupe"] = $ImportedUsers

Write-Host "`n== Membres d'ImportGroupe (importés depuis CSV) =="
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

