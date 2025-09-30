# Charger le premier script pour récupérer les utilisateurs
. .\utilisateurs1.ps1

# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Lister tous les utilisateurs dont le prénom contient "a" (insensible à la casse)
$Users | Where-Object {$_.Prenom -match "a"} | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

