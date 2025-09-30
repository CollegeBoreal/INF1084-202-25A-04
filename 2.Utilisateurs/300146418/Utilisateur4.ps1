# Chemin du fichier CSV dans le même dossier que le script
$csvPath = "$PSScriptRoot\UsersSimules.csv"

# Importer la liste des utilisateurs depuis le CSV
$ImportedUsers = Import-Csv -Path $csvPath

# Créer le groupe ImportGroupe (simulation avec tableau)
$ImportGroupe = @()

# Ajouter tous les utilisateurs importés au groupe
foreach ($user in $ImportedUsers) {
    $ImportGroupe += $user
}

# Afficher le contenu du groupe
Write-Output "=== Groupe 'ImportGroupe' créé avec les utilisateurs suivants ==="
$ImportGroupe | ForEach-Object {
    Write-Output "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

