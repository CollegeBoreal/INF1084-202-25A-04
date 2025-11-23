# ==================================================================
# Script : utilisateurs5.ps1
# Auteur : Fetis Nadir
# Identifiant : 300150485
# Objectif : Mini-projet - Simulation AD Promo2025
# ==================================================================

# 1️⃣ Créer 5 utilisateurs simulés dans l’OU "Promo2025"
$Promo2025 = @(
    @{Nom="Diallo"; Prenom="Amina"; Login="adiallo"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Luc"; Login="lgagnon"; OU="Promo2025"},
    @{Nom="Ribeiro"; Prenom="Carlos"; Login="cribeiro"; OU="Promo2025"},
    @{Nom="Bensalem"; Prenom="Nora"; Login="nbensalem"; OU="Promo2025"},
    @{Nom="Tran"; Prenom="Minh"; Login="mtran"; OU="Promo2025"}
)

Write-Host "✅ Utilisateurs créés dans l'OU Promo2025 :"
$Promo2025 | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 2️⃣ Créer un groupe "Etudiants2025"
$Groups = @{}
$Groups["Etudiants2025"] = $Promo2025

Write-Host "`n👥 Groupe 'Etudiants2025' créé avec les utilisateurs de Promo2025 :"
$Groups["Etudiants2025"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 3️⃣ Exporter la liste finale du groupe en CSV
$csvPath = "C:\Temp\Etudiants2025.csv"

# Créer le dossier C:\Temp s’il n’existe pas
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\" -Name "Temp" -ItemType Directory | Out-Null
    Write-Host "📁 Dossier C:\Temp créé"
}

# Export des données dans le fichier CSV
$Groups["Etudiants2025"] | ForEach-Object {
    [PSCustomObject]@{
        Nom     = $_.Nom
        Prenom  = $_.Prenom
        Login   = $_.Login
        OU      = $_.OU
    }
} | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "`n📁 Liste exportée avec succès vers $csvPath"
