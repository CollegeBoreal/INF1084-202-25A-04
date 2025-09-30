$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

