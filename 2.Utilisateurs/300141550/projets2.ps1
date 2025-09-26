

# 1️⃣ Créer un groupe vide
$Groups = @{
    "Etudiants2025" = @()
}

# 2️⃣ Ajouter tous les utilisateurs de l’OU "Promo2025" dans le groupe
$Groups["Etudiants2025"] += $Users | Where-Object { $_.OU -eq "Promo2025" }


$Groups["Etudiants2025"] 

# Afficher les utilisateurs      
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
