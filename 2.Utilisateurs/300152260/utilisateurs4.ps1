# Lister tous les utilisateurs dont le nom commence par "B"
Write-Host "`n--- Utilisateurs dont le nom commence par 'B' ---"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dans l'OU "Stagiaires"
Write-Host "`n--- Utilisateurs dans l'OU 'Stagiaires' ---"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
Write-Host "`n--- Utilisateurs dont le prénom contient 'a' ---"
$Users | Where-Object { $_.Prenom -match "(?i)a" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
