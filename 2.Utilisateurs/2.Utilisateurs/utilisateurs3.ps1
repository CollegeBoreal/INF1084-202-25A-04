# 3️⃣ Requêtes et filtres

# Lister tous les utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Lister tous les utilisateurs dans l'OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# 🧠 Exercice 3 :
# Lister tous les utilisateurs dont le prénom contient "a" (majuscule/minuscule).
