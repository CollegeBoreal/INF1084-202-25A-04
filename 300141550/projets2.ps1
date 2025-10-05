. .\projets1.ps1

$Groups = @{

   "Etudiants2025" = @()
}

# Ajouter tous les utilisateurs de l’OU "Promo2025" dans le groupe 
$Groups["Etudiants2025"] += $Users | Where-Object { $_.OU -eq "Promo2025" }
 
# Vérifier que le groupe contient bien les bons utilisateurs 
$Groups["Etudiants2025"] 
