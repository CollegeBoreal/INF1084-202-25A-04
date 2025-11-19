###########################################################
# 💻 INF1084 - Mini-projet : Simulation complète
# Auteur : Mohammed Aiche
# Étudiant : 300151608
# Collège Boréal
###########################################################

# Étape 1 : Création de 5 utilisateurs simulés dans l’OU "Promo2025"
$Promo2025 = @(
    @{Nom="Aiche"; Prenom="Mohammed"; Login="maiche"; OU="Promo2025"},
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Promo2025"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Promo2025"},
    @{Nom="Diallo"; Prenom="Hakin"; Login="hdiallo"; OU="Promo2025"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Promo2025"}
)

# Étape 2 : Création d’un groupe "Etudiants2025"
$Groups = @{
    "Etudiants2025" = @()
}

# Étape 3 : Ajouter tous les utilisateurs de "Promo2025" dans le groupe
$Groups["Etudiants2025"] += $Promo2025

# Étape 4 : Afficher les membres du groupe
Write-Host "`n👥 Membres du groupe Etudiants2025 :"
$Groups["Etudiants2025"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }

# Étape 5 : Exporter la liste en CSV
$Path = "C:\Temp\Etudiants2025.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $Path -NoTypeInformation
Write-Host "`n✅ Exportation terminée : $Path"
