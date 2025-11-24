# 300150268
# Mohand Said KEMICHE
# Script : utilisateurs4.ps1
# Objectif : Exporter et importer des utilisateurs simulés via CSV

# Création d'une liste d'utilisateurs simulés
$utilisateurs = @(
    @{Nom="KEMICHE"; Prenom="Mohand"; OU="Stagiaires"},
    @{Nom="BELBESSAI"; Prenom="Boualem"; OU="Professeurs"},
    @{Nom="AMRANI"; Prenom="Sofia"; OU="Stagiaires"},
    @{Nom="NADIR"; Prenom="Ali"; OU="Stagiaires"},
    @{Nom="BOUZID"; Prenom="Karim"; OU="Employés"}
)

# Exportation des utilisateurs vers un fichier CSV
$utilisateurs | Export-Csv -Path ".\utilisateurs.csv" -NoTypeInformation
Write-Host "`nExport effectué vers utilisateurs.csv"

# Importation des utilisateurs depuis le fichier CSV
$importes = Import-Csv ".\utilisateurs.csv"

# Ajout des utilisateurs importés dans un nouveau groupe ImportGroupe
Write-Host "`nAjout des utilisateurs importés dans le groupe ImportGroupe :"
foreach ($user in $importes) {
    Write-Host " - $($user.Prenom) $($user.Nom) ajouté à ImportGroupe"
}
