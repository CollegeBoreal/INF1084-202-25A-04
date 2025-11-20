# 300150268
# Mohand Said KEMICHE
# Script : utilisateurs3.ps1
# Objectif : Filtrer les utilisateurs dont le prénom contient "a"

# Liste d’utilisateurs simulés
$utilisateurs = @(
    @{Nom="KEMICHE"; Prenom="Mohand"},
    @{Nom="BELBESSAI"; Prenom="Boualem"},
    @{Nom="AMRANI"; Prenom="Sofia"},
    @{Nom="NADIR"; Prenom="Ali"},
    @{Nom="BOUZID"; Prenom="Karim"}
)

# Filtrer les utilisateurs dont le prénom contient "a" (insensible à la casse)
$filtre = $utilisateurs | Where-Object { $_.Prenom -match "a" }

Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$filtre | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
