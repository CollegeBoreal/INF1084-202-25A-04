. "$PSScriptRoot\utilisateurs1.ps1" > $null

# Filtrer les utilisateurs dont le nom commence par A
$UsersPrenomA = $Users | Where-Object { $_.Prenom -match "^[Aa]" }

# Filtrer les utilisateurs dont le nom commence par B
$UsersNomB = $Users | Where-Object { $_.Nom -like "B*" }

# Filtrer les utilisateurs qui sont dans l'OU "Stagiaires"
$UsersStagiaires = $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les résultats
Write-Host "`nListe de utilisateurs dont le Prenom commence par A`n"
$UsersPrenomA | ForEach-Object { Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

Write-Host "`nListe de utilisateurs dont le nom commence par B`n"
$UsersNomB | ForEach-Object { Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

Write-Host "`nListe des utilisateurs avec l'OU 'Stagiaires'`n"
$UsersStagiaires | ForEach-Object { Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
