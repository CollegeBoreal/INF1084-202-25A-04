# utilisateurs4.ps1
# Étape 4 : Importer les utilisateurs depuis un CSV et créer un groupe ImportGroupe

# 1. Exporter des utilisateurs simulés vers un CSV (pour s'assurer que le fichier existe)
$Users = @(
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Keller"; Prenom="Marc"; Login="mkeller"; OU="Stagiaires"},
    @{Nom="Boucher"; Prenom="Amira"; Login="aboucher"; OU="Stagiaires"},
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"}
)

$ExportPath = "C:\Temp\UsersSimules.csv"
if (-not (Test-Path "C:\Temp")) { New-Item -Path "C:\" -Name "Temp" -ItemType "Directory" }
$Users | Export-Csv -Path $ExportPath -NoTypeInformation

# 2. Importer le fichier CSV
$ImportedUsers = Import-Csv -Path $ExportPath

# 3. Créer le groupe ImportGroupe et y ajouter tous les utilisateurs importés
$Groups = @{}
$Groups["ImportGroupe"] = @()
$ImportedUsers | ForEach-Object {
    $Groups["ImportGroupe"] += $_
}

# 4. Afficher les utilisateurs dans ImportGroupe
Write-Host "Utilisateurs dans ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object {
    Write-Host " - $($_.Prenom) $($_.Nom) (Login: $($_.Login))"
}

