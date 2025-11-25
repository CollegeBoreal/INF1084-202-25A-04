# Script modifié par : Tasnim (300145940)
# Objectif : Filtrage de prénoms contenant une lettre spécifique

# Étape 1 – Définition d’une liste d’utilisateurs fictifs
$utilisateurs = @(
    @{Nom="LEFEBVRE"; Prenom="Alex"},
    @{Nom="MOREAU";   Prenom="Leila"},
    @{Nom="BENALI";   Prenom="Yasmine"},
    @{Nom="DURAND";   Prenom="Hugo"},
    @{Nom="KHELIFA";  Prenom="Maya"}
)

# Étape 2 – Sélection des utilisateurs dont le prénom contient la lettre “a”
$filtre = $utilisateurs | Where-Object { $_.Prenom -match "a" }

# Étape 3 – Affichage du résultat du filtrage
Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$filtre | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

