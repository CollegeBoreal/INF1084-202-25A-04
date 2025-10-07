# Exercice 4 : Exporter et importer CSV

# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Maria"; Login="mgarcia"; OU="Stagiaires"}
)

# Convertir les hashtables en objets PSCustomObject pour l'export CSV
$UsersObjects = $Users | ForEach-Object {
    [PSCustomObject]$_
}

# Exporter les utilisateurs simulés
Write-Host "`n=== Export des utilisateurs vers CSV ===" -ForegroundColor Cyan
$UsersObjects | Export-Csv -Path ".\UsersSimules.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Fichier créé : UsersSimules.csv" -ForegroundColor Green

# Importer depuis CSV
Write-Host "`n=== Import des utilisateurs depuis CSV ===" -ForegroundColor Cyan
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"
$ImportedUsers | ForEach-Object {
    Write-Host "- $($_.Prenom) $($_.Nom) - $($_.Login)" -ForegroundColor Green
}

# Créer un groupe "ImportGroupe" et ajouter tous les utilisateurs importés
$ImportGroupe = @()
$ImportedUsers | ForEach-Object {
    $ImportGroupe += $_
}

Write-Host "`n=== Groupe 'ImportGroupe' créé ===" -ForegroundColor Cyan
Write-Host "Nombre de membres : $($ImportGroupe.Count)" -ForegroundColor Yellow