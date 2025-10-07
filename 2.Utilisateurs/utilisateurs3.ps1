# 3?? Requ�tes et filtres

# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# Exercice : Lister tous les utilisateurs dont le pr�nom contient "a" (majuscule/minuscule).
