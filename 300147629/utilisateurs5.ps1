# utilisateurs5.ps1
# Mini-projet : Simulation Active Directory Promo2025

# 1️⃣ Créer 5 utilisateurs dans l'OU Promo2025
$Users2025 = @(
    @{Nom="Balde"; Prenom="Aminata"; Login="adiallo"; OU="Promo2025"},
    @{Nom="Messi"; Prenom="John"; Login="jsmith"; OU="Promo2025"},
    @{Nom="Fernandez"; Prenom="Maria"; Login="mfernandez"; OU="Promo2025"},
    @{Nom="Chen"; Prenom="Wei"; Login="wchen"; OU="Promo2025"},
    @{Nom="Haddad"; Prenom="Youssef"; Login="yhaddad"; OU="Promo2025"}
)

# 2️⃣ Créer le groupe Etudiants2025
$Groups = @{
    "Etudiants2025" = @()
}

# 3️⃣ Ajouter tous les utilisateurs de Promo2025 dans le groupe
$Groups["Etudiants2025"] += $Users2025

# 4️⃣ Exporter la liste finale du groupe en CSV dans le dossier courant
$Groups["Etudiants2025"] | Export-Csv -Path ".\Etudiants2025.csv" -NoTypeInformation

# 5️⃣ Vérification console
$Groups["Etudiants2025"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }
