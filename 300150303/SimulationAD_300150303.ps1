<#
.SYNOPSIS
TP Simulation Active Directory - Jesmina Dosreis - Matricule 300150303
.Objectifs
- Comprendre la structure AD (utilisateurs, groupes, OU)
- S’entraîner aux cmdlets PowerShell pour la création, la recherche et la manipulation d’objets
- Exporter et importer des utilisateurs en CSV
#>

# ==============================
# 1️⃣ Création d’objets utilisateurs simulés
# ==============================

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"} 
    @{Nom="jesmina"; Prenom="ludy"; Login="affi"; OU="Stagiaires"},
    @{Nom="emanuel"; Prenom="kossi"; Login="ekossi"; OU="Stagiaires"}

)

# Ajouter 2 nouveaux utilisateurs
$Users += @(
    @{Nom="Diallo"; Prenom="Amina"; Login="adiallo"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lucas"; Login="lnguyen"; OU="Stagiaires"}
)

Write-Host "`n✅ Liste des utilisateurs après ajout :"
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# ==============================
# 2️⃣ Création de groupes simulés
# ==============================

$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans "GroupeFormation"
$Groups["GroupeFormation"] = $Users | Where-Object { $_.OU -eq "Stagiaires" }

Write-Host "`n✅ Membres de GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# ==============================
# 3️⃣ Requêtes et filtres
# ==============================

Write-Host "`n✅ Utilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# ==============================
# 4️⃣ Export et import CSV
# ==============================

$ExportPath = "C:\Temp\UsersSimules.csv"

# Exporter
$Users | Export-Csv -Path $ExportPath -NoTypeInformation
Write-Host "`n✅ Export terminé : $ExportPath"

# Importer
$ImportedUsers = Import-Csv -Path $ExportPath

# Créer un groupe ImportGroupe
$Groups["ImportGroupe"] = $ImportedUsers

Write-Host "`n✅ Membres du groupe ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# ==============================
# 5️⃣ Mini-projet : script complet de simulation
# ==============================

# Créer 5 utilisateurs simulés dans l’OU "Promo2025"
$Promo2025 = @(
    @{Nom="Sow"; Prenom="Mariam"; Login="msow"; OU="Promo2025"},
    @{Nom="Bouchard"; Prenom="Émile"; Login="ebouchard"; OU="Promo2025"},
    @{Nom="Traoré"; Prenom="Fatou"; Login="ftraore"; OU="Promo2025"},
    @{Nom="Gomes"; Prenom="Rui"; Login="rgomes"; OU="Promo2025"},
    @{Nom="Chen"; Prenom="Lina"; Login="lchen"; OU="Promo2025"}
)

# Créer le groupe Etudiants2025
$Groups["Etudiants2025"] = $Promo2025

# Exporter la liste finale du groupe en CSV
$ExportPromoPath = "C:\Temp\Etudiants2025.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $ExportPromoPath -NoTypeInformation

Write-Host "`n✅ Mini-projet terminé : $ExportPromoPath"
Write-Host "`nToutes les étapes ont été exécutées avec succès ! 🎉"
