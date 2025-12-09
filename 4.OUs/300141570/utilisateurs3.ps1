# Auteur : Haroune Berkani (300141570)

# Step 1
$utilisateurs = @(
    @{Nom="MAHREZ";     Prenom="Riyad"},
    @{Nom="BENNACER";   Prenom="Ismael"},
    @{Nom="SLIMANI";    Prenom="Islam"},
    @{Nom="FEGHOULI";   Prenom="Sofiane"},
    @{Nom="MANDI";      Prenom="Aissa"}
)

# Step 2
$filtre = $utilisateurs | Where-Object { $_.Prenom -match "a" }

# Step 3
Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$filtre | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
