$Etudiants = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Nelson"; Prenom="William"; Login="wnelson"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Diara"; Prenom="Siga"; Login="sdiara"; OU="Promo2025"}

)

# Création des groupes
$Groups = @{
    "Etudiants2025" = @()
}

# Ajouter les Promo2025 dans Etudiants2025
$Groups["Etudiants2025"] += $Etudiants[0]
$Groups["Etudiants2025"] += $Etudiants[1]
$Groups["Etudiants2025"] += $Etudiants[2]
$Groups["Etudiants2025"] += $Etudiants[3]
$Groups["Etudiants2025"] += $Etudiants[4]

# Définir le chemin du fichier CSV
$CsvPath = "C:\Users\kelek\Documents\developer\INF1084-202-25A-03\2.Utilisateurs\300133071\file_etudiants.csv"

# Exporter $Etudiants vers un fichier CSV
$Etudiants | Export-Csv -Path $CsvPath  -NoTypeInformation
Write-Host "`nExportation des etudiants depuis : $CsvPath `n"

# Importer les utilisateurs depuis le CSV
$EtudiantsImportes = Import-Csv -Path $CsvPath

# Vérifier que le CSV contient des utilisateurs
if (-not $EtudiantsImportes) {
    Write-Host "Aucun etudiants trouvé dans le CSV."
    return
}

# Créer le groupe "ImportGroupe" sous forme de tableau vide
$ImportGroupe = @()

# Ajouter tous les utilisateurs importés au groupe
$ImportGroupe += $EtudiantsImportes

# Afficher les membres du groupe
Write-Host " Membres du groupe etudiants `n"
$ImportGroupe | Format-Table Prenom, Nom, Login, OU -AutoSize