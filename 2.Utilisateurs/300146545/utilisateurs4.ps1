# Définir des utilisateurs comme objets
$Users = @(   
    [PSCustomObject]@{ Nom="Dupont"; Prenom="Alice"; OU="Stagiaires" }  
    [PSCustomObject]@{ Nom="Diaks"; Prenom="rahima"; OU="Professeurs" } 
    [PSCustomObject]@{ Nom="malembe"; Prenom="driss"; OU="Stagiaires" }
)
# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path -Path "C:\Temp")) { 
   New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}
# Exporter les utilisateurs
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8
# Importer les utilisateurs
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
# Afficher les utilisateurs importés
Write-Host "Utilisateurs importés depuis le CSV :" -ForegroundColor Cyan

$ImportedUsers | Format-Table -AutoSize


