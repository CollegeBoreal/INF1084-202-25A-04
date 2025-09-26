# Lister tous les utilisateurs dont le prénom contient "a" (insensible à la casse)
$Users | Where-Object { $_.Prenom -match "a" }

