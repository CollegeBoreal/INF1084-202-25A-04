# Lister tous les utilisateurs dont le prénom contient "a" ou "A"
$Users | Where-Object { $_.Prenom -match "a" }
# Version insensible à la casse avec -like
$Users | Where-Object { $_.Prenom -like "*a*" -or $_.Prenom -like "*A*" }

