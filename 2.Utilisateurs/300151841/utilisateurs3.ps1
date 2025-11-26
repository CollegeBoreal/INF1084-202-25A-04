# utilisateurs3.ps1
# Objectif : Appliquer des filtres et requêtes sur la liste d'utilisateurs simulés

. .\utilisateurs1.ps1  # Importer la liste d’utilisateurs

# 1. Lister les utilisateurs dont le nom commence par "B"
"=== Utilisateurs dont le nom commence par B ==="
$Users | Where-Object { $_.Nom -like "B*" }

# 2. Lister les utilisateurs de l'OU Stagiaires
"=== Utilisateurs dans l'OU Stagiaires ==="
$Users | Where-Object { $_.OU -eq "Stagiaires" }

# 3. Lister les utilisateurs dont le prénom contient 'a' (majuscule/minuscule)
"=== Utilisateurs dont le prénom contient 'a' ==="
$Users | Where-Object { $_.Prenom -match "a" }
