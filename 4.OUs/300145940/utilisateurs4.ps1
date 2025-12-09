# Script ajusté par : Tasnim (300145940)
# But : Identifier les prénoms contenant une lettre précise

# Étape 1 – Création d’une liste simplifiée d’utilisateurs
$utilisateurs = @(
    @{Nom="LEBLANC";  Prenom="Ariana"},
    @{Nom="DION";     Prenom="Marc"},
    @{Nom="HAMDI";    Prenom="Sarra"},
    @{Nom="GIRARD";   Prenom="Adam"},
    @{Nom="MEJRI";    Prenom="Maya"}
)

# Étape 2 – Filtrer les personnes dont le prénom inclut la lettre “a”
$filtre = $utilisateurs | Where-Object { $_.Prenom -match "a" }

# Étape 3 – Affichage des résultats filtrés
Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$filtre | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

